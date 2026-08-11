Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552163FD137
	for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 07:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786432075; cv=none; b=NqyUpDnhTduEGM7Iteu6p28KNg7NNZ85hzk5X5PfoCxAVu1nz/MM+K2NsVHSd6INH1g1rONA6iri1e4/LBkWggmTyvWpLTBsJwru88ZItVD0eT28fFbU7omiDPmrDnIKAiRkUsO8Hvb6FhSDlKdzDhLbthfc7wvBDbHc1ZBg5P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786432075; c=relaxed/simple;
	bh=M0l4FbBo/EkNymrkGGpmvBA6vKquK6JBbdroqfDWZaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gPGi5sZr61Ui5m3aoL+M/7QPFPwXS/HH93hT8CIT2zLKjclb7daBRFq2LiioXuWpgpdoYWXiLar9GvOoeF1i7ApUyUyEtLRczJU1zKCScTS7b4LWF/UhvhtqJDKpgkIwUrAnNXuf9VQN4RY8X8yrgHw37Mrxqdixr17G2KxxCUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hp9yMqm8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hp9yMqm8"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cfff5f88dbso41557345ad.3
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 00:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786432074; x=1787036874; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YH6JnwhrMJ48wJS3EuEDXYc+J9l7GkieLILGb4BHTLM=;
        b=Hp9yMqm8kwHK9yvc60I5Z9hI0/3UthI5iRD2FbKDYSs+RFzMnRIN7eYv4q156R2ub8
         DJFEmVK463mRdQHnZ+DDQ4v4Kjx45ayOgMBKJi3QAg8CF6W4s7/jm6QMrHDS4o/Z9mM1
         V4vQGPf4ItU+5LNFzTWQYWsh2SMDQcv+K5AXaXlzv2OnserxLXGUF1lcK757JLk4zslo
         CC9GKckusrxJLfvGJeuC681Gp8JHKXg8OfX7Huqvynr1V66dxJct+fkLfk6Swt64s2UL
         ekp9ABp5nvYP1TU/FEK3Gcr6ftefUCDOsiNuv2YMoZxu/Jjyh7szOenvjIkxZsNPW21c
         XYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786432074; x=1787036874;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YH6JnwhrMJ48wJS3EuEDXYc+J9l7GkieLILGb4BHTLM=;
        b=OIw4R32+5e9Rp9UKMABHvTgcMtqRLBlD7Im02RDvpucqG8NPaunCnRI67Ni63KRyMg
         xD/aSwO20unGpxC9UYZd5oNYrlELENKfwKmHBnYoOsF/JWQAXABdJIRzrbDbrr0S4QKZ
         duV6eBMdM+UUaD9f8JxfWYIFSmYB04KYlmOq8yWDxkdvR86LCh9LtXLV1TY6o8OBqV8C
         bxHsIYSS4ibeL/HVgGVXQQx7ignZfF4Olu4ILmj79hfc+XzKkhezLH/157hVzNpmFy9m
         0h5o/KALMLPiGYI3wjqh8zHrTXtBk/4dBxqpGy2i2Ra1NTybOFiuawHak75EW/gvgx0s
         BJkA==
X-Gm-Message-State: AOJu0Yw9aD260nsFXlw0PbB5pD/q8u7UaXJUdeg4bG3plwXPVy7vdLfy
	D1A+dMclQC3BOUhZkETMYEudhEf6TNNEop14Mz3xSltyBYN0z+HFaO+g
X-Gm-Gg: AR+sD13t6coUJ/OltjX14Y2Of8Orrkbr1DcahxDHnLR57X8cRMOdxj1R2l9cQyWcgCk
	f8BKcbAaXB+WKkqPJwXXrCDpiqOjfKE4nk5vqcm6DkMex/oywUICVGTAEll7FCuB/chSOIP2uUd
	otbpqClPCqwxqFXPFRSKTP79lhTfbupas7VHzMppOWHbS+U7KIyXQvimK8rfREberSIGssfGvPM
	gKEx3euHqpkuQmLZc7lpMhRz2LOfEYleTo9n4O+ETHbezVumiFzsinl8n8UqlQ44zV7vquEYZ0l
	PREeyRDdXcEwI5YAnLKdk7SoVO4LIE6A5QGnp1kQBuN828lYAPAXBOL+P7na8T1Jtodq1u3PEz8
	icFhCMuslgXqR0TK3EetPFg3u6WhrXSH3XGCXk81MAGHM8FYmFDUhcJ3zUOld168s0vQjXJYO4T
	bwLffVrDJNHPgV9mKe9pr0/Zs0+/r5j5RZ1vNgbxXiGpiqXPbAmdBrT7fGpB6TIcXD92cMZRqfX
	ThYFXwa9csp1J93fgxy5WfP1XV+4GHz7Scf2SU=
X-Received: by 2002:a05:6a21:6003:b0:3bf:d487:4b42 with SMTP id adf61e73a8af0-3cc2bb49c25mr2183542637.35.1786432073567;
        Tue, 11 Aug 2026 00:07:53 -0700 (PDT)
Received: from [192.168.20.42] (115-70-157-242.ip4.superloop.au. [115.70.157.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31c619d0209sm1765052eec.5.2026.08.11.00.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 00:07:53 -0700 (PDT)
From: Tsz Shan Chan <tsz.chan.dev@gmail.com>
X-Google-Original-From: Tsz Shan Chan <tchan@jacques.com.au>
Date: Tue, 11 Aug 2026 17:07:25 +1000
Subject: [PATCH 2/2] iio: light: vcnl4000: add shared IRQ support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-vcnl4000-v1-2-50e7fb657692@jacques.com.au>
References: <20260811-vcnl4000-v1-0-50e7fb657692@jacques.com.au>
In-Reply-To: <20260811-vcnl4000-v1-0-50e7fb657692@jacques.com.au>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tsz Shan Chan <tchan@jacques.com.au>
X-Mailer: b4 0.14.3

Use the IRQ trigger type set by firmware instead, and fall back to
IRQF_TRIGGER_FALLING if no trigger type is specified to maintain current
behaviour.

Support IRQF_TRIGGER_FALLING and IRQF_TRIGGER_LOW, which match the open
drain active low interrupt output. Reject unsupported trigger types.

Request the interrupt with IRQF_SHARED, and return IRQ_NONE in the irq
handler when there is no interrupt pending.

Signed-off-by: Tsz Shan Chan <tchan@jacques.com.au>
---
 drivers/iio/light/vcnl4000.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 663e623da833..9fff00ae515e 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1469,8 +1469,8 @@ static irqreturn_t vcnl4040_irq_thread(int irq, void *p)
 	int ret;
 
 	ret = i2c_smbus_read_word_data(data->client, data->chip_spec->int_reg);
-	if (ret < 0)
-		return IRQ_HANDLED;
+	if (ret <= 0)
+		return IRQ_NONE;
 
 	if (ret & VCNL4040_PS_IF_CLOSE) {
 		iio_push_event(indio_dev,
@@ -1525,8 +1525,8 @@ static irqreturn_t vcnl4010_irq_thread(int irq, void *p)
 	int ret;
 
 	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ISR);
-	if (ret < 0)
-		goto end;
+	if (ret <= 0)
+		return IRQ_NONE;
 
 	isr = ret;
 
@@ -1558,7 +1558,6 @@ static irqreturn_t vcnl4010_irq_thread(int irq, void *p)
 	if (isr & VCNL4010_INT_DRDY && iio_buffer_enabled(indio_dev))
 		iio_trigger_poll_nested(indio_dev->trig);
 
-end:
 	return IRQ_HANDLED;
 }
 
@@ -1979,10 +1978,24 @@ static int vcnl4000_probe(struct i2c_client *client)
 	}
 
 	if (client->irq && data->chip_spec->irq_thread) {
+		u32 irq_type = irq_get_trigger_type(client->irq);
+
+		switch (irq_type) {
+		case IRQF_TRIGGER_FALLING:
+		case IRQF_TRIGGER_LOW:
+			break;
+		case IRQF_TRIGGER_NONE:
+			irq_type = IRQF_TRIGGER_FALLING;
+			break;
+		default:
+			return dev_err_probe(dev, -EINVAL,
+					"unsupported irq trigger type %x\n",
+					irq_type);
+		}
 		ret = devm_request_threaded_irq(dev, client->irq, NULL,
 						data->chip_spec->irq_thread,
-						IRQF_TRIGGER_FALLING |
-						IRQF_ONESHOT,
+						IRQF_ONESHOT | IRQF_SHARED |
+						irq_type,
 						"vcnl4000_irq",
 						indio_dev);
 		if (ret < 0)

-- 
2.55.0

