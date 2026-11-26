Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795695221;
	b=OfetdcJmhCPVG0yxH1QFhMmmfTuqCSTGNcBoEF4gvjYuUN7EUQlg+/OJDc1jw2pIC/s1
	 w5rOtOAoQ88UokPnoUpqWnyiaTbAIL3qNkIdwPgzkA5pQOaOnfk02q4yFv/4OP6u9h8oi
	 NfVGWu+FFGI7ib+5Sq3P/OWfQazdskLxTYaJR/b3pG5pfV9zfUlOtOBOpOBDnuBBZAL0D
	 cTDAjbUiFiSxUHBDueO2xaCDHKUSoG/BBzOt7Glp+O54HQun8cd5lx5HSbdjIAd/ITRM6
	 a+cwMAJbvHORptrdgwong241+2wDtmdUTU3IwjLvl3n02K6DZs6JUls0rVfRFflz7vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795695221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jMhje2gFEGMhwhdy3xLDdOVh6UnYKEqxlg7UxZsDxjQ=;
	b=RRVAGHS8K/yJ5V/94PSbQoHotBj4oij08J5O/laQEeROu9qSPwpxp6tYBtRt81Ze6j1D
	 h1vJ0GqMVVN18pGb80JcApeS+LVtDFYoXInZRsVdJsAihShZbu5ZXdyELlGzaJtiEDC5P
	 U/U1qcwtqRay0ILIQAs/ps/09AlsF5NqUw24wPpALP5PVjHOG0/cnt7aaRxdIXFPGFqTb
	 fN1wqdH5tp4l9IrgCrkjr3z/yBNPBrlGCIJr8DBBwHNbQBCjGteUpmEzM323kzdWWZRpH
	 Q9b34fOLpvJF8JZ5rBg7XSEGtIJDNHYujrWPbAK6ohhfwVKh/MZIMTwyJ6Rqw6Qma9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K9zhOTlt;
	arc=none smtp.remote-ip=209.85.167.43
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E774F606A31E
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 12:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E774F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K9zhOTlt
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so352793e87.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 04:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795695219; x=1796300019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jMhje2gFEGMhwhdy3xLDdOVh6UnYKEqxlg7UxZsDxjQ=;
        b=K9zhOTlt4nNrZhN0V6C4mNeztK/FZUJg2ZJ5o41KHa7dN71TZZVR16IoRdaF6r+qwH
         cNfDIvfBmBKraEjiIwcI2xx4PtYlxgu5/bi26QbQENxjEBGj93OmJZKJ09ePjESzwMWE
         NxmHAdy0xskOBOO43s4IHcDocFwQhvgiWP6D7ac0YKhpFarH5e0A73IJYbKIWgH08DU7
         e2lcoeapKX6qJFd9DmKYMwhxubueeOtsVfIcMJeVP6LtOtJP6GtfjhAnZr9LvBnytseL
         s5BVsEaGhqkqFTY20R3HUBZj8hsUjW1cj30uFGRC8fYVPgQZO9HruTYKWbbcDNcuSOHt
         kkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795695219; x=1796300019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jMhje2gFEGMhwhdy3xLDdOVh6UnYKEqxlg7UxZsDxjQ=;
        b=QXepUiotIATMFuccZeX+DyCaT/ixwoJvHQqvIrFuYvua0aQNWuthFXl0c/nVhUJhjD
         wqePDBgo3sdDd3Q+gP2gWpvtaEv0RfW3JKFh2L/gLSrSlxE/MXGMnoRBfnbm5q+fkwWy
         O4NDi2FDNr/7CVDW1vcJTglRQoHbb6pAeNn8BS73PWJxDE+lEksGIacp9UFk1RVixFjG
         nWezTwYLzMk76vTHL9HRXd3xGLPwm2y3uI2E/VkF+hxBXD6EjCVvVr1WbxzD/xSdl2Ub
         d2ooN1scgPBKASZprNCWl06v2XhIO6PudpDEPR+6A/EgRbGDvnQH1lw97bQe39fP3cd0
         Bbjg==
X-Gm-Message-State: APuU4Z8y1H7/y8/NOJV7OpTq9w/zHKH8gfEgoSqe537mbEafQNGRCQOW
	RzZwlkFSdydevkBJ3P49rvF3g93L2gKzoXW1HrdUGB4sMZsq7w2uz53y
X-Gm-Gg: AZFdTZdxiFa9GkcODquCRvaLaChgd6OpL5Nh+N7dbU15ct2/tXJZ86QlwTlsP54hdif
	AnTxALed+NMc6SIPxKtIAdp+rmrhMPYMCCj9UmJCYAXr+3+XGDHWqc3EwP7ZRTVVyskj+UVkrGS
	4VngJak8cH7L8fU4+dQ/8cW/QO4qoELoRnQID5TFvcYJvVjg7K62LDzLvjyhAT7l2giJJxzXL1j
	MsEXztXut5u/4hvGNVNTtmTJFaiiqk+ez8FPHcXM8DetcEdnrnsNzgSjmZ+tzTOoUMCT76DsJ6J
	ARR7Wwfk/KJ0NO6Xo1e5DwxvYsogF0KlEr2/xyROdA/KHPU9t3uDsDdpKTx1tfAIhW3Xh8TUZRP
	1UCqdboVp+Wd4Y5mq3ZdF2vakF7Ln/CE43feajZU+dS4AY5UJ61L6NCI77d/BLH+7tYythS6pdO
	ysCO3jEvcVmyg0iSof/iabJywJshSOwJHbzcP84/Uq80TCOidp7mO0Kzcdp3pKKgtRytr7jR3BP
	7xI6ucJ+XkqicwmQfVQh+gVrLHjXa6pBBPsXqrZGpeOd7yapdb0UBhLe5Zai/+tuPgGV02XWpiq
	8RHp61ADPSfQ0pPgv4i+4qSeln3LBahCNxVPJFG+5kdLEIsfHayv+v2BrujJ5SaFx3b9nIUVIym
	Ayq0ObpQiQAR9aOuddXjhQmLnwUJFulu30nPE
X-Received: by 2002:a05:6512:6695:10b0:5c0:bca:77cd with SMTP id 2adb3069b0e04-5c1bc803ecamr4435362e87.42.1795695218890;
        Thu, 26 Nov 2026 04:13:38 -0800 (PST)
Received: from yantra.. (nekmmqtmzjx8yvukhae-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:68b4:f70:61d8:6e86])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae8044e8e0sm56541791fa.5.2026.11.26.04.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 04:13:38 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH v2 1/7] iio: pressure: dps310: sort register field defines high to low
Date: Thu, 26 Nov 2026 14:13:24 +0200
Message-ID: <20261126121331.10438-2-zoone.rupert@gmail.com>
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

Some field defines run from the high bit down, others from the low bit
up. Sort them all high to low, as the datasheet lists them.

Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
v2:
- sort high to low instead of low to high, fewer lines move and it is
  the datasheet order (Andy)

 drivers/iio/pressure/dps310.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 9ffef150cc4c..ce83bd3691af 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -54,20 +54,20 @@
 #define  DPS310_PRS_RATE_BITS	GENMASK(6, 4)
 #define  DPS310_PRS_PRC_BITS	GENMASK(3, 0)
 #define DPS310_TMP_CFG		0x07
+#define  DPS310_TMP_EXT		BIT(7)
 #define  DPS310_TMP_RATE_BITS	GENMASK(6, 4)
 #define   DPS310_TMP_RATE_1SPS	0
 #define  DPS310_TMP_PRC_BITS	GENMASK(3, 0)
 #define   DPS310_TMP_PRC_1	0
-#define  DPS310_TMP_EXT		BIT(7)
 #define DPS310_MEAS_CFG		0x08
+#define  DPS310_COEF_RDY	BIT(7)
+#define  DPS310_SENSOR_RDY	BIT(6)
+#define  DPS310_TMP_RDY		BIT(5)
+#define  DPS310_PRS_RDY		BIT(4)
 #define  DPS310_MEAS_CTRL_BITS	GENMASK(2, 0)
-#define   DPS310_PRS_EN		BIT(0)
-#define   DPS310_TEMP_EN	BIT(1)
 #define   DPS310_BACKGROUND	BIT(2)
-#define  DPS310_PRS_RDY		BIT(4)
-#define  DPS310_TMP_RDY		BIT(5)
-#define  DPS310_SENSOR_RDY	BIT(6)
-#define  DPS310_COEF_RDY	BIT(7)
+#define   DPS310_TEMP_EN	BIT(1)
+#define   DPS310_PRS_EN		BIT(0)
 #define DPS310_CFG_REG		0x09
 #define  DPS310_INT_HL		BIT(7)
 #define  DPS310_INT_TMP		BIT(5)
-- 
2.43.0

