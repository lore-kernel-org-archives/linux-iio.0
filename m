Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042192BE05A
	for <linux-iio@vger.kernel.org>; Fri,  3 Jul 2026 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783099424; cv=none; b=j9QK599FxNCJcyTuEwJmM9VfnIPTX28TXb/W+4gyRsVaXwlKQ/iqLknQ60BMoWaV22n0BEudCe9CupLXKYMoLybDWKWzJwa+3iYUIcn6+kjzbVFxmBEiAz4oAWfDAlGo6rsTR+CWAp81RQtmV0RqZYJwFWYTsoFyujOr3xT//3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783099424; c=relaxed/simple;
	bh=qYdz2l34v0TN2JYJeoaC/tJNCP8br4hld4P1rmIFcX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TB8BEN1IXic3oFmvVuWLIezT1g1mu6lQeFAuc2bVSqr+cQfoJXOsi1dagMtMrMgdfLzD6Ur49G4c3XXgoSStpoxxZV8rogpSLV/XeGI2L/9D/jqKq6fNHXM7B1zsKAQK1jN9LY1KqHSDTEacW9IV8NZWzE5v5zxYLZ5EmifUkz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYff+hbD; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYff+hbD"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-37fdee9276fso944733a91.3
        for <linux-iio@vger.kernel.org>; Fri, 03 Jul 2026 10:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783099422; x=1783704222; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OAt4kNYvWXjXbGFFUdudUFDT14XCYrT0MRiQUEJCymA=;
        b=NYff+hbDYBIYAR1jJqedEEwbz2mqQx/OuQoE6mhoZTArn1CZHl1SGm+UzZXA+wM86g
         jLaXnb2C8Z0cjf3RPNwLezyAksYMSkwapmufyFUAYiAcJIvhw4Yz77lJ0hf8QMErwpWK
         uF/qf2qlHzhftfdo1Ce/uIRt1LvwO0+eXUj7P0vxpSZ9sSxnREEJW3HuGTHg8Ey3+A6m
         Bp4kqGQBUBuJ5x9KZpXxPPmgGqfvgEZ8OfT+8JYfewYCFyz0YVYX7yheh1ifUYo3Y0WB
         h8OjOxJPjRRuW8QRv5NJvW5ROizwtGujrx1F9MbRaDU6AwHpO6yAu7oO6r9sl0FrM2aI
         aBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783099422; x=1783704222;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OAt4kNYvWXjXbGFFUdudUFDT14XCYrT0MRiQUEJCymA=;
        b=bXQABuYq2aScazCTo3XdRpI6hyI4OPWibbKg5kAKKTPBsc5wrGVbC0EjuUFa1WxwTI
         o+3zx/MGPX2KoE3gsIQp9bZ+LlQYb9ViMt6jMtbPrcMDq1KxzZZJK1Go7u3R2t0InFRk
         MFU3QgyUX6C8PX954krQp9Gr+eNjiH7vV4sqvXNf+7S1HQUlZVzF+XPxwrH+jW9QORFa
         a/krhrwA0VYqKjdNS1VeXNL8E02iouNcOOJqHBLGHJEbAXRu+jMrongVg8IlUCtDde+G
         8zbzcO5a7rUpXoBZFwE3udlP9JUOeMyA6NycmzaqoYkB1UL4GkOalPTRjqfzSerIrJ55
         LLMw==
X-Gm-Message-State: AOJu0Yxosg6BBO2lkfwOcnaoZOWEUWhbvmmSYp1DOtdBC1ybvhYUzniJ
	9zzVv3yCxGT25SvtI1fuTH+ZuSWkmSDFBx8s7Koj8Nj5uU5q2aiPBoz4Bf9L7W4C
X-Gm-Gg: AfdE7cn8RXlnaAjuWOLHAdu9xsd9hyVAgry1LSL7mBZn+9z89WmvKZIOltwJIQV01gh
	9SNYFK6Iyh3cCdCF3RhKR6KgEjX2GIgyoTIVZEvIgNOUdbhzjSLeyt0LoelQxl0acOJxOGkVXfN
	Di6ztDVFIHFhcTewIklhOmP0yeopz01qeiKmjsVnwJ+lDwLPO8MNeJZZmc5Fz1q6jkOcvgKnKtM
	us+0GFBzQfKe8KFwXfDQIVXJrpUrT1dhJysw3dTwn+BRK4WSRiFs8e5QTeoGEw/ZFzkRycZsdhU
	q2GTGCQZITRfsvf+9DWgo10NS0ExddECKofhWzJkVD/53Hs1k7c8O5NI2A+/aIbSHGIZQfJy/Hh
	5aKpX94ji5YZofRRjjAl8km1A8VcwxqssgPMsoRJDgdRXAip+pJZhZvfEvyWqm4vEPcaKyQwXPp
	HeWLYnP7d3+2wBJug+mXHD2w3IuMp6U6TVtMAKhY7uu1kSgic=
X-Received: by 2002:a17:90b:1d04:b0:381:abcc:c8e9 with SMTP id 98e67ed59e1d1-382803b43b1mr399967a91.7.1783099422127;
        Fri, 03 Jul 2026 10:23:42 -0700 (PDT)
Received: from birens-macbook-air.local ([49.207.223.101])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb843fasm22278176eec.18.2026.07.03.10.23.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jul 2026 10:23:41 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
Date: Fri, 03 Jul 2026 22:53:23 +0530
Subject: [PATCH 2/2] iio: accel: kxsd9: fix runtime PM leaks and unchecked
 returns
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-kxsd9-v3-proper-v1-2-e9f08af25d7e@gmail.com>
References: <20260703-kxsd9-v3-proper-v1-0-e9f08af25d7e@gmail.com>
In-Reply-To: <20260703-kxsd9-v3-proper-v1-0-e9f08af25d7e@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Biren Pandya <birenpandya@gmail.com>
X-Mailer: b4 0.15.2

The driver fails to check the return value of pm_runtime_get_sync(),
leading to potential silent failures. Additionally, error paths leak the
runtime PM usage counter by returning without decrementing it.

Fix this by transitioning to pm_runtime_resume_and_get():

- In kxsd9_write_raw() and kxsd9_read_raw(), check the resume status and
  guarantee pm_runtime_put_autosuspend() is called on all return paths.
  Simultaneously, refactor the control flow to align with standard IIO
  idioms (removing the dead -EINVAL initializer in favor of explicit
  assignments).
- In kxsd9_buffer_preenable(), propagate the resume error code.
- In kxsd9_common_remove(), only decrement the usage counter on a
  successful resume, while retaining the unconditional power-down for a
  best-effort shutdown.

Fixes: 9a9a369d6178 ("iio: accel: kxsd9: Deploy system and runtime PM")
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
---
 drivers/iio/accel/kxsd9.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 27adcdd312014..e9a0790e2eea2 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -139,18 +139,17 @@ static int kxsd9_write_raw(struct iio_dev *indio_dev,
 			   int val2,
 			   long mask)
 {
-	int ret = -EINVAL;
 	struct kxsd9_state *st = iio_priv(indio_dev);
+	int ret;
 
-	pm_runtime_get_sync(st->dev);
+	ret = pm_runtime_resume_and_get(st->dev);
+	if (ret < 0)
+		return ret;
 
-	if (mask == IIO_CHAN_INFO_SCALE) {
-		/* Check no integer component */
-		if (val)
-			ret = -EINVAL;
-		else
-			ret = kxsd9_write_scale(indio_dev, val2);
-	}
+	if (mask == IIO_CHAN_INFO_SCALE && !val)
+		ret = kxsd9_write_scale(indio_dev, val2);
+	else
+		ret = -EINVAL;
 
 	pm_runtime_put_autosuspend(st->dev);
 
@@ -161,20 +160,22 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
 			  struct iio_chan_spec const *chan,
 			  int *val, int *val2, long mask)
 {
-	int ret = -EINVAL;
 	struct kxsd9_state *st = iio_priv(indio_dev);
 	unsigned int regval;
 	__be16 raw_val;
 	u16 nval;
+	int ret;
 
-	pm_runtime_get_sync(st->dev);
+	ret = pm_runtime_resume_and_get(st->dev);
+	if (ret < 0)
+		return ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		ret = regmap_bulk_read(st->map, chan->address, &raw_val,
 				       sizeof(raw_val));
 		if (ret)
-			goto error_ret;
+			break;
 		nval = be16_to_cpu(raw_val);
 		/* Only 12 bits are valid */
 		nval >>= 4;
@@ -191,18 +192,20 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
 				  KXSD9_REG_CTRL_C,
 				  &regval);
 		if (ret < 0)
-			goto error_ret;
+			break;
 		*val = 0;
 		*val2 = kxsd9_micro_scales[regval & KXSD9_CTRL_C_FS_MASK];
 		ret = IIO_VAL_INT_PLUS_MICRO;
 		break;
+	default:
+		ret = -EINVAL;
+		break;
 	}
 
-error_ret:
 	pm_runtime_put_autosuspend(st->dev);
 
 	return ret;
-};
+}
 
 static irqreturn_t kxsd9_trigger_handler(int irq, void *p)
 {
@@ -240,9 +243,7 @@ static int kxsd9_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct kxsd9_state *st = iio_priv(indio_dev);
 
-	pm_runtime_get_sync(st->dev);
-
-	return 0;
+	return pm_runtime_resume_and_get(st->dev);
 }
 
 static int kxsd9_buffer_postdisable(struct iio_dev *indio_dev)
@@ -480,8 +481,9 @@ void kxsd9_common_remove(struct device *dev)
 
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
-	pm_runtime_get_sync(dev);
-	pm_runtime_put_noidle(dev);
+
+	if (pm_runtime_resume_and_get(dev) >= 0)
+		pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
 	kxsd9_power_down(st);
 }

-- 
Git-155)

