Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC9B437448
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386841; cv=none; b=Jn04bttuHGbzJ0IxbPP0Th2IwSBkUIh7qzJnq+IpyNgM8vXxQeO4D5N9koJJRelFJpYHigrMmB81xj0xEMxuUvtid2giXmvBMGnMSpbcIsNIwohxIPHzCRTTF6X954VEECq7TaiVEX0BZhw0199ezQruVXtTBgnraV8FOcvf+6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386841; c=relaxed/simple;
	bh=SqcgA4LJuoWFHZgSuIGEdqOlMctmYEWvqDTQVUq2iwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gtPBNk2rG3yGtbnxCPjJyUYS1QgHlGnolY1wklhRNHYGFzZUtvSSJh4QjjTs8gp57AuMSLoyY+g6xc2UHtqa7pDu62RWuC2k82QtnE6YoXXuFZFmVPQkS5Kr7ow4kMo+nuh/Xy4v99t1Y1hKTht8xEV3UIWuHj0RZBHa0UktgsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKGt0K8q; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKGt0K8q"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-caf45fc5202so1853977a12.1
        for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 11:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786386839; x=1786991639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MKUjBVCjl00/cCCAjLM5qqAoQDkenE2Pgtyp/CT8tOo=;
        b=eKGt0K8qslLTv2CxTswmX7IWBsEOGFP1w6JbPl5qyoe02nuDQzfkAubjUHco1quCWW
         azWRYACTtTzOtUxsNdOK3uMf/XdtG37P17+N7G3TOUbtv7c2XdFl/HX9tNtzoO0BCjFA
         0t9wNVtr0sLbuUBu/TjtI+crZ0+nrfTvx4IGB0ZRazaXoIaxvMHCF8Kk+YtKfRGiPxJO
         GcXCFYKwZR07wRUEq40Kp0SdER+13c4GEok8F63ahCggWlawJDRTWdzCpgN1E9fJfiRQ
         VAry4QuAZpRuv9chKj++RXpXeRU7TUPQPSb2sB2L8vg+7XHiCzBzrMmJN1TTdLxDAUR3
         JA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786386839; x=1786991639;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MKUjBVCjl00/cCCAjLM5qqAoQDkenE2Pgtyp/CT8tOo=;
        b=QRcwKXHh27J1A3tyYC2wP9LGw4VBH5GP6q4+rhae2TbKIKry402UFHu4n9mesY8WKQ
         tLlCDfEaadruRsPerhHmj6MvtTx5/Ic/SaaUN63uGYIVKLPL8MICdWVAb2PADf4OG+Ta
         +deaMVLCpQXQxYbARa1cfQ4fdo4e5F/YpbcU8E+6IRddGZ9VQLFMqRO2Dq927A6ljHAl
         xHSoRAADWuxAHlSXi1FohVLR4bItQ1aSC6FAC0jcLIKhAaIimJV0j0JvU9mZ2ln6fI/e
         XmDLN1/5j685QM/rdhL/ioxW2A9u97U5hMXhw8mj/b9iYmwr3xzr5gz33bbHbh1yn57S
         cwPQ==
X-Forwarded-Encrypted: i=1; AHgh+RpCDqX5SssdQlMUDlVsmwV+YsntLiPyhB7jZhZPBXf6IaRuExmCoGFK//o47owANCQtCgQZ493HliE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA0OijpDMCTXNw8CWImN+Uk/ef0Qtz4Zf2HRI91lkLx1gX1+if
	18BNWgXycXAqtYfz1gbSS0k55/KiGgcW69a2Fmem6FJ6YaCsw3vhGgrW1vnA4qY=
X-Gm-Gg: AR+sD10yajw4Y7V785dUQ3t4+4gLtnRtMlu/uuzbhZksOpRtYTASqBsvbWaVfjWxT2k
	URjV5rQPYJO6mkEgk0gK+dQpWzCj2Iv7+q5sOx2lutV3zZEy3vBBW/Dt31t0cGjMvZ55qBRlDUm
	mUKCxs9wFX2v2tCYUFPA2i4Xrf3eFaWSFFVvNEMYU2Uf5hxRWnGGHmA9OuewSfmNEG4y7d+cy2i
	nSUbGoBFIPmx3zExEv7F5noaH+jb3kT5nsX8XvuNbEymprzYxL/IQ4dCEKogF0at1JN2I1yaA6R
	4MT231ZS7OSWB0zu76kJ5mKYG0mxS4WjLmnrPhMYXIyQVSkMddgwa61tzazK1drsvTkCVGJETQ+
	4bZJHZytA7id0y3MCjxjTS+12sPbIOCfUIeOSl5CrOPwz574knWcYQEYG/sy9O55Hwvqct+ysX9
	lSyOfLkqEY+d+fXHXW9wKmL2deYAt2DoMa5PybmYu6t1cRe9LpfMxXcy8KSWt9Jlu9VuJ5R9bm3
	+bycP1n7XsadjEOrkJXO5swQvtCv6ficT9lgCVt
X-Received: by 2002:a05:6a21:3392:b0:3c3:9595:57ef with SMTP id adf61e73a8af0-3cb85ffd1cemr50581343637.31.1786386839340;
        Mon, 10 Aug 2026 11:33:59 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be8a9220sm48209020eec.7.2026.08.10.11.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 11:33:58 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	David Lechner <dlechner@baylibre.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2] iio: humidity: am2315: add am2320 to i2c_device_id table
Date: Mon, 10 Aug 2026 15:32:31 -0300
Message-ID: <20260810183337.451812-1-nico.antinori.7@gmail.com>
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
v2:
- Adapted KConfig text using the suggestions from v1 by Nuno Sá and Andy
  Shevchenko

v1: https://lore.kernel.org/all/20260805183733.1000550-1-nico.antinori.7@gmail.com/T/#u

 drivers/iio/humidity/Kconfig  | 8 +++++---
 drivers/iio/humidity/am2315.c | 3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
index 54f11f000b6f..10598a0b15bc 100644
--- a/drivers/iio/humidity/Kconfig
+++ b/drivers/iio/humidity/Kconfig
@@ -5,13 +5,15 @@
 menu "Humidity sensors"

 config AM2315
-	tristate "Aosong AM2315 relative humidity and temperature sensor"
+	tristate "Aosong AM2315 and similar relative humidity and temperature sensor"
 	depends on I2C
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-	  If you say yes here you get support for the Aosong AM2315
-	  relative humidity and ambient temperature sensor.
+	  If you say yes here you get support for the Aosong relative
+	  humidity and ambient temperature sensors:
+	  - AM2315
+	  - AM2320

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
+ * Aosong AM2315 and similar relative humidity and temperature
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

