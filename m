Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694F949AA4A
	for <linux-iio@vger.kernel.org>; Mon,  5 Oct 2026 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208979; cv=none; b=cIiShtxlZ4zVb2uON1QRLxRhFWUh4I2Bb55b3E5JEMNxmiMW7dlkw3lOLZ0AOLMuQRtpNvHif6CavZpNu5IHJwnP7/aBI6zxe1XKwbNVcOIEM2VE7b7A6QOHHZlxuI7qyAMB5nONe+Pm9O/BwtL52nkyPL/k0U/Pfyrh3wloOKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208979; c=relaxed/simple;
	bh=KCBezTNPNwn+wv/MGPf477eb50EQguIvOs8Yudzaz8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sh3aPhRDDIZ+blRxN2b94T7ullJdpbvQ33VrIjdNaC79XPe4GbxuV3IJfM3dq5fwvkEpncpzOLraGnMGHwcZo09lswVpEm5kpCxM512wnsVG6QyJS5P2EwEdcs4vn3zoU9LxBQRcr11atbvmnoR4/lCehPDJiJniSTZ2w4hF3zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=tZYS2Hgu; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="tZYS2Hgu"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a1706a2b24so8337025e9.1
        for <linux-iio@vger.kernel.org>; Mon, 05 Oct 2026 07:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1791208975; x=1791813775; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OQhdUrcKElInA0tjUPY+bSsyeNTTBVQW8jgHs5CR+oA=;
        b=tZYS2HguY//jO2B4vwT69ykhjMth4h27apz92QZTLb5XU6ziGJLfoe5NYyF/HN5ve1
         ti413EaHDeGVeSbxHWBF37GQcHq56W1nQr11INv7F2WuMGo5Gac7MKp6u+fHgQSdktc2
         kmdPljhO2+e8g7oOlpOrQDjDAhsIxmtuH4wOO8yqm+zoi9wuFmLMSTvb4rnY2SH4N1Xp
         2sdeI3hhJ2axJP49SmY/DR3hHADLqGbDNLToL7UtFilcLd88br9JVNbAE5CCcB9VOg+a
         MwG+8s8kt02Qviz2JiPSVGMMcocRHaY6FDfyWGR9099rRL6aerl37lni5P/KCSV6SwbY
         VcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791208975; x=1791813775;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OQhdUrcKElInA0tjUPY+bSsyeNTTBVQW8jgHs5CR+oA=;
        b=b2sOO0tnAr8JSTmhWY4QhPwi5TWwaCwa/Sfmpko120LMiFPQK/Gx18bEGr02iBbfFH
         iDt7Za4i+oNsuQ+PMBlLbphgiPDMbld1pwxLMQwutMsLxpIQFifH4H6nHVf5klQAzny7
         NoOaqhqkq+SRRy3g9iniUELjOwW0kNOeqnIquGtZCXOlTfcDzihnvuoqu31J/Hj0BfV3
         C3EA87ixe826GCi3Gi0tPfEP/58dCTkls40w+JPHfo3pI0I8cWU2pkHmMPorU6FKsqG5
         aOvKnFHV8sC26SyaT+5kcl3Fh5bNoczNoKldYkviS0ecWgn4lKsEzBhbxKOYu0cl+hgT
         PAVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzCFZWkCmpeuNZ4Ydn/AeKNnJXjsI/HLJR+a6R7t0Zm1dWgTTaGWQpUozBHysTdES6BCbp6JW0sogY=@vger.kernel.org
X-Gm-Message-State: AFuF++nhRZHHVwwq21wUaCu72nDljHZ5u7A8mirOHBEM/oCsRVj56hHc
	YbR6EB8uKRe2HdWhsas49LkwnNjQkZWlHmJnScXLbjoSHG6RFKXZXaAWHXwyZXySMiw=
X-Gm-Gg: AYBFou0m8vpWUqipvKmlTKGIRq0vPjSLYJl7NCe5/fvviej9rJcp6DIuHJ1QMr/IX4d
	0zvAztvqnesH9l83SQrpE6pb/cczpHBG++LWk5ZZDElb4ZOPE19FaMaiB8YjTMax+9psqZYP5GJ
	y4DKohaDQg6Qv6Aj0FvTXjwCaYvKqfJJ+raKhBJtb/QV/FwCjjvCFHztNsG9EI06swKXmUEJgSt
	GYZHfMCpRXu6IiluPZ6drDiCId1R6JMy2+k65tWConPuGjSNgIlIP1eqmZPJJaHeUrvCseEy7EW
	dxs4T7pClYsxRStAlY2nTYVbLtJSwRjbuk6PsQ9LFFpm/nKFjmyI9DxsbjpUWTYFUAMIhZCyAhG
	aHwc+KhwzPVvFiWyo/Dzw79jmdnNm+MN5PIs0hV85gp3n5RqaF/uBY4HE6yLvW9kbHsYlKPtL/V
	9GTDQwz/OQXd2ciMcNZ6YcuHCShimpEtzyFSwhMaZaprFr8IfjpZStfsM55spt8u7RkbpyjhiBj
	6t8dHpVBmMY+3A=
X-Received: by 2002:a05:600c:3501:b0:4a0:1723:2d8e with SMTP id 5b1f17b1804b1-4a0274f3bcdmr189786705e9.2.1791208975486;
        Mon, 05 Oct 2026 07:02:55 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:9c1b:24c4:d43:125f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a162e867e8sm324052715e9.15.2026.10.05.07.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:02:55 -0700 (PDT)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 05 Oct 2026 15:02:06 +0100
Subject: [PATCH 10/12] iio: pressure: use named initializers for
 acpi_device_id
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-acpi-iio-v1-10-2796f713945a@thegoodpenguin.co.uk>
References: <20261005-acpi-iio-v1-0-2796f713945a@thegoodpenguin.co.uk>
In-Reply-To: <20261005-acpi-iio-v1-0-2796f713945a@thegoodpenguin.co.uk>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Petre Rodan <petre.rodan@subdimension.ro>, 
 Matteo Martelli <matteomartelli3@gmail.com>, 
 Marius Cristea <marius.cristea@microchip.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Alex Lanzano <lanzano.alex@gmail.com>, 
 Jagath Jog J <jagathjog1996@gmail.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Kevin Tsai <ktsai@capellamicro.com>, Eddie James <eajames@linux.ibm.com>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791208959; l=2013;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=KCBezTNPNwn+wv/MGPf477eb50EQguIvOs8Yudzaz8I=;
 b=95IISmzRnRNivfQPCqrEnnhrUqgPCXYTfSEHVVkCjGOVng6THNLRcuI7VLELVkGjB2BkTxXMh
 JFJQk5tJUFfAmq26lFZ2AxdE65VZywFiswn/5SDjRXM52hWudtgL/+z
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Use a designated initializer for the acpi_device_id fields which makes the
code more readable and consistent with how lists are initialized in the
rest of the kernel code base. Also drop explicitly setting fields to 0
where it is redundant.

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
 drivers/iio/pressure/dps310.c          | 2 +-
 drivers/iio/pressure/hp206c.c          | 2 +-
 drivers/iio/pressure/st_pressure_i2c.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 45bdb8c7670f..5b5d6bfde91b 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -892,7 +892,7 @@ static const struct i2c_device_id dps310_id[] = {
 MODULE_DEVICE_TABLE(i2c, dps310_id);
 
 static const struct acpi_device_id dps310_acpi_match[] = {
-	{ "IFX3100" },
+	{ .id = "IFX3100" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, dps310_acpi_match);
diff --git a/drivers/iio/pressure/hp206c.c b/drivers/iio/pressure/hp206c.c
index ee34c8908b74..29797dd9af85 100644
--- a/drivers/iio/pressure/hp206c.c
+++ b/drivers/iio/pressure/hp206c.c
@@ -400,7 +400,7 @@ static const struct i2c_device_id hp206c_id[] = {
 MODULE_DEVICE_TABLE(i2c, hp206c_id);
 
 static const struct acpi_device_id hp206c_acpi_match[] = {
-	{"HOP206C", 0},
+	{ .id = "HOP206C" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, hp206c_acpi_match);
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index 2b7c84b7e6b4..2d630cde19ac 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -54,7 +54,7 @@ static const struct of_device_id st_press_of_match[] = {
 MODULE_DEVICE_TABLE(of, st_press_of_match);
 
 static const struct acpi_device_id st_press_acpi_match[] = {
-	{"SNO9210", LPS22HB},
+	{ .id = "SNO9210", .driver_data = LPS22HB },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, st_press_acpi_match);

-- 
2.53.0

