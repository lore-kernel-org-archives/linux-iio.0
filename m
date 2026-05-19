Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8853A382B
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 23:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779234513; cv=none; b=p4U//+f1QF5NWrMW37FCczfj6UaCEoDHCM5P7tPSK41S5rrTzQ4vowzZdIL0yezy8ZXJtV7DRDcv1PYXK/UzDev6KNNpP/RlaTQt+vPBf/dFgj11fW0fotSPmgn8blLBJOLdWssRtK80nKEbY3tmBp3lmP/FeT9kanWmfeSLia8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779234513; c=relaxed/simple;
	bh=Dnn1CGS+4OZOJShrWTbuyQ6nfUqx5TGkH6Z+F5fnlXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VSEv8HwF0L1ZLC9AV7/hYvxA6+pFNsffPrj1dTcBpjgvvk7vVKrbibcON7ZT4l1Ua+Iy5c2+es+xN5ZJDHeD/eQWUTisY5I/1SJ58iQ/UeAEXbAzoVnEZFNsEwKGNxBwqV9lKSnadlaxPTX05pIpkJHCl7HwZD3PXUBkSVGcV5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=qF5lczHg; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="qF5lczHg"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8acae26e564so54308126d6.2
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 16:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1779234511; x=1779839311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erGMYs6yW3leYyCJ6nURYYZoDVNiP3/mQp9l8F6DAlI=;
        b=qF5lczHggrAaA4so7bhbzZ2i6Fs1gueZ7edaRB03NjIeoqrNC2tJ9qLm6I7TyXiUuD
         LTqB+FP88fea9WVIVE4PUmjFI8Hy+JikFojbtd6KM7GgtUveqWhLvtWZP5JY2XbNam+s
         7mSXF5GvOKVAj1XovAeBwL4CS5fhvwUuYWi2BPhtJZMVJ7tctNN5bBRywccbgCU5s6lC
         45tNKQFxDr8rqMvimWNL2mpI7uzs4nnCnY4G7NtLiBUKQ1oK81xN4wDiANmAxzO9jBIu
         Eno71l+lneMf6BBOL8LSZeRJ4UejugQCjUCAo/3FEv+F1qyAlzyiqo2vf/Yfwa7cOI9B
         Qa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779234511; x=1779839311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=erGMYs6yW3leYyCJ6nURYYZoDVNiP3/mQp9l8F6DAlI=;
        b=Q7yajlrH19WllLao6Mor7awNw0vlRzhty6jhAJLZ2iBxvi/HKLpkEusAbR765+nogV
         i6+JuT6oU0Vk39qpEYUdfgdVtYY/weerBviz8GWwceghrhM0M5RWgNxT5gvNp3S4YCB2
         Yovgoi3ZrJU4UQCEU2/8iYxd7RbiQJpZEMf8Kae8DyxiB4yjxlIWsLa1txJrQljunCuX
         29R6/ggrbNDsq9VAWWiO+vDu8GMOpspISaL5ZitClluMWCaTxcmj6O9lyuTp15pf2ckz
         FS3CapksYsz2BnNDmN0YBaLCKzoQwOyw396KjePKrtCPtbieqZNwZ3XPQWMFZmLeTABh
         Nd4w==
X-Forwarded-Encrypted: i=1; AFNElJ/U2qDP8bBUT+ou60ZyqtCjF55dkyXxfRFuNnW0zaj3sGk5BMIX6W4gXrgwZADS4k9+iXAoMdKt5ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTST3UZ+4Ica/SoWEEBLByqna/8IfNOcXw4u0u5BfPGKk1Xd0l
	Gf1AFTUgqcYFsdPSgDgsg+4Gum8wHmQmWTRK3moRmq/sOBx0PutlUu6TNL5NqsjOwAg=
X-Gm-Gg: Acq92OG0C0589nMpOYd2jtuJxx5pk6cT8nDMELlvV8AFPLh+HgvqMQZE6VksfC5mZZM
	p84UtXF8F29i5vM4Espt5f4+pRgcGM/zHOUX95J9MsKNs/VXTct2Er5GIsI7ig0ayfriyFziUEG
	Z7nn9+JJ9e2dmx3aExkbwnHmlp3pvwj/wRrRLcaNj2mjHPzPmJPbpYmdXK7Z0dWYDFXRrIbjKtZ
	ySV5fBA0pYEhoKwHqDAPZSUkNQLMNXjdjRWDXCgpPdWExCF0UnELVu8z1nsvBXkumbD9Fu9lKYh
	zJjKVzymXNyf+jZxDIieHnbigm/VT2SxtI77bkP6rK+twd/5gSMt+RM3hNlMcBeYTI9PFhXLibS
	fwUbKYeZEonkwpv0Fk67vs1mg1Otxp8/+pwBiK2UxsiGq/vZqXQ7f1lJo9KyQKev5Xfqmv3E495
	iUsi2cc6JNe/dJlrKsVUGV9F9JKwTOZsX4sWTTfvU=
X-Received: by 2002:a05:6214:33c8:b0:89c:d808:c255 with SMTP id 6a1803df08f44-8ca0f697396mr374299376d6.37.1779234511542;
        Tue, 19 May 2026 16:48:31 -0700 (PDT)
Received: from natalia-pc ([179.162.246.45])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36095326sm107301896d6.14.2026.05.19.16.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:48:31 -0700 (PDT)
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
Subject: [PATCH v4 5/6] iio: magnetometer: HID: hid-sensor-magn-3d: Refactor channel initialization
Date: Tue, 19 May 2026 20:40:47 -0300
Message-ID: <20260519234752.23911-6-natalia.andre@ime.usp.br>
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

Replace the local magn_3d_adjust_channel_bit_mask() function with a
compound literal for scan_type initialization to improve code
readability.

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 20 ++++++-------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index c673f9323e47..3b26dc41dd4c 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -3,6 +3,7 @@
  * HID Sensors Driver
  * Copyright (c) 2012, Intel Corporation.
  */
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
@@ -132,17 +133,6 @@ static const struct iio_chan_spec magn_3d_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(7)
 };
 
-/* Adjust channel real bits based on report descriptor */
-static void magn_3d_adjust_channel_bit_mask(struct iio_chan_spec *channels,
-						int channel, int size)
-{
-	channels[channel].scan_type.sign = 's';
-	/* Real storage bits will change based on the report desc. */
-	channels[channel].scan_type.realbits = size * 8;
-	/* Maximum size of a sample to capture is u32 */
-	channels[channel].scan_type.storagebits = sizeof(u32) * 8;
-}
-
 /* Channel read_raw handler */
 static int magn_3d_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -418,9 +408,11 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 			if (i != CHANNEL_SCAN_INDEX_TIMESTAMP) {
 				/* Set magn_val_addr to iio value address */
 				st->magn_val_addr[i] = &st->iio_vals[*chan_count];
-				magn_3d_adjust_channel_bit_mask(_channels,
-								*chan_count,
-								st->magn[i].size);
+				_channels[*chan_count].scan_type = (struct iio_scan_type) {
+					.format = 's',
+					.realbits = BYTES_TO_BITS(st->magn[i].size),
+					.storagebits = BITS_PER_TYPE(u32),
+				};
 			}
 			(*chan_count)++;
 		}
-- 
2.51.0

