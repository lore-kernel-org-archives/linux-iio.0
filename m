Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C24A4218A8
	for <linux-iio@vger.kernel.org>; Fri,  6 Feb 2026 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398967; cv=none; b=CNBfx2Py4RArTnLet2ijRLh5bDPiv0k10ENaFVEkZrdFM4MfGoR7ik26L7hfQztr+0mduo5OHTC+p7FmzBjlMvEzDyNu+OMIFRRZUYFyc7Mo8QW7E2I1UO+Jk/21pNRu0ATkqYFPOZVWBexiHT87+RZEYuOX9J22zrNblp5f/ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398967; c=relaxed/simple;
	bh=N4sfHKpleqMrWkE0BhhX+wodEn0xk4GfgnLKvXeA0GE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlzkeAfbDf/JKVh6UF2Yb3d/4Rjjtnzq0EtIMnjTAWZy6PhszcHPlkgaHtKVsklTcea26ZD4XgDXKWxYWmuUVmzN6PSgUp4HqO4I/ltuJssamrMuKI6WJqTgXUArjZESkAl064MuL/i+/AtIl5/Uo+OwZKUwvOtmAb7wE2a4qRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/jkF7v0; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/jkF7v0"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4327790c4e9so1488597f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 06 Feb 2026 09:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770398965; x=1771003765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38QOshg4B3/jkxvuLV9no2rb1uvRJQraCFfp6So5X0E=;
        b=S/jkF7v0GbCn6RLVuE/7WjPJLirr51CYwPHqb3ND+yMGndKzcmW0CJvHHd8WLjqNxn
         cse7gBYYXPRm1kGUf/emz9eL127UgXG7UE0r+eM5Des6PcRtDVhWZ5z4imlS35IO51bY
         eJXu0awcHZMSv3YbwyxxHjfpRIZYgyQLemLHj/ol6uJoVJF8LFy54zT7DCjd0/f8lr7A
         WK99muoGi/4GLge5wqZRaiQ00aKOTz8Vn2gWs6q81GmztoRxQJr+x6Ks/qdb6RO52VOs
         eg1qD/BXypUjgykHpiF3DeLuaISjcO5i3ZJ2rriiBBdUNjcdp1Hzys/xUrakGDAlewr8
         T9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770398965; x=1771003765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=38QOshg4B3/jkxvuLV9no2rb1uvRJQraCFfp6So5X0E=;
        b=LOBNtlijsdkVEWz9iG3Bejr1+VHWm+3uVF5fG4+1/7fhYG3paSJ4UobdnoxR0IciCR
         2ZVga3nsVWI9hgczvrKsJx2d9ZLAeYt4fEcIOqvKoQrCNDLVeomdMacAnI6kbcR+DYl/
         c11fCGl6U9NP4ZNh+m3AjM8AqR6rkU3HgVrsClk+wJcdzKqp2JcYtN7GCsgu4yRTUjC2
         nKoUltAAVEp3+GhV/ZAqo97VvKhPTqawMLmqbM5HFLl9kgVGp6HPKiLw3b9nf5DdmbnI
         6Jj/E3Za9j7NQgMlACUTESgujqYMdQeABBObRp+Rxp695vX6O643mTm7R6b607b0mUq2
         33kw==
X-Gm-Message-State: AOJu0Yy8u2Jm7HtqS9MkhEmxVPQrcvwumuyi+ARewTVQuJReMOqR0zyM
	WFuotallAb6IXHuO4/N5jdGpxiOtyP/wjq0D2eJbQmyFMLvcjnAj4lxO
X-Gm-Gg: AZuq6aLSkekVTrU+J7lseDMD3Zbtv4KbyVN3iNypJNq0plJULSbBXDdmu31LI9fVIf6
	QKHCJhSB+wOCH7ZejOU9ce2ILY4FJ6gIMMoPpAYoz53v3OD4nky2+SzHfs6goiotFcOZGpqj91o
	INo3iUgyrWf1mAFK5exZ3X31ch/LqB+t/I/DoJM0QzpEXwO4Aglbh2rpekqRjuOHTUqL28wtoLt
	/62UsLWciMckBweHqsEzVXheOLECu7JMz7pAiP6jHS58xeeIUUhfchM7wQ60iIZ4q7oY9yzl7zC
	lHmU0irtfpWGIoT+roqcQfFk0W+ipOR9y0vKOCA3cwwEgTUbZmy7OFN7JNAJDjLgzrLLT307KBg
	l1iJOW04J1h6q5n/9fZSyjxzMwgMZ6GizkbPQh7F53Q5oObPPyc+/qcW4P+GIeh7Mwd2c6CR4vO
	rr
X-Received: by 2002:adf:e3ca:0:b0:436:307c:b756 with SMTP id ffacd0b85a97d-436307cb85dmr1101460f8f.47.1770398965306;
        Fri, 06 Feb 2026 09:29:25 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629734268sm6846033f8f.24.2026.02.06.09.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:29:24 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v2 11/11] mfd: motorola-cpcap: add support for Mot CPCAP composition
Date: Fri,  6 Feb 2026 19:28:45 +0200
Message-ID: <20260206172845.145407-12-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206172845.145407-1-clamor95@gmail.com>
References: <20260206172845.145407-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a MFD subdevice composition used in Tegra20 based Mot board
(Motorola Atrix 4G and Droid X2).

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/motorola-cpcap.c | 50 ++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
index bea11868e823..d64c83614f12 100644
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -206,6 +206,7 @@ static const struct spi_device_id cpcap_spi_ids[] = {
 	{ .name = "cpcap", },
 	{ .name = "6556002", },
 	{ .name = "mapphone-cpcap", },
+	{ .name = "mot-cpcap", },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, cpcap_spi_ids);
@@ -343,6 +344,54 @@ static const struct cpcap_chip_data cpcap_mapphone_data = {
 	.num_devices = ARRAY_SIZE(cpcap_mapphone_mfd_devices),
 };
 
+/*
+ * The Mot board features a USB-PHY and charger similar to the ones in
+ * Mapphone; however, because Mot is based on Tegra20, it is incompatible
+ * with the existing implementation, which is tightly interconnected with
+ * the OMAP USB PHY.
+ */
+static const struct mfd_cell cpcap_mot_mfd_devices[] = {
+	{
+		.name          = "cpcap_adc",
+		.of_compatible = "motorola,mot-cpcap-adc",
+	}, {
+		.name          = "cpcap_battery",
+		.of_compatible = "motorola,cpcap-battery",
+	}, {
+		.name          = "cpcap-regulator",
+		.of_compatible = "motorola,mot-cpcap-regulator",
+	}, {
+		.name          = "cpcap-rtc",
+		.of_compatible = "motorola,cpcap-rtc",
+	}, {
+		.name          = "cpcap-pwrbutton",
+		.of_compatible = "motorola,cpcap-pwrbutton",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 0,
+		.of_compatible = "motorola,cpcap-led-red",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 1,
+		.of_compatible = "motorola,cpcap-led-green",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 2,
+		.of_compatible = "motorola,cpcap-led-blue",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 3,
+		.of_compatible = "motorola,cpcap-led-adl",
+	}, {
+		.name          = "cpcap-codec",
+	},
+};
+
+static const struct cpcap_chip_data cpcap_mot_data = {
+	.mfd_devices = cpcap_mot_mfd_devices,
+	.num_devices = ARRAY_SIZE(cpcap_mot_mfd_devices),
+};
+
 static int cpcap_probe(struct spi_device *spi)
 {
 	struct cpcap_ddata *cpcap;
@@ -398,6 +447,7 @@ static const struct of_device_id cpcap_of_match[] = {
 	{ .compatible = "motorola,cpcap", .data = &cpcap_default_data },
 	{ .compatible = "st,6556002", .data = &cpcap_default_data },
 	{ .compatible = "motorola,mapphone-cpcap", .data = &cpcap_mapphone_data	},
+	{ .compatible = "motorola,mot-cpcap", .data = &cpcap_mot_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, cpcap_of_match);
-- 
2.51.0

