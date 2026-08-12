Received: from sg-2-4.ptr.blmpb.com (sg-2-4.ptr.blmpb.com [71.18.227.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23A536B936
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 07:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521552; cv=none; b=kSfaFJ6FRnQUxFBORYOp7BHKXD3zVbkO+gtQwu2pZ5UUyNYYUdj0v4OSEP7x9b8SnC1Ot2iExnKsXDseAZ26jv4llQ//FsDXewumdWrfHaz18J4jhJndjJFvewNzfp12bOIorpjDFmEfnqULqfB8s6IQO8g5YKqNaeX4xgkJaPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521552; c=relaxed/simple;
	bh=GeMMm1VvuHQc5O/Qc1ZF934cmcKFtcsga93zBQT8JVI=;
	h=Subject:In-Reply-To:Content-Type:To:From:Date:Message-Id:
	 References:Cc:Mime-Version; b=VwxZHO2iSLagRHC2JPzG5QQRCn7QoHtacwTBN36sv78n7eBrk/9FsDkcWeqVTJWQRzI+eVF9v2pNbzPpx6zT7/LzFIg9ufGH2nxZdvMMjO0UgaTXSz1JT2mkdLH4JWbvJrHhUggM+pWyXu8hvcd3vykqtTKefOXRo6AxKTw6BSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=cejp/GOa; arc=none smtp.client-ip=71.18.227.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="cejp/GOa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1786521538; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Tw9iG1KtVJQ7+SktZV1lQpXLURpBc5juHplZa6eihjM=;
 b=cejp/GOaxIW30TOCRIdRQQRiY9YQlMMeSsd6Xxhpqp6pKr6f15qMYUNGrbMVhqiSIwdqeA
 Okb5/QqLhX+kGx6VPYUzDo4Wgw+O+lhSf9urG9o/A/pSK8659aSEMu09ZLfLuYItZKrjdC
 OoYAHg/IhiM5Do05W9k3UdIy/ZRTnbM00vPcb4nuu41z4ewktvN8DwG6dkOvaZh8VAydH9
 p9r/dcinFVa9xEGoWxQ8H+h4cZQk05gUm/5JBY7DyicfeZYdSaxw+g2/l0h3fSFT7AoJyQ
 ma66q6o6tVbHebNZb6pJUK7J+hHmHbcXoEZZfR65arxnhx+8iUC4Ws39BG6smA==
Subject: [PATCH v2 1/2] iio: accel: adxl380: reject out-of-range FIFO entry count
In-Reply-To: <20260812-adxl-fifo-v2-0-86bea20faf1c@cherr.cc>
X-Lms-Return-Path: <lba+26a7c27c0+c3de5a+vger.kernel.org+me@cherr.cc>
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Content-Type: text/plain; charset=UTF-8
X-Mailer: b4 0.14.2
To: "Ramona Gradinariu" <ramona.gradinariu@analog.com>, 
	"Antoniu Miclaus" <antoniu.miclaus@analog.com>, 
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
	"Michael Hennerich" <Michael.Hennerich@analog.com>, 
	"Jonathan Cameron" <jic23@kernel.org>, 
	"David Lechner" <dlechner@baylibre.com>, 
	"Andy Shevchenko" <andy@kernel.org>, 
	"Marcelo Schmitt" <marcelo.schmitt@analog.com>
From: "Shengzhuo Wei" <me@cherr.cc>
Date: Wed, 12 Aug 2026 15:58:49 +0800
Message-Id: <20260812-adxl-fifo-v2-1-86bea20faf1c@cherr.cc>
References: <20260812-adxl-fifo-v2-0-86bea20faf1c@cherr.cc>
Cc: <linux@analog.com>, <linux-iio@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, "Shengzhuo Wei" <me@cherr.cc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [192.168.9.107] ([111.42.148.52]) by smtp.feishu.cn with ESMTPS; Wed, 12 Aug 2026 15:58:55 +0800
Content-Transfer-Encoding: 7bit

The FIFO entry count is a 9-bit device-reported value, so it can be as
large as 511, but fifo_buf[] only has room for ADXL380_FIFO_SAMPLES
(315) entries. adxl380_irq_handler() uses the reported count directly as
the length of a bulk FIFO read, so a count above ADXL380_FIFO_SAMPLES
overflows fifo_buf, a heap out-of-bounds write of up to 392 bytes into
adjacent memory.

Rather than clamp the count and silently drop the excess, abort the
read: a count beyond the FIFO size means the device is returning
garbage, so the data cannot be trusted. The message is ratelimited
because a stuck device can raise the watermark IRQ repeatedly.

Assisted-by: GLM:5.2
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
 drivers/iio/accel/adxl380.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index 7dca5523091fc4c6a3c3bf7e388d5d0d507bee19..8518ee23e114901ee02933e91b8bdf8d7c83008c 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -966,6 +966,13 @@ static irqreturn_t adxl380_irq_handler(int irq, void  *p)
 	if (ret)
 		return IRQ_HANDLED;
 
+	if (fifo_entries > ADXL380_FIFO_SAMPLES) {
+		dev_err_ratelimited(st->dev,
+				    "FIFO entry count %u exceeds FIFO size %lu\n",
+				    fifo_entries, ADXL380_FIFO_SAMPLES);
+		return IRQ_HANDLED;
+	}
+
 	fifo_entries = rounddown(fifo_entries, st->fifo_set_size);
 	ret = regmap_noinc_read(st->regmap, ADXL380_FIFO_DATA, &st->fifo_buf,
 				sizeof(*st->fifo_buf) * fifo_entries);

-- 
2.47.3
