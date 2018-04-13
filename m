Return-Path: <SRS0=Jzh+=HC=vanguardiasur.com.ar=hernan@kernel.org>
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
Subject: [PATCH v2 03/14] staging: iio: ad7746: Fix bound checkings
Date: Fri, 13 Apr 2018 13:36:40 -0300
Message-Id: <1523637411-8531-4-git-send-email-hernan@vanguardiasur.com.ar>
In-Reply-To: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Also remove unnecessary parenthesis

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/staging/iio/cdc/ad7746.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 516aa93..d793785 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -458,7 +458,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 		ret = 0;
 		break;
 	case IIO_CHAN_INFO_CALIBBIAS:
-		if ((val < 0) | (val > 0xFFFF)) {
+		if (val < 0 || val > 0xFFFF) {
 			ret = -EINVAL;
 			goto out;
 		}
@@ -470,7 +470,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 		ret = 0;
 		break;
 	case IIO_CHAN_INFO_OFFSET:
-		if ((val < 0) | (val > 43008000)) { /* 21pF */
+		if (val < 0 || val > 43008000) { /* 21pF */
 			ret = -EINVAL;
 			goto out;
 		}
-- 
2.7.4
