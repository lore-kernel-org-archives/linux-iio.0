Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AB035C1BD
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028715; cv=none; b=EwA+PYBBOd9rHA5RuyHgRJrwxLBDylkuyQHsshjHjGYVgavSdksqc+xn3pOSYwNN3tcWQbpYGzWO01gZQPKrEvVFYVE81Fyi7f9TBwdZ5b12z0f6zKPtjLPlI3uCa3SxF/1znwBi31eqGTkYM67borFLxYQxvhZfSnK3sjvZY2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028715; c=relaxed/simple;
	bh=biO2VDvvuMrg2uvDOeIUh5S1pDVpoUHuMMBFpMiL5jU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GLGd6jm53WMULWG5HH6ClRvH+gjLWmNqe925SSRw7ojO5R337DkNVZcyc46KW9lhVjgwBNJ+7k1X1l4P2GZhfhs/MZAXMQ2eWzOuluoVyS0gnf73Mo2GxBGAJQhrTL8i2yT+J0xCwMwhDXjMQLWEmY384oQraCes9XPcnTd7kQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fltIsD98; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fltIsD98"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9fe3c9bd5fso689515a12.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 04:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784028710; x=1784633510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y0H1G5WZdR9SN2z823rVvQJ9X5UKno+8iIWeLBusZtg=;
        b=fltIsD98C6WwW35+fnMCah7EQCrx1Xn/JkgE20wqUNZTSaAARsguva9Ro5U0bElYMn
         H3auFQS+1JtrnUB9MLco8PsHNiR+m6OQSbl8zK4inpXg+GT1mjgDw+VglG8p569so6s2
         7UEnxlzbs5x6KIInaNSNG3W2RBqedIeXn+5us7wme12mSUGuqVIDPysy6+fgGXi0E1d8
         xT59dm4/r6qmh/9oWHbjxFMPeJgkARTiY4bDDNdGb9kiwANgBLyfQoMzc0ZUsnViBw6F
         QOs4KE+IYPXnQKvhEWtFy5MPqGhYUspU0btETSdtnUs8c0zm1R4Y35zOFp2hVME3f9cC
         94OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784028710; x=1784633510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y0H1G5WZdR9SN2z823rVvQJ9X5UKno+8iIWeLBusZtg=;
        b=Wo2JWBt8UswJo/iSLDyO1135GsS73MymwO7stHIjKGMQIiy3QaMdBPNkqMuBwe2hvs
         3rnwBNHc9Sfq6f1DrW6q2Rx4+sDNSWJf7Kqo+kLU3gQs9dOj7QJ+90MEFPVfi6CKMgHz
         VHkmMPz0uI/GyNDST9EyYsXa/L2f9bM165bA5/m1ODMYhXcJYvLzO/V7oLTmvHpB7RSa
         HljS4koTfQI9fQHfSaJuwcAP87+/mzAG67FEsIbCrUcXD7lBmmzooZdOG+lZfrl9QG+G
         WaODeZuFYYQj70NedWT5AZHvXEUXlbwVekHgT9HTZR+Q9JePF2jEzMQ7QwfWXQBgBUDE
         kr6g==
X-Forwarded-Encrypted: i=1; AHgh+RoCgNCcOoYKQIZvxrjM51Qcs4lpjhNI3uRaQt5S5qUznwSV3bK7bk/WGnlJntjjMlTG+ttoH3b205A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXOgylWUVvGgVK7I83YWsz5nPrCComYAaUs2vrjZYYlvcfPKEU
	pYY9w9Tim1A7/dModG2g3YtJq0nHKzoe0vdfKVQ05XH9lM5Ow7zMvzB4ED4IOmM=
X-Gm-Gg: AfdE7clE04gHYT/ewK/+n3+34y4YswuR2rSwR6Q2XtPSFALpN8KJCFR+XSHhKAFs0oA
	NeV3AKCJalE3+hKpBeScWYDjRxs1HUMBMaNqD40gJ3k7OIUMsMX0M124gLRTXtr8YD+mq3LkPt5
	vptt4HHLVgRPFR/jtU87YaD7wfG0mBZoWxQc5tdr1Okx5eZy//bmYqG2tIG523osiWiFNwKJbb0
	DqawZt91OH7pbInN8RZc6rGqv+Vad+5VvweoeYdUeq+1ADb9IWrIZTapgRkNbCocbEbijC9F9If
	nJz5rwZTPSAT91itmtdrfdSfcv4cPe/DJEaxp96GnQoaEruUp/0vgYF6QPvm3vNjMYFzZ8N9zhE
	RClQ0lpTO8E1yw/9FJXed6F1bJ7gDRcuv+wmb3al10lvt+5z1XpnNMTZo8Qb7Dv4fxdMu5k3tmt
	QcKMSawQM4FphUpxSORXHVWBynF79opKF84bM4j8NEXl1kwde6n/39
X-Received: by 2002:a05:6300:2189:b0:3bf:8a0e:dd99 with SMTP id adf61e73a8af0-3c0f0990bcfmr19424002637.17.1784028710394;
        Tue, 14 Jul 2026 04:31:50 -0700 (PDT)
Received: from localhost.localdomain ([101.0.63.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f72a6sm95357368eec.1.2026.07.14.04.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:31:49 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v3 2/4] iio: light: opt4001: Fix incompatible pointer type passed to div_u64_rem()
Date: Tue, 14 Jul 2026 17:01:32 +0530
Message-Id: <20260714113134.3445-3-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260714113134.3445-1-nikhilgtr@gmail.com>
References: <20260714113134.3445-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

div_u64_rem() takes a u32 * for the remainder but is passed val2, which
is an int *. There is no functional impact as int and u32 have the same
size and representation on all supported architectures and the remainder
is always smaller than the divisor, so it fits in the positive range of
int. Fix the type mismatch by using a local u32 for the remainder and
assigning the result to *val2.

Fixes: 9a9608418292 ("iio: light: Add support for TI OPT4001 light sensor")
Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/light/opt4001.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
index 66563000d081..a0f174888384 100644
--- a/drivers/iio/light/opt4001.c
+++ b/drivers/iio/light/opt4001.c
@@ -173,6 +173,7 @@ static int opt4001_read_lux_value(struct iio_dev *indio_dev,
 	u8 crc;
 	u8 calc_crc;
 	u64 lux_raw;
+	u32 rem;
 	int ret;
 
 	ret = regmap_read(chip->regmap, OPT4001_LIGHT1_MSB, &light1);
@@ -199,8 +200,8 @@ static int opt4001_read_lux_value(struct iio_dev *indio_dev,
 
 	lux_raw = lux_raw << exp;
 	lux_raw = lux_raw * chip->chip_info->mul;
-	*val = div_u64_rem(lux_raw, chip->chip_info->div, val2);
-	*val2 = *val2 * 100;
+	*val = div_u64_rem(lux_raw, chip->chip_info->div, &rem);
+	*val2 = rem * 100;
 
 	return IIO_VAL_INT_PLUS_NANO;
 }
-- 
2.39.5

