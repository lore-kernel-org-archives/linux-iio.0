Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48367 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbbC3Tio (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2015 15:38:44 -0400
Message-ID: <5519A642.3070407@kernel.org>
Date: Mon, 30 Mar 2015 20:38:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 4.0 set 4
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 3d8bbe243dc7418b4b2eadcbf5693887d076a521:

  Merge tag 'iio-fixes-for-4.0c' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2015-03-24 22:55:20 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.0d

for you to fetch changes up to 4ce7ca89d6e8eae9e201cd0e972ba323f33e2fb4:

  iio: imu: Use iio_trigger_get for indio_dev->trig assignment (2015-03-28 13:51:40 +0000)

----------------------------------------------------------------
IIO fixes for 4.0 set 4

A couple more IIO fixes.

* Fix check for HAS_IOMEM in the cc100001_adc driver to avoid build errors.
  Rather curiously it was ORed with Regulator and clock support.
* vf610 driver was trying to use an ADC clock outside the possible
  spec on some boards.  The driver assumed a fixed clock speed previously
  across all boards, but that is not true.  This fix ensures that the
  reported frequency is correct on all boards.
* The adis imu common code directly set the current trigger to the
  driver supplied one.  Unfortunately this didn't increase the use count
  leading to a double free via a particular path of changing the trigger
  then removing the driver.

----------------------------------------------------------------
Darshana Padmadas (1):
      iio: imu: Use iio_trigger_get for indio_dev->trig assignment

Richard Weinberger (1):
      iio/adc/cc10001_adc.c: Fix !HAS_IOMEM build

Stefan Agner (1):
      iio: adc: vf610: use ADC clock within specification

 drivers/iio/adc/Kconfig        |  3 +-
 drivers/iio/adc/vf610_adc.c    | 91 ++++++++++++++++++++++++++++--------------
 drivers/iio/imu/adis_trigger.c |  2 +-
 3 files changed, 64 insertions(+), 32 deletions(-)
