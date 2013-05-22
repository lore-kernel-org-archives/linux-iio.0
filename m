Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39589 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756513Ab3EVWIK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 May 2013 18:08:10 -0400
Message-ID: <519D41C7.10304@kernel.org>
Date: Wed, 22 May 2013 23:08:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 3.10 - set 1
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit c7b0cf3e712775e8e2015c2f4582864159540be6:

  staging: imx-drm: imx-tve: Check the return value of 'regulator_enable()' (2013-05-21 10:48:54 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.10a

for you to fetch changes up to 927b4dc3e440a060bd7d9a7ecb83c3dcd80adc84:

  iio: exynos_adc: fix wrong structure extration in suspend and resume (2013-05-22 22:15:20 +0100)

----------------------------------------------------------------
First round of IIO fixes for the 3.10 cycle.

The usual mixed bag of little fixes.

1) A fix for mxs-lradc having missed out on some global abi changes that and
   hence being unable to start up buffered output.
2) Clean up error handling in tsl2x7x
3) A build fix for some of the dac drivers when they have spi master support
   built in, but i2c support build as a module.
4) Add a missing disable after a oneshot capture to the st sensor core.
5) Exynos adc driver took a novel an incorrect route to get at its private
   data store.

----------------------------------------------------------------
Axel Lin (1):
      iio: dac: Fix build error when CONFIG_SPI_MASTER=y && CONFIG_I2C=m

Denis CIOCCA (1):
      iio:common:st: added disable function after read info raw data

Michał Mirosław (1):
      staging/iio/mxs-lradc: fix preenable for multiple buffers

Naveen Krishna Chatradhi (1):
      iio: exynos_adc: fix wrong structure extration in suspend and resume

Wei Yongjun (1):
      staging:iio:light:tsl2x7x: fix the error handling in tsl2x7x_probe()

 drivers/iio/adc/exynos_adc.c                    | 8 ++++----
 drivers/iio/common/st_sensors/st_sensors_core.c | 2 ++
 drivers/iio/dac/Kconfig                         | 6 +++---
 drivers/staging/iio/adc/mxs-lradc.c             | 5 ++---
 drivers/staging/iio/light/tsl2x7x_core.c        | 9 +++++----
 5 files changed, 16 insertions(+), 14 deletions(-)
