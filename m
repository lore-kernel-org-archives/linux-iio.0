Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [RFC PATCH] Start of move towards threaded interrupts. 
Date: Fri,  4 Mar 2011 18:05:13 +0000
Message-Id: <1299261914-15006-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

The majority of this patch splits the handling of lis3l02dq interrupts
(which all occur on one physical pin) completely.  Thus all interrupt
requests (one threaded, one not) occur on demand.

Note it's one mega patch for now.  The move to threaded interrupts for
events is going to involve some ugly temporary code in order to allow
bisectability and I'm not working out how to do that until I'm sure
we are heading in the right direction over all.

Note this will break all drivers that use the events infrastructure.

I'm not propsoing to push this change upstream until after
the merge window. For now it's just to get opinions on the
approach taken.

Does anyone have a good reason why we shouldn't move to the threaded
handlers for events as proposed here?  Triggers are a whole different
kettle of fish and now this lis3l02dq split has occured can be
addressed separately.

Jonathan Cameron (1):
  RFC Staging:iio: move to threaded interrupts for events.

 drivers/staging/iio/accel/lis3l02dq.h      |    4 +-
 drivers/staging/iio/accel/lis3l02dq_core.c |   68 ++++++++--------
 drivers/staging/iio/accel/lis3l02dq_ring.c |   96 +++++++++++++++------
 drivers/staging/iio/iio.h                  |   22 +++++-
 drivers/staging/iio/industrialio-core.c    |  124 ++++++++++++++++++++--------
 5 files changed, 214 insertions(+), 100 deletions(-)

-- 
1.7.3.4
