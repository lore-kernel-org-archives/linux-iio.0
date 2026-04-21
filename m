Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4846935A933
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 22:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776810155; cv=none; b=s/R9xW4iJF5ZopO3XEEEp4PSqJXkFDzrRfNhwm+cPzBqLw6r69nVJoRlijCXsHHtABdsvYus5r+dw6JOdBa9unPXvy3Fzsv/zZatvOD37241eIXxQhH/swc8Owv7nUpAmSvmit8cP3Oyt0Cg8TuJxBT3i0A1DkOTNy6vTbZWQGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776810155; c=relaxed/simple;
	bh=spg5rQKXsqW1a1lIS9VujueN2QCUDqNUSHNDWHg6oCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EsFYM7JEtFBYiliQsp8B0EdG/1yLACq0CwBP3vl6EgqncmAcOj8WB1h9zM0sqhCAw+fAQ8B71GSVYsjEBS8DO1gk7oYOn54Uel9SAQ3QWcPvo7/NnKG/dI7JZneiozf7U2u2Bhkrag12VJ9sv6JPB4rfaJsHNIw9tLET9Umge8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=bw2pqXAb; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="bw2pqXAb"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c726ef332so6501609c88.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 15:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776810153; x=1777414953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFReESBgBDz5s2/o3KOByBeZqhXkDZ85laE9wQTf5Jg=;
        b=bw2pqXAbaLpm9CpffwkHgDSGDIud+97eB/Vp49SerP4+5gNjvftAV35jljtnOVEiFw
         JMRYAuqCR4AsQ7IYWDu/PzMma1vuU84ButgIMTWSRb/gFRFn6YRIG1MtED/MkpouBv9+
         rm7kxuZWXzU80RrN/dYdHsLrENwhLZNHBeEbk0qgNkDUCE1CqsoYwD1forvk+68sGbh6
         GaKcE6apHzd996XXbfIXx/BtXzlgJvmibA3WC/jdsdknbQlNJTDpKvgor+9OgrmEfjgb
         VwkXWEYGq5woYQJTEO65py0mBZ5drp3Gkxr30cQNYQMCLG37h7zHYPqdeCim05hIKv8C
         8LMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776810153; x=1777414953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OFReESBgBDz5s2/o3KOByBeZqhXkDZ85laE9wQTf5Jg=;
        b=XGTRPwmnmmdcjIVFZPxZhd1GBSSnejRKr8RKGMjwn7oFjPPCdmoBdWbTdjjjupqdiy
         FlWPigbQ40ZxEFsVUwl3x+GnqA6d7PH5mkHRXTQyuej0aGnIc7lM2M9ycStFCXcf9nwL
         h+rGvl5JPjDd8isKjGp3lCKQjlroVnEuD+osDwUiz2rdYZ7+e48aKnXbIQvr24gyhNlE
         YwRVj0spUobhXL9p4xgPymXlzU/GS/HzHBqpV6zzlPg1JaIUPIEMN0cS3OAEfI7bQNRg
         FyoI1XXyR/LyvEFRPS7s65LRzQZs+W/hH+PHg8AbYphuxIHOkCZX1dbzVQT8xVjH3iV9
         yXcA==
X-Forwarded-Encrypted: i=1; AFNElJ+wFoarVFB7GNApR9XEekq/bybXP1oJ30Cl1AR/i/pya496AYsJ7Sg8Ich17WaXSssBHeKW0i310Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeCiQqavtnooH9WjlVXurcTUDr031L6HhVU4C3DeMBtr0HeqLf
	hprpIceVStJEFrGt7AcnEC8s2Y0M6s9qw6tqt2sFCssGKr0Hax1tJfOY7ZLtrebg3wg=
X-Gm-Gg: AeBDiesK7ZFPPSAHNIuDdZBJptqj+3Y3B/RZagXoHNMMsteNQJKMn7pZpBfyoEbEnw1
	jv6wUxObwbPMYGmFmnPmdTB/EzcV+4gvQoXv8Zwe3hghEcrimaSlMsUfOWEp+TthtihNeL6JKQj
	GKk8DqXKBJbTWJvJwEw07ofb6jS146RlvB5AgOBdC9e/Gdn+FFXgqGS20gffprv41SBsH7E8LBW
	XvFAg3VwtUst9F/UE4DCTPNlVUYNwPvOu5PI2u3FZ2PLPI8cLWDBTCHF6j8WyB2W/w4HqXrYJzQ
	7unMjyRyNlZ4DTkW+7IbNFhVivA0PjStjJtLuUP5ZRQsjuSjyuCpTJmdTfKJleaQdCG81acBoft
	7XJjhyGokeZ7aqVHbPn5xEuq1zf3jIA8Yto0whPB39AvxGjnRAiFSpM93jW5fueriOs1Mq4wNaa
	DN4YrIyHk6TlEAqofkA4JB6z8N7DbBs5URPQio/Q==
X-Received: by 2002:a05:7022:e22:b0:128:d494:a1ab with SMTP id a92af1059eb24-12c73f83681mr11273411c88.15.1776810153245;
        Tue, 21 Apr 2026 15:22:33 -0700 (PDT)
Received: from natalia-pc ([187.116.73.68])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c831d5b29sm20129785c88.8.2026.04.21.15.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:22:32 -0700 (PDT)
From: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>
To: andy@kernel.org,
	bentiss@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jikos@kernel.org,
	nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com
Cc: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>,
	Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v2 1/7] iio: HID: Add helper method hid_sensor_adjust_channel_bit_mask()
Date: Tue, 21 Apr 2026 19:20:33 -0300
Message-ID: <20260421222210.16016-2-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260421222210.16016-1-natalia.andre@ime.usp.br>
References: <20260421222210.16016-1-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add helper method to deduplicate code in HID sensors.

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 .../iio/common/hid-sensors/hid-sensor-attributes.c   | 12 ++++++++++++
 include/linux/hid-sensor-hub.h                       |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index c115a72832b2..3ee6e83c6cac 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -3,6 +3,7 @@
  * HID Sensors Driver
  * Copyright (c) 2012, Intel Corporation.
  */
+#include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/time.h>
@@ -589,6 +590,17 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
 }
 EXPORT_SYMBOL_NS(hid_sensor_parse_common_attributes, "IIO_HID");
 
+void hid_sensor_adjust_channel_bit_mask(struct iio_chan_spec *channels,
+					int channel, int size)
+{
+	channels[channel].scan_type.format = 's';
+	/* Real storage bits will change based on the report desc. */
+	channels[channel].scan_type.realbits = size * BITS_PER_BYTE;
+	/* Maximum size of a sample to capture is u32 */
+	channels[channel].scan_type.storagebits = sizeof(u32) * BITS_PER_BYTE;
+}
+EXPORT_SYMBOL_NS(hid_sensor_adjust_channel_bit_mask, "IIO_HID");
+
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@intel.com>");
 MODULE_DESCRIPTION("HID Sensor common attribute processing");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index e71056553108..6523d46c63e0 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -281,4 +281,7 @@ bool hid_sensor_batch_mode_supported(struct hid_sensor_common *st);
 int hid_sensor_set_report_latency(struct hid_sensor_common *st, int latency);
 int hid_sensor_get_report_latency(struct hid_sensor_common *st);
 
+void hid_sensor_adjust_channel_bit_mask(struct iio_chan_spec *channels,
+					int channel, int size);
+
 #endif
-- 
2.51.0

