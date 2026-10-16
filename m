Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF2E3101A6;
	Fri, 16 Oct 2026 23:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792194358; cv=none; b=j7MMeUj1LPiIY3eSZ+LweV6Uay+jf9vZJPxZQBly9Bia1CNfgMgedN6Vi/HZwSkhq9Z2NXWDhIqZdeKNhCHL4OhwFIEe0H8cRtegDeovQRs5jcuwsUeFbFDQB5mqegEOFwMO0zyHfTuZUY+gpO87ZChyqNmyZDmS8yFrNtIxd14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792194358; c=relaxed/simple;
	bh=gs32zXmkqfNnDVhhozI3eslbeo8A7IlYN/2jK6jv1uk=;
	h=From:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type; b=rCcsGyWjgX/Q2QESdVYtMCsjW5dcXXsI8cSop+U9VRWAciL24AzrDwMo3GUtdhNG7cIg/MA46Mmk0KwdU2czGZqvaDezhMCOPICnrqqoIp2eGO3OyAMvHSuMO77B39ktGmGTQef3NxplS0eiUFZsFBq9aqRU67gtTa1xpb2eLZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoKkzt+E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoKkzt+E"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B56BC2BCF4;
	Fri, 16 Oct 2026 23:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792194358;
	bh=gs32zXmkqfNnDVhhozI3eslbeo8A7IlYN/2jK6jv1uk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=XoKkzt+E71f0q0TAgbfXIuGHZz6T+PRUJTjBgS/SVXjDvTimEJjfOdTVV6dkPZObx
	 1wZp3syUNWcsAfYwWD1qyzP5AanIE898CoeNv28fcUELu9vR/ozuDa69pKyjIAMcyw
	 oEpGlEmhOIzme82+Oslr1IP5KDpX2VqBKV/0+VNRjCAd1/vJIYtv/xiVeuThfYyuWE
	 x2Vx4wjeCFS8uVJu2VpsM1m3ZD0mOiNHUdy9OJpkyjkJ1yLBrMFcOfeDiVVe22loZD
	 edru4FWMZTemFCIy5B6m78URU+HAUha73IL6z4TheHvyk7xpqWFHGDQWz2hybPkwKm
	 AEiuMzAUZ2/qw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56799CCA46C;
	Fri, 16 Oct 2026 23:45:58 +0000 (UTC)
From: Amir Atef via B4 Relay <devnull+amiratefabdallah1122.gmail.com@kernel.org>
Subject: [PATCH v2] staging: iio: frequency: ad9834: use guard(mutex)
Date: Sat, 17 Oct 2026 02:45:52 +0300
Message-Id: <179219435216.322.13409717511306957730.20261017-ad9834-guard-mutex-v2@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792194352; l=4410;
 i=amiratefabdallah1122@gmail.com; s=20261016; h=from:subject:message-id;
 bh=QC3WjUcRokALSjuAgdPJHx7Z+g92N3srbIAjHSHgWH0=;
 b=XqlHDjIA8XspS27KHuZUtY1Q9oxs7Yin5t4IjtP4AZgGZvqWRSEuhAIOQZebtLSetiYdydJ5z
 Bb6H5vmf0WyA2YwWr4yKFsbGkzOgT7Lrx/mkq6UAnVIfyVOpQqWpgmE
X-Developer-Key: i=amiratefabdallah1122@gmail.com; a=ed25519;
 pk=FRhtQptjt3GSkQBUg7qfVL8eusorsJqHzciu3+ss11o=
X-Endpoint-Received: by B4 Relay for
 amiratefabdallah1122@gmail.com/20261016 with auth_id=1209
X-Original-From: Amir Atef <amiratefabdallah1122@gmail.com>
Reply-To: amiratefabdallah1122@gmail.com

From: Amir Atef <amiratefabdallah1122@gmail.com>

Use guard(mutex) to manage the state lock in ad9834_write() and
ad9834_store_wavetype(). This simplifies error handling by allowing
early returns instead of setting the return code and breaking out of the
switch statement to manually unlock the mutex.

Signed-off-by: Amir Atef <amiratefabdallah1122@gmail.com>
---
Changes in v2:
- Add blank line after guard(mutex) in ad9834_write().
- Move 'int ret;' to the end of the variable declaration block in
  ad9834_store_wavetype().
- Drop redundant 'else' in ad9834_store_wavetype() case 1 by inverting
  the condition (kept 'else' in ad9834_write() and case 0 where they are
  part of if-else-if-else chains).
- Replace ternary return with explicit 'if (ret) return ret;' in
  ad9834_store_wavetype().
- Link to v1: https://lore.kernel.org/r/179214943270.333.5921549521929682753.20261016-ad9834-guard-mutex@gmail.com

 drivers/staging/iio/frequency/ad9834.c | 50 ++++++++++++--------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 0d20f796e0f0..c45bb388c998 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/dev_printk.h>
 #include <linux/err.h>
@@ -154,7 +155,8 @@ static ssize_t ad9834_write(struct device *dev,
 	if (ret)
 		return ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	switch ((u32)this_attr->address) {
 	case AD9834_REG_FREQ0:
 	case AD9834_REG_FREQ1:
@@ -165,10 +167,8 @@ static ssize_t ad9834_write(struct device *dev,
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
@@ -194,8 +194,7 @@ static ssize_t ad9834_write(struct device *dev,
 			st->control |= this_attr->address;
 			st->control &= ~AD9834_PIN_SW;
 		} else {
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
 		st->data = cpu_to_be16(AD9834_REG_CMD | st->control);
 		ret = spi_sync(st->spi, &st->msg);
@@ -210,9 +209,8 @@ static ssize_t ad9834_write(struct device *dev,
 		ret = spi_sync(st->spi, &st->msg);
 		break;
 	default:
-		ret = -ENODEV;
+		return -ENODEV;
 	}
-	mutex_unlock(&st->lock);
 
 	return ret ? ret : len;
 }
@@ -225,10 +223,10 @@ static ssize_t ad9834_store_wavetype(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad9834_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int ret = 0;
 	bool is_ad9833_7 = (st->devid == ID_AD9833) || (st->devid == ID_AD9837);
+	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	switch ((u32)this_attr->address) {
 	case 0:
@@ -241,7 +239,7 @@ static ssize_t ad9834_store_wavetype(struct device *dev,
 				st->control &= ~AD9834_OPBITEN;
 				st->control |= AD9834_MODE;
 			} else if (st->control & AD9834_OPBITEN) {
-				ret = -EINVAL;	/* AD9834 reserved mode */
+				return -EINVAL;	/* AD9834 reserved mode */
 			} else {
 				st->control |= AD9834_MODE;
 			}
@@ -249,31 +247,27 @@ static ssize_t ad9834_store_wavetype(struct device *dev,
 			st->control &= ~AD9834_MODE;
 			st->control |= AD9834_OPBITEN;
 		} else {
-			ret = -EINVAL;
+			return -EINVAL;
 		}
 
 		break;
 	case 1:
-		if (sysfs_streq(buf, "square") &&
-		    !(st->control & AD9834_MODE)) {
-			st->control &= ~AD9834_MODE;
-			st->control |= AD9834_OPBITEN;
-		} else {
-			ret = -EINVAL;
-		}
+		if (!sysfs_streq(buf, "square") || (st->control & AD9834_MODE))
+			return -EINVAL;
+
+		st->control &= ~AD9834_MODE;
+		st->control |= AD9834_OPBITEN;
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
+	if (ret)
+		return ret;
 
-	return ret ? ret : len;
+	return len;
 }
 
 static
-- 
2.51.0



