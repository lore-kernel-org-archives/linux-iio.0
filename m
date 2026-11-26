Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795695225;
	b=GSCYVusqeU9GoJsZRqIcHx9Mhtp7Iah6pkJ2b1F3EaAOu531eoXSjBoVBtnn/09oXfSU
	 AvdFEU8VrEOB54WpvUBWDb/YOK6x47Z66hX6jiQuGs42MInaQD2tGrOzaBdfpzZJ98KV7
	 VbVkRGVEI8AF0Jewh/DTaS+htsprBjYv1TK4zdEspO4jX4Z0WSl6fvrTpURgNabgb3GqO
	 8b8bULiuS0mpHKmPWetGfBuFcxGWSuPATb8jXslk0TP3CXa9Fa8Jvbo2DkIrLRMSG5ak3
	 1/W6PpX3jZpH4isEDRVHOLqqzzVVbskuMMBYQ5zdbytE+FkVHgylPrQWRc6J6N/eu7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795695225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IKo51XN8NfxEpTsepqSSjLtEqea01Lke9oM38577tNE=;
	b=kMGE/2VHLuaUFJ/jsbZI8ASPZqzxqVAY9oWO1JcF+YLOnryrDfpL5vKln6/JlaJriENn
	 im/y3LAvGumwjO8Vd2qgh1pExJb8D34iPkUOOUJHeE6L8mgH87Jq9IQpR2lPwF0ATd/M9
	 TTDF5pXPpKdSLStN3rzkSOoJHYXor3PhAvsi6pg/wdOR29owYD+tUILMHkx6cv+yS1iO+
	 tT3KCZfDut1OaHiCBvUkIeurnpCsnMK0g5QTBk0CjQ3DwcK5jvfbvDIdNZ/5zqR6a9qdd
	 3FuZYiz9mUk+OQuUmg7DTi5Y6gSaXYqTI3i8XuTqVbQYmaA38JPU7B0Ji4TfdeM9SXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZmfgwZ+y;
	arc=none smtp.remote-ip=209.85.167.44
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8E2606A31C
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 12:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D8E2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZmfgwZ+y
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5c14f3dab0cso3915359e87.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 04:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795695223; x=1796300023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IKo51XN8NfxEpTsepqSSjLtEqea01Lke9oM38577tNE=;
        b=ZmfgwZ+yVNUDOm+Pni5F6B76OERMzyyBtswaeBekBLzeIOigrnptcsVOguQyL6zInq
         PDLjeupiVgUFuFjvlHUek93Y+8dpGJc1V4fE6dHr2GxMMi/2R8+LUbO1eKn8Sj9vl3Ei
         GTQ3aYYDRhC7TkJrd/Tx47LHN//NNBJ4Tn8EZ/FEHd2v7dcvngtaVlogn2tEkmynbb/g
         wwA6/om1EpPEAmS1X/tkchCLsXBSHr9fxIfF2b5axcH4Nk7t6Hnz7ya9c++rOibtqclM
         1s2Z2Y8z2EFKPST3Zf9rYc+AbcrFoKk5zPCadG3DzELXqJZUWo4QGUZVL1CC364x7NBu
         0XEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795695223; x=1796300023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IKo51XN8NfxEpTsepqSSjLtEqea01Lke9oM38577tNE=;
        b=J6mA2lw64bwS+WsGabiPxxVFw3RaPpQE5FRDInIt1m0EEjQHRk2nXyB61ERjn5L/Z2
         W8mkTedS/1SVs+vv0asq1OpusMvC+luqrs9b3LZZmgcPJrTR5z22eC6NJyavn95+9gKM
         auSZpd+ZysPk0ZDId9XSvFxvv409kIQg8kvN/Htx2lXyHlyqbpUlGmQjhH6r83mPDraw
         yTAUCbNcowfY7kfTSx42Z7aMnC/nt7S/Vtxaw4nDPq5w040jKAUDTyjOz2atJDaE/I0a
         JxE+5Ha8nqxqbfv6lhiEDUrv6O4/SNMhwXVX0xlIYTz3x9USIbYTxf0l7xPsD9TrOi0O
         Z9IA==
X-Gm-Message-State: APuU4Z+6jvxAeagunLE3IGdb5hgNyu5euDDsG97iOOuPv7GE34ns+b4i
	luhxzJSDkeCQeCqWhL+DrwO3VPBOCZ0h8gb0JMFmTeZVRFgJA0OoZHVd
X-Gm-Gg: AZFdTZcaBqh3KYf98QwbNih21nvg0068NNFg/41lv2ZBgRNWwzCmwOWh4YH81PtDUaa
	ZLkOQBj7tXcXLjnmPA6RCoctHQz82buaK6gBVgUlQjmremIZBLRK95NoEMMK9nQSvZ4/Q4CO+W3
	3tWtBevppBYhbJcVvXagW0SQCaeBSzmgFL/D1VbahKdjzlWTomxtzf/qtgGqoAu7HUC+W8LEl6k
	h9z3E597f5dzdRBeCqnihlt1MIi9aJIuLqZsF8fCtP62vCAH3cv1REC0mwFbr6/j2UfbSxXrIU2
	GoKbI8tMmvGpdwIrjLpW8wm9XeNyJ1xsAn2ugzFFwSKE+OMZYg6tNrHeZ87LU2AFYG1zt0T+4qk
	1av9x7rUDptIPUfuLWqnQo1fh0dmi3YHvapREwwUeDG5h4iqn3PhTKpNpELIR5t5teP+J/i/HQP
	ZPqAhYYWEy8jE2awTokX1AFcgji82dn/vfkCHZG0xtDEAsfdk8k5fYQ61Fuc08aULwjljxC9QfK
	fmx/gBYxlWNLgOs5WHVZOSNpEMGwBqYPh4qP6qsGEGpvKTzQyh2rZpK3enoprdTOhXa2iZkNfuQ
	C+NMNxGgE7k6aqmajfMUqsyFZAkufODFtn1iR6cohVxdBoOn/6sGdDFV07JT3+5TZo+olUXcqnX
	LWR5eFdXZHzbfMME3mgSv8con66DkiObu0Y2XWPuN6DcnK6pKRJYLu7rVpQ==
X-Received: by 2002:a05:6512:304e:b0:5c1:4bbc:45cf with SMTP id 2adb3069b0e04-5c1bc8a5cf6mr6545422e87.48.1795695223318;
        Thu, 26 Nov 2026 04:13:43 -0800 (PST)
Received: from yantra.. (nekmmqtmzjx8yvukhae-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:68b4:f70:61d8:6e86])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae8044e8e0sm56541791fa.5.2026.11.26.04.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 04:13:42 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v2 2/7] iio: pressure: dps310: read the coefficients with get_unaligned_be*()
Date: Thu, 26 Nov 2026 14:13:25 +0200
Message-ID: <20261126121331.10438-3-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126121331.10438-1-zoone.rupert@gmail.com>
References: <20261126121331.10438-1-zoone.rupert@gmail.com>
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

The coefficients are big endian fields, some of them 12 or 20 bits
wide and not byte aligned. Read each with get_unaligned_be16() or
get_unaligned_be24() and let sign_extend32() drop the bits of the
neighbouring field, as the ZTS8032 coefficients already do.

No functional change intended.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
v2:
- "No functional change intended." (Andy)

 drivers/iio/pressure/dps310.c | 36 +++++++++--------------------------
 1 file changed, 9 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index ce83bd3691af..abf1652980ea 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -239,8 +239,6 @@ static int dps310_get_coefs(struct dps310_data *data)
 {
 	int rc;
 	u8 coef[MAX_COEF_LEN];
-	u32 c0, c1;
-	u32 c00, c10, c20, c30, c01, c11, c21;
 
 	/* Read all sensor calibration coefficients from the COEF registers. */
 	rc = regmap_bulk_read(data->regmap, DPS310_COEF_BASE, coef,
@@ -252,37 +250,21 @@ static int dps310_get_coefs(struct dps310_data *data)
 	 * Calculate temperature calibration coefficients c0 and c1. The
 	 * numbers are 12-bit 2's complement numbers.
 	 */
-	c0 = (coef[0] << 4) | (coef[1] >> 4);
-	data->c0 = sign_extend32(c0, 11);
-
-	c1 = ((coef[1] & GENMASK(3, 0)) << 8) | coef[2];
-	data->c1 = sign_extend32(c1, 11);
+	data->c0 = sign_extend32(get_unaligned_be16(&coef[0]) >> 4, 11);
+	data->c1 = sign_extend32(get_unaligned_be16(&coef[1]), 11);
 
 	/*
 	 * Calculate pressure calibration coefficients. c00 and c10 are 20 bit
 	 * 2's complement numbers, while c01, c11, c20, c21 and c30 are 16 bit
 	 * 2's complement numbers.
 	 */
-	c00 = (coef[3] << 12) | (coef[4] << 4) | (coef[5] >> 4);
-	data->c00 = sign_extend32(c00, 19);
-
-	c10 = ((coef[5] & GENMASK(3, 0)) << 16) | (coef[6] << 8) | coef[7];
-	data->c10 = sign_extend32(c10, 19);
-
-	c01 = (coef[8] << 8) | coef[9];
-	data->c01 = sign_extend32(c01, 15);
-
-	c11 = (coef[10] << 8) | coef[11];
-	data->c11 = sign_extend32(c11, 15);
-
-	c20 = (coef[12] << 8) | coef[13];
-	data->c20 = sign_extend32(c20, 15);
-
-	c21 = (coef[14] << 8) | coef[15];
-	data->c21 = sign_extend32(c21, 15);
-
-	c30 = (coef[16] << 8) | coef[17];
-	data->c30 = sign_extend32(c30, 15);
+	data->c00 = sign_extend32(get_unaligned_be24(&coef[3]) >> 4, 19);
+	data->c10 = sign_extend32(get_unaligned_be24(&coef[5]), 19);
+	data->c01 = sign_extend32(get_unaligned_be16(&coef[8]), 15);
+	data->c11 = sign_extend32(get_unaligned_be16(&coef[10]), 15);
+	data->c20 = sign_extend32(get_unaligned_be16(&coef[12]), 15);
+	data->c21 = sign_extend32(get_unaligned_be16(&coef[14]), 15);
+	data->c30 = sign_extend32(get_unaligned_be16(&coef[16]), 15);
 
 	if (!data->info->has_c31_c40)
 		return 0;
-- 
2.43.0

