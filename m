Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491842BD013
	for <linux-iio@vger.kernel.org>; Thu, 12 Feb 2026 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770877880; cv=none; b=qgz9D0hKaPyp++NS7B0kOR1T6JAsK+USmx4lvVeticDCcFQQvg0pWtm7k37Kz3XJELGxPMc4OGaOu6Gs3+0JPHF5cqiHEyCkgo+FcAJ5+dUpnhpYfCyO0UXeOWN6EVHOP92YNlipYrd7U3ebaID4ung7H2k5mbqSWFrHoUq5vYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770877880; c=relaxed/simple;
	bh=Cwukr+asA9q81opMyHdC2mH8rdLJNfh+2ybtKX0oQjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yw6xMg9CflxIPXxBp5pMP+86RCA1fPG81Rex5c8pyKCj4i+MgNDCMlRnx6t3f+VICaYCE0lpS8fP8TH+IznbmtIKzPHd3q+6qI7ucyq/qKNfIWEumVBtscG2JaOSDU0TR8ASQWUIdfe2Tetbz7xVHSvf0ZEjjqCjqKu2xcVRP1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbWa82w7; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbWa82w7"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-124713e4244so295901c88.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 22:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770877877; x=1771482677; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0wTHjf1tC7HZoXFDboB9BM1y3uG0BFOwWiKdrJ7KGQ=;
        b=EbWa82w7jw77s2M9lAbs4JGc7VenOCRl6RWbinHKv2+nbhlRFmXovRbfwEBvpQP8y0
         mUeLu/M4ruPtlBFZeI9iUgJCSDTC+I9zi8Hq2rmDLbpPr3BWd3zzxHVgKwg1+ERpys/S
         wpQKztyGt+MxxQ9NngX/+nwFgL2W+x0gQ80MIrn9LAiFBsEh4L5eW1VAKvvSN+/xZSt8
         tmQMmOL1iHqpEmzG4RhNP6wJ2gFh+SR7yrwW1MxlyiGG4D89KfYPYFh8g6XU/bOBoz4N
         WZYDcJPXPBVs89ENan56kofAHJ2+/BBCDCn+P2sRrDs8oanrDsvrpPIggIckmS3Nypr7
         Gjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770877877; x=1771482677;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S0wTHjf1tC7HZoXFDboB9BM1y3uG0BFOwWiKdrJ7KGQ=;
        b=gXMy1cFmtRGSXtA9L6a4Kv+bRxrakYsRMycC0P9O+3r6IO+ZwGsXDsdLL0Utf3f57R
         u+9/t7ykAP/ngFWjcAJnfKs3tcGR4RnYamfbhUNCVrnQLITzxiknKkRHcSK88VmzKcMA
         DGVq8vCCjgjOQIZbZP5aL99TEwP2BDTketMIh9/IP1ma2NPXVwgVEvtt0n9iCSzCnfji
         JjE2Xz7SjyafqsCJJVzVx5IU76vYJWorc31qRkoCxCdvTbjuvYs7Il8LB5s3fsr0ifFE
         76P1Ucy9Fd9TLTovSr7qODffauVky3wYH4u33VZE/8IDp5DxsSpxApG2VsX7XQ0Ejz/t
         KabA==
X-Gm-Message-State: AOJu0YwOp2qY2TiTA0gzHj1kQc/VXQ/q1sfcDfFTJtUA+FKURP5hdw0f
	Ouf18SOMw+ky+ZPlTf2G6WLE6MD6ecIiuv6y2iFiLh2gzbQKmGva9O5otZFK+g==
X-Gm-Gg: AZuq6aKFy2c5x4dNgKrp8+MXyvyXnNdj1VHlc6oUC/POrWoYILmOthfDmc9/Kt0YRgd
	O1G06/qkJobP5JKlATaoW+hAjEjKvgaHTNTUEWfl1bNS4DpY1Q8K9h377jOnVx9vsFTuJtITnzi
	4n6SPC3atjHBOF9hJhYl02YW5ul/Vmyotno1s1YdKK5ovWuFcqQ5ULXRs9ehASNRbQa1HoG1DP6
	lzw+IbsMe2GWg6QK26JLo/6j4sXwxEzQiGuWjMKCgo0/MP5QcOeaYgxnWeet4Edl3HA6smrzOup
	q4mgotDrEcv+vjzDRw7WLpdIqqMBXdzEMKJkLs+Nzozr/T5LFCn2dkjKqZCsDyytdGU0cpc3DWU
	XO/JuGquIw3XlvgCNrhc2Pd+dgAS9eIWNfDQ3dhxkS473PwdKQD9qhc6w9YakvDjlqdug0Ab+D4
	ZHGd/nEHHH4VpL+rQKJLAVv6NSY1v0fzt/UFmXBDFTfsam9nZ2B2ihyVk=
X-Received: by 2002:a05:7022:6993:b0:127:1186:8139 with SMTP id a92af1059eb24-1272f79ca53mr428488c88.7.1770877877169;
        Wed, 11 Feb 2026 22:31:17 -0800 (PST)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1272a6f29dasm4313870c88.12.2026.02.11.22.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 22:31:16 -0800 (PST)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Thu, 12 Feb 2026 14:26:53 +0800
Subject: [PATCH v2 2/4] iio: proximity: hx9023s: Protect against division
 by zero in set_samp_freq
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-upstream-20260219-v2-2-2b28fce5d09e@gmail.com>
References: <20260212-upstream-20260219-v2-0-2b28fce5d09e@gmail.com>
In-Reply-To: <20260212-upstream-20260219-v2-0-2b28fce5d09e@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1101; i=yasin.lee.x@gmail.com;
 h=from:subject:message-id; bh=Cwukr+asA9q81opMyHdC2mH8rdLJNfh+2ybtKX0oQjI=;
 b=owGbwMvMwCEYyfeRr6Zs90zG02pJDJm9xUv3Fbw7OM2UdZHq3f1/nSuOZxhNDl6hGqn6r+74+
 zWlYmV3O0pZGAQ5GGTFFFnOvH7Dmq/6cE/wb9cMmDmsTCBDGLg4BWAiK/gYGebGVTctVqyfdy65
 OcVsQ5qbk5KAv/Gls1uyFuUw7p6p/JOR4XzdzdQ1tvZXu32Wy6lcunP2463oFa+/ST3srFNMm22
 qGg4A
X-Developer-Key: i=yasin.lee.x@gmail.com; a=openpgp;
 fpr=CCEBEC056F25E1BC53FB4568590EF10E7C76BB99

Avoid division by zero when sampling frequency is unspecified by
falling back to a default 100ms sampling period.

Fixes: 60df548277b7 ("iio: proximity: Add driver support for TYHX's HX9023S capacitive proximity sensor")
Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index ad839db6b326..e714fe00a44e 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -719,7 +719,11 @@ static int hx9023s_set_samp_freq(struct hx9023s_data *data, int val, int val2)
 	struct device *dev = regmap_get_device(data->regmap);
 	unsigned int i, period_ms;
 
-	period_ms = div_u64(NANO, (val * MEGA + val2));
+	if (val || val2)
+		period_ms = div_u64(NANO, (val * MEGA + val2));
+	else
+		/* Fallback to a safe default sampling period */
+		period_ms = 100;
 
 	for (i = 0; i < ARRAY_SIZE(hx9023s_samp_freq_table); i++) {
 		if (period_ms == hx9023s_samp_freq_table[i])

-- 
2.43.0

