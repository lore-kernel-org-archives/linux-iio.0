Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:49891 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755512Ab1K0Oqt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2011 09:46:49 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
	manuel.stahl@iis.fraunhofer.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/3] staging:iio: more buffer related cleanups.
Date: Sun, 27 Nov 2011 14:46:50 +0000
Message-Id: <1322405213-13570-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These were after the inkern pull interface stuff in my tree, but
with a closer look they clearly aren't dependent on it so I'll tack
them on to the end of the previous series if everyone is happy.

Jonathan

Jonathan Cameron (3):
  staging:iio:buffer scrap to_iio_buffer as it no longer has meaning.
  staging:iio:buffer struct iio_buffer doesn't need an indio_dev
    pointer.
  staging:iio:buffer.h update struct buffer docs.

 drivers/staging/iio/accel/sca3000_core.c        |    6 +++---
 drivers/staging/iio/accel/sca3000_ring.c        |   11 ++++-------
 drivers/staging/iio/buffer.h                    |   21 +++++++++++----------
 drivers/staging/iio/gyro/adis16260_core.c       |   15 ++++++++++-----
 drivers/staging/iio/impedance-analyzer/ad5933.c |    4 ++--
 drivers/staging/iio/industrialio-buffer.c       |   15 +++++++--------
 drivers/staging/iio/kfifo_buf.c                 |    2 +-
 drivers/staging/iio/ring_sw.c                   |    2 +-
 8 files changed, 39 insertions(+), 37 deletions(-)

-- 
1.7.7.3

