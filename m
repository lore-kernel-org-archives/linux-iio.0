Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471619;
	b=i/ZleoA6/bSnTEe+nJRgJursGcBv+0QkmmGlssnoInuufZcEEJ/mJ0EYFWF7wsoVfRQs
	 H8LM0n9QSHJdPUAxZhvl/hk6IJxyyYF/9mnszKbIp+odk9v+KN5RF7G1cc07vQfy6nq5t
	 865aB0lrEh+B9fDiBp6FN+1Y+j2ZIf0JjqxT5uDjHtJNZJKKPP7z+wG9PX+ZYDv5x30FT
	 bNmAHa2qjNMqgC+dZhODFLAdJMaBetFtEATI9BELXgLSDSL/xD1fEhOOQJ/49OC4DYNy3
	 uP7uII9xLzbOHY8Oy2jjmgovjCfq/gbrKVgAgxyr74RsJB9e0I6kfU6fsuT/WBbfGvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471619;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=o7w+XYrUuPM5OlZczhXAMuU75dtDBjR/bPRPu3dewXw=;
	b=RkLNxzNdoFZ81bOXoxbsB6W7GkDHkJ7CkJu6qn/85WxIm1tWh5MLcPKuRR1nEKLwkkOX
	 /WhO1UyTYb/Rel+eI3ZCaCk3BrL1PdwCPpX9ulOtEEaMagqf8FKVnb8tK6Ew/3lUddAGP
	 WNkasAEHNBWFB4v9tmU4Wy4H7oUUJbARBF35UCbq2dihaGNUnH9WpdFHVol2KoIoWM8vj
	 b6zUeQX2ADhDXJszX5OrKsK0ZC07fHw5y22Ve+8VmLopt5L6DpZR3gl8eqk79EcxuoAxb
	 DpQNl0TrflogMi2OILij+Dh/9nuC76C7EDDZisJvZV8B45mp7eqkYXOwJhbJQ4xf4dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z9xdN1z2;
	arc=none smtp.remote-ip=209.85.208.173
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929F6606A332
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 22:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 929F6606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z9xdN1z2
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3ae85e3685cso24159821fa.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 14:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795471617; x=1796076417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o7w+XYrUuPM5OlZczhXAMuU75dtDBjR/bPRPu3dewXw=;
        b=Z9xdN1z25XmSHzZ4s0E/IbSkGR0uFFE68m3F/9/VOGIbSzHYtF6gJP7jHCfQz91G+x
         W8N+BiUDrttMBOzTFOyEVSmbDz4XVPLxCH8+tZkowj0FIeiLJfkmvhPHV0pH7NoAgYDz
         59iMsTBO3wS5MBL6gf3FvXV3DlTpqeBP1yEDXeCMJxRLbcOdx5H7owFE5Pw/bOZFFgFB
         QmuHbJhlkiN7XtPOw0LmaZWjl27SmWZruqaymDnZwpyvmKskmU7/YkeUr0fkvy+8dOYN
         dKEjNVpVEoZv5VtZmvqQxlaVR+K6a46irUJHM+athRHOgHJ/HEmmoCX/U0OLx4KLErzM
         gwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795471617; x=1796076417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o7w+XYrUuPM5OlZczhXAMuU75dtDBjR/bPRPu3dewXw=;
        b=nkWra1ZzAzASrCAi0GNVRJyi28lRghVa+9ymUGnagSnR8g5TcS4gjnnWBNnMKq0Gbb
         Cq34m3nvSM2000K5CwRXBqV6JB+DMwhL5SXIvBj7hvat7uFFt7LoIzrXrmpbqMDgzD12
         RNZpTva2F0KrwesHkf3ZVNZ7w8Az4+wPIDaH6ArbaFIqSLCtP4FSE+FqqzJGoqZKFKDY
         Pboy5BYCfZYfNbtzrnnv4pRz01QfHRXpWwhst6Ltx8snQuuruU9lrsJSIVVh0bO5JAms
         xYQzAzaNfqS9GvTABeH6oKsAjDMebjfRFM3Fw8eE/CSP8dj5f/FWKXN/0fLN/KXbUkUK
         9DBg==
X-Gm-Message-State: APuU4Z/hjRxJ8KUZhulOORadYxMKyLUZ1oxGGSL/4XPpbVEjFqVQ5jTC
	YK+j01Okz+0hSgl7MWKE2PebLApRxvzAhYpu7H5V2GACHwahA2EQCRzS
X-Gm-Gg: AZFdTZeYn7nkjV6ferDYxE6DCy1int59s7EbgFGtsSgjTB909877HXi6rqx6kEg4lq/
	8DWiAIdgUx5h/Qffw7YfPjlX3gkYuNRTpRBx2KwxZTVWxHgEiLPSmS4yInUo1K/v3M+93a1MH/M
	NV9CQYtFxpuyssPhl88U/HCDIQ+7OScvTok51XIH7/axW4OftRu3Ac/aZK7NVbxJavs/ZGwSiXm
	yMf5wPtr+Ey5dxVwlG9r1hzv9pGKSBzIfWt6QVXB93sGXk6tB0y2ohmiLklTcYLY1hwTYGXdJC5
	oP18umiHsrqdDlia6WycRW6nBrEovPDCbHOSmCTc4UjXjCsC2U9rtll7kKDjjnFySNaYxkyvxUB
	BQycQd5GxAGzx1kSdXifsBV1FgrjxD/8jyGRUjbTuPB+DP/nk6hIIiNHSOXKEtefvu6FI8mVDgm
	h6VT+ah00DHguLUemCdjmENG1QvW/Ayp/AOfMH90Im7F2dW5Nn8F8G4Rbu1Y5HefEzMWF7up9P9
	ThN6Lrol25ohbr+9iUofjELDgJ6FlsDWEwthJ32VF1mOtJ/laMpnyhLXjsxZan43Ej10Sbtgs/J
	1d/d//p59f9GRML48RFFQG8ezJkeMyo7p6TXo+CSK7ZKtTyfklGUP3sxdQzJut/8QKpsgIfxcXr
	SSD+XbIulPBgRzakDTVauyP3XqpIQ3KrYcDlQwPXRvAevjj3W+aPyX2MMpzA=
X-Received: by 2002:a05:6512:1313:b0:5c1:57e3:f5de with SMTP id 2adb3069b0e04-5c1bc81a0ddmr4006457e87.38.1795471616638;
        Mon, 23 Nov 2026 14:06:56 -0800 (PST)
Received: from yantra.. (nekmmqsyyquzw1lm5eb-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:3cd2:d52a:a1ef:5dd3])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae805215ccsm34272021fa.21.2026.11.23.14.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:06:55 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH 1/7] iio: pressure: dps310: sort register field defines low to high
Date: Tue, 24 Nov 2026 00:06:43 +0200
Message-ID: <20261123220649.36887-2-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123220649.36887-1-zoone.rupert@gmail.com>
References: <20261123220649.36887-1-zoone.rupert@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some field defines run from the high bit down, others from the low bit
up. Sort them all low to high.

Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 9ffef150cc4c..02dbc5a8ac37 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -51,13 +51,13 @@
 #define DPS310_TMP_B1		0x04
 #define DPS310_TMP_B2		0x05
 #define DPS310_PRS_CFG		0x06
-#define  DPS310_PRS_RATE_BITS	GENMASK(6, 4)
 #define  DPS310_PRS_PRC_BITS	GENMASK(3, 0)
+#define  DPS310_PRS_RATE_BITS	GENMASK(6, 4)
 #define DPS310_TMP_CFG		0x07
-#define  DPS310_TMP_RATE_BITS	GENMASK(6, 4)
-#define   DPS310_TMP_RATE_1SPS	0
 #define  DPS310_TMP_PRC_BITS	GENMASK(3, 0)
 #define   DPS310_TMP_PRC_1	0
+#define  DPS310_TMP_RATE_BITS	GENMASK(6, 4)
+#define   DPS310_TMP_RATE_1SPS	0
 #define  DPS310_TMP_EXT		BIT(7)
 #define DPS310_MEAS_CFG		0x08
 #define  DPS310_MEAS_CTRL_BITS	GENMASK(2, 0)
@@ -69,19 +69,19 @@
 #define  DPS310_SENSOR_RDY	BIT(6)
 #define  DPS310_COEF_RDY	BIT(7)
 #define DPS310_CFG_REG		0x09
-#define  DPS310_INT_HL		BIT(7)
-#define  DPS310_INT_TMP		BIT(5)
-#define  DPS310_INT_PRS		BIT(4)
-#define  DPS310_TMP_SHIFT_EN	BIT(3)
-#define  DPS310_PRS_SHIFT_EN	BIT(2)
-#define  DPS310_FIFO_EN		BIT(1)
 #define  DPS310_SPI_EN		BIT(0)
+#define  DPS310_FIFO_EN		BIT(1)
+#define  DPS310_PRS_SHIFT_EN	BIT(2)
+#define  DPS310_TMP_SHIFT_EN	BIT(3)
+#define  DPS310_INT_PRS		BIT(4)
+#define  DPS310_INT_TMP		BIT(5)
+#define  DPS310_INT_HL		BIT(7)
 #define DPS310_INT_STS		0x0a
-#define  DPS310_INT_STS_TMP	BIT(1)
 #define  DPS310_INT_STS_PRS	BIT(0)
+#define  DPS310_INT_STS_TMP	BIT(1)
 #define DPS310_RESET		0x0c
-#define  DPS310_FIFO_FLUSH	BIT(7)
 #define  DPS310_RESET_MAGIC	0x09
+#define  DPS310_FIFO_FLUSH	BIT(7)
 #define DPS310_COEF_BASE	0x10
 #define DPS310_COEF_LEN		18
 #define SPL07_COEF_LEN		21
-- 
2.43.0

