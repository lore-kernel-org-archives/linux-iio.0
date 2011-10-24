Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/6] staging:iio: misc fixes
Date: Mon, 24 Oct 2011 10:43:29 +0100
Message-Id: <1319449415-23269-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi All,

I've just gathered up the fixes sitting in my various trees
ready to send on.  I have lost track of whether all of these
have previously been posted for review so this is to make
sure they all have.  They are all in the github master branch.

I'd like to push these out before the larger changes that
Lars-Peter and I made at the end of last week.

Thanks,

Jonathan

Jonathan Cameron (5):
  staging:iio:light:tsl2563 both intensity channels have same
    chan_spec.
  staging:iio:triggers Remove unecessary existence checks and return
    val
  staging:iio:industrialio-trigger.c Trivial code style brackets fix
  staging:iio:kfifo remove entirely pointless code.
  staging:iio: trigger fixes for repeat request of same trigger and
    allocation failure

Maxin B. John (1):
  staging:iio:light:tsl2563 missing setting of id in get id function.

 drivers/staging/iio/iio_core_trigger.h     |    3 +-
 drivers/staging/iio/industrialio-trigger.c |   34 ++++++++++++++-------------
 drivers/staging/iio/kfifo_buf.c            |    9 +------
 drivers/staging/iio/light/tsl2563.c        |    4 ++-
 4 files changed, 23 insertions(+), 27 deletions(-)

-- 
1.7.7
