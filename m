Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080E733E374
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 03:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783915077; cv=none; b=NDlBaj7+SFd+2CENcQTaUCBbId0+Wv8uy0+dY4kGmewuHVPa0ZnyUzOwgEnlu2S0pEILaZli8ZGxYol0k0Y8L76FMtsCsw+lQMTPTWp+K5CsAnTOX8RUhzV0rFvI6RjE2JEilkX0zUm6LaM81bROGQmv/iEGDc2yQLcBYE3Nh/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783915077; c=relaxed/simple;
	bh=FttQ8RmdF7jMEA9kPV1TdKHVweC3ujH2gsNMi5NimDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fpOs9Q0fJ7dNeewgBeueanmrs7OLAFoGOrTTkFB0QyBzzXpNKKVuOgKYmqEGZEmxKkT/r0KR0QrYiM+Jk2q8wfqxOktt8BdlrhlWlkKzUo6teIRQDHo3q+/WYxqh2JBvX11tRl3TOpqBeyC7T02wxKLX6UuUFppVFO7OFBfhPeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzSJkx/9; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzSJkx/9"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso1512283a12.2
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 20:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783915075; x=1784519875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9u3/eEAOJr6IzOF2yv7lerO2luzOs8+kGo7tSPCV4fA=;
        b=VzSJkx/9iHOnxZelQlalNFhY0zHE77wJniaHHMrfEG+c4JKXD4l5mbHjGmO6AYId6s
         1zMoXVqxwDCCdURQ82FQDAaikL0Oasi3tTTZcoWhYhsguYqK0It7jsXlJFuV2VbH1Xh8
         g6D4+R9S6jRsLQvmSt4r+X11dghjvTy6+Fqzhqwq7z6hvVnayWRdp8t+HRpnKM5pqy8Q
         YsBPwn1nyGcAVVzLlYt4xKBrm99TpwyNOAgJsEB6ED+cpuFz3M0boU4KwCovv36PNPsU
         RpKVlJ0GoETDqUzqVQeWQ4raYfkYncoSFQ4B+HicF4aGoh2Jqse9jrMv9cSNIlw9aAVz
         SjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783915075; x=1784519875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9u3/eEAOJr6IzOF2yv7lerO2luzOs8+kGo7tSPCV4fA=;
        b=SA731/kthA4rkto6nbpyBOrjSv7J5gpWOvnaXfKYFLSG9Ge6xIt7XsT15wDyk572j4
         1F9ZI4ktqhGtZxudfFig53lEv/Lj16MxM1WxYq45/EcJ9/Hsn6Cr4htv5olEddCzqxle
         IqNh2HvjuYudqdwXUwMgv0vMgbRKfxSVMHx4/9v8BtCTPkjvrhkHY39tNHUaOcX/0b1s
         jKfRKvq4kbnKwcmEiImC06DdMUwRoDLeNUTwEUC1MtHEi8tKXiq5jvdj5r5AOtayDD0o
         zhJMOirvwhqtO9mJHgLzEHcA3EWs9F9PuY9wm6xqI9UiftAXss91w8s6YWX+sUh0eMi9
         lrmw==
X-Forwarded-Encrypted: i=1; AHgh+RpIQnO0zvbE14IgPJEFmUX4kmHCYfS0yMCO3NEtDrAqc2L4KIvlGyBxDpsTCPqyPsKY3THguSE17dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR51sYQIlcxcqbPCw8Kd5nLd+I611vqZTxmlt6lpMbxdEQ54rH
	XVHlsgs7Gi0EfvtrmcrIaU2SYULG18y3AeXhz3kGIJ5jM+9xh1ycNHpTdXhxWfo=
X-Gm-Gg: AfdE7cmscVf8ee21av12amsz68auh9aTXtSFFgb0KRcN463iByW1UxA6syGbVRwdCej
	pEyx0C3pQc8/JR30OdFBSOlq2yDxC6GjAQYoxGfNCymfBfRLiez3OSsT5tQ4dMQtlM3y4AfOaE+
	izxWlYKpuZi1dXP4ErUqyUVbPy4mbpw5lLbrLZ6/B6w8TbAlZDVw2W/0VbD94T5CngZqXkRd3Sq
	ITxCqhqMXmhnnUzwksr1EgU9lcYXiY9mjaHpiwHsnIWnlO+M0wHcPBmqMAYcQdze+6JdCQk9vO2
	Q9z4ftGOHIp8E+NFE9XLLs1D8L7dodvU8m49K5k3+y1eEAHO2z9pWJNRQ9IKaSYeTItNOgzX0DF
	2xB++59J/XtzPlHg7e5MmCZ86grBca6bxNYFGTnlLCBVMlYH4vSIR7pHXSxY4tQQZoYz1/pAMxF
	L+df7IllW2NlBxsbd3lNr65AXE/awqW/lzK+CTC+1adUr+9F2mvqg5QcmArnsH5g8=
X-Received: by 2002:a05:6a20:9f8c:b0:3c0:9c19:659c with SMTP id adf61e73a8af0-3c110b7ba39mr7967809637.68.1783915075371;
        Sun, 12 Jul 2026 20:57:55 -0700 (PDT)
Received: from localhost.localdomain ([101.0.63.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5975sm60862704eec.4.2026.07.12.20.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 20:57:54 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v2 3/4] iio: light: opt4001: Fix incompatible pointer type passed to div_u64_rem()
Date: Mon, 13 Jul 2026 09:27:35 +0530
Message-Id: <20260713035736.11346-4-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260713035736.11346-1-nikhilgtr@gmail.com>
References: <20260713035736.11346-1-nikhilgtr@gmail.com>
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
index 9ff99c19b6ae..9f877c5798b9 100644
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

