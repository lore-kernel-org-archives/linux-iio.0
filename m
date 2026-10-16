Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE2347D45B;
	Fri, 16 Oct 2026 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792149437; cv=none; b=KvGefPoCNkRAF/U30E1A+q6Fhy8czlaLFL8D6wRqMW25+E1tRhMW9Jk6JjyzEwJ8bguzFz27Os1t0pp6brrmoRecxs748ZolX4gCmmEhq5ekDP+dEZNFDgrWKjr10u/ZjMBqEGFBJGJxbiuZPZGl8rsuq+5ESQ9+8HebZH5ILSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792149437; c=relaxed/simple;
	bh=p8iLKHeLSsqSHq5BgtXcXKEPiJD1O5exfgfWkIq8ETs=;
	h=From:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type; b=AgjbM47Nv8TGMcvkh+TxMd5D31vg5s7M1/Dg2M2wJVoooCnZEFRHthwryGhHONb7e3RIVT1YVhPgDQ6oAy/TKddmI5tvXwdZVX6M1vMzqdXCcbaHDW99f1n0wNBu54oplhMwGCwtvl0ZQZbhNfbLQCQSRPv68Gf8R/LzSpzs3WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DO/t5OuG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DO/t5OuG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 194A4C2BCF4;
	Fri, 16 Oct 2026 11:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792149437;
	bh=p8iLKHeLSsqSHq5BgtXcXKEPiJD1O5exfgfWkIq8ETs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=DO/t5OuGkGIDpxsgSQQZAaMcvn4oEp4VowpY5/pi0jmTw10FFQ/ZTf2gpy9ZW4eyb
	 vLnrogli2wNquxOZ1iMcanMVmRmFgE7mcqFAh7U67SZsP8AxvsN50YolVqjxtj/CpQ
	 Jwjp7qe/5lnQ0uLEKHK1ma/USIH4mlFzAj88htuoxGMEW3Jj6NjJwbZ5QYDWFf9Ho0
	 Y+kKqmbAyFH4TqJjcAKgPOvIpFr9ji/jqfZURBQ6MDlPeUw7sm3sNnWlWsGS3pmgiw
	 f0uYaP+Y2sGvwXIioGST+VhTHqXQ2pNU2blOcqzVoY6TXUSau+cE31rraFZG1rRHUI
	 VlPo0W4ATwXUQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94A6CCA462;
	Fri, 16 Oct 2026 11:17:16 +0000 (UTC)
From: Amir Atef via B4 Relay <devnull+amiratefabdallah1122.gmail.com@kernel.org>
Subject: [PATCH] staging: iio: frequency: ad9834: use guard(mutex)
Date: Fri, 16 Oct 2026 14:17:12 +0300
Message-Id: <179214943270.333.5921549521929682753.20261016-ad9834-guard-mutex@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792149432; l=3644;
 i=amiratefabdallah1122@gmail.com; s=20261016; h=from:subject:message-id;
 bh=b1+SRs3iAPcCs6+33+xk+21acapvMkXoR0sdLd32oT4=;
 b=eTM9ePPa1AzM1Tbm5Ij4l2P8xsth9a3dmtSM+YUgQN+ZqFJFvY7lqeLrd3PmMUxYAIFollqXh
 sRMZsk01lYIAlbISZDi1QbuuKeJmaa16TioawPSa+pP47EwLhwRfyDp
X-Developer-Key: i=amiratefabdallah1122@gmail.com; a=ed25519;
 pk=FRhtQptjt3GSkQBUg7qfVL8eusorsJqHzciu3+ss11o=
X-Endpoint-Received: by B4 Relay for
 amiratefabdallah1122@gmail.com/20261016 with auth_id=1209
X-Original-From: Amir Atef <amiratefabdallah1122@gmail.com>
Reply-To: amiratefabdallah1122@gmail.com

From: Amir Atef <amiratefabdallah1122@gmail.com>

Use guard(mutex) to manage the state lock in ad9834_write() and
ad9834_store_wavetype(). simplifies error handling by allowing
early returns instead of setting the return code and breaking out of the
switch statement to manually unlock the mutex.

Signed-off-by: Amir Atef <amiratefabdallah1122@gmail.com>
---
 drivers/staging/iio/frequency/ad9834.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 0d20f796e0f0..76a520280f68 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/dev_printk.h>
 #include <linux/err.h>
@@ -155,7 +156,7 @@ static ssize_t ad9834_write(struct device *dev,
 	if (ret)
 		return ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	switch ((u32)this_attr->address) {
 	case AD9834_REG_FREQ0:
 	case AD9834_REG_FREQ1:
@@ -166,10 +167,8 @@ static ssize_t ad9834_write(struct device *dev,
 		ret = ad9834_write_phase(st, this_attr->address, val);
 		break;
 	case AD9834_OPBITEN:
-		if (st->control & AD9834_MODE) {
-			ret = -EINVAL;  /* AD9834 reserved mode */
-			break;
-		}
+		if (st->control & AD9834_MODE)
+			return -EINVAL;  /* AD9834 reserved mode */
 
 		if (val)
 			st->control |= AD9834_OPBITEN;
@@ -193,8 +192,7 @@ static ssize_t ad9834_write(struct device *dev,
 			st->control |= this_attr->address;
 			st->control &= ~AD9834_PIN_SW;
 		} else {
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
 		st->data = cpu_to_be16(AD9834_REG_CMD | st->control);
 		ret = spi_sync(st->spi, &st->msg);
@@ -209,9 +207,8 @@ static ssize_t ad9834_write(struct device *dev,
 		ret = spi_sync(st->spi, &st->msg);
 		break;
 	default:
-		ret = -ENODEV;
+		return -ENODEV;
 	}
-	mutex_unlock(&st->lock);
 
 	return ret ? ret : len;
 }
@@ -223,11 +220,11 @@ static ssize_t ad9834_store_wavetype(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad9834_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int ret = 0;
+	int ret;
 	bool is_ad9833_7 = (st->devid == ID_AD9833) || (st->devid == ID_AD9837);
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	switch ((u32)this_attr->address) {
 	case 0:
@@ -239,7 +236,7 @@ static ssize_t ad9834_store_wavetype(struct device *dev,
 				st->control &= ~AD9834_OPBITEN;
 				st->control |= AD9834_MODE;
 			} else if (st->control & AD9834_OPBITEN) {
-				ret = -EINVAL;	/* AD9834 reserved mode */
+				return -EINVAL;	/* AD9834 reserved mode */
 			} else {
 				st->control |= AD9834_MODE;
 			}
@@ -247,7 +244,7 @@ static ssize_t ad9834_store_wavetype(struct device *dev,
 			st->control &= ~AD9834_MODE;
 			st->control |= AD9834_OPBITEN;
 		} else {
-			ret = -EINVAL;
+			return -EINVAL;
 		}
 
 		break;
@@ -257,19 +254,15 @@ static ssize_t ad9834_store_wavetype(struct device *dev,
 			st->control &= ~AD9834_MODE;
 			st->control |= AD9834_OPBITEN;
 		} else {
-			ret = -EINVAL;
+			return -EINVAL;
 		}
 		break;
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
 
-	if (!ret) {
-		st->data = cpu_to_be16(AD9834_REG_CMD | st->control);
-		ret = spi_sync(st->spi, &st->msg);
-	}
-	mutex_unlock(&st->lock);
+	st->data = cpu_to_be16(AD9834_REG_CMD | st->control);
+	ret = spi_sync(st->spi, &st->msg);
 
 	return ret ? ret : len;
 }
-- 
2.51.0



