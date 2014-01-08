Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35677 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591AbaAHUAE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jan 2014 15:00:04 -0500
Message-ID: <52CDAE4A.7000200@kernel.org>
Date: Wed, 08 Jan 2014 20:00:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PULL] IIO new drivers, features and cleanups for 3.14 - set 3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit a6e8e3a470bf96575eebfa9dbfda6e1ec8929fb8:

   Merge tag 'iio-for-3.14b' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2013-12-24 10:30:57 -0800)

are available in the git repository at:


   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.14c

for you to fetch changes up to 38125b2c935b0037787ca213f96a7b976eba3199:

   iio: mxs-lradc: convert is_divided to a bitmap (2014-01-01 14:31:56 +0000)

----------------------------------------------------------------
Third round of new drivers, features and cleanups for IIO in the 3.14 cycle.

One new driver a spot of new functionality and a cleanup.

* New driver for the Capella CM32181 ambient light sensor. This is the first
   driver directly from Kevin at Capella with more already in the pipeline.
* Support for configurable predividers on the mxs lradc
* Convert a field to a bitmap in mxs lradc instead of using an array of
   unsigned longs to store boolean values.

----------------------------------------------------------------
Alexandre Belloni (1):
       iio: mxs-lradc: convert is_divided to a bitmap

Hector Palacios (3):
       iio: mxs-lradc: add scale attribute to channels
       iio: mxs-lradc: add scale_available file to channels
       iio: mxs-lradc: add write_raw function to modify scale

Kevin Tsai (1):
       iio: add Capella CM32181 ambient light sensor driver.

  .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
  drivers/iio/light/Kconfig                          |  11 +
  drivers/iio/light/Makefile                         |   1 +
  drivers/iio/light/cm32181.c                        | 379 +++++++++++++++++++++
  drivers/staging/iio/adc/mxs-lradc.c                | 222 +++++++++++-
  5 files changed, 611 insertions(+), 3 deletions(-)
  create mode 100644 drivers/iio/light/cm32181.c
