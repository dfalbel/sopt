library(xml2)
library(tidyverse)

users <- read_xml('data-raw/Users.xml') %>%
  xml2::as_list() %>%
  map_df(~.x %>% attributes %>% as_data_frame) %>%
  mutate_all(parse_guess)

saveRDS(users, 'data/users.rds')

posts <- read_xml('data-raw/Posts.xml') %>%
  xml2::as_list() %>%
  map_df(~.x %>% attributes %>% as_data_frame) %>%
  mutate_all(parse_guess) %>%
  mutate(
    PostType = ifelse(PostTypeId == 1, 'Question', 'Answer')
    )

# - Id
# - PostTypeId
# - 1: Question
# - 2: Answer
# - ParentID (only present if PostTypeId is 2)
# - AcceptedAnswerId (only present if PostTypeId is 1)
# - CreationDate
# - Score
# - ViewCount
# - Body
# - OwnerUserId
# - LastEditorUserId
# - LastEditorDisplayName="Jeff Atwood"
# - LastEditDate="2009-03-05T22:28:34.823"
# - LastActivityDate="2009-03-11T12:51:01.480"
# - CommunityOwnedDate="2009-03-11T12:51:01.480"
# - ClosedDate="2009-03-11T12:51:01.480"
# - Title=
#   - Tags=
#   - AnswerCount
# - CommentCount
# - FavoriteCount

saveRDS(posts, 'data/posts.rds')





