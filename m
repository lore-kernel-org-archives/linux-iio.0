Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:55109 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382AbaEYL0Y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 25 May 2014 07:26:24 -0400
Message-ID: <5381D3C6.3040205@kernel.org>
Date: Sun, 25 May 2014 12:28:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Linux IIO List <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new drivers, features and cleanups for 3.16 - set 3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit c4784756a53f7b17056f5d86fe0eb9740d235578:

   Merge branch 'imx-drm-fixes' of git://ftp.arm.linux.org.uk/~rmk/linux-arm into staging-next (2014-05-06 06:26:31 -0700)

are available in the git repository at:


   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.16c

for you to fetch changes up to 34683a5c6e0ffaa61528ff71c283efe3063cc53f:

   fix format string missmatch in staging/iio/Documentation/iio_utils.h (2014-05-25 12:09:37 +0100)

----------------------------------------------------------------
Third round of new stuff for IIO in the 3.16 cycle.

This (rather late) set consists only of fixes to patches earlier in the
cycle or minor fixes for other problems (such as randconfig build issues
picked up by Arnd).  I've included the general minor fixes here as it is
very late in the current cycle and they can all wait for the merge window.

* Recent change to hid-sensors introduced a possible infinite loop due to a
   typo. In the same series, a report interval unit read was added but in the
   case where the hardware doesn't support it a value of 0 would lead to some
   nasty issues.  The patch sets it to the specified default of msecs.
* Anon inodes were used by IIO without being explicitly selected.  This has
   been true for a long time so it clearly only effects rather unusual
   configurations (rand configs)
* at91 requires the input subsytem but this wasn't explicity in the Kconfig.
* A couple of parts supported by the max1363 driver were using the wrong
   iio_chan_spec arrays and hence would missreport their bit depths.  This has
   been there a long time and was never right so isn't a regression.

----------------------------------------------------------------
Archana Patni (1):
       iio: hid-sensors: Set default unit of measure for report interval

Arnd Bergmann (2):
       iio: always select ANON_INODES
       iio:adc: at91 requires the input subsystem

Dan Carpenter (1):
       iio: hid-sensors: typo leads to potential forever loop

Jonathan Cameron (1):
       iio:adc:max1363 incorrect resolutions for max11604, max11605, max11610 and max11611.

Toralf Förster (1):
       fix format string missmatch in staging/iio/Documentation/iio_utils.h

  drivers/iio/Kconfig                                   |  1 +
  drivers/iio/adc/Kconfig                               |  1 +
  drivers/iio/adc/max1363.c                             | 16 ++++++++--------
  .../iio/common/hid-sensors/hid-sensor-attributes.c    | 19 ++++++++++++++++---
  drivers/staging/iio/Documentation/iio_utils.h         |  4 ++--
  5 files changed, 28 insertions(+), 13 deletions(-)
