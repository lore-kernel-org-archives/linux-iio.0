Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD06319851
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783852383; cv=none; b=gw/GfYz2Nrhh9uAdrAxFmetucyhTzaxLhoF1o5mx9V0hEozkk3xEOanUzmZyKiyrCLUerQOj+e2F11WnaqTWoLtgOe6jb2vvRpFL+w3HyjJfK3k7aEmohMol3e6avDa+4YueU7Cg3P1jLHv7nfSDkZNkRBxvs4TFKw68+DU6plg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783852383; c=relaxed/simple;
	bh=RrklVRzBRBce3Bd8GD73B9ORJuj+XQu4iWolITviVtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VINM1ld/tOQhmAJrpRfV/Rt89t36c8mXCnk1HNbj3+QZMukoxlVUwKmeKxLDKipMZn9VjAwvo7jEj4wMConzMqWOWxapPNPtux7km+HbEMK78V3+0rL1Ccln3Unru6qfCRTxGjLt7wZjm5M9PrhvQHzVGO403rkK1PfT/kcQE2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nethgFs1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nethgFs1"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493f60208a5so17436825e9.3
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 03:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783852380; x=1784457180; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9e3UweMYvS8J3tU5WoKv+KC7H9hp0P+6acq/wKnOeKA=;
        b=nethgFs1Q6oJjjfBhsgl62p6zLKs6L0qbyj77KpnKEgpQnigBLfJgq5vwkL0y6Q2Eq
         JRo6VLO5g9i/TMXc56v2Rdnnjp8CL/tZYDize7YK6tICZ5fIGPFBxlyIcVgh4EXACgYh
         l3JYgY5rWt+PImbn7HnQR7LNJrw21tDc9zgQr6Yv8goVKmIFxWgZFivuns8Rr0pPXNIP
         XetMeTYqjNpjd/PUH9lvfIqoiZUbuaaZVkavPweeJ7Od6z3fO9kSoufRSuc/DvutU43F
         /MOrlMXAQukh4z6zcwstmDDlBFZYo/t+bvo9p2it1XX0bGHDjA+EN2d2UvnSyzbulT/W
         QHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783852380; x=1784457180;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9e3UweMYvS8J3tU5WoKv+KC7H9hp0P+6acq/wKnOeKA=;
        b=dw5meByV33gG9dh4V4O1qFs24Nnpe55ZvKd2DI6mHYZT18RUdpT/nvTyL3W2bNo7E5
         0mkp32vNQ/4b1DQ1oCPSbEhOfzCtZRL2b/v31D0iHdzeKmccnf73CawIAvjmrjyEZgTj
         TL431GFgXA+4wGKYt9A523xR5kP+c954oVKXqo35CUdcBa9rBMtB+o6SxTApb4DQmIiT
         U/Z4h0RlWxQfpV5evn38faQwGWcr7ceU5GH12NtoXBnTUKgbrjR0RKIHNLOr2xwfizsp
         BIrBNA1bXnJkRbyVoXugQHx3ieTvQU9q3B7kI6Wa0XNnmcme75oB5/A2a/mxk+Yyrsjk
         J/BA==
X-Gm-Message-State: AOJu0Yyc/KKXGQMgoyPmGxO9MaazxsAYg+CGH42YRpHaxQ8g9gVzPmMj
	GkGeTTtK0wUQEzFfKa7NIaeBfgHGjxitdO0D0n7b0c0GoFDlVJqBJi2s
X-Gm-Gg: AfdE7cmXoY+JO5dnD9eOTzCJuyWk1UxdNgC6BXrx3prLqM//p/ZS8OoIw8aAju2rqP7
	lgeoMqmmCVdlR1Lu/Rc4wwP5guF7npVXVmmWssyYPYyXZsxMfZ9Whq1kUnFAYnj85WHyadCOMXc
	eL3GdbVJFTT9e5glc9zkXIQOHX9/V2usbytg0Hb/pI+QpJ9U9Rei/huCYhPw1+f4aXk9YaFJuE9
	bazEaxrD2OeLL/y/AlHhBWz2eM55A0Z/WOj3oq9FfDUJRcz7H7e6y31VYW7V7Oc9XWbej/loa/0
	I9mlTZfuSclzZFz9H+zXfVy5HEIstuiQHcQNdURjol7uf/d/+YL0KBWIBb+jq6TQbimcMkTL5qB
	bp5yQsUzvUrz8DRhtI6irN/MQwW64dC2GrUk0AXunC+RK4jtcgOVu+8IbvLB5xc+wvJWg5QZqwh
	d2N9zvYmi//Kiqg1yy8AAQZDesHEIEHoCkYcBENXv/0zqaKtKVpCRgBiG2pWDOAw0uF8pmseU3l
	y275bvgBtshKZ0lxkPeJFbg3gVbVAOeqj5S8lnF6/4jpaFDTzh+lFnQI4rNHnTZAFdpms/iR8UN
	4/LkEhvb16ptBsgmoyeNs+Z/4DM8VHhYHt+3bxkHjEu+GyOfMQPofQ==
X-Received: by 2002:a05:600c:1f91:b0:493:e79e:daa6 with SMTP id 5b1f17b1804b1-493f8826e69mr49552895e9.33.1783852380230;
        Sun, 12 Jul 2026 03:33:00 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4cbc620sm172632325e9.13.2026.07.12.03.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 03:32:59 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 12 Jul 2026 12:32:49 +0200
Subject: [PATCH v3] iio: light: opt3001: split opt3001_get_processed()
 logic
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-opt3001-unwind-cleanup-v3-1-5fa336876b08@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNQQ6DIBCF4asY1qUZsGLtqvdoukAYlUTBgNI2x
 rsXXblpuvxfMt8sJKA3GMgtW4jHaIJxNkV+yojqpG2RGp2acOACSrhSN045AKOzfRmrqepR2nm
 klUTUmItCFAVJx6PHxrx3+PFM3ZkwOf/Z/0S2rX/JyCijFUDNVaN1LeS9HaTpz8oNZCMjPzCM/
 WR4Yi5lI1iJAEoUR2Zd1y9a819AAwEAAA==
X-Change-ID: 20260708-opt3001-unwind-cleanup-9aeede365655
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783852379; l=7889;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=RrklVRzBRBce3Bd8GD73B9ORJuj+XQu4iWolITviVtg=;
 b=J1k166bpCQ+QAdvMozPl6NdfkOIuYDxIHZBezptOAkizeikBpnejAYS38zzyTcqITXLIKQP9n
 Rzl1rRphDacCSuvpzzbnDKEHTefW703CW+W+xNmFOVP2Nyg9ZSteLJI
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Split the logic inside the opt3001_get_processed() function, as the
current flow is hard to read, mixing IRQ and non-IRQ code blocks.

Separate the IRQ code path into its own function, same for the
non-IRQ path.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
This patch fixes the absolutely horrible code flow in the
opt3001_get_processed() function, where the original implementation
used checks whether IRQ mode is enabled to execute blocks of code,
making the function hard to read. Ideas on how to improve the functions
are more than welcome.

Originally suggested by Jonathan Cameron.
---
Changes in v3:
- Move duplicated code blocks to common functions (David)
- Change wrapping of comments and function call (Jonathan)
- Link to v2: https://lore.kernel.org/r/20260711-opt3001-unwind-cleanup-v2-1-47f617e00c65@gmail.com

Changes in v2:
- Remove ternary operator and add if/else (Andy)
- Remove timeout variable (Andy)
- Link to v1: https://lore.kernel.org/r/20260708-opt3001-unwind-cleanup-v1-1-900b2cfddb6a@gmail.com
---
 drivers/iio/light/opt3001.c | 194 +++++++++++++++++++++++++-------------------
 1 file changed, 109 insertions(+), 85 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 2bce6cd5f4e4..c72eb0eaeaef 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -316,35 +316,12 @@ static const struct iio_chan_spec opt3002_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(1),
 };
 
-static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
+static int opt3001_start_conversion(struct opt3001 *opt)
 {
 	struct i2c_client *client = opt->client;
 	struct device *dev = &client->dev;
-	int ret;
-	u16 mantissa;
 	u16 reg;
-	u8 exponent;
-	u16 value;
-	long timeout;
-
-	if (opt->use_irq) {
-		/*
-		 * Enable the end-of-conversion interrupt mechanism. Note that
-		 * doing so will overwrite the low-level limit value however we
-		 * will restore this value later on.
-		 */
-		ret = i2c_smbus_write_word_swapped(client,
-						   OPT3001_LOW_LIMIT,
-						   OPT3001_LOW_LIMIT_EOC_ENABLE);
-		if (ret < 0) {
-			dev_err(dev, "failed to write register %02x\n",
-				OPT3001_LOW_LIMIT);
-			return ret;
-		}
-
-		/* Allow IRQ to access the device despite lock being set */
-		opt->ok_to_ignore_lock = true;
-	}
+	int ret;
 
 	/* Reset data-ready indicator flag */
 	opt->result_ready = false;
@@ -354,7 +331,7 @@ static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
 	if (ret < 0) {
 		dev_err(dev, "failed to read register %02x\n",
 			OPT3001_CONFIGURATION);
-		goto err;
+		return ret;
 	}
 
 	reg = ret;
@@ -364,75 +341,122 @@ static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
 	if (ret < 0) {
 		dev_err(dev, "failed to write register %02x\n",
 			OPT3001_CONFIGURATION);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int opt3001_get_processed_irq(struct opt3001 *opt)
+{
+	struct i2c_client *client = opt->client;
+	struct device *dev = &client->dev;
+	u16 value;
+	int ret;
+
+	/*
+	 * Enable the end-of-conversion interrupt mechanism. Note that doing so
+	 * will overwrite the low-level limit value however we will restore this
+	 * value later on.
+	 */
+	ret = i2c_smbus_write_word_swapped(client,
+					   OPT3001_LOW_LIMIT,
+					   OPT3001_LOW_LIMIT_EOC_ENABLE);
+	if (ret < 0) {
+		dev_err(dev, "failed to write register %02x\n",
+			OPT3001_LOW_LIMIT);
+		return ret;
+	}
+
+	/* Allow IRQ to access the device despite lock being set */
+	opt->ok_to_ignore_lock = true;
+
+	ret = opt3001_start_conversion(opt);
+	if (ret)
 		goto err;
-	}
 
-	if (opt->use_irq) {
-		/* Wait for the IRQ to indicate the conversion is complete */
-		ret = wait_event_timeout(opt->result_ready_queue,
-					 opt->result_ready,
-					 msecs_to_jiffies(OPT3001_RESULT_READY_LONG));
-		if (ret == 0) {
-			ret = -ETIMEDOUT;
-			goto err;
-		}
-	} else {
-		/* Sleep for result ready time */
-		timeout = (opt->int_time == OPT3001_INT_TIME_SHORT) ?
-			OPT3001_RESULT_READY_SHORT : OPT3001_RESULT_READY_LONG;
-		msleep(timeout);
-
-		/* Check result ready flag */
-		ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
-		if (ret < 0) {
-			dev_err(dev, "failed to read register %02x\n",
-				OPT3001_CONFIGURATION);
-			goto err;
-		}
-
-		if (!(ret & OPT3001_CONFIGURATION_CRF)) {
-			ret = -ETIMEDOUT;
-			goto err;
-		}
-
-		/* Obtain value */
-		ret = i2c_smbus_read_word_swapped(client, OPT3001_RESULT);
-		if (ret < 0) {
-			dev_err(dev, "failed to read register %02x\n",
-				OPT3001_RESULT);
-			goto err;
-		}
-		opt->result = ret;
-		opt->result_ready = true;
-	}
+	ret = wait_event_timeout(opt->result_ready_queue,
+				 opt->result_ready,
+				 msecs_to_jiffies(OPT3001_RESULT_READY_LONG));
+	if (ret == 0)
+		ret = -ETIMEDOUT;
 
 err:
-	if (opt->use_irq)
-		/* Disallow IRQ to access the device while lock is active */
-		opt->ok_to_ignore_lock = false;
+	opt->ok_to_ignore_lock = false;
 
 	if (ret < 0)
 		return ret;
 
-	if (opt->use_irq) {
-		/*
-		 * Disable the end-of-conversion interrupt mechanism by
-		 * restoring the low-level limit value (clearing
-		 * OPT3001_LOW_LIMIT_EOC_ENABLE). Note that selectively clearing
-		 * those enable bits would affect the actual limit value due to
-		 * bit-overlap and therefore can't be done.
-		 */
-		value = (opt->low_thresh_exp << 12) | opt->low_thresh_mantissa;
-		ret = i2c_smbus_write_word_swapped(client,
-						   OPT3001_LOW_LIMIT,
-						   value);
-		if (ret < 0) {
-			dev_err(dev, "failed to write register %02x\n",
-				OPT3001_LOW_LIMIT);
-			return ret;
-		}
+	/*
+	 * Disable the end-of-conversion interrupt mechanism by restoring the
+	 * low-level limit value (clearing OPT3001_LOW_LIMIT_EOC_ENABLE). Note
+	 * that selectively clearing those enable bits would affect the actual
+	 * limit value due to bit-overlap and therefore can't be done.
+	 */
+	value = (opt->low_thresh_exp << 12) | opt->low_thresh_mantissa;
+	ret = i2c_smbus_write_word_swapped(client, OPT3001_LOW_LIMIT, value);
+	if (ret < 0) {
+		dev_err(dev, "failed to write register %02x\n",
+			OPT3001_LOW_LIMIT);
+		return ret;
 	}
 
+	return 0;
+}
+
+static int opt3001_get_processed_noirq(struct opt3001 *opt)
+{
+	struct i2c_client *client = opt->client;
+	struct device *dev = &client->dev;
+	int ret;
+
+	ret = opt3001_start_conversion(opt);
+	if (ret)
+		return ret;
+
+	if (opt->int_time == OPT3001_INT_TIME_SHORT)
+		msleep(OPT3001_RESULT_READY_SHORT);
+	else
+		msleep(OPT3001_RESULT_READY_LONG);
+
+	/* Check result ready flag */
+	ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
+	if (ret < 0) {
+		dev_err(dev, "failed to read register %02x\n",
+			OPT3001_CONFIGURATION);
+		return ret;
+	}
+
+	if (!(ret & OPT3001_CONFIGURATION_CRF))
+		return -ETIMEDOUT;
+
+	/* Obtain value */
+	ret = i2c_smbus_read_word_swapped(client, OPT3001_RESULT);
+	if (ret < 0) {
+		dev_err(dev, "failed to read register %02x\n",
+			OPT3001_RESULT);
+		return ret;
+	}
+
+	opt->result = ret;
+	opt->result_ready = true;
+
+	return 0;
+}
+
+static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
+{
+	u16 mantissa;
+	u8 exponent;
+	int ret;
+
+	if (opt->use_irq)
+		ret = opt3001_get_processed_irq(opt);
+	else
+		ret = opt3001_get_processed_noirq(opt);
+	if (ret)
+		return ret;
+
 	exponent = OPT3001_REG_EXPONENT(opt->result);
 	mantissa = OPT3001_REG_MANTISSA(opt->result);
 

---
base-commit: fef4337eb2888c758c7058e1723903204f012a26
change-id: 20260708-opt3001-unwind-cleanup-9aeede365655

Best regards,
-- 
Kind regards

CJD

