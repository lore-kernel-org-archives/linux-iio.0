Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/2] IIO: Kfifo usage improvements
Date: Sat, 30 Jun 2012 13:52:41 +0100
Message-Id: <1341060763-9602-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi All,

These have both been on the list before in various forms, be
it burried deep in threads.

Anyhow, please test these and review.

Jonathan

Jonathan Cameron (2):
  iio:kfifo_buf  Take advantage of the fixed record size used in IIO
  iio: kfifo - add poll support.

 drivers/iio/kfifo_buf.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

-- 
1.7.11.1
