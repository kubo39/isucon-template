import std;
import mysql;
import vibe.d;

__gshared MySQLPool pool;

shared static this()
{
    // TODO: fix to correct settings.
    string host = environment.get("MYSQL_HOST", "127.0.0.1");
    ushort port = environment.get("MYSQL_PORT", "3306").to!ushort;
    string user = environment.get("MYSQL_USER", "isucon");
    string dbname = environment.get("MYSQL_DBNAME", "isucon");
    string password = environment.get("MYSQL_PASSWORD", "isucon");

    pool = new MySQLPool(host, user, password, dbname, port);
    pool.maxConcurrency(128);
}

void getIndex(HTTPServerRequest req, HTTPServerResponse res)
{
}

void main()
{
    // TODO: fix correct settings.
    auto settings = new HTTPServerSettings;
    settings.port = environment.get("SERVER_PORT", "8080").to!ushort;
    settings.bindAddresses = ["127.0.0.1"];

    auto router = new URLRouter;
    auto fileServerSettings = new HTTPFileServerSettings;
    // fileServerSettings.encodingFileExtension = ["gzip": ".gz"];
    router.get("*", serveStaticFile("./public/",)); // fix to correct path.

    auto listener = listenHTTP(settings, router);
    scope(exit) listener.stopListening();

    logInfo("Starting...");
    runApplication();
}
