Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:48968 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750957AbdAQJZN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Jan 2017 04:25:13 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH v2 00/15] staging cleanups
Date: Tue, 17 Jan 2017 04:24:47 -0500
Message-Id: <20170117092502.6951-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch set contains more of my cleanups to the isl29028 light driver
in preparation for moving the driver out of staging. The main feature
introduced by this patch set is support for runtime power management
and autosuspend after two seconds. The rest of the patches are minor
code improvements, mostly style.

The ALS and IR portion of the sensor was tested using an ISL29028 hooked
up to a Raspberry Pi 2. In my v1 submission cover letter, I mention that
I am not able to use the proximity sensing function on my sensor. (This
is before any of my code changes.) I'm going to look into that issue
next. I suspect that it is a hardware issue on my local setup. I verified
with a visible light LED that the IRDR pin continues to be driven as
expected when a proximity reading is requested and is turned off after
two seconds of inactivity. The pin is driven the next time a proximity
reading is requested.

Datasheet:
http://www.intersil.com/content/dam/Intersil/documents/isl2/isl29028.pdf

Changes since version 1:
- Suggestions from Jonathan Cameron
  - In v1 patch #4 (#15 in this series), remove suspended flag. Added
    support for runtime power management support and autosuspend.
  - Dropped v1 patch #19 (remove legacy device tree binding)
  - Dropped v1 patch #11 (made column alignment in isl29028_channels
    consistent)
  - In v1 patches #13 and #14, if there is an error, return inside
    the error check.
  - It was suggested to drop the v1 #2 patch that removes the enable
    flag from isl29028_enable_proximity(). I think that we can apply
    that patch now that the driver has runtime power management support.
- Suggestions from Dan Carpenter
  - Dropped v1 patch #12 (fix comparison between signed and unsigned
    integers)

Brian Masney (15):
  staging: iio: isl29028: made alignment of variables in struct
    isl29028_chip consistent
  staging: iio: isl29028: fix alignment of function arguments
  staging: iio: isl29028: combine isl29028_proxim_get() and
    isl29028_read_proxim()
  staging: iio: isl29028: change newlines to improve readability
  staging: iio: isl29028: remove unused define ISL29028_DEV_ATTR
  staging: iio: isl29028: move failure logging into
    isl29028_set_proxim_sampling()
  staging: iio: isl29028: move failure logging into
    isl29028_set_als_scale()
  staging: iio: isl29028: made error messages consistent
  staging: iio: isl29028: remove unnecessary error logging in
    isl29028_chip_init_and_power_on()
  staging: iio: isl29028: remove out of memory log message
  staging: iio: isl29028: remove unnecessary parenthesis
  staging: iio: isl29028: remove enable flag from
    isl29028_enable_proximity()
  staging: iio: isl29028: only set proximity sampling rate when
    proximity is enabled
  staging: iio: isl29028: only set ALS scale when ALS sensing is enabled
  staging: iio: isl29028: add runtime power management support

 drivers/staging/iio/light/isl29028.c | 323 ++++++++++++++++++++++++-----------
 1 file changed, 221 insertions(+), 102 deletions(-)

-- 
2.9.3

