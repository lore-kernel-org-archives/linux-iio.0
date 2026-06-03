Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4FC4657C0
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506779; cv=none; b=EPzawsvYNOOxlCFIG8SsDiq7flJrxnGjg+54n+miatyCO9zef3rw4Znw1EyEznJKlQOMB7T2HJ7B1f+wpwgacg62HFk8F5xho9orQGBf0K0IJiJRrXgDaO33N3SsJYaTZUPVwbfGOrpvpCrKYofq2zAOcU63LVfBtVc+Siv/Jis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506779; c=relaxed/simple;
	bh=QeWJCZvpTY5nLADABMkjfcMoywKp5RzEV7WCG0/i08U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rWVS8f2Iqa4Y56e1w7QUzfiIw971FBIj7v5ziDy4SzhBPnfS1PTRyQMiAn+DX+MefX73vAIY+PugO+oPaMQZxyjxOE3VYdOlguE3eqw0vgBLaRmlQMXKZ/cmlZFMqdOB1GfoQWyoSf7NHM47mSfjplk2LPr+Vg6CzURxyFW50/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euA/QbeI; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euA/QbeI"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45eeba68948so5150555f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 10:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780506776; x=1781111576; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOMRBHKYKTsxlDpldBhhYcBNx5WxuRJUnFPdfKzqslI=;
        b=euA/QbeIvsBYNp8cDGvi8L69Aanj9LOSSLQhMCldsxUR32aKDpAmWE+RhAJVjVInlp
         hJO6ENnwm9L6aE394ikERTWRjch4QcYiTDUWxSjwfBqHI5X/Dc3476tUyiKw1UAvVhQ7
         gPGhZ8a6NTFDwcGelnkMsdv0Y6lASzzGBav1zUrSz/roeV/6VVw0lMGNKrocDT9b3WXO
         Xx3eaB7uaF+2X1ZMjmw1QrYqtXbuj72lzK9AXK90/rYHbOLsi0l99Fizdj9RQ92OF4zU
         er0ULasieloizhsxX30ErLngXwMyumuojkDzx0jNlc9JQq445YRX41nF0MHGJllayAX4
         cXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780506776; x=1781111576;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FOMRBHKYKTsxlDpldBhhYcBNx5WxuRJUnFPdfKzqslI=;
        b=GlOj/CY5qgtl7Cujn0RyYlrlhxKnMv5KdszVVZ9Wtt2UkbbICXqdon1851QDa9VqeN
         hCteZATQeB6/r9BVOx4CYr4hdhTF7rm8MKf8KlhG4TfkFCjZiWOgoFBkzU/X5Bo/esDT
         1WoCIQ6qTC9PBs4RO5F0qTUJWpfTUm3oIGBPiphQS3YM3KqfSlr0Cx7cz9xvDCm0mD/X
         uoF4b0kR7zel9P4239YT7XUvks244cZu9S5SiNTW5vZHWkykDHoskKb70HenfD/sglIx
         bCxR85fj6ky9fbxGlmRlhhNcjzfL/8lDqosW/RLrOIZRYJ3lb85+zbLxvOfDUr5FIfRF
         cm6A==
X-Gm-Message-State: AOJu0Ywzw5rEh7xflsPheHxXOC4V/5gjvpJWlKu//osLxFecPe7dlHbc
	65BYrNimaIIaU9CPz6/7Yiy9wylJQ8K8f+er1Tw48qLliRDlMQNmR/Gk
X-Gm-Gg: Acq92OH34hCIxrcGx2fFiya3CIO/Mog6pfPsMBP4T0TYJsOhNqybKFppDvpUQrlFQVX
	WKnx6PIBEQPy9KqxGci1g/wTjvgTlLlS2c/hWQEeVhjbhc9/J0uT5feSpOoBakNoWe0KT83030p
	twP3c2mY2u25U9Fo4OKrGDp7qUbdjkja/TUkZo8ehAEcwTmdMTB2HkhIB1PRUBnd/kzShMc/Wqi
	5NKk7BVggYhgZ1e9aY0uW/k3z8h3X5OWaQorPIcj/En1MW2P4xRaZ/HmqCJhT4cK61kLAsfj0ur
	afOeLNck9CkpvdZobMXS+xavasYI20w8vo0vIprjOl88Jg05LSXiVAT2ylj4QPc/xLXqr0kmzAl
	WkDvjMhaYfFDP1FirrZ2CJs8m6d1xwp05F9Eziy+e2R9b8uN02fY7dP/Qm5HolYRkCUsIp6/5d8
	NIHVnYEIF1yAZWjm8+aTx0PSUEHZEllDNa1auNrV5JMyGIrJ7c8vb46oB74SvbedMWV3My8OhcM
	QgKICn9ED8pmlsfpo02GnPqoKxly9NCP+hwlazDRWJzlzxkxdFile4Ho7vKg7a80Urnic2YlsOW
	4tjxJJkfmMQpE2BfpmNz2Kb3QWucGiXR8U/VOiSLgMiTuZ94bZ8=
X-Received: by 2002:a5d:5710:0:b0:453:e3a1:6580 with SMTP id ffacd0b85a97d-46021844ce7mr4854446f8f.25.1780506776224;
        Wed, 03 Jun 2026 10:12:56 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0:c287:187e:fb7a:66a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f345209sm8797506f8f.17.2026.06.03.10.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 10:12:56 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 03 Jun 2026 19:12:54 +0200
Subject: [PATCH v5 3/8] iio: light: opt3001: ensure correct parenthesis
 alignment
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-opt3001-cleanup-v5-3-3ef7b926d555@gmail.com>
References: <20260603-opt3001-cleanup-v5-0-3ef7b926d555@gmail.com>
In-Reply-To: <20260603-opt3001-cleanup-v5-0-3ef7b926d555@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Maxwell Doose <m32285159@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780506773; l=6428;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=QeWJCZvpTY5nLADABMkjfcMoywKp5RzEV7WCG0/i08U=;
 b=JFvRNsROi1QB5Q7e5g6wFAj9uvKmkfk3y3pDYgTT22sBva2hn4sTvto6WkxTJJ6CJAlwvlhXz
 LNI2qAyAvFPDpW/wIENxfauegoiK17f0fuyu/Lphaz2W1qK1MU69Mf1
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Ensure correct parenthesis alignment per checkpatch.pl report.

No functional change.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Maxwell Doose <m32285159@gmail.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 73 +++++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index efaad85dfaf3..532929e8fa8b 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -223,8 +223,8 @@ static const struct opt3001_scale opt3002_scales[] = {
 	},
 };
 
-static int opt3001_find_scale(const struct opt3001 *opt, int val,
-		int val2, u8 *exponent)
+static int opt3001_find_scale(const struct opt3001 *opt, int val, int val2,
+			      u8 *exponent)
 {
 	int i;
 	for (i = 0; i < ARRAY_SIZE(*opt->chip_info->scales); i++) {
@@ -242,8 +242,8 @@ static int opt3001_find_scale(const struct opt3001 *opt, int val,
 	return -EINVAL;
 }
 
-static void opt3001_to_iio_ret(struct opt3001 *opt, u8 exponent,
-		u16 mantissa, int *val, int *val2)
+static void opt3001_to_iio_ret(struct opt3001 *opt, u8 exponent, u16 mantissa,
+			       int *val, int *val2)
 {
 	int ret;
 	int whole = opt->chip_info->factor_whole;
@@ -364,8 +364,8 @@ static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
 	if (opt->use_irq) {
 		/* Wait for the IRQ to indicate the conversion is complete */
 		ret = wait_event_timeout(opt->result_ready_queue,
-				opt->result_ready,
-				msecs_to_jiffies(OPT3001_RESULT_READY_LONG));
+					 opt->result_ready,
+					 msecs_to_jiffies(OPT3001_RESULT_READY_LONG));
 		if (ret == 0)
 			return -ETIMEDOUT;
 	} else {
@@ -474,8 +474,8 @@ static int opt3001_set_int_time(struct opt3001 *opt, int time)
 }
 
 static int opt3001_read_raw(struct iio_dev *iio,
-		struct iio_chan_spec const *chan, int *val, int *val2,
-		long mask)
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
 {
 	struct opt3001 *opt = iio_priv(iio);
 	int ret;
@@ -506,8 +506,8 @@ static int opt3001_read_raw(struct iio_dev *iio,
 }
 
 static int opt3001_write_raw(struct iio_dev *iio,
-		struct iio_chan_spec const *chan, int val, int val2,
-		long mask)
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
 {
 	struct opt3001 *opt = iio_priv(iio);
 	int ret;
@@ -532,9 +532,11 @@ static int opt3001_write_raw(struct iio_dev *iio,
 }
 
 static int opt3001_read_event_value(struct iio_dev *iio,
-		const struct iio_chan_spec *chan, enum iio_event_type type,
-		enum iio_event_direction dir, enum iio_event_info info,
-		int *val, int *val2)
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int *val, int *val2)
 {
 	struct opt3001 *opt = iio_priv(iio);
 	int ret = IIO_VAL_INT_PLUS_MICRO;
@@ -544,11 +546,13 @@ static int opt3001_read_event_value(struct iio_dev *iio,
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
 		opt3001_to_iio_ret(opt, opt->high_thresh_exp,
-				opt->high_thresh_mantissa, val, val2);
+				   opt->high_thresh_mantissa,
+				   val, val2);
 		break;
 	case IIO_EV_DIR_FALLING:
 		opt3001_to_iio_ret(opt, opt->low_thresh_exp,
-				opt->low_thresh_mantissa, val, val2);
+				   opt->low_thresh_mantissa,
+				   val, val2);
 		break;
 	default:
 		ret = -EINVAL;
@@ -560,9 +564,11 @@ static int opt3001_read_event_value(struct iio_dev *iio,
 }
 
 static int opt3001_write_event_value(struct iio_dev *iio,
-		const struct iio_chan_spec *chan, enum iio_event_type type,
-		enum iio_event_direction dir, enum iio_event_info info,
-		int val, int val2)
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     enum iio_event_info info,
+				     int val, int val2)
 {
 	struct opt3001 *opt = iio_priv(iio);
 	struct i2c_client *client = opt->client;
@@ -626,8 +632,9 @@ static int opt3001_write_event_value(struct iio_dev *iio,
 }
 
 static int opt3001_read_event_config(struct iio_dev *iio,
-		const struct iio_chan_spec *chan, enum iio_event_type type,
-		enum iio_event_direction dir)
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
 {
 	struct opt3001 *opt = iio_priv(iio);
 
@@ -635,8 +642,10 @@ static int opt3001_read_event_config(struct iio_dev *iio,
 }
 
 static int opt3001_write_event_config(struct iio_dev *iio,
-		const struct iio_chan_spec *chan, enum iio_event_type type,
-		enum iio_event_direction dir, bool state)
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+				      bool state)
 {
 	struct opt3001 *opt = iio_priv(iio);
 	struct i2c_client *client = opt->client;
@@ -812,16 +821,16 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 			OPT3001_CONFIGURATION_M_CONTINUOUS) {
 		if (ret & OPT3001_CONFIGURATION_FH)
 			iio_push_event(iio,
-					IIO_UNMOD_EVENT_CODE(chan_type, 0,
-							IIO_EV_TYPE_THRESH,
-							IIO_EV_DIR_RISING),
-					iio_get_time_ns(iio));
+				       IIO_UNMOD_EVENT_CODE(chan_type, 0,
+							    IIO_EV_TYPE_THRESH,
+							    IIO_EV_DIR_RISING),
+				       iio_get_time_ns(iio));
 		if (ret & OPT3001_CONFIGURATION_FL)
 			iio_push_event(iio,
-					IIO_UNMOD_EVENT_CODE(chan_type, 0,
-							IIO_EV_TYPE_THRESH,
-							IIO_EV_DIR_FALLING),
-					iio_get_time_ns(iio));
+				       IIO_UNMOD_EVENT_CODE(chan_type, 0,
+							    IIO_EV_TYPE_THRESH,
+							    IIO_EV_DIR_FALLING),
+				       iio_get_time_ns(iio));
 	} else if (ret & OPT3001_CONFIGURATION_CRF) {
 		ret = i2c_smbus_read_word_swapped(client, OPT3001_RESULT);
 		if (ret < 0) {
@@ -884,8 +893,8 @@ static int opt3001_probe(struct i2c_client *client)
 	/* Make use of INT pin only if valid IRQ no. is given */
 	if (irq > 0) {
 		ret = request_threaded_irq(irq, NULL, opt3001_irq,
-				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				"opt3001", iio);
+					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					   "opt3001", iio);
 		if (ret) {
 			dev_err(dev, "failed to request IRQ #%d\n", irq);
 			return ret;

-- 
2.54.0

