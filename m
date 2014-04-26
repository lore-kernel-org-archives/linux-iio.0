Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56249 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbaDZPAK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 26 Apr 2014 11:00:10 -0400
Message-ID: <535BCA52.4000905@kernel.org>
Date: Sat, 26 Apr 2014 16:01:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux IIO List <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 3.15 round 2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 8b425aa193439a2b60a988a9230f1de753e36902:

   Merge tag 'iio-fixes-for-3.15a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2014-04-22 21:29:20 -0700)

are available in the git repository at:


   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.15b

for you to fetch changes up to bbc28134e915d2e2e8cac0254d1d056db0ae3247:

   iio: adc: Nothing in ADC should be a bool CONFIG (2014-04-26 11:22:16 +0100)

----------------------------------------------------------------
Second set of fixes for IIO in the 3.15 cycle.

* ad2s1200 - Fix some missing parenthesis in a for statement that could have
   led to an error being missed when getting gpios.
* Fix a null derefference issue in the mpu6050 when platform data is not
   provided (or is provided via the device tree for example).
* exynos_adc bug on remove due to child devices having been added to the
   parent of the IIO device rather than the IIO device itself.  This caused an
   issue with the IIO device removing itself in it's remove function.
* Make all ADC drivers buildable as modules to avoid dependency issues if
   the IIO core is itself built as a module.  The exynos adc bug became
   apparently whilst this fix was being tested.

----------------------------------------------------------------
Atilla Filiz (1):
       iio:imu:mpu6050: Fixed segfault in Invensens MPU driver due to null dereference

Doug Anderson (1):
       iio: adc: Nothing in ADC should be a bool CONFIG

Jimmy Li (1):
       staging:iio:ad2s1200 fix missing parenthesis in a for statment.

Naveen Krishna Ch (1):
       iio: exynos_adc: use indio_dev->dev structure to handle child nodes

  drivers/iio/adc/Kconfig                    | 4 ++--
  drivers/iio/adc/exynos_adc.c               | 6 +++---
  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 7 +++++--
  drivers/staging/iio/resolver/ad2s1200.c    | 3 ++-
  4 files changed, 12 insertions(+), 8 deletions(-)
