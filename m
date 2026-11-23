Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471621;
	b=0v/YGRi7vxwXkvSO1D20kacVqQAVa8W8rvd44F5t6/lauppYJ/xbe03ksDulyI4qTDtX
	 sMygUt+BP0UnhASYdllo/1arMrQMIzIuEzXq0y4LA/R7+LTJMLcLu9K9OZTaM7thehWvS
	 QfxheGula7nCBtSxp/NjUMSU4Vwq2967hxff/gDzE5nUL3JPJeRAX7P/5GjsyfkPaz9iN
	 ymjd8gjKQkrjek8/SMFbAJToJ1chMrXEIXeJ5V4fCJe42MOMY1VdWka6iS2PMin7ea8wg
	 PaIqF51vyq+1/gaOxPiYK9sopyNHWy1O6j535huNkC90XwpdkaiDOzuGO/75aqDcD9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471621;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Tk5uD5V8TbLVU7b4UvMj1XLTNRvdHu0DZPTcg4okPo8=;
	b=DmSEjWmPCzaxzAdU0Y4N1Nr0Wsz/DIt1hgc5T74Mq5Fk3knT2EiXgJwZo5jytibPs/BD
	 YpM2szdTGDE+5BrxSfC5YaypaAq3nabOQAe6BgyCEGsAQkjWIVsEdJVOVfn5Sd9HLYP8g
	 xYNMRkqwSG2cNr0v6VV6jd3aqtKvazAP9O9U7Sr7v38nujO8mym01bjmfK323dJ3JTjWr
	 3R7TzOLk0ohTThTPLCj79WgICu0v/ueopgWGyQj8K7C3fAD5O6IgNgLusaYWuLpalV4+Z
	 srDV2uWpEVFWCVuifRCB/CV3i9G+N8UJqgnvu7EcaW8Vg8p4VnR4AeWPFFb2D/BxKfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IRaV6suM;
	arc=none smtp.remote-ip=209.85.208.181
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FF9606A334
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 22:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26FF9606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IRaV6suM
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3adfc004920so35733801fa.3
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 14:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795471618; x=1796076418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tk5uD5V8TbLVU7b4UvMj1XLTNRvdHu0DZPTcg4okPo8=;
        b=IRaV6suMaATEzy7Z8xlAs82gQKdSOD5DxtdJp7vzrttrtp4P5eruedMcoebET8FIuP
         El+in7pWOjjlLTi290kTMLLEXdlXAxi3f2RE3yeJoWVv0lUFalJ6DwRIcS6XHb2ayeJQ
         32loRqtMNq8/OiBwFU8Q3HfYDfitKTsxpNplR2SIXjvjFpHPn4Kf7tvpfwEGf0nM28Bi
         BleBdGntVKD+KNEyoCMg55JWPIWupPpgdQd7jrZHcR0jnQ2/PM5Oifv/kiHwCjioy5s+
         Pta/9VXVg9Qt+Jsnz6EmvrlE0CjCpzycrIzUVQThnPk+PHbo1zO4rvXaMzGVHuEhpNzi
         ngNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795471618; x=1796076418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tk5uD5V8TbLVU7b4UvMj1XLTNRvdHu0DZPTcg4okPo8=;
        b=2S/uXjYNZ0uBxGXN7zHSlGMBpUXFKjrJSEKs+suEHwOPY+jMfRJjTzIMbJH11DnA4+
         710ZNpFWjNyukhRcWEvR0yY13FHK3Ld1EdpI5m5dJE79FCVI2JfE5Rpdt4xcidDUpQH6
         4VNMsxhGoaibA0IX6gtmedtFqpE/3bXVFzYsxiDmTnKscX7kKzIrnqEimBSrOHrmoOUy
         B99FGq0wunZbtOIEDdPPmOQEwvkv70CHH2mPzGsIpO+i5k9BSOtbG3+NMk2yaikEnTZp
         yf+XskTuVWGI51cW0TGdVaXe5KB/auZXlGjomd4DvL4LNBU/WMag4XnvF479ygznbwjT
         9OsQ==
X-Gm-Message-State: APuU4Z+knd77+0GFOmgtsXUPxoayEBrScuVM4DtXG2a1mB2aXibrLzYL
	RpK9IsWcgIo7w+DV1hZbu9ZpYZyOfyiEvLvl4oOs85Iv6OAyW9oziqdF
X-Gm-Gg: AZFdTZe7NUpun+bc4tdY9lxSB935EjieKPDD2n44zt7+QHHdczdIlE5Zwtnfz1JjXUk
	wMiLe6PIpVXK7U8zjPLFoBASMM3C4oAEW+2Uz3uI1XhFOyQVdPpKu4EnfoWzrEokpw9bbmyH07e
	MpkCeO923YG12fagbXZLxx1XHTmCPextE+JazxduHMLo1/vZ+yz9pLSufD3mfRlMaEj1j1b8pT4
	4B8Xf09t33GsLw8BDNPDz4lnim8SB7IqG6t9C48pV7qy4efAr5fajKUiLGWU+26CLlMm8yAogxj
	owAACD6/iqHn+Tjvqmn46L1hEPGDkAJilURxErGRMKwLycI+TYDSqUf4qC9dslasa0QN+JSyDhl
	GX1yjnb1MT2x/nlpt7fVJ/kifx2nQi7v+CanbCcKSFpFiIJBY3U7Porx/Fyu+3HRTW41yZSvp/m
	3iQCwfKRyh3mif6enUpgXinFI9CvFd1MqoCjVFZBWMbyCUfdetX5AtydBNr5jAe5DB0d6vBTlaJ
	BpzBg4SPawq+eCqaBwDYCVTkC7FSvT+lc7DuvC5dlLG7ZXU35de5J2evPSAxAfWQXCaFvU92qWR
	OAFOqYcIJBTVGbrFHA3RIu6ZPCOIEXEKwb27raeLrLnrah35rWg0nKFjJQCBGHcQeB6efXBBRB3
	J7ZSSZXzRlHRg+MgaualZukqAsYuVTYNrDweVtw==
X-Received: by 2002:a2e:bc02:0:b0:3ad:f36d:41ed with SMTP id 38308e7fff4ca-3ae7fa19f9cmr37612581fa.19.1795471618073;
        Mon, 23 Nov 2026 14:06:58 -0800 (PST)
Received: from yantra.. (nekmmqsyyquzw1lm5eb-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:3cd2:d52a:a1ef:5dd3])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae805215ccsm34272021fa.21.2026.11.23.14.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:06:56 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH 2/7] iio: pressure: dps310: read the coefficients with get_unaligned_be*()
Date: Tue, 24 Nov 2026 00:06:44 +0200
Message-ID: <20261123220649.36887-3-zoone.rupert@gmail.com>
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

The coefficients are big endian fields, some of them 12 or 20 bits
wide and not byte aligned. Read each with get_unaligned_be16() or
get_unaligned_be24() and let sign_extend32() drop the bits of the
neighbouring field, as the ZTS8032 coefficients already do.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 36 +++++++++--------------------------
 1 file changed, 9 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 02dbc5a8ac37..48df5a28c140 100644
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

