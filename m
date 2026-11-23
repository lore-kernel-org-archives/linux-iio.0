Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471626;
	b=E3lgcXTaWPsn+6Ts4QoOoY5tVrsv1tFr6MkGTPZvQjQuFOqy/Yb1NT9G5vlA2IctFO4t
	 4kC2rrWIex1Cu4dUJ0/2K3oGuRtoDqZWLbdASyLhym6n+lK2+n2Wd47yYE7PqBEzmVCEQ
	 eEnFungoJnLokAu9xDldrxm4T4k7dpzl/V+E//23uZ0bG9bIeOscSUIr2EX6OWf8w0F3H
	 mLeXVGNLgtAa3VNnPbkSWPFAcJUR3z67BMWDJq/kMQpplKb20f4tJMFPwWWL/MPywCKst
	 uyc0MCnKyc31CWxteZTdLDotaQkSqHO2xLw4t1XuI7D3w6/RH196pKhGC67E5I42Lgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471626;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2A2uXjB+0bzchrY2vV2nfV3+nn4kAAzYbCNxqbBXeCI=;
	b=LiSf9iIBC3H8Byhxq62aT4ZGXr3iJprCRa2/hlzbOhh0oR08Vcly3/rPGydLyBpesrDC
	 50gE/qxWtsJMO4HJDBB8A/iRNaApIupX1D2oe5Ma/5KlZgTCRHS06lhhBiUE8pZaSwzn2
	 rpPnL9bLX/QMGg30SMxUJOXsdsgmtXsIgjMfEXAE0Jn4+XRAl639pV1MT33h73C95zXj0
	 eksDSEgAcpq/SY7QxO3nFVz0pRR0p+BkVnfJxV6aeb1fLW8fmL70cyov75MClPUWdbp4f
	 FCahujtV1wha1iTxT4/5Jh8GVZeb5PdTlw6fzSaGyoIYLZLM95E4sRo6B24xp9uLtNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b8mVBdXh;
	arc=none smtp.remote-ip=209.85.167.49
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA864606A331
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 22:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA864606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b8mVBdXh
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5c14f3dab66so3054263e87.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 14:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795471624; x=1796076424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2A2uXjB+0bzchrY2vV2nfV3+nn4kAAzYbCNxqbBXeCI=;
        b=b8mVBdXhorwXtY/YNR5kRqgbjNIC/yQbC7/YJdXpv7HkUx1+QYbk1AhzkZhr2Gi115
         1OxV/ic+O/1R1TbyXNPFXBYVELF2Y0JB4x+4Cib0X1cym5U/S7v3QiB9ej0etFkMqDvt
         vCuqo6EsXzT1ckyul4S8f/XMdLuZxBoV2CFgxybLsIP8PAb5DSkv2kCDzCWO831fa7zH
         uZL7/lqKUT3vkIyWKZGUQI7tImrY7/eSMUjBvk/eXGEv95kBIKkuLJSNnshA2vS7JUcx
         ioNjnjAfTRD/TGsu/digRPdtrr6HTpQQ1pfhHwySjrv8dAmwug3g2Cej/CUN9FYUjxZM
         /wJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795471624; x=1796076424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2A2uXjB+0bzchrY2vV2nfV3+nn4kAAzYbCNxqbBXeCI=;
        b=DXaEzi7/FPfzheWYcUwd+Nw770OZbTYcL4jPy9MO39i1fqF1lKnIeubtPWLecRPRpq
         y7Xq7VrjEaGaPt/XDkwPjR3cyFnovZe5B1CDyE3/KUKJD+pNBS89MmxXFOf8jImSU9bB
         wn1RCaG0pctZtCIG6nnITtuCgz87XbOJQ3C0RWziKb/ipju2OHSxKDaHy8XHfDSIwsrP
         Zta8f8RjCqkdzwnkILJWj9sXFM/2EDU96EdGbl55nbApaXrRf99LhmGK11HUbQ8nHqF6
         NnZJ88PJjqmfP9KRa/eCoGa/1mWGDo5eZPKr2aMCityyJgTAf77FKACLR/mxsdutnNbf
         3g9A==
X-Gm-Message-State: APuU4Z/zoT1nOmMb4iFpLhChGvhd8C3dcKnKzR2i2DWGKa3u4S9yvgMo
	uHII2Y4jXg+vpAIlzO0xCm88Wqa0wtICnxfuDHfici0SzAkvUrKzJ+Cw
X-Gm-Gg: AZFdTZdKuOUJBT2dGajImAb3wyldpfX5cMV4MT6Aihct+0C8u4+C0L8NbifEMjwRvgl
	5G3cJZK5F50mMYETzZuaVjlr5mh2n9S9lYpVQYrvkK2Y0cYvJe+whmeAlQWT3GGzODPEOecrKia
	Va78tcaexyNT/5EZLm7cz1pMFQW2O5vHQwjEfzL6URJJ80cetRFuTyz2skpWATcRU8Op0/+wyTw
	2BN7PEPiMkSJbRJ6VWuPnmgQK3k90p1AoLgKQPbx8OnvuOXJ134qS6MEYVqWpKzyjFjpq5+Av35
	OPKjqJmuWhfcN+VyGKSwXE/BgCbiONLvxU0NopWSzPDyG/N7Jk2/SYrQLu1gdqP6Q18TmpBALzM
	heQ+FbToqbGNiMTXDd654B1Hqts8bLBolkcDNnNZ+KDcNIpI9qHnWtwhYjt/XHPIF+gDvCwygqr
	+jdu95OuGQjexh/gWDSXA6V4uHVfticBIjrd0zw7AjCXfRpezPljr+cIbVBqsfpcSrX3Qe//IGb
	XzUQFMA08IouNpkrY+dtEr1s5vE/5udZF7o0krntYWjzrw5Epb8GmDH3YG08wsKqwupmJz9mIMw
	X2NWRyBxD9BE9B76kFowDtnPDfaqgG54dQgBD8XxFdVmetcdtcnkd075E9rf5dDJvC5iNcvZSEq
	HOfv1VP91e6uW7pGTHeP6Ily/2G31SNUCeuWzThrK2wqFxv6ncdRIKSxF6ms=
X-Received: by 2002:a05:6512:114c:b0:5c1:4bb3:afbc with SMTP id 2adb3069b0e04-5c1b7c42d53mr3575738e87.26.1795471623995;
        Mon, 23 Nov 2026 14:07:03 -0800 (PST)
Received: from yantra.. (nekmmqsyyquzw1lm5eb-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:3cd2:d52a:a1ef:5dd3])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae805215ccsm34272021fa.21.2026.11.23.14.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:07:02 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH 5/7] iio: pressure: dps310: use time unit macros for sleeps and timeouts
Date: Tue, 24 Nov 2026 00:06:47 +0200
Message-ID: <20261123220649.36887-6-zoone.rupert@gmail.com>
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

Write the microsecond values as multiples of USEC_PER_MSEC, like the
poll timeout next to them already uses USEC_PER_SEC. Wait the 15 ms
after a reset with fsleep(), which allows less slack than the old
55 ms upper bound.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index e5a89dac1325..eb5715f75e9e 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -20,6 +20,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/cleanup.h>
+#include <linux/delay.h>
 #include <linux/devm-helpers.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
@@ -103,7 +104,7 @@
 #define DPS310_DRAIN_MAX_MS	(2 * MSEC_PER_SEC)
 
 /* Make sure sleep time is <= 30ms for usleep_range */
-#define DPS310_POLL_SLEEP_US(t)		min(30000, (t) / 8)
+#define DPS310_POLL_SLEEP_US(t)		min(30 * USEC_PER_MSEC, (t) / 8)
 /* A period plus a measurement time; silently handle error in rate value */
 #define DPS310_POLL_TIMEOUT_US(rc)	(2 * USEC_PER_SEC / max(rc, 1))
 
@@ -370,7 +371,8 @@ static int dps310_startup(struct dps310_data *data)
 	 * They are available 40ms after the device has started
 	 */
 	rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
-				      ready & DPS310_COEF_RDY, 10000, 40000);
+				      ready & DPS310_COEF_RDY,
+				      10 * USEC_PER_MSEC, 40 * USEC_PER_MSEC);
 	if (rc)
 		return rc;
 
@@ -558,7 +560,7 @@ static int dps310_reset_wait(struct dps310_data *data)
 		return rc;
 
 	/* Wait for device chip access: 15ms in specification */
-	usleep_range(15000, 55000);
+	fsleep(15 * USEC_PER_MSEC);
 	return 0;
 }
 
-- 
2.43.0

