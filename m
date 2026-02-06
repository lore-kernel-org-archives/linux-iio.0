Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FDC423A63
	for <linux-iio@vger.kernel.org>; Fri,  6 Feb 2026 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398957; cv=none; b=DVNzY8Tscxi7PnRDpqtts5ACqFQ97bccLLMzCcPndeoZpzWE0tRYaCZLT4FqtJVrQ0PFTisL8ky7EsH6LiHW3SpRVCXYJVaZKBxIsnLj77ITSDTC0FmA9wI/D87v42qivDem36FxvDqIDG92w8zr3rg3pF8pKzUFGJ/E73yUgSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398957; c=relaxed/simple;
	bh=zDdA6Z/8E3qzcgVxUJG9XgVMg2hV9AEwM6u4bLx3TbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/3M7fKFIqsOTDfqO84+7ajEcP+YZth7EXEtYJaM5ueJ9YcqYio3UAVVBT/5WpnA79G2zg0TOY836b82nlgqpymE0qFmDhOQr4ajF8zvLdGYZXQf3pi0krthUQIGYAr00xzhXzvV/uU4IROg24s9i+DWRC6WGTIZTd2DcPJuw3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdN5I5wj; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdN5I5wj"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4362507f396so1720306f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Feb 2026 09:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770398956; x=1771003756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NXIB170Miy5U8AUdI7je1qnmIqOJUqz+7CF8NtEdwM=;
        b=fdN5I5wjE2WPpeZmJrs2RKKds7Z8CciRyzg9TQKKINNc3TbY51b3CHbwd5CRsO8Fdl
         D/bRgw6zij3btttKrnf4ku31E5FKVm0Olu1OOtQFA6NnD+I0IXleCXTQQ1L3ACuAN/mX
         uVCvxs64sBHXq7EGyt2RgD05BkCNHJp+DqZPfXsdJDqkC4B9swNLgRrV04XKxqcbvVNA
         6ukFI3yJRxYkS5U/jAvINak46f1XVQZ/COOqhUv3JaDCSpAk0W6PQBSvx7zpbvQGtWMU
         iKhcKY7LUEi8QWvbr/lq+Pwh0OgnmrwSfpI9cKAgz3rBKqA3BHWaGupA3jzdXhiT6l4/
         RDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770398956; x=1771003756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3NXIB170Miy5U8AUdI7je1qnmIqOJUqz+7CF8NtEdwM=;
        b=Y1xzvFXHd1MgnUmH0mkUkwGJpMFbPRLQAMLyZgjcSvEWF2AqNc19/qSuLODwqMk/1r
         YHr6+0o+cKSWR3wNrJxCbTmUt+wf/i2VUj4K/PdcManpJXQUdGHL9APDYnOoeoaYJqGb
         /Evz8kcl78Y3WraQoHUawroMolAE16o81XkFPEmmzhdTD1rgIHwg9CcUfeTzfZbwvHwK
         WBAZuIgPM7F505VCY4xw2cWrzhCyfM4GI5sBBM7jV7JT8XXsQfiJUOyu3WJLLMoT+XZp
         WYDOplRVbkggsAPF8W0gi1Lt/obaEPRxez3r7MFAve3g0t8wnv0ebnQ81tlVampZAbGR
         Mysg==
X-Gm-Message-State: AOJu0YydkP0TDApMu4c48PDFz1rTXRpBZ4c4vbXC1lrUqMvMoFSpfSBM
	4RXr+D+wHJuHG9aQ8kV73anpP5QeRtbSuUIP83qhmqbm3Rnpq6v+UHWA
X-Gm-Gg: AZuq6aLbCwCoDC2pnxW+rUg/8TkiY4ax4c5fLsz9Gdw6FcK2hK9V+SuVX88OHJ+uh6M
	IRI75OKFOVjLWWYTOcZMFk/KQ+9R6Y4k3bGGGksFRMQ+aFdmW7C8iNdcy31A8W3Nyezz8WHz2yI
	smZhQ8M7LJOh1vrm24FohTaF0xGM6OORdEpK2N8RYORU9qllzEwQmAvzRZHPk5wjwnH74+sAyIr
	mIXt4iexA9BSifeaHLW8DDkLI0f5rVMqJl5Ova2/LEiS5YP2gbA/wz9XC+rc/p3NiiNLNYJfXDh
	/xe9L3u8pHuU8QIawIE80PLsrC+Exs0qC1FgxLZY770DIkrCtwz70PhrSnAfnaIYFqsr79I+LiF
	PI2H3jgHEE0O86FmqD3dAMZiz3ljpFjfo0KLPpzx7pBEqjz8aNAJSl6OSJlvA67YpCjf99ldmtM
	kX
X-Received: by 2002:a05:6000:603:b0:435:dbe3:c6b1 with SMTP id ffacd0b85a97d-436293413e2mr5847642f8f.25.1770398955843;
        Fri, 06 Feb 2026 09:29:15 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629734268sm6846033f8f.24.2026.02.06.09.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:29:15 -0800 (PST)
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
Subject: [PATCH v2 05/11] iio: adc: cpcap-adc: add support for Mot ADC
Date: Fri,  6 Feb 2026 19:28:39 +0200
Message-ID: <20260206172845.145407-6-clamor95@gmail.com>
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

Add support for ADC found in Motorola Mot board, used as a base for
Atrix 4G and Droid X2 smartphones.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/iio/adc/cpcap-adc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
index d9ee2ea116a7..f6f72efcc6ed 100644
--- a/drivers/iio/adc/cpcap-adc.c
+++ b/drivers/iio/adc/cpcap-adc.c
@@ -934,6 +934,17 @@ static const struct cpcap_adc_ato mapphone_adc = {
 	.atox_ps_factor_out = 0,
 };
 
+static const struct cpcap_adc_ato mot_adc = {
+	.ato_in = 0x0300,
+	.atox_in = 0,
+	.adc_ps_factor_in = 0x0200,
+	.atox_ps_factor_in = 0,
+	.ato_out = 0x0780,
+	.atox_out = 0,
+	.adc_ps_factor_out = 0x0600,
+	.atox_ps_factor_out = 0,
+};
+
 static const struct of_device_id cpcap_adc_id_table[] = {
 	{
 		.compatible = "motorola,cpcap-adc",
@@ -942,6 +953,10 @@ static const struct of_device_id cpcap_adc_id_table[] = {
 		.compatible = "motorola,mapphone-cpcap-adc",
 		.data = &mapphone_adc,
 	},
+	{
+		.compatible = "motorola,mot-cpcap-adc",
+		.data = &mot_adc,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, cpcap_adc_id_table);
-- 
2.51.0

