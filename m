Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:36003 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074AbaGHU3v (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 8 Jul 2014 16:29:51 -0400
Message-ID: <53BC5543.4040806@kernel.org>
Date: Tue, 08 Jul 2014 21:32:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux IIO List <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 3.16 - set 3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 6b64168de843b16e96a22f9e98c6afc92ee1da71:

   Merge tag 'iio-fixes-for-3.16b' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2014-06-29 09:43:23 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.16c

for you to fetch changes up to baa3c65298c089a9014b4e523a14ec2885cca1bc:

   iio: ti_am335x_adc: Fix: Use same step id at FIFOs both ends (2014-07-08 21:21:22 +0100)

----------------------------------------------------------------
Third round of iio fixes for the 3.16 cycle.

* Lots of hid sensors component drivers had a bug due to a local variable
   whose name suggested it was returned from the read_raw function not
   infact being returned (ret vs ret_type).  Fixed and unused ret removed.
* Block a possible race condition in tcs3472 by locking around some
   dependant i2c messages.
* Fix bug in the am335x driver fifo setup that occurs if the final
   channel enabled takes certain values.

----------------------------------------------------------------
Jan Kardell (1):
       iio: ti_am335x_adc: Fix: Use same step id at FIFOs both ends

Peter Meerwald (1):
       iio:tcs3472: Check for buffer enabled and locking

Sachin Kamat (6):
       iio: hid-sensor-press: Fix return values
       iio: hid-sensor-accel-3d: Fix return values
       iio: hid-sensor-magn-3d: Fix return values
       iio: hid-sensor-als: Fix return values
       iio: hid-sensor-gyro-3d: Fix return values
       iio: hid-sensor-prox: Fix return values

  drivers/iio/accel/hid-sensor-accel-3d.c       |  7 ++-----
  drivers/iio/adc/ti_am335x_adc.c               |  2 +-
  drivers/iio/gyro/hid-sensor-gyro-3d.c         |  7 ++-----
  drivers/iio/light/hid-sensor-als.c            |  7 ++-----
  drivers/iio/light/hid-sensor-prox.c           |  7 ++-----
  drivers/iio/light/tcs3472.c                   | 11 ++++++++++-
  drivers/iio/magnetometer/hid-sensor-magn-3d.c |  7 ++-----
  drivers/iio/pressure/hid-sensor-press.c       |  7 ++-----
  8 files changed, 23 insertions(+), 32 deletions(-)
