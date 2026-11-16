Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794862438;
	b=wgU+eTBp1XzipNw6gOWdb//Tuhs3HutAvuvoZC5+zjnW8vDBj01bQr/XBdGH3aUWSTXL
	 0jL8XWeYAet5ejt3t59omstY9o1fo5gf/dRmv+/DRP92EV7k/IONZYdHdDznsRMS3oPvC
	 we0mCffGfXHF7SpwzpIKClw03+gRRvqXnimS7zS0MkThAlSZodF4NoXPxxvXerpvbcsLZ
	 6Gwc4axOVdEffATVlVCq2fpcMj6zc09K+rlVN2fYT8z/Xu7IYHel//n9WeXyeqijB6y4V
	 YMiFwH4Ll5agQsRLkrd6a7Bu+NuuIqiFv+FiJJzU7V7XH7/flRSPf18d/AwkbFGMGMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862438;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ljvyR0WuHX+wTiGEcCFlcGHOJ6URbUYTzcXzcdYxpLw=;
	b=an+Z1PAjVQHpgUyDNCk9qIF26kVF3/YVaFX31C5FQu/vjVEC+rR2BiJ/l3ZCejCimrkF
	 lRzBTPNc7tZx3TcIrI8l5Zi9sfZ1X68UF+ZXMmDdplYxkkVOvbSlBrk5p6flw75cP2h4/
	 u6X6Y8cQoyK0w4pD5zQiDJDghkWeeOMTZyZ1y2oUEIWJAcenEEoGPFERiA6t7Oyou9i27
	 ZHea89JAPOrz6hCeCtKMIS4Y9QwNWyWbOCzo95PBfwTCB2/WcD7hRxZUCvrqbioOwDkNy
	 9tRqLj9wxOvrB+1S7YawoFLVCaJ2Evv3Zg3+Uk+oF4P0zJZzO+Brylf2KXrExaWXlnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YAnC5pjD;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CA6606A88F
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 20:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24CA6606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YAnC5pjD
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b244fb7fffso4689809c88.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 12:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794862437; x=1795467237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ljvyR0WuHX+wTiGEcCFlcGHOJ6URbUYTzcXzcdYxpLw=;
        b=YAnC5pjDk1mPYDsTC2lRlCBPfbMyvkSuH9z3Tw9hwVmf8dOU4IAskT7fjlTtIPnA/X
         NzJ3EHjwxpyPBcW/+2g5EzSOzATzaKEhxIR74PiXekxsVM2/ZWE+Lz2ZklxrTuBT1bom
         MHWfjof6NY3apTZeUiLgoSj5LTSOPKD7MUlEWmVz11K6gA+3RgFw6IycG1X+bKWGfPLH
         UKp7/YNqbcixdPUUEfKMWNclykcXfBqba5jnrk8k8phrNzYe1IUqur50faM6wtzjEvm7
         WVEOucJt77aqZNVP8Sjc88AvuTIILfLqfbwICG7XfuInG8E0jXkUiny0L0yyPbibc1dp
         fyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794862437; x=1795467237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ljvyR0WuHX+wTiGEcCFlcGHOJ6URbUYTzcXzcdYxpLw=;
        b=mKVaakLbvUNFCLnjXNmojdsSEQWym7HyNR2m1Aj15DxVKEVJWkokCj2x8wmbFrxcu2
         leREj5mBh91oRTmMzN654z+dyRWDULtw4+Fqo0CFPnZWgolFg5YM2YFiWdKsUoc1eK5z
         pQbf/ppVbuTX0crVpTYNXLFVQYoQ5MuBtXv8D3GoDPu/OJHyNXIe1QDA/1/uc032QMSY
         u2BQEizuQ61+5h1OLj3ggcspehRU99FVOce/8Cd4QEft5IyOKkCL6vgE8y0GshoD5ufI
         6g7gFK2DCSryTlFMiH4uPD33fcRxBv+fsQn5oft1tOgs8eOgstsP9XzYbvZy8LAQCu1e
         PgvQ==
X-Forwarded-Encrypted: i=1; AL+hErEsCBr8Zk9Ou0o/ZriNzws11Vz0bdxiFC/T4AhDto1uCwyYFTpGzV7kzGzcUDxYdLyGs01cK1cEI04=@vger.kernel.org
X-Gm-Message-State: APuU4Z+w83hZPmgSJTRoNPUcOvvOunAXjo2RxEz0P8bHnKLhum1k8FSR
	8oVyo1YKOA3KspvUEG8FHS3uS59/4Lr+nDZ0aZmr4VpK6NYXOWcnrcNH
X-Gm-Gg: AYBFou0dV3jv1/hjNcAOSeN+jHdwioh9ffIMvewrTpCGVgbaiiFgdrYOQoFbgT4dE+b
	ysUueaJJQB0d625GLCKQCMoZKCxm3gIHZCcUQAj4p3EVth4gMtNydfFOXpi734rSydjXZF5+3fh
	gUlCKluBAmJmhEWUflFLARzk1AGyOSwQpNnMj/UI7LPRq2pYsiqRcuiswjmZ+ogJy2Vu9opUSOS
	TStOa7NZeqV9VGLBfv9OIODo48st1goYwh3z6Myxau5+LGB3iJP0pt2aha6rhPtyk6Q4A6E6I/W
	XQl1gpibQNJrFgOsN18vDh7Bq4CWQO5ouPoqs93pIsqpbp6x4bwRckXR7CFnh8N9APjtCftONRV
	sXxqdSkri1/z4fGgxw1giY0VLggrJwJ0mF/X1l3I4gg2Yc1RsO3dhBcCUatrxeaaIc9CrBMoaT4
	83xFbieZsxOtT1EJKBFKQTw7JT9hmeL0FMNzDhU5GuGK61BeILhDWomyOGiE+LDcVZUjnWRInKC
	6hiP1cSs+Tji9LcAwaupbZvv467kmCqrTcAtVLBnj5UEEVFFQzNFT9wnJCmDNePYe9uZ3z1s+Zk
	brlctcw5Ych6kVN+oMEhn2koMRaij5ZvuUIlZBY1NINCfIF0orDZtp5+8D0/EEP9Z4k7hReSly7
	L2wltgqDB2mZ/4i1mo5SIftlX06UhEbL7grgB4qulKQTQm7VlxWrgVAY31IsRrpnAPNOVjrjG1N
	Wl+aNn2zREhJujb7lUpK5JkifSHGfhMsPOLlYvqMYHxA==
X-Received: by 2002:a05:701a:ccd9:10b0:1b5:32d6:677f with SMTP id a92af1059eb24-1b532d667b7mr2676150c88.34.1794862437187;
        Mon, 16 Nov 2026 12:53:57 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b524049e0asm15293497c88.4.2026.11.16.12.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:53:56 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH 5/6] iio: proximity: sx9360: fix proximity threshold writes
Date: Tue, 17 Nov 2026 02:23:13 +0530
Message-ID: <20261116205320.26070-6-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116205320.26070-1-kapoorarnav43@gmail.com>
References: <20261116205320.26070-1-kapoorarnav43@gmail.com>
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

sx9360_read_thresh() reports a PROX_THRESH code r as r for r <= 1 and as
r * r / 2 otherwise, but sx9360_write_thresh() converts back with
int_sqrt(2 * val). For odd r the read value is (r * r - 1) / 2, so
writing back the value that was just read programs r - 1: setting the
threshold to the value it already has lowers it, for 127 of the 256
codes (3, 5, 7, ...).

The int to unsigned int conversion also lets some negative values
through: 2 * val wraps, so e.g. INT_MIN is written as 0 and values just
above INT_MIN as small thresholds instead of being rejected.

Reject negative values and use int_sqrt(2 * val + 1), which picks the
largest code whose reported threshold does not exceed the requested
value and makes read_thresh() and write_thresh() inverses of each
other for all 256 codes.

Fixes: 1cdb4c47f7f5 ("iio:proximity:sx9360: Add sx9360 support")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9360.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 9ba967a33c98..26190f9c6c1f 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -510,8 +510,12 @@ static int sx9360_write_thresh(struct sx_common_data *data, int _val)
 {
 	unsigned int val = _val;
 
+	if (_val < 0)
+		return -EINVAL;
+
+	/* Inverse of read_thresh(), so that writing back a read value is a no-op */
 	if (val >= 1)
-		val = int_sqrt(2 * val);
+		val = int_sqrt(2 * val + 1);
 
 	if (val > 0xff)
 		return -EINVAL;
-- 
2.53.0

