Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F8B1FC101
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 01:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778549025; cv=none; b=GRQdeIAac/VzedaOdBW3DgpSllK7cQRnXoA7KxV2zTkbsImMBzjq5+czttjKw0pNayz6r9yGXvZGWwQVTdF9l5lPCCnxl09TS85odc5+0OQTvB4o+5xK3NCURhHzoit3NcYE/NEIcD0F6gcYDLaHHtDdlyMwouZSV/Vxzfi6488=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778549025; c=relaxed/simple;
	bh=QSiv7WSpFd2YKxc//BeochhaYMtiyPIjzqQwxwybp8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uycjBpJ9g9WYzRhR3jcGxGH9q511xByjgMD8yOaSEY7nukk/Mmrx0/3tdufbnMHwjXrS3mMStJNFO/NU9j2V3F57d8WFkZd8kszE62Z/CqnYuu9+W/+M/svfQ8bhxnPB7alJd2tZDj6dZjhZTtLYY3EaKYrTZW6EWdVyu5yDaCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=TbjS6kCZ; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="TbjS6kCZ"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c156c4a9efso6670648eec.1
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 18:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778549023; x=1779153823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0NDejsVUf9MUY06XbPz1Snkq7R09XiljUeZXWH8Ubo=;
        b=TbjS6kCZlhbqbBY/uwLRDr9lAqMPw6hvIb2J6nX2A14lnk/vtlAtXYB60I+f/jhP12
         Q4ur45Zq/P4Ack7Jk/yPcgu+YM1Mn/ju4bLr2jq+VAI/Wd6naHHGByiuplN0UVNtVIGs
         2QyxdZrEGh7QHkuG612na59MIlXp0ZphqV7ES4gZGEwhjR+H0ctsg84hCZeSt0ixzc7b
         rXo3VqMsxYpCTbrS2k1gmsM2d/hzMXU/lHGoPPaAr0VdBcRp8suaTlxCPzNhKLxxKHfb
         biPHfYFI/iMIcl1l24Ml4HvfFzlrMqA4+fj+SsHmsg8eph0tugBPRIw1l5QVJeysay/6
         DBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778549023; x=1779153823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h0NDejsVUf9MUY06XbPz1Snkq7R09XiljUeZXWH8Ubo=;
        b=bUt/McrJOIr6F+stL0aZJKwbKKhiCYQbUH6LbJ4CGFQg+qAa5KniEeXC9+EV6LrTmE
         7OuMaJxlMK4SGgeNQYkB2YQx4ueWOJ2W6jqLZDDmGnnK8QRbCt+mXch++aO8rcFkiJFe
         qhisLSJS5NssWyH11bldl31ZnjXLewaMWVpQUdMj1Hx3ROQS4pUVb87mXleNjT/SKwUP
         gK0aLa32kbU4AiPBIP1Gqlnw/NVYhoYxSdblMqOsMefGjwS8IlQr4hRNvAJNGe/xGX73
         Jv4WiWxSRb86+JvJ76Ofn5RrrVRopAwaklWlYtswn5ckQvIvPfUrW33sLRdNmUNSWHE8
         UXQw==
X-Forwarded-Encrypted: i=1; AFNElJ+OXkNhcZY77vtnBizpNSSRC65zWMYspQSk854sxI0nWz9gGuxndp17WwzCiv/Ecj0eJPDI+qXg1uE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkAqDXjK1fe8leyItY0MsUyDuooIiJShoMekvRDWEeYwmOk9ZC
	EnzJiamQhpgGTVNnRpX9E3TzFVAKvyVanjnA4qxBP8y15JMSFv57B/coX+9IimbTeZI=
X-Gm-Gg: Acq92OHpUpN9voup+kWYoHU0M57n3dWolMQq/TZ+4gVN2LDUJiHSX7YRLPx4LQmDMZ1
	P/P0g0m7qKXHRENmThXt87sSygSMzhvxbv9M4t/3t7ZQK9Cr2/taCysh/UG2I25I5lRIgKjTAUs
	zjZJxAHHrT+Yl7Lsxnh6Afe7rbW1PpIR3oSlnoNUpi8mvqvxfgDWUV12LMn9Z6mO5t3kuu6Iypd
	5y5KXETtH6al8HqLF7wEm8rrjr652TXjzP83u0eXlli+fKRdjdkafpINkhgNuG/q82/1V9dWwyV
	W9gMa010MZkGK5Ee/Kp/Rj+LQPNw+3wxvO8+CDcUjV2sAX1OaoKOQymgjlYgyjWSxV+927gTYoe
	E5b0IuCZQBLXrntPbxJFkzsloVPJVPNGJkDLTYd4hI6lauFMpZydWnn9FnbzcROVyIxHuQtacMv
	gIXgob92FHHQGKvcxUEQSr07lS3cjo6Q==
X-Received: by 2002:a05:7300:f191:b0:2c4:61be:1d33 with SMTP id 5a478bee46e88-2f54d69b008mr12339249eec.6.1778549023476;
        Mon, 11 May 2026 18:23:43 -0700 (PDT)
Received: from natalia-pc ([191.205.196.185])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847506fsm19484481eec.18.2026.05.11.18.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:23:43 -0700 (PDT)
From: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jikos@kernel.org,
	nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com
Cc: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>,
	Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v3 6/6] iio: pressure: HID: hid-sensor-press: Refactor channel initialization
Date: Mon, 11 May 2026 22:16:22 -0300
Message-ID: <20260512012302.20883-7-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260512012302.20883-1-natalia.andre@ime.usp.br>
References: <20260512012302.20883-1-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace the local press_adjust_channel_bit_mask() function with a
compound literal for scan_type initialization to improve code
readability.

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/pressure/hid-sensor-press.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 5f1d6abda3e4..a039b99d9851 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -3,6 +3,7 @@
  * HID Sensors Driver
  * Copyright (c) 2014, Intel Corporation.
  */
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
@@ -53,17 +54,6 @@ static const struct iio_chan_spec press_channels[] = {
 
 };
 
-/* Adjust channel real bits based on report descriptor */
-static void press_adjust_channel_bit_mask(struct iio_chan_spec *channels,
-					int channel, int size)
-{
-	channels[channel].scan_type.sign = 's';
-	/* Real storage bits will change based on the report desc. */
-	channels[channel].scan_type.realbits = size * 8;
-	/* Maximum size of a sample to capture is u32 */
-	channels[channel].scan_type.storagebits = sizeof(u32) * 8;
-}
-
 /* Channel read_raw handler */
 static int press_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -225,8 +215,11 @@ static int press_parse_report(struct platform_device *pdev,
 			&st->press_attr);
 	if (ret < 0)
 		return ret;
-	press_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_PRESSURE,
-					st->press_attr.size);
+	channels[CHANNEL_SCAN_INDEX_PRESSURE].scan_type = (struct iio_scan_type) {
+		.format = 's',
+		.realbits = BYTES_TO_BITS(st->press_attr.size),
+		.storagebits = BITS_PER_TYPE(u32),
+	};
 
 	dev_dbg(&pdev->dev, "press %x:%x\n", st->press_attr.index,
 			st->press_attr.report_id);
-- 
2.51.0

