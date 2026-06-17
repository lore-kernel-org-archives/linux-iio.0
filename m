Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC46C33A6E9
	for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781717257; cv=none; b=nl8qcw+liMXSaXUJbi3jWdb8jvdsXXtSSzzeUhFDAV1Kf+UzMuV6ncRj3TloX2Xxy6cEFaaUCfq2k0QkksAV/L8Wmv5mLtwJo8zRcw7D/PcL5OxQkH+5BlUtOvzO2dCHhE3U6WcW6hibxcOdUNAJHT4su/t5oDaas7jqpAo/lzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781717257; c=relaxed/simple;
	bh=3MWfK95AihyVSP9k+3Pe2t8/pnxNKk5+M5FvZFdy8xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EM3i1mm2DYvvpzMPjoA/IAGeGffa+2TH3yUtghePohTZPgbeuT16ovAC5cMkoV3zYGU1OUL73LvJoDlMU8GSPc++Lqs2i85xo3ZqzKOAEo4v7dhjIcWPK2vILLek2hz7DtZJ1fVSZD4elXCv/KqFwovJRuqCeyI9Eh8iGWAiDuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pudiHTuP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pudiHTuP"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so39208785e9.0
        for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 10:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781717253; x=1782322053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tKIF1mZS4jjCEHELSu1FnSPTd6Qoe+ZevMWCZrdQ/w=;
        b=pudiHTuP7RKSIPweKQpJsV2R+a1xe62dJO9vsU3QHpgct5vuG8yVTRlgQx6oONvFU5
         X84OdQDwzCAXidDi6BUzBsbRNzfG+5a8i3PHMnCtKGH7t0+Qyr+ri/Tt6pl/3nMikE9S
         Id3+OhweCGBFCfvOnx7c2XW8jWJOHLSgWMrF4+LOI/10/yOtJsDCm3r0uuyb+i7DKKy1
         vPJTE9RJH74y85uh+RYOOsVxxWXh60Xw2WUGtozzk2BJAjhUlk/JS5Am4l4QyUozFNEj
         6BM2VZoqtXUt52CKsX/zGiShtWb1o1BNuqgmx7laHqWaaZLx+ABuPIzL9Uu6fXs0EXA6
         s73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781717253; x=1782322053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2tKIF1mZS4jjCEHELSu1FnSPTd6Qoe+ZevMWCZrdQ/w=;
        b=MBV8bp5OjTCfTX9Ay4oxloTjzHHAXmhNGFXX+rUvbMamHlCxEJ2JrjM9y3CFTVzPVr
         6fVqE+R5CbcYRWQqyht/ONpWSsTqIYbH8lMQdLCxxdcBV+ZRs6w7CX+kI8ZAmZ4xsGcE
         SebMMIkusKVysckSC0WXkxuohn1sE904vfDXSeG6igk12V/Dwji5Y9N8ujMHPyzMsNtN
         IYWM3VUh86e4HgwtvGKvy7jCgxzUbUyp7Awj7I55Gwd0fACB7df1oKOiVPjhyNDjv58l
         16riutTVx8MjtzA0QX7iOHekSRjE/GnUcCcv3TH7FWKTxqggUz7APgbJDvwBo/qXa3os
         bTFQ==
X-Gm-Message-State: AOJu0Yy7nR9zG40uO9PV5scOhtr9FIfahDT6H+WvNNKaqZjdSeNBm5++
	WI62Uuic7r80S1ijRPO/1eMV1GVYuafodQmLtLngNbMKsuz5cwVpM1kD
X-Gm-Gg: Acq92OGP/iH6mo5wZMoeQWx+X4ume1SW6gHMM+tklCbekipZoFKEG6jV84THGrzsD/3
	xH0ZWIrSqSCA2vcd+4UYX3kpy6hufklQbtcOn6Rq2Ge7wj3aD7CjtsZa0vGedtQdm8+JIUHKm/V
	Jty/kv6CBoPUu92CFXMM+mxRB4h0Gna2uzZc/tOvmrPfUazwId/qq8HkInhGGJTBed8sMEHiAVx
	YW8hilKMEAQ2O2Ez+gRNrW1FBuJ87P5Z2co62TnPRT0aB+aodVB8trOldJbFyJGtKiMWLJQ+PEy
	KIAbgfPaR90up4kRGgUs5+9v3SED5R/INjegGvtMUQCT5pxZM8AOMqnfjxVYL3YRXcyx/xyrjzb
	sb0JjekTph4vjOjpUfI3b0mZfVItEC2xCt/8cQa5Ch4vbtcQ/9eRzwjPHC+xjd2KHPwJBerBrFI
	55fNWcLtj26G1q61BoPxvUl4dkZ4GiGoGQhI3+RLEPvmCyJ1+AvWdk6wCu/U0WhsygUSk=
X-Received: by 2002:a05:600c:a48:b0:492:10e8:3f92 with SMTP id 5b1f17b1804b1-49238219655mr6445175e9.17.1781717253117;
        Wed, 17 Jun 2026 10:27:33 -0700 (PDT)
Received: from arch.lan ([91.230.98.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa3a4easm197273175e9.3.2026.06.17.10.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 10:27:32 -0700 (PDT)
From: Tomasz Duszynski <tduszyns@gmail.com>
To: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	m32285159@gmail.com,
	nuno.sa@analog.com,
	tduszyns@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] iio: chemical: sps30: update email
Date: Wed, 17 Jun 2026 19:27:15 +0200
Message-ID: <20260617172715.115019-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617172138.114572-1-tduszyns@gmail.com>
References: <20260617172138.114572-1-tduszyns@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The old email has been inactive for a while. Replace all occurrences
with the current address.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 .mailmap                            | 1 +
 drivers/iio/chemical/sps30_i2c.c    | 4 ++--
 drivers/iio/chemical/sps30_serial.c | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index a009f73d7ea5..10a2e4f8fba7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -861,6 +861,7 @@ Tobias Klauser <tklauser@distanz.ch> <klto@zhaw.ch>
 Tobias Klauser <tklauser@distanz.ch> <tklauser@nuerscht.ch>
 Tobias Klauser <tklauser@distanz.ch> <tklauser@xenon.tklauser.home>
 Todor Tomov <todor.too@gmail.com> <todor.tomov@linaro.org>
+Tomasz Duszynski <tduszyns@gmail.com> <tomasz.duszynski@octakon.com>
 Tomasz Jeznach <tomasz.jeznach@linux.dev> <tjeznach@rivosinc.com>
 Tony Luck <tony.luck@intel.com>
 Trilok Soni <quic_tsoni@quicinc.com> <tsoni@codeaurora.org>
diff --git a/drivers/iio/chemical/sps30_i2c.c b/drivers/iio/chemical/sps30_i2c.c
index 61781aaabd85..bd4a2e6eff5f 100644
--- a/drivers/iio/chemical/sps30_i2c.c
+++ b/drivers/iio/chemical/sps30_i2c.c
@@ -2,7 +2,7 @@
 /*
  * Sensirion SPS30 particulate matter sensor i2c driver
  *
- * Copyright (c) 2020 Tomasz Duszynski <tomasz.duszynski@octakon.com>
+ * Copyright (c) 2020 Tomasz Duszynski <tduszyns@gmail.com>
  *
  * I2C slave address: 0x69
  */
@@ -253,7 +253,7 @@ static struct i2c_driver sps30_i2c_driver = {
 };
 module_i2c_driver(sps30_i2c_driver);
 
-MODULE_AUTHOR("Tomasz Duszynski <tomasz.duszynski@octakon.com>");
+MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
 MODULE_DESCRIPTION("Sensirion SPS30 particulate matter sensor i2c driver");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS("IIO_SPS30");
diff --git a/drivers/iio/chemical/sps30_serial.c b/drivers/iio/chemical/sps30_serial.c
index a5e6bc08d5fd..c8bad4de0c26 100644
--- a/drivers/iio/chemical/sps30_serial.c
+++ b/drivers/iio/chemical/sps30_serial.c
@@ -2,7 +2,7 @@
 /*
  * Sensirion SPS30 particulate matter sensor serial driver
  *
- * Copyright (c) 2021 Tomasz Duszynski <tomasz.duszynski@octakon.com>
+ * Copyright (c) 2021 Tomasz Duszynski <tduszyns@gmail.com>
  */
 #include <linux/completion.h>
 #include <linux/device.h>
@@ -426,7 +426,7 @@ static struct serdev_device_driver sps30_serial_driver = {
 };
 module_serdev_device_driver(sps30_serial_driver);
 
-MODULE_AUTHOR("Tomasz Duszynski <tomasz.duszynski@octakon.com>");
+MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
 MODULE_DESCRIPTION("Sensirion SPS30 particulate matter sensor serial driver");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS("IIO_SPS30");
-- 
2.54.0

