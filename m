Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471624;
	b=3ibNIyYxhgfWBlu0Tv37cWO/c01aNVsHX0f3fheeaZWAAGhDv490Kr5pVESl/8zPiMhb
	 Zwz4AdcPtXS1jhqZbVswCYXwKsCEbxN2dzoQQ5SWW5LcxUB0MQETBlTeBWujMTMShqNzn
	 lU7bW1bkVcCrp0eD5zS0EDy/OB8x5hv0ibTKdsWAUzlODBW+1ttUPRRrTjRLKaLZcN9pX
	 rlCGT8v7R+14r4CTU9ljRrWM+V9kshdK9fwJz12yYJFNHoMH0jACV0Bfq+Y3MN7sMLhE8
	 j+m0fYjowqJeGswxdJToJQquHn2qi5nmjgPWtsY+CiaQ3w+ugpY6GI+E7VeiIE7zhuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471624;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Cc3Yze4XZSoWd5COsCahsRwXKqXznpMqPrcsRubO3Y8=;
	b=PWDH/H35Z9l4wdH6UunnrfJnQVZuXqIgGCzuJQbFZY9lUxGT9XypD14MOtOp1MGf8hKG
	 mM/H6ZUaCbCLvlilEve2YL94hYxY/tkgtOr68BldwpqA95ieVpS0p6jlCwzfzyjxAZplw
	 LybTtguCFWjvgJ8WSTTL3haBxyNdtK1O1WFUPRiQiq4/K9kKk/DfEchVFp4WjWxE90w92
	 fWJqchOprHohWOGDrSHNgGbQZlDDdO/CGXfscoyinHqLFCIWwtCxsndRgMIXZry96b5cA
	 k1ZofMwZ306yf0aCz34+f0pcX0Qo4vj6h+uZrtbWPlOR/mI0nS+OsJ61XElbJaFLbaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dUU5+aTV;
	arc=none smtp.remote-ip=209.85.208.180
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9177606A336
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 22:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9177606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dUU5+aTV
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3ae2fb3fe2fso34259421fa.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 14:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795471622; x=1796076422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cc3Yze4XZSoWd5COsCahsRwXKqXznpMqPrcsRubO3Y8=;
        b=dUU5+aTV1huIgZIo4bNmRi8Exz/6ZCURgC0RvSb8BoUkrCcVtOcin2V7HB+C9t/Q1x
         15QW0riFtSdUila/eZvD738KypsrIM9ULOvJsv8utLXv1CMELTnFZ6TTcCO9JVr/XC6u
         wLzJxe06JgSKY1fxksz4GJB9kHhCKzGfbWU6C97EkqRVzDusL/SZ9/esQCtGBOe1RThq
         d1OrUoUgmWPC3oqtTDAaPorVbmPgYHDG8qOlPNF/VkcojiH5Ox2ggjK86iqMfxzLjMhb
         emYXQQFlhh18Bin7BzTmWwBsbND3NNit7hx8KlRDxM3ZjZSAuFpknAudXMMLjaS4jOw/
         vFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795471622; x=1796076422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cc3Yze4XZSoWd5COsCahsRwXKqXznpMqPrcsRubO3Y8=;
        b=CzrJylBAjJeDbWFf9+Y7D1CvMIURznx272UbHd5E8A5JO6IAYYJkgonzLTM/pM4pDC
         PB7/HQsu3EHNxo/uzEjOqdiWLjLabO3B6TkR6J58T7SfIY5rmDb70Wv/H/Ebxd7Nmfpr
         VlooF8WhdspDjfzMWxC+0+Pum2hfjMBp8uHasveP9qXcf89PCLk9/Pbwlpp1u4ddF04y
         AJhHcu/bNQGBIsxb6+e80bV0YwRvDWSUYRxaiKEvffCsj0nrR6uocAPwYunQULRMraJh
         Z+yT0+lRDSQSCwIpt0L7LZ5I0eVgIMNGKkLH6+A3xUG3BhjbPM/0gD66Tp3anFAPvK8i
         +nVA==
X-Gm-Message-State: APuU4Z9sk69z8fzKG0TNkTatgOAQemILPcXIBDp7UXtcOAV/2gFTdiQE
	V6TG+RuewtOuijjtANbJEo7/lu80p7Aa0kNyZjql/c2JHONKNoGGcLAR
X-Gm-Gg: AZFdTZdXJnpxQsiIgfpnASKSy6vgOS4u4ilLKM3Lk7R4pdxBc34L7isG+J3EIhCC7Hl
	o2ly3BWMxFH6DKwKjaBKkEVEGSfX0p/hbxZfiIqCxtNMflTdywmxVo1zjBo+AWtme5SYGcIWpvU
	xBIqdEB3xYKpdUdRV6Yb11h5nV649I1qYhVBaBqvVaCY0Jdyd7FCuwi6Rm8GzbDQc4zOuJDlhX+
	2bdH+peMogsXEb0FebLNG+F5SZz5OMG0lOzA60ddE2YOEbAuRd84L/zxWKrBE4uN4jnPBvZfHUQ
	fEpy5xlCqi+kXlQ4+oeL/py2Cy+OW8Hba09wCNXWKUvAw9upMhM20p1KFGFUXzfT7p0ZBTzxQNA
	VTS1z+KRspFQG5uOszS7kJnsnl0ctQL5AwERIVdLuw2mt+U13A+phB8vZvIKheyUHtrObMSYuAA
	xSaiSGTHQ+cO23o77vOUnhsoFE9NPGsNgbl1UvFgAjS+QsOnfvrQmm+sRnNmFegPmEFi3Lv+yJv
	v0d0APnnhrbUlU0JIS7CjRA8nsscxIOK8s6UEW/DpBnIGM7NrdamJW4NYM4yldo4Ceqd1FJ3rGZ
	OjcGz7w00LL2kLJIJyoPzKY3WfqBForNre+lB/Y369lQwmPYlsVtkNwrCA6nNlpIH94kMcgew0m
	sc8RjZTUM9/EmEVb48nhlXs9kOFoGWHQ5oIu5yQ==
X-Received: by 2002:a05:651c:c018:10b0:3ae:854f:d042 with SMTP id 38308e7fff4ca-3ae854fd127mr23047811fa.12.1795471621752;
        Mon, 23 Nov 2026 14:07:01 -0800 (PST)
Received: from yantra.. (nekmmqsyyquzw1lm5eb-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:3cd2:d52a:a1ef:5dd3])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae805215ccsm34272021fa.21.2026.11.23.14.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:07:00 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH 4/7] iio: pressure: dps310: use KILO for the Pa to kPa conversion
Date: Tue, 24 Nov 2026 00:06:46 +0200
Message-ID: <20261123220649.36887-5-zoone.rupert@gmail.com>
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

Spell the Pa to kPa divisor as KILO from units.h, in both places.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 535b77da7654..e5a89dac1325 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -33,6 +33,7 @@
 #include <linux/slab.h>
 #include <linux/time.h>
 #include <linux/unaligned.h>
+#include <linux/units.h>
 #include <linux/workqueue.h>
 
 #include <linux/iio/buffer.h>
@@ -895,13 +896,13 @@ static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
 		if (rc)
 			return rc;
 
-		*val2 = 1000; /* Convert Pa to KPa per IIO ABI */
+		*val2 = KILO; /* Convert Pa to KPa per IIO ABI */
 		return IIO_VAL_FRACTIONAL;
 
 	case IIO_CHAN_INFO_SCALE:
 		/* The raw value is in Pa, the ABI wants kPa */
 		*val = 1;
-		*val2 = 1000;
+		*val2 = KILO;
 		return IIO_VAL_FRACTIONAL;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-- 
2.43.0

