Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435DC38DC50
	for <linux-iio@vger.kernel.org>; Wed,  5 Aug 2026 18:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785955106; cv=none; b=eBAUHH1ZAEKhWhcXmj6ECfXYJdgvbIuuIGgQS91RIaT+ofeaJvQCZxcxGLZ/PNL1gjSoTZvEftfacZi5EacZw5B8S5NCqPBzW1zbMCCeoCJE4EZtR9eQdcmkiqcjjjKKBJQuAcGovndmIw07vuterSIr7y608bvl+PK9Hzzkx28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785955106; c=relaxed/simple;
	bh=Kg2Kxv6fzc0scOsXjrgF6Ue/IrPuOnHYB2EMECrfbUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rkr9vFvF016YC82BiY1mm0JJXMBfgLF+V4y4KtihZrWdWV3ueOvtBDrbhqx4MRHf8bsbzZcXKXf7UmX4ZCb9C6nL5ZTonu9nq6xrgofp2+tfOyBE9TrqEJygpXhbe+EkBUVNOk3k9/fyr00xnVu7yFJvTbog8n/c5XxZrX2E+JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNiufuB+; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNiufuB+"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84867f07d63so1621881b3a.2
        for <linux-iio@vger.kernel.org>; Wed, 05 Aug 2026 11:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785955104; x=1786559904; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IcI3jVVavG4O7m6ymsDhUgAeGCONzrnZZCZc1GCzkcM=;
        b=iNiufuB+XpN0CXVVLRR9nblH5a/IwS8Mis9xTEkISDHzbmQB6k3pDxNgkR7oBN04X9
         6QKdsRy8Ogy1QoO9jRLfxGtfdoS1MXuWHTHEtWrt+Y1mZOCNmjpxpuxh4tt2gmbEiLFJ
         of8eTZuj/Eoba2uWfscLPcqcSoHvUjxB4uX7EI4j9Tfxygmw6F9YmUICM1vnO6ePXym+
         ECabvWoNP2BIZY7CUNqMcIL74H/OOslhF6/XlwQll9m4LtuG8kA27liBhDBEeluLqnJ8
         YtXg8DuhBipgXVkJl4aenrXriGlyg/70vY7DQXRd0BYuXTfuULtn9EC/GesxfS0y0cyR
         KVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785955104; x=1786559904;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IcI3jVVavG4O7m6ymsDhUgAeGCONzrnZZCZc1GCzkcM=;
        b=IXVJM9Xvgm4cBhuefpfPeuSa7TXm0c3LnrlcywV3t6PdKetDkxpJr3Ge4BJkzBVsbI
         ziWJarlAcMPBhALNyOSCoH2VXSioRGH885Zxt6VLjrDyrA92oyhGJxrQ9zLi8taSs/Ak
         Lm4l0pZiI3757W0gzhtwaTSIZAoQE/rp2+Jo8HK5JxSmWqL+yHqHsVOE/2uagaW9mzS5
         wICzFfx3LxsLN2h/7Ya62femfOrSt41wlD9Ezp3DgLIHIQak/aKzQNo3E+BWRuPLi/ZH
         bvzYi9iYpy1qvjucpn6HJvjsMucmwDQagHc3+IJHNTAzFQ7+PDhN1rBERAoKxqmAzdKq
         75Fw==
X-Forwarded-Encrypted: i=1; AHgh+RoMxUdIHQ++ODQokZdgz8av7Zs0LbEqqF3os+zGYwuRs3JokxIXPlyrSI2llHPYO3v+Vegq+SXRqdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEVTePAaSfKtJrVd7SyqCKcJShgFqGdD41i+lKoK6UD11EwjNq
	uzswMWuLKewZgPD3ddV03yWB3tAHQtjHBjBnjlPSlhN79FwPvO4tmM0=
X-Gm-Gg: AR+sD123kOUrElVBeCG3q/QY3TECy8cQoEazdt4HQlt+MX3uDeNfZz2QN80jxL//TUd
	dnD0X4AV25L6sJ8tQZiDFxUZ4AWr8nWgNAdPkKAHAyvn1nVw5S9/eUOSgfk2Ud0dWEqy1dKo+SG
	29PIqT95JVckR64ICXaJFHsu/xHy6T7I490EhQYgy1QCp8IU1Q248ZtpruC/LmWvCZgBT3DA0iQ
	ZQPEpI42Iq2utKoj1GDC8DE0Yzy+o/to5zASeiH46m42Ztu6XtNmuNYVkl5aL97RDlPYMUFvgDd
	J5Jtf4ttZb72ydmZ8WIQRfcVLTVyQp0B7EOsRmJgY0Cidw98KkuSubExN7UNfvkmFufD+w/B9Y6
	QKu4gyk0fQ/8rGczIcvO1EkNFWdjL4P+nbMgxIXlI5b0ddvmMGEzHbqNKE2CTicIwmCRfn2PWB5
	YvRc6rngq/TGdsPAZvqsL+ZvewcNVo6v9b42YtI8bg33wkqPEI3kS/0FHmlcf5Clu7uJVrxzVvV
	tb2uL32f3VQZPgFBWGLRyeM6mOtLrkKsaJtI28A/vQGNdaSMok=
X-Received: by 2002:a05:6a20:7f86:b0:3bf:9c93:ac44 with SMTP id adf61e73a8af0-3cb85ea363cmr7925125637.19.1785955104544;
        Wed, 05 Aug 2026 11:38:24 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158673b7b2sm19156631eec.19.2026.08.05.11.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 11:38:24 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	David Lechner <dlechner@baylibre.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] iio: humidity: am2315: add am2320 to i2c_device_id table
Date: Wed,  5 Aug 2026 15:37:26 -0300
Message-ID: <20260805183733.1000550-1-nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AM2320 is fully compatible with the AM2315 sensor in terms of I2C
communication protocol and measurement conversions.

Add the "am2320" entry to the i2c_device_id table.

Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
---
Tested with Raspberry Pi 3b+

Used as reference AM2315 Datasheet [1] and AM2320 datasheet [2]

[1] https://cdn-shop.adafruit.com/datasheets/AM2315.pdf
[2] https://cdn-shop.adafruit.com/product-files/3721/AM2320.pdf

 drivers/iio/humidity/Kconfig  | 4 ++--
 drivers/iio/humidity/am2315.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
index 54f11f000b6f..6907805945f3 100644
--- a/drivers/iio/humidity/Kconfig
+++ b/drivers/iio/humidity/Kconfig
@@ -5,13 +5,13 @@
 menu "Humidity sensors"

 config AM2315
-	tristate "Aosong AM2315 relative humidity and temperature sensor"
+	tristate "Aosong AM2315/AM2320 relative humidity and temperature sensor"
 	depends on I2C
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
 	  If you say yes here you get support for the Aosong AM2315
-	  relative humidity and ambient temperature sensor.
+	  and AM2320 relative humidity and ambient temperature sensors.

 	  This driver can also be built as a module. If so, the module will
 	  be called am2315.
diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
index f29baa251f9f..5bce5eec45cc 100644
--- a/drivers/iio/humidity/am2315.c
+++ b/drivers/iio/humidity/am2315.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Aosong AM2315 relative humidity and temperature
+ * Aosong AM2315/AM2320 relative humidity and temperature
  *
  * Copyright (c) 2016, Intel Corporation.
  *
@@ -251,6 +251,7 @@ static int am2315_probe(struct i2c_client *client)

 static const struct i2c_device_id am2315_i2c_id[] = {
 	{ .name = "am2315" },
+	{ .name = "am2320" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, am2315_i2c_id);
--
2.47.3

