Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [RFC PATCH 0/3] Experimenting with channel specification structures.
Date: Thu, 24 Mar 2011 20:05:22 +0000
Message-Id: <1300997125-2896-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi All,

This set came out a suggestion of Arnd Bergmann that we look into
alternatives to the huge attribute tables that dominate some of the
current drivers (max1363 may be the worst).

To that end, what we have in this set is an initial stab at
at using an iio_chan_spec structure to specify an awful lot
about a given channel.

Advantages I can see from this experiement

1) Simple drivers are more consise.
2) It is infact possible to do this for a lot of cases (I had
my doubts ;)
3) It gives us many of the rigid constraints that the many
   attribute macros now handle in a nice clean form.

Disadvantages:

1) The core code is rather more complex than I'd like.
2) There are cases I haven't yet worked out how to handle properly
   - for example, our lis3l02dq used to output accel_mag_value
   as the threshold value is shared across all high and low threshold
   interrupts.  Right now I have no way of specifying this level
   of control for the events lines.
   Also the use of shared event handlers is clunky to say the least.
   This may go away when we rethink the event system though.
3) Putting hard requirements on numeric formatting of some
   parameters is a pain. If nothing else I need to write a fixed point
   input function.

Anyhow, all comments welcome. Personally I'm currently in favour of
this approach, but we will need routes around it for the 'odd'
cases.  The trick is going to be limiting what we let through that
way to the absolute minimum of extremely device specific stuff.

Lots still to do here, and I need to take on one of the devices
where 'naming' the channels is important such as a light sensor...

At least in theory this set shouldn't 'break' anything.

Note it is on top of the general fixes I sent out last week.

Jonathan


p.s. Despite Arnd's original thread going to lkml I've kept this
on list for now (+ Arnd of course!) because I want to pin it down
a bit more before throwing it out more generally. Basically
this is big and ugly and I'm a wimp ;)

Jonathan Cameron (3):
  staging:iio: allow channels to be set up using a table of
    iio_channel_spec structures.
  staging:iio:lis3l02dq - experimental move to new channel_spec
    approach.
  staging:iio:max1363 - experimental move to channel_spec registration.

 drivers/staging/iio/accel/lis3l02dq.h      |   13 +-
 drivers/staging/iio/accel/lis3l02dq_core.c |  525 +++++-------
 drivers/staging/iio/accel/lis3l02dq_ring.c |  228 ++---
 drivers/staging/iio/adc/max1363.h          |    8 +-
 drivers/staging/iio/adc/max1363_core.c     | 1277 +++++++++++-----------------
 drivers/staging/iio/adc/max1363_ring.c     |    1 -
 drivers/staging/iio/chrdev.h               |    3 +
 drivers/staging/iio/iio.h                  |  157 ++++
 drivers/staging/iio/industrialio-core.c    |  535 ++++++++++++-
 drivers/staging/iio/industrialio-ring.c    |  188 ++++-
 drivers/staging/iio/ring_generic.h         |   19 +
 drivers/staging/iio/sysfs.h                |   31 +-
 12 files changed, 1693 insertions(+), 1292 deletions(-)

-- 
1.7.3.4
