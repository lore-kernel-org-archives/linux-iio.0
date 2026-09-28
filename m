Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D90034BA42
	for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605510; cv=none; b=C9ArW5n6eObQCo753F8L/PBI6wSL+No9M6LrysM2fVd8ZdraRm++htD89k9B94sQnSCJGGoHW1If9c71mfaw1g7SrU47Fi5OdEx158+1bgBYPOuT5E945/YyyHD4DbLE98K72Roz06ziATZ8oc7oNcy9m05g11jf6PWTQhqc/u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605510; c=relaxed/simple;
	bh=mf3hvugbE3AhK+xoz4r5nVLwHXOKy2f0yQoZNu6pYaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WidtI0o+D1PY0TDci7UjGH81zH63FDnbXpZx3LwIPf3531xe8YjgZemaZeM7zqp3MzY4PP2t2C8zM3khxdnxvkbdE+Hbtq2pJ3GTm8NLhSMJ8BQlx+e3iSZAyFWvmL7snyQzjqOFS7pQuCl1iN24E8wb39j9nbR+ibhRDoy0dPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ogZybVCJ; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogZybVCJ"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3115c4451c8so2483004eec.1
        for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 07:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790605507; x=1791210307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eZgUQuTykGxBSJt5x1FfopNzOuVlXIKdkSB27V8r4Cs=;
        b=ogZybVCJHdlAIaE6MiPjS/tgK28jHFZ/gD/gJ8Hnts382Wo8PSMCixVTyw24y7mIvu
         FrFQ9Vd93vE40qoJaNGQY9IYwfbv9YV+NHVi5+fXKwDLXWFiXmDrL/W3gtiqNpThXEIO
         /euxpDvAOMy79Y6b6ectskfrDdcx96KVygO9fo2WscV1stHfJRiachs3Wi+EgLAc8B61
         Z5Co29R3E6QDcYweTc65IbKHWP1X0+CW62G4MSEuoZY/icFw3F1LDbz16Yd4xdRY0R2V
         WP8Rt2lIozQv+IQ+maApMam8nBKsJXeo4fcA2PSSFQTQiZtMrSZCM6Q7YAlCdLKdA66D
         J6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790605507; x=1791210307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eZgUQuTykGxBSJt5x1FfopNzOuVlXIKdkSB27V8r4Cs=;
        b=I3aoqHopX/bUWitdP3MfMkTnI9x8q+B69XIGLk9reUXEk0Zif+FHsFE5NCYewiNv58
         P4mnmn56y1JVqO3H+ciS5TB4O2SA9ErD+ytreKl+pQmYXz99o0Aaud/XuE/H7b9HBAUF
         ckiZN8MgE32ESYmJpaSLM3mkuJUhI78QIEwnPqCnAdTCy4sSb/xx0Elf0YECN7kHyVWm
         3Evg6wGZX+1F/C40YTyT6nOiUmdx6AM+qc0XVBEZX8Pvl7flG9OT3Jaofs/vQ9X7rS/o
         /NjDlyqWbMJT/D5Scn4jCseMNUiA1PWrLHkQqGGmpiIH0liONjOr6aMCZ3zA8WOm6xFF
         vQvA==
X-Forwarded-Encrypted: i=1; AKwUvBy2zuQfQLuNvvb7SFe8kvVLAKtJn5tahKEibwxaq/nF7cVQXc7wGi9aOGGe5zqonR2PP17DO5DsPKQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUcIaSfOaJeo8MBVVQj4MXJKPVWcZ8u+ml57BxyEQY+27LAHOG
	wynRgqVwgABArDqRv+dtB2mePZdg4QsMB32h0/v/oWxsDZHH1UdbVwyn
X-Gm-Gg: AYBFou3LyDZSrxfeaYCOy7q+4ubUhQUZG+6r+TBIxzdEPlqMYs5AO9eOWq45YgrKagn
	0GqDXRW9mqtPk1J54M0ZHJGH8YmDeRUk9dc0rTKOeQqhRkzOQLMf4ioNsXNS7NS1WRBVbAwzg5F
	G3um/vjonFdKEE0Cxk8vh0qpz3Gl1AINfuBElNVd7wAQKGFfu+4IS79peRsM9Xnd+Cwtyec0Jwg
	z6JEm3sIbFqN4jts0QjlGz+YhY2xVGc8NyWU/0fXPxDJogxU+Nhplup1t9dOK/BuRhqXPP/+ORP
	0YLNNPCK5SZVh9GmDRrkKWjZKgUjS0r76PBwI+rBCnYnOGUF5fHIKNDGWoVn5/G4JLnln6RYfs1
	B++VhvUyVD2GN/dNc1J/hrCjvWqj8qE8NArArSsZ492xhqH7H63cOgUvWzAEsaIoxqVxwiF1uDc
	DUro2BXmQKudBWhCyw9YWUnHF/JQN2iJeyPbmHZuWVqp+BWcjcDpibissxt96LWDerV0XZebrFn
	zXJe8sX/In/5ROAjZz79VrX1SViCQV5nKf/SBs=
X-Received: by 2002:a05:7300:c3a8:b0:348:201a:6c88 with SMTP id 5a478bee46e88-348201a6eb5mr2740212eec.13.1790605506418;
        Mon, 28 Sep 2026 07:25:06 -0700 (PDT)
Received: from primary ([117.203.246.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3444fd04d93sm10670483eec.12.2026.09.28.07.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:25:06 -0700 (PDT)
From: Vidhu Sarwal <vidhu.linux@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Siratul Islam <email@sirat.me>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Vidhu Sarwal <vidhu.linux@gmail.com>
Subject: [PATCH] iio: humidity: am2315: fix negative temperature decoding
Date: Mon, 28 Sep 2026 19:54:50 +0530
Message-ID: <20260928142450.103799-1-vidhu.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AM2315/AM2320 report temperature as a sign-magnitude value,
with bit 15 as the sign and bits 14-0 as the magnitude.
am2315_read_data() stores the raw value directly in an s16, causing
negative temperatures to be interpreted as two's complement. Both the
read_raw and the triggered buffer paths are affected.

Decode the sign bit before storing the temperature value. Positive
readings are unaffected.

Fixes: 366a3270c1c5 ("iio: humidity: Add support for AM2315")
Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>
---
Other implementations [1] [2] for the same sensor have hit this bug when the
sensor was placed in a freezer, although neither is kernel code.
 [1] https://github.com/adafruit/Adafruit_CircuitPython_AM2320/issues/1
 [2] https://github.com/letscontrolit/ESPEasy/issues/307

 drivers/iio/humidity/am2315.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
index f29baa251f9f..31c4f52a0108 100644
--- a/drivers/iio/humidity/am2315.c
+++ b/drivers/iio/humidity/am2315.c
@@ -113,6 +113,7 @@ static int am2315_read_data(struct am2315_data *data,
 	 */
 	u8 rx_buf[8];
 	u16 crc;
+	u16 temp_raw;
 
 	/* First wake up the device. */
 	am2315_ping(data->client);
@@ -144,8 +145,15 @@ static int am2315_read_data(struct am2315_data *data,
 
 	sensor_data->hum_data = (rx_buf[AM2315_HUM_OFFSET] << 8) |
 				 rx_buf[AM2315_HUM_OFFSET + 1];
-	sensor_data->temp_data = (rx_buf[AM2315_TEMP_OFFSET] << 8) |
-				  rx_buf[AM2315_TEMP_OFFSET + 1];
+
+	/*
+	 * Temperature is sign-magnitude, not two's complement:
+	 * bit 15 is the sign, bits 14-0 are the magnitude (x0.1 degC).
+	 */
+	temp_raw = (rx_buf[AM2315_TEMP_OFFSET] << 8) |
+		   rx_buf[AM2315_TEMP_OFFSET + 1];
+	sensor_data->temp_data = (temp_raw & 0x8000) ?
+				  -(temp_raw & 0x7fff) : temp_raw;
 
 	return ret;
 
-- 
2.53.0

