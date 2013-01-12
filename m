Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44683 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322Ab3ALU7P (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Jan 2013 15:59:15 -0500
Message-ID: <50F1CEA1.6090606@kernel.org>
Date: Sat, 12 Jan 2013 20:59:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] [PULL] IIO fixes for v3.8-rc1 set 2
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 678fb42e2b2c815c3475884017aac4da22124d0d:

  iio: (max1363) Fix probe error path (2012-12-27 11:11:27 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.8b

for you to fetch changes up to a02a8c42b588059aa06dff6f614a7afcba12df69:

  staging:iio:adis16080: Perform sign extension (2013-01-09 21:15:33 +0000)

----------------------------------------------------------------
Second round of fixes for IIO post 3.8-rc1

Two tiny fixes
* A build warning fix due to signed / unsigned comparison
* Missing sign extension in adis16080

----------------------------------------------------------------
Fabio Estevam (1):
      iio: mxs-lradc: indexes are unsigned

Lars-Peter Clausen (1):
      staging:iio:adis16080: Perform sign extension

 drivers/staging/iio/adc/mxs-lradc.c       | 2 +-
 drivers/staging/iio/gyro/adis16080_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
