Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46614 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756229Ab2ICUDX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 3 Sep 2012 16:03:23 -0400
Message-ID: <50450D09.5060206@kernel.org>
Date: Mon, 03 Sep 2012 21:03:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for v3.6-rc1 set 2
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


The following changes since commit 95d1c8c7e26e303ccab5b65fe0ce04f70f42ea8a:

  iio: lm3533-als: Fix build warnings (2012-08-16 20:24:38 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/v3.6-rc1-iio-fixes-2

for you to fetch changes up to f755bbbf1f9f180aa61eb730d638b62e225bfc10:

  drivers/iio/adc/at91_adc.c: adjust inconsistent IS_ERR and PTR_ERR (2012-08-27 21:15:25 +0100)

----------------------------------------------------------------
IIO fixes for v3.6-rc1 set 2

A few simple fixes.

1)Fix up some possible divide by zero issues in various drivers.

2)Prevent a memory leak in an error path in lis3l02dq

3)Make sure the PTR_ERR call in at91_adc matches the
check for IS_ERR just above it rather than using a different
pointer.

Merges fine against v3.6rc4

----------------------------------------------------------------
Dan Carpenter (1):
      staging:iio: prevent divide by zero bugs

Julia Lawall (1):
      drivers/iio/adc/at91_adc.c: adjust inconsistent IS_ERR and PTR_ERR

Peter Meerwald (1):
      staging iio: fix potential memory leak in lis3l02dq_ring.c

 drivers/iio/adc/at91_adc.c                 | 2 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c | 4 +++-
 drivers/staging/iio/adc/ad7192.c           | 2 ++
 drivers/staging/iio/gyro/adis16260_core.c  | 2 ++
 drivers/staging/iio/imu/adis16400_core.c   | 2 ++
 drivers/staging/iio/meter/ade7753.c        | 2 ++
 drivers/staging/iio/meter/ade7754.c        | 2 ++
 drivers/staging/iio/meter/ade7759.c        | 2 ++
 8 files changed, 16 insertions(+), 2 deletions(-)
