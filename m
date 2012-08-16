Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34828 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933220Ab2HPUDb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Aug 2012 16:03:31 -0400
Message-ID: <502D5211.5020206@kernel.org>
Date: Thu, 16 Aug 2012 21:03:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL V2] IIO Fixes for v3.6-rc1
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/v3.6-rc1-iio-fixes

for you to fetch changes up to 95d1c8c7e26e303ccab5b65fe0ce04f70f42ea8a:

  iio: lm3533-als: Fix build warnings (2012-08-16 20:24:38 +0100)

----------------------------------------------------------------
IIO fixes for v3.6-rc1

These mostly consist of fixes from Lars-Peter Clausen that were
the first part of a large series reworking the drivers concerned.
Turns out these drivers had quite a wealth of minor bugs.

Also here are some build warning fixes for lm3533-als and
adjd_s111 (both new drives in this cycle).
Final elements are a a div factor overflow and a warning
related fix in a couple of Analog Devices drivers.

All in all nothing major, but a worthwhile bunch of short
fixes.

----------------------------------------------------------------
Alexey Khoroshilov (1):
      iio/adjd_s311: Fix potential memory leak in adjd_s311_update_scan_mode()

Axel Lin (1):
      iio: lm3533-als: Fix build warnings

Lars-Peter Clausen (12):
      staging:iio:ad7793: Add missing break in switch statement
      staging:iio:ad7793: Mark channels as unsigned
      staging:iio:ad7793: Report channel offset
      staging:iio:ad7793: Fix temperature scale and offset
      staging:iio:ad7793: Follow new IIO naming spec
      staging:iio:ad7793: Fix internal reference value
      staging:iio:ad7192: Add missing break in switch statement
      staging:iio:ad7192: Fix setting ACX
      staging:iio:ad7192: Mark channels as unsigned
      staging:iio:ad7192: Report channel offset
      staging:iio:ad7192: Report offset and scale for temperature channel
      staging:iio:ad7780: Mark channels as unsigned

Michael Hennerich (2):
      iio: staging: ad7298_ring: Fix maybe-uninitialized warning
      iio: frequency: ADF4350: Fix potential reference div factor overflow.

 drivers/iio/frequency/adf4350.c       | 24 +++++----
 drivers/iio/light/adjd_s311.c         |  7 +--
 drivers/iio/light/lm3533-als.c        |  4 +-
 drivers/staging/iio/adc/ad7192.c      | 48 +++++++++--------
 drivers/staging/iio/adc/ad7298_ring.c |  2 +-
 drivers/staging/iio/adc/ad7780.c      | 10 ++--
 drivers/staging/iio/adc/ad7793.c      | 99 +++++++++++++++++++++--------------
 include/linux/iio/frequency/adf4350.h |  2 +
 8 files changed, 116 insertions(+), 80 deletions(-)
