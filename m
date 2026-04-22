Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27DA3D16F6
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 11:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776856938; cv=none; b=UdctLVivHCpurF9Elf3GZkONt5RuaM4CsT0c5Zq4252IHP3XqRxpjVoOMic3+WoWSmeP0yNGKUxcqu3p8h/TNqnJXsylVt7WRKipK0CySg/CoEKyeKHKbaOUHoXkei8tJAQ/2Y5LlBFDvlBSYjKsY6UG4D85U8DXZ1WPFiHasP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776856938; c=relaxed/simple;
	bh=ELeduL2AOJ0a21jL4mB8Ddr8Zke1vXbWgcFBi/970lY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCq1NXY5O3YfMPNtj7Ers03p/MHegAS3RY1z0xEAsrgzDVl801rd8VW11hjSMZFPkBReXO2sk3Ws1JpZ9FAc/F9z3zlqOREgDWC7n8gqD4OllZ2Cq+L5xGvGo13NGUWbcLBndxebZo9jcOj1c3Af/EB/m925l+FTYNNyYeowdT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yeq3eDKx; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yeq3eDKx"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ba92146cc86so357532266b.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 04:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776856935; x=1777461735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6H6WelrBg+h3VHziDGIho/XkEcoBV7nOVLijFF+4rdI=;
        b=Yeq3eDKxjzb6MgTwKH5fYng6BNsIblm+4pDWwUmLyL/WNBe6gW88D1VpjWz/TyP6Bt
         1MZBK9iQ/KGgtNs2Rgs3ZADGWhZ2w6qvTtONz7m3W8DUGzwR2A1q6ifcQbNeQTIfL5xZ
         CSx7beRKLv/AF/Z4lxEfQdkrA41NHyXr2PeCR3TfuvgCyPZyB1oi0hBphW7U8yAm9PhM
         z5ByYFO62Gl2LmYKg81wLlxyMCZmaRDZn7fhGcKbXdP/C1hVNXWLR7K+S378l6/P0EoW
         8Z40DPYDpbwdvkveA/uRAhoEVsqP0oJsq6GFtTbm7CaOCeQIV9O+C5X77afJGE3pzrIt
         eAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776856935; x=1777461735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6H6WelrBg+h3VHziDGIho/XkEcoBV7nOVLijFF+4rdI=;
        b=nYRQ5mA/LzicIdHg6XW+Ai4/hmhn2k25Y/t5Vo0ZTODJImlfgmW8y8OC5PbWuHvCgs
         EEVB2Oh9Zp5qY2birVfBELExo2wC+fss/dSuJ7wcyt66Zvg4RLjPpIKGAQ3X4e4S1ghq
         zgZtHT7luKmj0yuyFM/6Q0Kbk5Aw8Ax3JoFPZe5shMGp75epJ0gAEKk6TtCN76whoTYV
         Q17BlN4RuvrsU/swPpm8pgY/GadlFShXkfgbpBfVHtHRU4X5tk7cHEMKScshwmGsskXK
         acqsPGvOkFePPu6IkDz5p2aKSbyJoEluOouO+nMYsRfepbqEG5OWJdH9KDbDLxg8YTbb
         4ZIA==
X-Forwarded-Encrypted: i=1; AFNElJ8idixQmCDrkWGu6mAyRHBIC3m0a37tVwCggfNVFjfQCwTXh78WlB+VUKY77eJVjJJpWVEr8be7oeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNGh7C4sa/3KLUSUuAoHxrRcSHPsdHu/P9WBjPZGSQeqt8IEUH
	w3zY7UgwlpBMkpmrh8IWlheqokAnWKFL1g8WAsRgRCgt/l0GgViZNlCW
X-Gm-Gg: AeBDiesjqk6wAzu/t/gjJMPoGpKICbXNRNpynuCidq4j7ouxMUkmeaIZLyzQicRPrpo
	JORej+OmG0mCScL+BFn1/lDNiAEhps4UwXkUOlWJTX1sP1UJujJeF4bJD244+iy1Y9pF7j8UbAL
	AE2Qp7jyidfuhPb9qv5oe3e/ZiD31h5jZA8VBm3uBf255eLOR8G93v5VmvJaql4I2T+B32rB1yf
	WEt99DKk1B0+M4ieASMa/lmQNI8WCLVH9i/pmEDMZfJUQf43QUEGnLL4YpuihX8BdDksQCw5PHd
	fJaEZea+u81qD4H7E6CK7hvWBtna8Vd9g09MQBM5Yv/pEuaRYGzi3o+SkwEpo7gLziN6odIzXQn
	gsyS0cusyX1z3sXlUjcLj8DwePbyrj0beZ/mD8wzL30SLOZyXgtR/PQIWROlSzdoI6aqEHOiq+7
	ce0+ZnFVe0QvLeBDZT3R3HbbaVXV7nxrqP3845iVJ0WaZ9lfa6uyfj1JEARwBqaY/AaAM6r54o8
	nruAJpZyywI1uzA7eJ1OPI4b8w75hDQNgU1UoBBHy5jA3G4xj2KwHvojtvgzmLfqIIjLLUtoaDk
	ZGds5gcJ877MrBS/UY45isy9kImdzUZ0PeGCC+iJNkBEPCr5F28bm0AoJZhA4jCPJzkUXx2ERLM
	DI6vJSiBkFzD8im8e14gcR4jLHAgzmXlxCssgyCC+7nOEotU8lhP717Nn3Xy8HeLSZgJK7UCcQT
	1jwc5TJNk=
X-Received: by 2002:a17:907:3f8d:b0:ba7:3d21:c137 with SMTP id a640c23a62f3a-ba73d31091dmr660607866b.17.1776856934999;
        Wed, 22 Apr 2026 04:22:14 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.od237066db22328bb-tp.internal (25.236.141.34.bc.googleusercontent.com. [34.141.236.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba6366452c6sm395156866b.11.2026.04.22.04.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 04:22:14 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] iio: magnetometer: ak8975: modernize polling loops with iopoll() macros
Date: Wed, 22 Apr 2026 11:22:07 +0000
Message-ID: <20260422112207.1313-7-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422112207.1313-1-joshua.crofts1@gmail.com>
References: <20260422112207.1313-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver currently uses while loops and msleep() for polling during
conversion waits.

Replace the custom polling loops with readx_poll_timeout() and
read_poll_timeout() macros from <linux/iopoll.h>. This reduces
boilerplate, standardizes timeout handling and improves overall code
readability, keeping the original timing and error behaviour. Add
<linux/time.h> for USEC_PER_MSEC macro instead of using magic numbers.

Assisted-by: Gemini:3.1-Pro
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 47 ++++++++++++++-----------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 723c2f64b8e..0724569e766 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -15,6 +15,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/iopoll.h>
 #include <linux/irqreturn.h>
 #include <linux/minmax.h>
 #include <linux/mod_devicetable.h>
@@ -23,6 +24,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
+#include <linux/time.h>
 #include <linux/types.h>
 #include <linux/wait.h>
 
@@ -652,18 +654,16 @@ static int ak8975_setup(struct i2c_client *client)
 static int wait_conversion_complete_gpio(struct ak8975_data *data)
 {
 	struct i2c_client *client = data->client;
-	u32 timeout_ms = AK8975_MAX_CONVERSION_TIMEOUT;
 	int ret;
+	int val;
 
 	/* Wait for the conversion to complete. */
-	while (timeout_ms) {
-		msleep(AK8975_CONVERSION_DONE_POLL_TIME);
-		if (gpiod_get_value(data->eoc_gpiod))
-			break;
-		timeout_ms -= AK8975_CONVERSION_DONE_POLL_TIME;
-	}
-	if (!timeout_ms)
-		return -ETIMEDOUT;
+	ret = readx_poll_timeout(gpiod_get_value, data->eoc_gpiod, val,
+				 val != 0,
+				 AK8975_CONVERSION_DONE_POLL_TIME * USEC_PER_MSEC,
+				 AK8975_MAX_CONVERSION_TIMEOUT * USEC_PER_MSEC);
+	if (ret)
+		return ret;
 
 	ret = i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST1]);
 	if (ret < 0)
@@ -675,28 +675,23 @@ static int wait_conversion_complete_gpio(struct ak8975_data *data)
 static int wait_conversion_complete_polled(struct ak8975_data *data)
 {
 	struct i2c_client *client = data->client;
-	u8 read_status;
-	u32 timeout_ms = AK8975_MAX_CONVERSION_TIMEOUT;
 	int ret;
+	int val;
 
 	/* Wait for the conversion to complete. */
-	while (timeout_ms) {
-		msleep(AK8975_CONVERSION_DONE_POLL_TIME);
-		ret = i2c_smbus_read_byte_data(client,
-					       data->def->ctrl_regs[ST1]);
-		if (ret < 0) {
-			dev_err(&client->dev, "Error in reading ST1\n");
-			return ret;
-		}
-		read_status = ret;
-		if (read_status)
-			break;
-		timeout_ms -= AK8975_CONVERSION_DONE_POLL_TIME;
+	ret = read_poll_timeout(i2c_smbus_read_byte_data, val, val != 0,
+				AK8975_CONVERSION_DONE_POLL_TIME * USEC_PER_MSEC,
+				AK8975_MAX_CONVERSION_TIMEOUT * USEC_PER_MSEC,
+				true,
+				client, data->def->ctrl_regs[ST1]);
+	if (ret)
+		return ret;
+	if (val < 0) {
+		dev_err(&client->dev, "Error in reading ST1\n");
+		return val;
 	}
-	if (!timeout_ms)
-		return -ETIMEDOUT;
 
-	return read_status;
+	return val;
 }
 
 /* Returns 0 if the end of conversion interrupt occurred or -ETIME otherwise */
-- 
2.47.3

