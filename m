Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:46251 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933618Ab1JZQ1j (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 26 Oct 2011 12:27:39 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 00/10] staging:iio:various fixes
Date: Wed, 26 Oct 2011 17:27:35 +0100
Message-Id: <1319646465-2788-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Greg,

A mixed bag of fixes.  Nothing controversial and all have been on
the mailing list in various series.

[PATCH 0/6] staging:iio: misc fixes
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

[PATCH] staging:iio: one more fix

Drat, missed this one in the last set.

Anyhow, relatively trivial.


Lars-Peter's ones were bare patches as presented here.




Jonathan Cameron (7):
  staging:iio:light:tsl2563 both intensity channels have same
    chan_spec.
  staging:iio:triggers Remove unecessary existence checks and return
    val
  staging:iio:industrialio-trigger.c Trivial code style brackets fix
  staging:iio:kfifo remove entirely pointless code.
  staging:iio: trigger fixes for repeat request of same trigger and
    allocation failure
  staging:iio:core shared attrs do not work with modifier.
  staging:iio: core.  Allow for event chrdev obtaining ioctl if no
    buffer present.

Lars-Peter Clausen (2):
  staging:iio:events: Make sure userspace buffer is large enough
  staging:iio:iio_utils.h: Add missing include

Maxin B. John (1):
  staging:iio:light:tsl2563 missing setting of id in get id function.

 drivers/staging/iio/Documentation/iio_utils.h |    1 +
 drivers/staging/iio/iio_core.h                |    2 +-
 drivers/staging/iio/iio_core_trigger.h        |    3 +-
 drivers/staging/iio/industrialio-buffer.c     |    6 +++-
 drivers/staging/iio/industrialio-core.c       |    8 +++--
 drivers/staging/iio/industrialio-trigger.c    |   34 +++++++++++++-----------
 drivers/staging/iio/kfifo_buf.c               |    9 +------
 drivers/staging/iio/light/tsl2563.c           |    4 ++-
 8 files changed, 34 insertions(+), 33 deletions(-)

-- 
1.7.7

