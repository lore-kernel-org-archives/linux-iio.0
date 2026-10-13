Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5544EC675
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791890515; cv=none; b=GHS8ycVilus9lPJ8l4r06xPJafOv+fr4RaXwfRhuSUJK2p1Uojs+4iqVhsTVZMttfamfEVcommwWeEkY00uWfAdCHhw3q3SCJ0yIbI+FoYw5tmiR6BSWKZp6wroyv7OVuNSkI+LNFu/K4ro7WLBbjshW/OboBMgwuBjLAsMvgJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791890515; c=relaxed/simple;
	bh=zMbMI1iPl24pAs5T/eaw5EOzPDqLoofRmlKw9qDv1E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGODyIuR1B20iTiSEyLv8mJP+ohV3sx2M+7XHHTS94fE9YgCrgpEwvMUKuR5/Nnv7IlDNowM4ef/t4t5M8frLaElflWt5wE47wWlxsHyxRAY9+/HSSEC4UoNd7J1va8YPE5vyoqG2i4RTIwo+vMMvtwJDDHmgo3UPk9x8LsSSSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qnJuT15U; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnJuT15U"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5bccecba199so2023689e87.1
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 04:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791890510; x=1792495310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ZBikVK3qvt9tK1Q7n4ziWN1MiTDEPE8C1CFx11XlAQ=;
        b=qnJuT15UdlpKjiaPx3d5nfCrLJJE/t9RIbrsu/c/kWW2qqNcqM0I6WBM8PRbmqjnKG
         ZLfepO2z+tLY7xb4QM1CP47TvJyeiGGej3oG51Eu1U+MsW2w+wOaVQPGqS/LBb75A1PF
         0SiDgoUa1VBx/s2wFvzbAFxt6dBvLDx0XVkqVyfsdfMAT0WLmYjLYsULvSx20FxVQu2i
         AI61lyyObXaITlRCrkid0to6x7ZtQR2oYfM6MeFNqp2mc4k4dkRUs07ulurT9l/IvW5+
         pq03fKpw05m7/hhH/u4wK6zxdxxFq6Y1HmXWIJx8kejk5LE81GvnIk5PsPGlc0oVMnMS
         Iv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791890510; x=1792495310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9ZBikVK3qvt9tK1Q7n4ziWN1MiTDEPE8C1CFx11XlAQ=;
        b=1jb83qbYlC/OgNwaHqf2NW71Nal+lKVkDsuH38V4bLeYUDaSFz5J0/yMaLz99SWxaf
         sLi34UH0fly/OZ7468hhy5/BIi1+ZOLs5rkMgAj9Lk2CylWN1eFw9Doq/T2yfq7HyKyF
         CKiVrDu1tiLj2SuAyVWuxWtCVeG7kPPQGxwf7LqPXLXqDGUWtJfCP/X4Mxpt87QETUOk
         rRTkyUFiC4R/7DQOQ/PcorRXBe7a+BumBdb+kqR0J6bCdRLrnyCaseZrRM1lnLdPfhKe
         IkkhRVdL0U+pBUHVQf2+FhoW5zu2eyhxx02SCw/Y33g8T+GxmsjZTJPWk61XZ4/mvzq4
         eyig==
X-Forwarded-Encrypted: i=1; AKwUvByS/S+lmsZgHuKPDiFpQ+v/MU1EVUPGBgSRiwdE5C2J4gb0CvZe3xtf4ZDG/QLviTIZstp/zcIlWiI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKt8/7S1kTiexadmrKjanJxGw9gzeKtZnEvx5o1aViZ+dXsk9Np
	9G8B8ZsGgDdqOFwGczbTy9AikLhv3HvGEzuK84xNW4RMIV8Y4nqcVDMF
X-Gm-Gg: AYBFou2f4EVEWpSYkacOX1TgURRWYMVZs+5dLm2JoODloDVevE9Myr114d9sNOnz8Nj
	9QLs6Wuqj7f89SMxChfT8KX0mYLYcyN48dlSnZQc53p6x2UMaIhUdasySIFxHb4TqsYvbvbb9Q9
	n9539SHyIFXPgWBc9fk1kijh5ZeUavq2fcBe72iJN8esAua0WmJfPqyotjAU+vs3KCrYF4oKUqY
	f3Ng3uhch8NVoCAIRnC3zuwAauP7XNVroprqvBWezl3u4YsTh9RbHRdc9XrjKC2d7VPMM5So/Nv
	/I2pJYQEjD/GwDvSJSvGD1KQFGRHkfx/83EpROJLP1gbbLknuPYSC28CTUd2Ih5RWox6vhwg+vE
	yGaKkYMZ6IUdAeVGlIX3xVBNFMHxbTtvkbqV6V5zMZrYUubl78VYLMkxijRjqLowyNTD5+STSBb
	prKI2VyffAFpRmU94WgoNSCzxnNZDVgPJg4B+BDSjeUv6M113WBRnGmgV/wy+B2RASgK5G1qE1d
	UEkjG00ns4ar253YoKqpKKCG4FHKeRm8tOPMgwWThBHwgsXYbNv0vNx7+2jLyac6TaaNZXuzMoa
	QWY/nZoJvQZ1msWy9/GFDvaPV+oxmResh5ITdQ==
X-Received: by 2002:a05:6512:108c:b0:5b6:1a7c:fd8c with SMTP id 2adb3069b0e04-5bcde8cf921mr4238371e87.50.1791890509803;
        Tue, 13 Oct 2026 04:21:49 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcf8a3970asm1116148e87.79.2026.10.13.04.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 04:21:49 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH v2 5/6] iio: pressure: dps310: add an OF match table
Date: Tue, 13 Oct 2026 14:21:23 +0300
Message-ID: <20261013112124.1878296-6-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013112124.1878296-1-paulius.zaleckas@gmail.com>
References: <20261013112124.1878296-1-paulius.zaleckas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devicetree nodes match the driver only through the I2C ID table fallback.
Add an OF match table, so the chip data comes from the compatible and the
module autoloads from the of: modalias the I2C core reports for
devicetree devices.

Assisted-by: LLM
Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---
 drivers/iio/pressure/dps310.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 0d558edff5ab..3b27a61b70a5 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -1045,6 +1045,12 @@ static const struct i2c_device_id dps310_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, dps310_id);
 
+static const struct of_device_id dps310_of_match[] = {
+	{ .compatible = "infineon,dps310", .data = &dps310_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, dps310_of_match);
+
 static const struct acpi_device_id dps310_acpi_match[] = {
 	{ "IFX3100", (kernel_ulong_t)&dps310_chip_info },
 	{ }
@@ -1054,6 +1060,7 @@ MODULE_DEVICE_TABLE(acpi, dps310_acpi_match);
 static struct i2c_driver dps310_driver = {
 	.driver = {
 		.name = DPS310_DEV_NAME,
+		.of_match_table = dps310_of_match,
 		.acpi_match_table = dps310_acpi_match,
 	},
 	.probe = dps310_probe,
-- 
2.55.0

