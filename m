Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41909 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbbJKPBM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 11 Oct 2015 11:01:12 -0400
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 4.3 - set 1.
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <561A79B6.1000003@kernel.org>
Date: Sun, 11 Oct 2015 16:01:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 9ffecb10283508260936b96022d4ee43a7798b4c:

  Linux 4.3-rc3 (2015-09-27 07:50:08 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.3a

for you to fetch changes up to b94e22805a2224061bb263a82b72e09544a5fbb3:

  iio: mxs-lradc: Fix temperature offset (2015-10-11 15:02:02 +0100)

----------------------------------------------------------------
First set of IIO fixes for the 4.3 cycle.

* twl4030 - incorrect readings for some channels due to a failure to
  initialize a bias regulator or configure the lines for input rather than
  USB use.
* lis3lv02 - a missunderstanding of the way the interrupts worked on this
  chip lead to activation of the wrong interrupt.
* sca3000 - an old bug meant that memory corruption could occur in the
  hardware ring buffer readout function.
* mxs-lradc - wrong temp offset.

----------------------------------------------------------------
Adam YH Lee (1):
      iio: adc: twl4030: Fix ADC[3:6] readings

Alexandre Belloni (1):
      iio: mxs-lradc: Fix temperature offset

Dan Carpenter (1):
      iio: accel: sca3000: memory corruption in sca3000_read_first_n_hw_rb()

Linus Walleij (1):
      iio: st_accel: fix interrupt handling on LIS3LV02

 drivers/iio/accel/st_accel_core.c        |  6 ------
 drivers/iio/adc/twl4030-madc.c           | 34 ++++++++++++++++++++++++++++++++
 drivers/staging/iio/accel/sca3000_ring.c |  2 +-
 drivers/staging/iio/adc/mxs-lradc.c      |  9 +++++----
 4 files changed, 40 insertions(+), 11 deletions(-)
