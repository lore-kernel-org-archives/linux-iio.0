Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 06/12] iio: ad7291: fix mask bit generation
Date: Wed, 31 Aug 2011 12:57:34 +0200
Message-ID: <1314788260-5791-6-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com>
References: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7291.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 2fafca7..7dfdc27 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -417,7 +417,7 @@ static int ad7291_write_event_config(struct iio_dev *indio_dev,
 				~(1 << IIO_EVENT_CODE_EXTRACT_NUM(event_code));
 		else if (state && (!(chip->c_mask &
 				(1 << IIO_EVENT_CODE_EXTRACT_NUM(event_code)))))
-			chip->c_mask &=
+			chip->c_mask |=
 				(1 << IIO_EVENT_CODE_EXTRACT_NUM(event_code));
 		else
 			break;
-- 
1.7.0.4
