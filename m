Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44573 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbaDLRyx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Apr 2014 13:54:53 -0400
Message-ID: <53497E3C.20304@kernel.org>
Date: Sat, 12 Apr 2014 18:56:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux IIO List <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 3.15 round 1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 084b6e7765b9554699afa23a50e702a3d0ae4b24:

   staging/cxt1e1/linux.c: Correct arbitrary memory write in c4_ioctl() (2014-03-04 16:20:01 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.15a

for you to fetch changes up to e036f71e8ce310dc58b1351c3eb967b892f4641c:

   iio: adc: mxs-lradc: fix warning when buidling on avr32 (2014-03-22 12:25:02 +0000)

----------------------------------------------------------------
First found of IIO fixes for the 3.15 cycle.

* Fix the platform data support for the at91 adc driver.
* A couple of related follow up patches get the support working again
   for at91sam9260 and at91sam9g45 as the earlier patch results in a device
   name change.
* A default timer value in the at91 adc driver was bonkers.  Make it sane.
* Fix incorrect reporting of the integration time for the cm32181 light sensor
* Fix a missing break in the ad2s1200 driver which would have give a false
   error return.
* Make sure buffer scan mask queries from userspace return 0/1 rather than
   a fairly random value depending on their implementation of test_bit
* Fix leak of the i2c client and a null pointer dereference in the cm36651
   driver.
* Fix a build warning on avr32 for the mxs-lradc (not exactly a critical
   combination - but the issue was real).

----------------------------------------------------------------
Alec Berg (1):
       iio: querying buffer scan_mask should return 0/1

Alexandre Belloni (5):
       iio: adc: at91_adc: Repair broken platform_data support
       ARM: at91: at91sam9g45: change at91_adc name
       ARM: at91: at91sam9260: change at91_adc name
       iio: adc: at91_adc: correct default shtim value
       iio: adc: mxs-lradc: fix warning when buidling on avr32

Beomho Seo (1):
       iio: cm32181: Fix read integration time function

Jimmy Li (1):
       staging:iio:ad2s1200 fix a missing break

Krzysztof Kozlowski (1):
       iio: cm36651: Fix i2c client leak and possible NULL pointer dereference

  arch/arm/mach-at91/at91sam9260_devices.c |  2 +-
  arch/arm/mach-at91/at91sam9g45_devices.c |  2 +-
  drivers/iio/adc/at91_adc.c               | 33 ++++++++++++++++++++++++++------
  drivers/iio/industrialio-buffer.c        |  6 ++++--
  drivers/iio/light/cm32181.c              |  1 +
  drivers/iio/light/cm36651.c              | 22 +++++++++++++++++++--
  drivers/staging/iio/adc/mxs-lradc.c      |  2 +-
  drivers/staging/iio/resolver/ad2s1200.c  |  1 +
  8 files changed, 56 insertions(+), 13 deletions(-)
