Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729052;
	b=RbBQC9ZnjKWOfAqTLnIo8WVrwbNhjJwmarCpe+XIFzzRfilzfqWlxe7w4Rsz6UktD667
	 WQMJPeft3w/AhWUvQaWAvIqrZwwMBiaBxlkGDU6J0Eh//G8harazTZF5StkJj5Z6yGYPG
	 4TYs1MdeuEAdJm7Xo3Xb/DmBRuGNpeFVyjwpTKmhf2ZxjZw4kFgiV82Fk/4nWLTOalcpa
	 Adsv1zG1oWo8XdjN8xlC5u8UADjUSVCyWJrPLbNPDjOd+322Pb4+cj3czio7r9S5VmcT1
	 FNSIU4ny5e7s0BkPCKD7mEJADDBusvOhBGbow9PuoI4zEHVqYXSB+WCFHiq2XoNco8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xtSscZaOAAEhQ13kt1QeGIrKWGeJGW2xn6PNjxpIljc=;
	b=PJmFYiXTCiV4nxNPLEv6nFQYnj0f+YjRzc16Ah2MuMhUEL/JAEcx7et361fXnn074vmX
	 DhH846vEGxJ30Q/wFk+aUvWtyUFHQtdg6bj9MiZF5ndtUHAgQ4rxcKXTaAxURT57dv96i
	 PsWx4Eol4zyx+8jNqOVF+Ci0pGt5CBQA6lTdxSyHOm8MqEQflmObB/Dygtmd0inORo1F/
	 gPtis4unsWs/OAPjbSmddvziENOaof/KdppHk5krxzt28In++1S+0U6saMQI9xgOzD3J1
	 3F0KAjaJabGBzK8irjy+SlUE+di8kQ4o1extn2TQ8Vf1HYktCK1cWaLvwXecuh9Ex7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XeZEo7KS;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1EF606A693
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 21:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E1EF606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XeZEo7KS
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so3654037b3a.0
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 13:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795729051; x=1796333851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xtSscZaOAAEhQ13kt1QeGIrKWGeJGW2xn6PNjxpIljc=;
        b=XeZEo7KS7YYo7XNkK/6rm/23627+iQqo7Uy/rlIhBJLC9Eua4fW6ajMmI7XcU8C7PM
         rTaZEZTp4yKrRjnjmUB/kINwZ2I0I6AhMhssPNkHrn3vF2V6b3kRRytD0t8tcFJrAQRQ
         rlWf43/0Bhuf3ZUYzCghMBRViSwbBrMsl245jF3rNk7u2tyUJqQ9gF3vytMJSDyE/Tyj
         y6ZaZHAASr3GWvxkq8eW2i3bKE0yEEkl+ZypWH0uVKCbq81b8gg2Y49mrGfXCmtxIwex
         AU90kSquLE7dpXuyord4BbUHAqq9dwDXD8b8Ye1lWHAzx1fJnI48jPzFGLVWOHomMVPb
         B+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795729051; x=1796333851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xtSscZaOAAEhQ13kt1QeGIrKWGeJGW2xn6PNjxpIljc=;
        b=2Cx3afFG5ykjA1z2vIAD/Fh3eTtfNW/nJUGw7Kda5BIyDZ6uq8JAw9BtOAPEPfUyBz
         PKtWsiKITFrPj2f1mHq7MuFsIdwRQ00VB9xjIqbuRXI7rpWL1Fju29IU8h5g/1jN7f/l
         S+Kxrxu1TNqJCQZNNYswSIWw5gtLedQjZx3nQBQlej0RN5cTdjPG6CMNKtofLC97Rabq
         2OjCNemh8CD6JTiNpo5s0Ry644k/2AwDLgypOK6ca5xV1VfIgTd/USr5+Rg0iBnkWRUw
         xOp3YFelRp/6GDX/J1bSlc/9clvQsr3/TgdpVAyTcNo803WUnrOan5Vh7RNyQ8jngSSE
         ynqQ==
X-Forwarded-Encrypted: i=1; AL+hErGOzYc/5vuGci1noPyigQHlefHBDqGWzi4VgZA7pnKWKz0iNM+Sb778zosiWstFznFffd0/vDid/1A=@vger.kernel.org
X-Gm-Message-State: APuU4Z/T2yQodLNyWvzntL1tLvwZB5lUdXy5PxQXIGIV4MkNA3GtvGts
	xxvMMGQCFkZNZWYvdYA1CkhaWSl7ZBv3Xf/b92Hf+MIaVwPJDAjroXUh
X-Gm-Gg: AZFdTZfCFN24gkLgyqBFOyvIAFhfAaNNepUHqitAHvXwENL5DnF08yy0Dl0sgSz8BNg
	yOSqRw4vKA+Jn7sRxSJnq09wXmwNaJublo8qudn8Wpchx2NxMzZbvWiirAOMsBPiUATdtVOCPui
	UipfJuNyksdVrdnfsJHi8hVK0MfrjgaVqTvH91HqadQSHS6y0+jFiC976zhyQlZ95KjEXQjfWMX
	b8TOouWoxdDhEkkRJc31Ad0E7Rmb8UKYD/6TyINVFJYWlsfLaa/AUsjHD/xYa/uWhn10OwfEOYj
	ce8cLnIy/mtaONm3Z8nVdNehEAk8sOeKh7SuUmzpY0vDvOdKecftrdkakEnRiNTm0263ddbEQBG
	UmAhSEtKuHdk2qavSOcWuI0QEwqLGCnSR0y95F019xM8naxJZoBL6Dq6EGTvHSHyPb1wXXQV0Gn
	F5OpxEWzK/IxPJi8J2BkwBCoIMXuRn9ltz2XNCGBqH7qKLJK9FgyZKG7UTJBxdVPedoFu7CAXvi
	9cwtfPEN/fcxThrI9Qak1LnZxkMAKCLIwyNqvEm2jBZ/VJPEw6iNj8hVvP4LgD8ei4KbWCazm7d
	Rp1vyKaq3Du55b7eMdPWvF2Fa7WY3qj1dgf7siHxKBpO4fFMYx44H8/s0eTiC3PRNZOrCj+1o+z
	24PTH+T9BoIt5GIbd6/Hy6cLa1Y2F3PtWXPPD74wV0GDZ92R5yfabLzP/rM9jxYDTJ8/4vVd31a
	xK5/rUMdEpBgHP0GddAkWjWg==
X-Received: by 2002:a05:6a20:6a09:b0:3fb:2086:9060 with SMTP id adf61e73a8af0-4014cb394f8mr24110185637.12.1795729051247;
        Thu, 26 Nov 2026 13:37:31 -0800 (PST)
Received: from kapoor ([149.40.62.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cea7c38sm11703905a12.2.2026.11.26.13.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:37:30 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2 1/6] iio: proximity: hx9023s: fix division by zero in set_samp_freq
Date: Fri, 27 Nov 2026 03:06:46 +0530
Message-ID: <20261126213710.1047676-2-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126213710.1047676-1-kapoorarnav43@gmail.com>
References: <20261126213710.1047676-1-kapoorarnav43@gmail.com>
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

hx9023s_set_samp_freq() passes val * MEGA + val2 to div_u64(), whose
divisor is a u32, so the sum is truncated to 32 bits. MEGA is an
unsigned long, so on 64-bit the product itself does not overflow, but
the truncation does, and on 32-bit the product already wraps. Either
way, any value for which val * MEGA + val2 is a multiple of 2^32 gives a
zero divisor, e.g.

  echo 67108864 > sampling_frequency

(67108864 * 10^6 = 15625 * 2^32) triggers a divide error, on both 32-bit
and 64-bit architectures. Negative values wrap the same way (-67108864
also gives 0), which the check added by commit a318cfc08537 ("iio:
proximity: hx9023s: Protect against division by zero in set_samp_freq")
does not catch, as it only rejects val == 0 && val2 == 0.

Reject negative values, and reject frequencies of 1 kHz and above: they
give a period of at most 1 ms, below the smallest entry (2 ms) of
hx9023s_samp_freq_table[], so they never matched anyway. With them gone
the divisor stays below NANO and fits in 32 bits, so a plain division is
enough.

Fixes: 60df548277b7 ("iio: proximity: Add driver support for TYHX's HX9023S capacitive proximity sensor")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 2a6da557f22e..f5cd31a308c3 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -718,10 +718,17 @@ static int hx9023s_set_samp_freq(struct hx9023s_data *data, int val, int val2)
 	struct device *dev = regmap_get_device(data->regmap);
 	unsigned int i, period_ms;
 
-	if (!val && !val2)
+	if (val < 0 || val2 < 0 || (val == 0 && val2 == 0))
 		return -EINVAL;
 
-	period_ms = div_u64(NANO, (val * MEGA + val2));
+	/*
+	 * 1 kHz or more gives a period below the smallest table entry. Rejecting
+	 * it here also keeps the divisor below NANO, so it fits in 32 bits.
+	 */
+	if (val >= KILO)
+		return -EINVAL;
+
+	period_ms = NANO / (val * MEGA + val2);
 
 	for (i = 0; i < ARRAY_SIZE(hx9023s_samp_freq_table); i++) {
 		if (period_ms == hx9023s_samp_freq_table[i])
-- 
2.53.0

