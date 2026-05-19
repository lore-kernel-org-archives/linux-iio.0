Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E793A1695
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 23:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779234510; cv=none; b=keuUdNgBXFTytYaifwf9ba5+r84mNOEzGaMdm9ouE1zSYJ4nD2iEgg2pu5Fie+AQIxZwUFgAPPtNDOiyHtk7P3QrJDelJzmc8J8jf+HPmN8zbWJtNbXd/jxzbmGfLalUA/bITYKvIeL12YMB3SK6S35ZkSWLufEqKlmjuTWEoaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779234510; c=relaxed/simple;
	bh=/I3M+dJwE3ssrUyauiC4MPHvaseDxH9HSFeUm4cQiYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iseXLFz8udeR16u1NSS1LnEgleGsSCrpeMMA9Nd2JGbg3yjBURKF9TDT8hvT9iuCMz1gUSBC7dbdw2oFPc8JABeBILtU71gUTTsrpltX02ssRf2gP2MuYJnhg38rWZ6BviGTo/BAXhauPagTsxwtCAvRZDq5HZ1yIc45eQZXbZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=kKNSp2Fa; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="kKNSp2Fa"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8b5232009a6so61146916d6.1
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 16:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1779234507; x=1779839307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+s+9Q2IgDnQDcADMbVW7QyQ8Sbudi94x3MxpTj/0PcQ=;
        b=kKNSp2FaUxv+lX9zKBiBVp0i+Cxspk3zonGjes1Wz3Pjd5Kd4RJRQckHjPIVlLI/BR
         7evaSZ223SCXukubH4ks94YiRrPXM1JH8wJ90oQdFcYG093bsrZOrGNfBtr/FtYoOWEY
         bwtTpy2FzLspFAKGbxGn5Fd5SMls5N1jW3vXDSeROhL/G/kg3BvzsoyVHieieEqDvx+Y
         upk62r/4OZM7lKGrQ5IAaHiHIzyCV6qIG+4go5QsAr3e77eD+sYMGIE/91ge+D8Io9C5
         3ve2qxJSdSa5bfsE+h5zhAdfOQ1Fftdqo3hx4XzRBzjzFKed8fupj/HHtJJa5CV2PQA4
         vRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779234507; x=1779839307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+s+9Q2IgDnQDcADMbVW7QyQ8Sbudi94x3MxpTj/0PcQ=;
        b=UHQHKlxw2qQ12E0lZs90NE279v9PzTsNdX94ioMaeszhDa6ElJLBcv/WVrmueryOvw
         3WVHA1KiyVCAx/fOu2VD4yP8JDNZyBTC8ykzELpXoZpoUqp948nDF5hX5I+4qC3s5Kwk
         LIOYSQk4BpcWGULRLQA17KuUw+aPTz9MZ9ED/EoobC1AMmYWIJja0SSE2fhWPX8oKQwk
         y5coj4Qdqso41NPFPbK705LDEW0XN3Uunbi9Ogw1tCJRHmi6cEzUWMAmTNfKJ6eboHfe
         4qTmlu1zcZs9QHmdaaGwoyIyYrX1q2xOf2WSibiQEL5FjjwhsN5ZbhGZh0Px0wTi7K9X
         2pqQ==
X-Forwarded-Encrypted: i=1; AFNElJ8XsmTAoAysIWbCJ2XYahzfMQ1kgmEuTz9NdS2rnaYT9ysUUe6/zN73KdeaEjQ10snlYjtrxUNBiFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKgLfyCoHHBhIzTg01IHwrOYQm+2b2iPMr+5bbjbA8gjB2s6ua
	iEQDJYZWMKGEEQoY/TBl+CW9t/lGVC2khECZHrZksj5/wy3fd0S7VblPNxlKUf3r3is=
X-Gm-Gg: Acq92OE7GlsJ+V77ylllo7km9vtfWUR7y5C0IXLIfk1/WdIIKaAXFRJNG0e2T3D7kiK
	aRKK/u5IZHeUBQeeiKfIWkeNU04ESeDSf34UoTDG3XCWEgvZf3zR0IJZAqNXYCHrrqoasjXyXO5
	IFaoGWA/YAT261/31OhhY6pNbeX/lYKemvuUZhFwZmqs52R0o0gdqAG9T+QS9Eg8rwYRpf4pHyf
	BLQopAR0XeJzSn+5NuK/U3nNgsdskqPQ5/jgRD856qaFLYYXPO7UE+JKR+tYBhDidw8zlW6XEF0
	ViWMSXZNespVy4UBlrbrJMaXcizJJpjQp3tHEYX4YAFLsl2BohvQpMR9I7zRPATt0XT6hJtfh5k
	roUIjWxGKOHYeSyxByjYhUfyW8/ZK+TX0anQGzyX6ijovRdr63PeNRUwJpzO8Fa9uZjQU2+KCyu
	hQDJokmn+knjchSmu0QAKAzQ8uQB3hTFVlqpLOUlQ=
X-Received: by 2002:a05:6214:5981:b0:8bd:de6d:c353 with SMTP id 6a1803df08f44-8ca0f6f4e4bmr355438186d6.27.1779234506937;
        Tue, 19 May 2026 16:48:26 -0700 (PDT)
Received: from natalia-pc ([179.162.246.45])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36095326sm107301896d6.14.2026.05.19.16.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:48:26 -0700 (PDT)
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
Subject: [PATCH v4 4/6] iio: light: HID: hid-sensor-prox: Refactor channel initialization
Date: Tue, 19 May 2026 20:40:46 -0300
Message-ID: <20260519234752.23911-5-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260519234752.23911-1-natalia.andre@ime.usp.br>
References: <20260519234752.23911-1-natalia.andre@ime.usp.br>
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

