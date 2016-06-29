Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36579 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbcF2RlC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jun 2016 13:41:02 -0400
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] Third set of fixes for IIO in the 4.7 cycle.
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1cb5bed4-54ab-9683-c33e-447f402d86e9@kernel.org>
Date: Wed, 29 Jun 2016 18:41:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit df013212a1b6557f071609983cab0612f71fd99b:

  Merge tag 'iio-fixes-for-4.7b' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2016-06-22 09:57:28 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.7c

for you to fetch changes up to 68b356eb3d9f5e38910fb62e22a78e2a18d544ae:

  iio:ad7266: Fix probe deferral for vref (2016-06-26 17:39:26 +0100)

----------------------------------------------------------------
Third set of fixes for IIO in the 4.7 cycle.

A couple of really old bugs and the results of Mark taking a close look at
some nasty regulator handling.

* ad7266
  - Fix broken regulator handling that won't play well with dummy regulators.
  - Correctly handle and optional regulator.
  - Fix probe deferral for the vref regulator.
* kxsd9
  - Fix a wrong error check that leads to an inability to write or read
  the scale.
* sca3000
  - Fix a wrong error check that leads to an inability to read back the
  sampling frequency.

----------------------------------------------------------------
Linus Walleij (1):
      iio: accel: kxsd9: fix the usage of spi_w8r8()

Luis de Bethencourt (1):
      staging: iio: accel: fix error check

Mark Brown (3):
      iio:ad7266: Fix broken regulator error handling
      iio:ad7266: Fix support for optional regulators
      iio:ad7266: Fix probe deferral for vref

 drivers/iio/accel/kxsd9.c                | 4 ++--
 drivers/iio/adc/ad7266.c                 | 7 +++++--
 drivers/staging/iio/accel/sca3000_core.c | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)
