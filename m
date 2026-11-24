Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795503027;
	b=Wao4lrHI650iaJiVmjt35IkuTsBaO9gBcP6PBW+43p945+Muh1RUFvaGwPKQLdO+jMlZ
	 BjK9dIYh+/bcJgyLtqoplieNWws/10ONdv/IRKYEvyfaLxHcLs4qaHpmmsaFXh+DhiSnB
	 GroiEOmwRx46UVsku8R3TdUszxeCKZqkJVpO+BmYtzAi7RUu8S4Gfij1pdIf3wDrTCvvZ
	 3dLxX9eksa5+XC71PqztVaQK571yVosT2dZRX5sWvTymknqccrpI36vuHb4ufhi9d7pXE
	 0YWSvy3qrEJ66FIazPkc4jR6Pt2Cuaz9jzfrL3DOcHi9XAE4NGt1vYhbJTwCrdMlM/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795503027;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DVeHLifVT1xO67SonoAkU2+l387BllNSZWUCd22A29g=;
	b=rEmGIdtbK0Jw81gRSf+np1EdO8dl4J7nLxr58TmDMSgUdDmvlncka84SuxWBxyxxegan
	 jLQcsdysikSclhZdMi0THSb51wA/uY5E159lyqtP5C9WXRKT4S/OlBB9vVXWPdnKujCJw
	 uYYVCBjLgPhHk6oJOpccxhy2xPgid9f0824to51X9RR4ADLIJsppXrqp1F8Q2GBEJlX92
	 NH4YtJ1bttwTy/+xZiia9Wp3nn7cXEJWHAADJQyXoOhbFN7Wp55vfPPphAlxLAdj6WKne
	 2m4g6YTeoALW292azT+zjag75ZP5gw+8ohbPiL7UrVIHuAHHzA6jN0GoJC+ePYqi1UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lnr3a9D5;
	arc=none smtp.remote-ip=209.85.208.180
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E26606A6B4
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 06:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8E26606A6B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lnr3a9D5
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3ace304021eso40007871fa.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 22:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795503025; x=1796107825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DVeHLifVT1xO67SonoAkU2+l387BllNSZWUCd22A29g=;
        b=Lnr3a9D5CojzMvN8BjEuOrqdp/HPrzXZrBKO9VPlyVLg5TW+SIPbc0U9x2gLP1VOH1
         jwbWZeXSum6NRfAzFH06uGmTth0Z4i5BmgBwAEC+UPeAwKPYZKov76qV0S0ba8VXXExY
         9wURHdptR4o+qAVyqViHR6iy7Re8MdyTfOb8qe3+doAphAWaY/fqOPoMHGBPih5gwABA
         GdGMRG70XpQS3fwILAVHDHgGC0DXVoZTD6ToXE5oLfQMXcW9qN54bd4wh+08UG8eZeL9
         ejbWwahPpLT8ra0fm6hgKsB9edH+4UOIxFygscT4XQCvB1nVduUvvJBM8LNZ3pphJukg
         OTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795503025; x=1796107825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DVeHLifVT1xO67SonoAkU2+l387BllNSZWUCd22A29g=;
        b=VXauB4cIEK2M6FAKnk5q1IT+DMvVVGX0gPvWKjPjatK6w3wcDsBxMrNh82bCJ1yTyF
         Jv+as+icl6t6jv2FHyHjJwNPg/PZQljsZZu+6xS+VY9M0wX68+g4nLBQxAkQmLylhZul
         sOMc/ElKtvCPxUYjA649jSF1v1KtR/X55oTBW07CQk9ao0u8PVvO5SoeWD/CydYZYzNM
         u1g1bRsOOgfZnEyswLbbnNU0Gc7qwRfYn0gSp2J//93GkLb6StrE94sw0UWTWksNG6Up
         vxV5QiYSG9IKnLbwyPMjxzFou2ZSY7BpP4vkjjKwrioOHRI8EqQI7cp8ivPMJChUFG/a
         yaeA==
X-Forwarded-Encrypted: i=1; AL+hErGsFcrFXx0Jwa+7Av/Kca480OVKgbtrs+kV3J4M3TzKKb0YNCS0zbmZJrcT1iZG8d4Ny+AbAh4FXOk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cK54nrJOPskH11XALM8aT1KiueeK5l+4Xjmiu7EUYGkVySvDj
	6jPtdxOSHwFBbwcPxkqI0Kis37uAn1zdU8UP9W+QMmfZCwhcwGZiY+Vt
X-Gm-Gg: AZFdTZf+9JTYFW1CCdrG6wyJ+BSbz6t0gOGUt00J8RUCopuiSoQJes65wYBn0+Avg3l
	dc8Or1IL/73xPL+2PSyhkVrBjYC9AGeeu1L6fb99Pab83ZP3jb0OqkUygHiu4lgfCxBc8IYpF01
	Uic3Uc+XpIsY2VJfk9em5XD3Xy6FbERVdssJFDFIfaVn/Z+B7VKjIMEX9Ebmz84Jldbc4e2pSR5
	Ty/vSf1wkD58x3iwH5aVvmR2aKoDXEXzjp/8hYNb7U7X5XKueXpJV7BmU464y8m1fTC7UeFM7cT
	5BG15UXrdIRoL3219g07/t9+5S4SEmXbDRJnz8V68dbhsA6SyC7NauXdcd5vErBUfnV+C928b7d
	P3t2n0iJ0y41NwM2vIcDl2VkGfm7V0gc4Ea61war2/eD1vkhESe1LwUwXWCl0iyHvN/8QeG2wzd
	nTOnNQIvqyadbeFvJSbVewq2P2fOpkNgemTku4xlzstKvQdhmMff1NOvCU0DS0re3tUIMVXHr/i
	4EtyZr5Nl5vCkvw70d1yVirAtT8urqUgXKjczmoJPuW5nCbCrMT2Z6fl60aOmeNzfXxEeplR3di
	fuq0B4GcuVldvawmgf6BkuZmKiAIoaYszv4hy+OV9L3zBLFOkm8dYAo/vTZE7eSzE8gLrOoigFs
	KV+Nn+2u81NeiD/UyqC4VhVyf27fJboNXPIW6xIw=
X-Received: by 2002:a05:6512:33c9:b0:5c0:13f:9b6 with SMTP id 2adb3069b0e04-5c1bc81c372mr3862415e87.54.1795503024669;
        Mon, 23 Nov 2026 22:50:24 -0800 (PST)
Received: from yantra.. (nekmmqsyyquzw1lm5eb-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:3cd2:d52a:a1ef:5dd3])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd018b45sm3538556e87.41.2026.11.23.22.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 22:50:24 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lucas Stankus <lucas.p.stankus@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH 5/6] iio: adc: ina2xx-adc: use iio_debugfs_reg_access_regmap()
Date: Tue, 24 Nov 2026 08:50:15 +0200
Message-ID: <20261124065016.185124-6-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124065016.185124-1-zoone.rupert@gmail.com>
References: <20261124065016.185124-1-zoone.rupert@gmail.com>
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

The debugfs callback only reads or writes the regmap of the parent
device, which is what the core helper does.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/adc/ina2xx-adc.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index c412f5ed46a1..587e82c33454 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -895,17 +895,6 @@ static const struct iio_buffer_setup_ops ina2xx_setup_ops = {
 	.predisable = &ina2xx_buffer_disable,
 };
 
-static int ina2xx_debug_reg(struct iio_dev *indio_dev,
-			    unsigned reg, unsigned writeval, unsigned *readval)
-{
-	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
-
-	if (!readval)
-		return regmap_write(chip->regmap, reg, writeval);
-
-	return regmap_read(chip->regmap, reg, readval);
-}
-
 /* Possible integration times for vshunt and vbus */
 static IIO_CONST_ATTR_NAMED(ina219_integration_time_available,
 			    integration_time_available,
@@ -950,14 +939,14 @@ static const struct iio_info ina219_info = {
 	.read_raw = ina2xx_read_raw,
 	.read_avail = ina2xx_read_avail,
 	.write_raw = ina2xx_write_raw,
-	.debugfs_reg_access = ina2xx_debug_reg,
+	.debugfs_reg_access = iio_debugfs_reg_access_regmap,
 };
 
 static const struct iio_info ina226_info = {
 	.attrs = &ina226_attribute_group,
 	.read_raw = ina2xx_read_raw,
 	.write_raw = ina2xx_write_raw,
-	.debugfs_reg_access = ina2xx_debug_reg,
+	.debugfs_reg_access = iio_debugfs_reg_access_regmap,
 };
 
 /* Initialize the configuration and calibration registers. */
-- 
2.43.0

