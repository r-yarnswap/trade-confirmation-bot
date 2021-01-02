# Reddit Trade Confirmation Bot

This bot handles trade confirmations on Reddit. Currently being used by `r/pen_swap`.

# Setup

## Prerequisites

This guide is very sparse on details and assumes you have some familiarity with Git, GitHub, and Heroku. You will need to know how to fork a repository, create developer access tokens, and create and deploy heroku apps. This guide is purely concerned with walking you through what this specific application needs to run on a heroku dyno.

---

There are specific bits of information you will be told to save for later, when setting up the heroku environment variables. I recommend opening notepad to save this information as you go, in the pattern of `section_key`. Eg: `mongodb_username`.

## MongoDB

For persistence, the app uses a mongoDB cluster.

1. Register for a free cluster on [mongoDB Atlas](https://www.mongodb.com/cloud/atlas/register). When registering create an initial database, eg: trade-confirmations.
2. After creating your database, __Save the database name for later__
3. Create database user
   1. After logging in, click Database Access
   2. Click Add New Database User
   3. Use authentication method Password
   4. Set the username, eg: trade-bot. __Save this for later__
   5. Click Autogenerate Secure Password. __Save this for later__
   6. Assign permission as Read and write to any database. ___** If you are using this mongodb for anything else, you should grant this user specific permissions on the trade confirmation database/collection___
4. Save cluster address
   1. Click on Clusters on the left menu
   2. Click on Connect Cluster
   3. Click connect your application
   4. Grab the host from the connection string. Eg if the string is `mongodb+srv://<username>:<password>@cluster-inky-bot.yiios.mongodb.net/<dbname>?retryWrites=true&w=majority`, you want `cluster-inky-bot.yiios.mongodb.net`. __Save this for later__
5. Decide on a collection name for the object store, eg: `object-store`. You don't need to create the collection manually as the app will handle that. __Save this for later__

You should have the following information saved for later:

mongodb_host
mongodb_database
mongodb_username
mongodb_password
mongodb_collection

## Reddit

You will need a bot account for reddit. Register for reddit like normal, and __save the username and password for later__.

After registering a new reddit account, [go to third party app authorization](https://www.reddit.com/prefs/apps) and create an app. Set the name to `trade-confirmation-bot` and the redirect url to `http://localhost:8081/oauth`. 

Now save the code under `person use script` label as `reddit_client_id`, and save the secret as `reddit_client_secret`.

## Pushover

If you would like to receive push notifications as the bot starts up / throws errors / creates the monthly post, create a [pushover.net](https://pushover.net) account. You will need variables `pushover_userToken` and `pushover_appToken`.

## Final Setup - Heroku

1. [Create a free heroku account](https://signup.heroku.com/login)
2. By default, you don't get enough compute hours to run the app 24/7; register a credit card (you WON'T be charged) for an addition allocation of free compute hours. Once you do so, you can run ONE application 24/7 without paying for compute.
3. Create a new heroku app, set as java.
4. Add the following config vars under settings
   1. `GIT_TOKEN` - generate a personal access token on GitHub with package read scope; the app uses several maven plugins hosted on github
   2. `GIT_USERNAME` - your GitHub username
   3. `MAVEN_CUSTOM_GOALS` - `package`
   4. `MAVEN_SETTINGS_PATH` - `.maven/settings.xml`
   5. `mongodb_host` - value saved earlier
   6. `mongodb_username` - value saved earlier
   7. `mongodb_password` - value saved earlier
   8. `mongodb_database` - value saved earlier
   9. `mongodb_collection` - value saved earlier
   10. `reddit_username` - value saved earlier
   11. `reddit_password` - value saved earlier
   12. `reddit_client_id` - value saved earlier
   13. `reddit_client_secret` - value saved earlier
   14. `reddit_subreddit` - subreddit to monitor, eg: `pen_swap`
   15. `pushover_userToken` - optional; value saved earlier
   16. `pushover_appToken` - optional; value saved earlier
5.  Set heroku to build the java app from your fork of this repo.