Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529AD1FC101
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 01:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778549018; cv=none; b=M0mjBKwifaFQ4wP28IMoRjLN743YAhV9lyU7a5iP5qHPUmGVKdyHXzlzypeH7UI7kMol12o46KqY/2obRxzpNka3kdV7P6jl/9ipSM0tVMUwVYLl2vAcbivLYyG4y4mq639f7aPUuQpbgAw2eLsWOlLQNdy50wN/q32Kr4pSBIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778549018; c=relaxed/simple;
	bh=/I3M+dJwE3ssrUyauiC4MPHvaseDxH9HSFeUm4cQiYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uodLUSYCXzDYVNhkDi4HaEYuhT/f0+2D3hnw26yTTcJc0s2kqnGBtXW3L9HVjZnOT5AwkYWC66zVy0xXPGvAmp3zo4A+Aoi2ddUaK77nS/Y4IiLduv5n0Lnt9Q4nr/49uyiEC2H03M9oRN+xAcH5t6O4xqck96c4W7Qk7I1n6UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=yKwZJs1g; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="yKwZJs1g"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso8619792eec.0
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 18:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778549016; x=1779153816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+s+9Q2IgDnQDcADMbVW7QyQ8Sbudi94x3MxpTj/0PcQ=;
        b=yKwZJs1gf27Skhq3ULXKCDi7cT673noAmxD/hHoygmgq/Btw36GPF5TpBP723hyRYk
         wO0KcQ00J3yLZjYW3CdT9XXjatrTIOSK8GZM/zO95JEVfxUMjdHo+Qoc5akmzF8Gh+PU
         r6QtTLwAxweamTPDDt7pgE2TWXb8HbcwUw31JPsBYFeahFCI3cyEWRpX7VOXyB3/v2Jl
         qhaxR48SmIQ6qsnoOLx+g2eAgk9xNrV2tKBdCtuXk8paml2I5V0DAG5EJPhcrVGdjuKc
         9GBLDnDrHHr4+I6v+wEV8iMDfPN0Qt0lF5bxExYqJGYYYRfeK4G4pXh/EJvQDuiK9YNJ
         7mTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778549016; x=1779153816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+s+9Q2IgDnQDcADMbVW7QyQ8Sbudi94x3MxpTj/0PcQ=;
        b=TBJTBqiaXh6+dXE4US8s8kXigCUH8KdZLi8wKk1M5xgoe7xqfVwgAmfkFBHOORU/+R
         LcFPW/k/tGCDJd4yI6mT1wBp6uw/JIjgDBi1RLLKkwwyAAPMZLnCJURI/1mPE5c2FRn0
         7OlLbJzl0s4AeMK6aOS4U2M0saLeVnwzqZTLE4Qt0P8tmXR2qgHwNqtvb1FWDTeIzQEo
         zX/7ECnOp2Pj9Sl3DRMcj8u2klQwQn0yMSJAdEG1xbDuyueA6MoPEHS2LFc5UvOY6k8P
         DmhptRzQVhpLgCeeWeq1NN2dzAD8Xq6Q+hjVTH4UgNtV1xBz4UPXtePbY/a1qHxK/LU1
         3GWg==
X-Forwarded-Encrypted: i=1; AFNElJ+T4DWlCrlypmzZIOQbECi8KxrzTGZKaPeRrBYc+RLH2JPD93YWlF9yfo4YZLYkUVlWI4mBAkEsHp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsoDUoS0zWFDjwnWveCSBKyvRBks1cdr/0b8VoZZrxiKCfMR3j
	aCl/N2Qe+fOgzUKphxcZL17/TpOSYmKP5OzSvxhoe4hWLunLFQ7dNdym80qkgKF7Wjo=
X-Gm-Gg: Acq92OFsiykhPSjo2eOP+27fISYOkNQ3DSh4j9i0bV6fWIazupHWSbXclP+JSok2LUb
	M5Zp3pZGcAOLtMdQJPP0Ep9GsXiiWfA2CDxgqay4tLhtY+Y+hU3FUEsL6DMeX2qynX9fw2F1Ewc
	wYfMnZSSO42TpJukkxNvAPq2ZYwEFE8pkax/rKcwL705bYigNlS1cxmUUsT11nuJEgweMtblRcK
	RlrxjaWsNCMDDloEOcP0Lcd42dAaexSKT/AhqUOpnAEsQ0Vb5rH/OCLbNkIQbf3fMahX6WkM+D4
	0H2QCxP1EFp3QF+GaF4Hotw9Z+UevSC7xpb2gtuT67bzFGUv4mOckkaDB8LsPRY1eoi8d9iQgur
	ixbxmo0CQAfYnm71aN7IrixFdBiGdb00+xRGDdvUYg8FiH+J+GkTRoxHisCe7cA2rohaZaOH4WH
	pHtmcykk0Y1EMoHjS5dua+x2OLCB+NHb91BLfMAIcB
X-Received: by 2002:a05:7301:1292:b0:2f5:5dd3:1fd8 with SMTP id 5a478bee46e88-2fb3e2ccb37mr5888495eec.8.1778549016421;
        Mon, 11 May 2026 18:23:36 -0700 (PDT)
Received: from natalia-pc ([191.205.196.185])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847506fsm19484481eec.18.2026.05.11.18.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:23:36 -0700 (PDT)
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
Subject: [PATCH v3 4/6] iio: light: HID: hid-sensor-prox: Refactor channel initialization
Date: Mon, 11 May 2026 22:16:20 -0300
Message-ID: <20260512012302.20883-5-natalia.andre@ime.usp.br>
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

Replace the local prox_adjust_channel_bit_mask() function with a
compound literal for scan_type initialization to improve code
readability.

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/light/hid-sensor-prox.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index efa904a70d0e..edc9274a2c07 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -3,6 +3,7 @@
  * HID Sensors Driver
  * Copyright (c) 2014, Intel Corporation.
  */
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
@@ -67,17 +68,6 @@ static const struct iio_chan_spec prox_channels[] = {
 	PROX_CHANNEL(false, 0),
 };
 
-/* Adjust channel real bits based on report descriptor */
-static void prox_adjust_channel_bit_mask(struct iio_chan_spec *channels,
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
 static int prox_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -250,8 +240,11 @@ static int prox_parse_report(struct platform_device *pdev,
 		st->scan_mask[0] |= BIT(index);
 		channels[index] = prox_channels[i];
 		channels[index].scan_index = index;
-		prox_adjust_channel_bit_mask(channels, index,
-					     st->prox_attr[index].size);
+		channels[index].scan_type = (struct iio_scan_type) {
+			.format = 's',
+			.realbits = BYTES_TO_BITS(st->prox_attr[index].size),
+			.storagebits = BITS_PER_TYPE(u32),
+		};
 		dev_dbg(&pdev->dev, "prox %x:%x\n", st->prox_attr[index].index,
 			st->prox_attr[index].report_id);
 		st->scale_precision[index] =
-- 
2.51.0

