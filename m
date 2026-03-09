Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130583BE16B
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773066297; cv=none; b=m7t6dgU+/lW3IufsZBzsVE/uQo0MLGDhJgBAIcsbh6o8GHT3y9XyIPSY8tF6T7ArwaidGJrYP8t08+P/8L9jRt9xspRl2plDoY2Wmz+83UWWZOvDfDr9SP7sc35I3lDo9Qwm+7FyLbGlzY3OYejglolbxZv7Cg4InckQSEBnv3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773066297; c=relaxed/simple;
	bh=tYmlw5EJddPO0i/7GhVZcraSQ1Bss/FoOSAoivPvmjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5qt6rRZ5JFxNIF5WOz3McAg3YOoZDKq9XiOZtf2KDCxqUddBB5hW/TfGirASVHPixutCJRcwniDfN6BbdsOUbX175ESBpYDYgJd+VeROSPfTSpZX7g7WEUcXGW9JMuvOsnbr1na42mzaK29+J4w3eiGPHtr0xByfmaMnRcxTN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/e47GfR; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/e47GfR"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35984cd0335so3453430a91.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 07:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066295; x=1773671095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJhbrAfBpXsuKw1KxcluPw8lwJFwkriN9862ZTb+amQ=;
        b=h/e47GfRu7HtQlR9/bqGMG+n9sM451AxE3VNTmj6JrgxqUiYafcsu1OE3gQ5Ppdvol
         HL/riBshk2uuEBZcCOvwHT6b8FYrCPaztQu9DV7UDJ6pZH79lHuTwqd4dw+ZYgVMf2H/
         1Ei7MCntEE6UgHn4W6ZYkKlozRfFMXLegwVbTkNDE1JKtpCT+iLq//CjnYrNXvUEZvWl
         DZKj1eo/W7QzYsa89Eby/1+eZcYi0sp5oNcUbpNaNMJSZGLOBcWmMzHWYsrX86YDFaPM
         XVsA86GnHQn6eK6PiZr2gFFoyW5crRCP1D6Yk2Gt5PL0XXouXGVCsH9I2JuiMdwHH9IW
         aD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066295; x=1773671095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iJhbrAfBpXsuKw1KxcluPw8lwJFwkriN9862ZTb+amQ=;
        b=IA5JZdimL4iL38gPvpR7RrhjF8NA6rSmlZ0UtYjC+rYRWcc2vDk06ngnHe7cBtSrSz
         XKZrc5/s82Bu7agInqRoEYGs+dYoxPtArTpAy18gHtvuYHaljeufXrLh42E53aneY0eH
         ftoV8eUgkSWYl+wdHm4WHXnphxkstPz5y5nKqx1BeEUO9dsqrTmCUCOreq1vbzPIYK8h
         Nql1jPi+CXea3O7aUT46NKEJSGp7gpgdd4PlJLgU4JKEkIIwk1iXL3N8ZAGu55KgGzDU
         +sQXzK/yMg1TVODUZvowzkGH4Tk+NQgc+utz80Q9j/3kFq/PLlEEYTCUPLUH1DScCs9o
         CrqQ==
X-Gm-Message-State: AOJu0Yw+7XFBqKoGKuOUCxe6DGFVIaHuMs+R7VIa/cVZ+58hq+fvDmOy
	0+7WiKX/W/W87f9pTLkcXjsIwFVQLyJOhRglAplEhP7tMUHNt196Gcti
X-Gm-Gg: ATEYQzzLZCOZwYleKPtHVlSUYQo21MHTaAYra4MQau0/MXNKd4Jf9yzB7ELrtNRmRej
	S9zidt7fdHFsrIiBM8li/uqo7b19DUFfc50M0dOvn7I9ETgX+I0gxlGM5TVMAkPB3JRbPaDzg0Q
	pcGJ79fd51CLAy+fA8a7dUmUD1UgpWh9Un9EX5QOCauKESxkqoueDj9IEgr1jf5rFEU95g3VJ6K
	Cmc7wR1USZfLNloK65xkawV2+ZFhlziP2ZqTWXOSKVZnt3sZoM8vdFrsYp7nNj7FRks4kU5Mvn1
	3TtAmj3Eg5kg955xX3i7nynhKBGPYQb2Gyj35xuXeu3hXsMdgFFBIctlp09kfsYg0DScxtpmjK7
	FJ6XgAx/KdCD0olrRWy03SzXJl8P20O+NN7GjDoxlucCUIPswq9TahFFKEdeLYSVwqCAY68kq71
	eh25AEa/I3UfaK64+oHPj4pCIgQOmzS6pLyMpDYWqPBGOdW4PalKeLrzyZFIVraG2W34KsSdnmU
	9Gmy+T8YtB9yPt/BAGIfNWdtLI=
X-Received: by 2002:a17:90b:48cd:b0:356:21e9:73ff with SMTP id 98e67ed59e1d1-359be354bc7mr8880922a91.11.1773066295430;
        Mon, 09 Mar 2026 07:24:55 -0700 (PDT)
Received: from fedora ([2401:4900:1c80:20f6:77bf:3a75:33cb:748c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2e0e1aasm18985311a91.15.2026.03.09.07.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:24:54 -0700 (PDT)
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	waqar.hameed@axis.com,
	linusw@kernel.org,
	sakari.ailus@linux.intel.com,
	harshit.m.mogalapalli@oracle.com,
	antoniu.miclaus@analog.com,
	andrew.ijano@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Subject: [PATCH 4/4] iio: accel: sca3000: convert to guard(mutex)
Date: Mon,  9 Mar 2026 19:53:52 +0530
Message-ID: <20260309142352.57407-5-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309142352.57407-1-rajveer.chaudhari.linux@gmail.com>
References: <20260309142352.57407-1-rajveer.chaudhari.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex_lock/mutex_unlock pair with guard(mutex) in
sca3000_print_rev(). This ensures the mutex is
released on all return paths and allows returning directly
without a goto label.

Aligned	headers	in alphabatical	order.

Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
---
 drivers/iio/accel/sca3000.c | 115 ++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 63 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 4a827be439a2..05c91dfbc6ab 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -7,20 +7,23 @@
  * See industrialio/accels/sca3000.h for comments.
  */
 
-#include <linux/interrupt.h>
-#include <linux/fs.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
-#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
-#include <linux/spi/spi.h>
-#include <linux/sysfs.h>
 #include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <linux/uaccess.h>
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-#include <linux/iio/events.h>
+
 #include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
+#include <linux/iio/sysfs.h>
+
+#include <linux/spi/spi.h>
 
 #define SCA3000_WRITE_REG(a) (((a) << 2) | 0x02)
 #define SCA3000_READ_REG(a) ((a) << 2)
@@ -424,16 +427,16 @@ static int sca3000_print_rev(struct iio_dev *indio_dev)
 	int ret;
 	struct sca3000_state *st = iio_priv(indio_dev);
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	ret = sca3000_read_data_short(st, SCA3000_REG_REVID_ADDR, 1);
 	if (ret < 0)
-		goto error_ret;
+		return ret;
+
 	dev_info(&indio_dev->dev,
 		 "sca3000 revision major=%lu, minor=%lu\n",
 		 st->rx[0] & SCA3000_REG_REVID_MAJOR_MASK,
 		 st->rx[0] & SCA3000_REG_REVID_MINOR_MASK);
-error_ret:
-	mutex_unlock(&st->lock);
 
 	return ret;
 }
@@ -996,13 +999,14 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
 	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret, i, num_available;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	if (val & SCA3000_REG_INT_STATUS_HALF) {
 		ret = sca3000_read_data_short(st, SCA3000_REG_BUF_COUNT_ADDR,
 					      1);
 		if (ret)
-			goto error_ret;
+			return;
+
 		num_available = st->rx[0];
 		/*
 		 * num_available is the total number of samples available
@@ -1011,7 +1015,8 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
 		ret = sca3000_read_data(st, SCA3000_REG_RING_OUT_ADDR, st->rx,
 					num_available * 2);
 		if (ret)
-			goto error_ret;
+			return;
+
 		for (i = 0; i < num_available / 3; i++) {
 			/*
 			 * Dirty hack to cover for 11 bit in fifo, 13 bit
@@ -1023,8 +1028,6 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
 			iio_push_to_buffers(indio_dev, st->rx + i * 3 * 2);
 		}
 	}
-error_ret:
-	mutex_unlock(&st->lock);
 }
 
 /**
@@ -1110,11 +1113,11 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
 	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret;
 	/* read current value of mode register */
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
-		goto error_ret;
+		return ret;
 
 	switch (chan->channel2) {
 	case IIO_MOD_X_AND_Y_AND_Z:
@@ -1134,7 +1137,7 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
 			ret = sca3000_read_ctrl_reg(st,
 						SCA3000_REG_CTRL_SEL_MD_CTRL);
 			if (ret < 0)
-				goto error_ret;
+				return ret;
 			/* only supporting logical or's for now */
 			ret = !!(ret & sca3000_addresses[chan->address][2]);
 		}
@@ -1143,9 +1146,6 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
 		ret = -EINVAL;
 	}
 
-error_ret:
-	mutex_unlock(&st->lock);
-
 	return ret;
 }
 
@@ -1277,10 +1277,12 @@ int __sca3000_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
 	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
-		goto error_ret;
+		return ret;
+
 	if (state) {
 		dev_info(&indio_dev->dev, "supposedly enabling ring buffer\n");
 		ret = sca3000_write_reg(st,
@@ -1290,8 +1292,6 @@ int __sca3000_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
 		ret = sca3000_write_reg(st,
 			SCA3000_REG_MODE_ADDR,
 			(st->rx[0] & ~SCA3000_REG_MODE_RING_BUF_ENABLE));
-error_ret:
-	mutex_unlock(&st->lock);
 
 	return ret;
 }
@@ -1310,26 +1310,20 @@ static int sca3000_hw_ring_preenable(struct iio_dev *indio_dev)
 	int ret;
 	struct sca3000_state *st = iio_priv(indio_dev);
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	/* Enable the 50% full interrupt */
 	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
-		goto error_unlock;
+		return ret;
+
 	ret = sca3000_write_reg(st,
 				SCA3000_REG_INT_MASK_ADDR,
 				st->rx[0] | SCA3000_REG_INT_MASK_RING_HALF);
 	if (ret)
-		goto error_unlock;
-
-	mutex_unlock(&st->lock);
+		return ret;
 
 	return __sca3000_hw_ring_state_set(indio_dev, 1);
-
-error_unlock:
-	mutex_unlock(&st->lock);
-
-	return ret;
 }
 
 static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
@@ -1342,17 +1336,15 @@ static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
 		return ret;
 
 	/* Disable the 50% full interrupt */
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
-		goto unlock;
-	ret = sca3000_write_reg(st,
+		return ret;
+
+	return sca3000_write_reg(st,
 				SCA3000_REG_INT_MASK_ADDR,
 				st->rx[0] & ~SCA3000_REG_INT_MASK_RING_HALF);
-unlock:
-	mutex_unlock(&st->lock);
-	return ret;
 }
 
 static const struct iio_buffer_setup_ops sca3000_ring_setup_ops = {
@@ -1372,25 +1364,26 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 {
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	/* Ensure all interrupts have been acknowledged */
 	ret = sca3000_read_data_short(st, SCA3000_REG_INT_STATUS_ADDR, 1);
 	if (ret)
-		goto error_ret;
+		return ret;
 
 	/* Turn off all motion detection channels */
 	ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_MD_CTRL);
 	if (ret < 0)
-		goto error_ret;
+		return ret;
 	ret = sca3000_write_ctrl_reg(st, SCA3000_REG_CTRL_SEL_MD_CTRL,
 				     ret & SCA3000_MD_CTRL_PROT_MASK);
 	if (ret)
-		goto error_ret;
+		return ret;
 
 	/* Disable ring buffer */
 	ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL);
 	if (ret < 0)
-		goto error_ret;
+		return ret;
 	ret = sca3000_write_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL,
 				     (ret & SCA3000_REG_OUT_CTRL_PROT_MASK)
 				     | SCA3000_REG_OUT_CTRL_BUF_X_EN
@@ -1398,17 +1391,17 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 				     | SCA3000_REG_OUT_CTRL_BUF_Z_EN
 				     | SCA3000_REG_OUT_CTRL_BUF_DIV_4);
 	if (ret)
-		goto error_ret;
+		return ret;
 	/* Enable interrupts, relevant to mode and set up as active low */
 	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
-		goto error_ret;
+		return ret;
 	ret = sca3000_write_reg(st,
 				SCA3000_REG_INT_MASK_ADDR,
 				(ret & SCA3000_REG_INT_MASK_PROT_MASK)
 				| SCA3000_REG_INT_MASK_ACTIVE_LOW);
 	if (ret)
-		goto error_ret;
+		return ret;
 	/*
 	 * Select normal measurement mode, free fall off, ring off
 	 * Ring in 12 bit mode - it is fine to overwrite reserved bits 3,5
@@ -1416,13 +1409,10 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 	 */
 	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
-		goto error_ret;
-	ret = sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
-				(st->rx[0] & SCA3000_MODE_PROT_MASK));
+		return ret;
 
-error_ret:
-	mutex_unlock(&st->lock);
-	return ret;
+	return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
+				(st->rx[0] & SCA3000_MODE_PROT_MASK));
 }
 
 static const struct iio_info sca3000_info = {
@@ -1504,18 +1494,17 @@ static int sca3000_stop_all_interrupts(struct sca3000_state *st)
 {
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
-		goto error_ret;
-	ret = sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
+		return ret;
+
+	return sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
 				(st->rx[0] &
 				 ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
 				   SCA3000_REG_INT_MASK_RING_HALF |
 				   SCA3000_REG_INT_MASK_ALL_INTS)));
-error_ret:
-	mutex_unlock(&st->lock);
-	return ret;
 }
 
 static void sca3000_remove(struct spi_device *spi)
-- 
2.53.0

