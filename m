Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:60109 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933226Ab1JNPeP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Oct 2011 11:34:15 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/3] staging:iio:dummy (example) driver.
Date: Fri, 14 Oct 2011 16:34:12 +0100
Message-Id: <1318606455-3471-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dependent on: staging:iio: two fixes (patch 1 only).

Hi Greg,

This driver is meant to mainly act as documentation although it is useful
in its own right for testing interfaces etc on devices with no hardware.

This version is slightly modified from last posting (fixed the freeing
of struct iio_dev as with all other drivers).

Some general positive feedback and seeing as it can't actually break
any real hardware seems sensible to get it in place asap.  Once merged
I'll clear out a few of the documentation files that it supercedes.

It's an odd category where only newbies are interested enough to read
the code and none of them are confident enough to sign off on it.
Oh well.

There may be a better way of faking the interupts than is done here, but
attempts to extract suggestions from Thomas Gleixner + wider world
failed.

Thanks,

Jonathan

Previous descriptions:

Hi All,

This has v2 of the dummy driver introduction to start with,
main changes are responses to Manuels review and a kernel doc
fixes (as I remembered the format wrong whilst writing the
original code - oops).

The second patch is somewhat evil in that it uses an additional
helper module purely to fake event 'interupts'.  This is the best
option I have come up with for how to write a 'standard' looking
driver that will work without hardware.  It's hacky, but I don't
really want to spend much time on it if it will simply work.

The code in the actual dummy driver is pretty simple and standard.
Note I have glossed over having a top half to the interrupt as
the evgen driver can't run one as currently stands.  We talked
a while ago about a workaround for that in the core, but nothing
is in place as yet.

The third patch puts basic example buffered support in place.
I haven't provided a trigger because that would require either
extending the nasty evgen module, or writing another.

Whilst it is decidely 'unusual' we do have a hardware free trigger
in the iio-trig-sysfs.  I'd not advise people look at that one
to get an idea of how a normal one works though.

So at the end of this, the weak point is the lack of an example
trigger, but those vary so much anyway I inclined to tell people
to look for a driver that happens to do roughly what their hardware
needs and copy that!

What do people think?

I propose to drop the 3 files I moaned about the other day from
the documentation directory in favour of a short description
of what this driver does but only once this is in place.

Thanks,

Jonathan

p.s. found a few bugs in the test prog, so I'll send a series
out cleaning those up soonish.


Jonathan Cameron (3):
  staging:iio:Documentation Simple dummy driver to explain the basics
  staging:iio:dummy Add event support + fake event generator
  staging:iio:dummy Add buffered reading support

 drivers/staging/iio/Kconfig                   |   27 ++
 drivers/staging/iio/Makefile                  |    7 +
 drivers/staging/iio/iio_dummy_evgen.c         |  217 ++++++++++
 drivers/staging/iio/iio_dummy_evgen.h         |    2 +
 drivers/staging/iio/iio_simple_dummy.c        |  545 +++++++++++++++++++++++++
 drivers/staging/iio/iio_simple_dummy.h        |  108 +++++
 drivers/staging/iio/iio_simple_dummy_buffer.c |  206 ++++++++++
 drivers/staging/iio/iio_simple_dummy_events.c |  190 +++++++++
 8 files changed, 1302 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/iio_dummy_evgen.c
 create mode 100644 drivers/staging/iio/iio_dummy_evgen.h
 create mode 100644 drivers/staging/iio/iio_simple_dummy.c
 create mode 100644 drivers/staging/iio/iio_simple_dummy.h
 create mode 100644 drivers/staging/iio/iio_simple_dummy_buffer.c
 create mode 100644 drivers/staging/iio/iio_simple_dummy_events.c

-- 
1.7.7

