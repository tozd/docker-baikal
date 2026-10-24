# tozd/baikal

<https://gitlab.com/tozd/docker/baikal>

Available as:

- [`tozd/baikal`](https://hub.docker.com/r/tozd/baikal)
- [`registry.gitlab.com/tozd/docker/baikal`](https://gitlab.com/tozd/docker/baikal/container_registry)

## Image inheritance

[`tozd/base`](https://gitlab.com/tozd/docker/base) ← [`tozd/dinit`](https://gitlab.com/tozd/docker/dinit) ← [`tozd/nginx`](https://gitlab.com/tozd/docker/nginx) ← [`tozd/nginx-mailer`](https://gitlab.com/tozd/docker/nginx-mailer) ← [`tozd/nginx-cron`](https://gitlab.com/tozd/docker/nginx-cron) ← [`tozd/php`](https://gitlab.com/tozd/docker/php) ← `tozd/baikal`

## Tags

- `latest`: Baikal v0.13.0

## Volumes

- `/var/lib/baikal`: Baikal configuration in `config/baikal.yaml` (it contains secrets, e.g., the database password
  and the admin password hash) and `Specific/` directory with the SQLite database, when SQLite is used.
  Baikal changes both from its admin interface, so persist this volume.

## Description

Image provides [Baikal](https://sabre.io/baikal/) CalDAV and CardDAV server.
When the container runs Baikal is available at `/baikal/` URL:

- `/baikal/dav.php`: CalDAV and CardDAV endpoint for clients. `/.well-known/caldav` and `/.well-known/carddav`
  redirect to it.
- `/baikal/cal.php` and `/baikal/card.php`: Deprecated endpoints, available for existing clients.
- `/baikal/admin/`: Admin interface to manage users, calendars, and address books.

On the first start without configuration, Baikal redirects to its installation wizard at `/baikal/admin/install/`,
where you set the admin password and configure the database. The wizard does not require a login until it
is finished, so finish it before you expose the container publicly.

When the container starts with a newer version of Baikal than the one which configured the database, Baikal
redirects to its upgrade wizard at `/baikal/admin/install/`, which upgrades the database schema.
Make a backup of the database before you open it.

## GitHub mirror

There is also a [read-only GitHub mirror available](https://github.com/tozd/docker-baikal),
if you need to fork the project there.
