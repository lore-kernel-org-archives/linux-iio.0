Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5FC3C9EF3
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778504406; cv=none; b=ostRul8H2AUck5TfRFYC8vfiXYA8VVqG19bEvaQC+627+tU7AANruo/tj199S/QLWwqXZMI3o4bSQRu1ydo8+mFvwPFwvBZz174FjoPgVTkMiScAV0jU1Yf7SHVgE7POhyLQwHDDLgrLh5EaUtUAB05vG59a61W+1gnIXWs9w5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778504406; c=relaxed/simple;
	bh=yLAa8xN4GDWRdkpFoT59uTVamATbSal7I81MqA706XA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bsMUSvD/ELt14544CniKV4PdJhOcBS6wVscC62raqatRFDHVPWjwtwZCOjJrB3BjE+iYpytg1dX/g9AoUwNxey0ndvsE+PetmawyJUiR5a0YlhDPPvfN5Qfe5DD0Q7wgcBqvkKioL93G4sFF7J1xHuBa+0Sg7kc97XJoK3eu/dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKbrpi2l; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKbrpi2l"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44ad87a57f6so419277f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 06:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778504403; x=1779109203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=llBXWZ4Ps94plAYDGvq5o6CrFl5XN3ThOZBOCy2eXlA=;
        b=CKbrpi2lvq+97/mFY/Ls3cANQDdvtuJeyg0sAlsfNJo7Trl+J4MC1sp0MOU3UVYWg7
         Rva60NALRhIypAI84gBv5hfOfYY7RGI3Pur89zgM4zOFLZjwjzGLQla3x3EHBoHkIs7x
         FxC470ZsqxtfQKLTet66aJBWVSj2Vz3t68h3ZWnVfG90L449vBPvVEeFozZh7QqXvMIx
         cF8+da19IhhaaICfwNgYlMTG9tgraRxSE0sTDiziYLvYOZ9x4RcfqGF/GgYCDPkScLz8
         bmpjuIz4toTP8XN2cdoiNgKyAmSc3SExy/TZrIrrbCehyUwl1Dk7CJupQHMTLA3pcszi
         Fecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778504403; x=1779109203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llBXWZ4Ps94plAYDGvq5o6CrFl5XN3ThOZBOCy2eXlA=;
        b=sJsJTefNHLkJulnf4aUEmCIvAj57oc6aC/5StoQBx41viHwW8g1nCNdbHQnv6LFNvB
         ZPANvDmjQVDWyJx48dpOqI5yHjn112tOCMKttOUS0kVm/01cOBISO1uOFj9prJB9bUKh
         CXxSArrjYvSnkGg/NQp45gpOU/d8nStnyhXmDYtClo4PeQn+EGM5rtWBOM6OEXjAFZyT
         VZFiBJK2hH+/PFKnbdanU3REboMx1y762yaQ72X5D/pbU4mTXdIhJrtFlThxiMOYg/qt
         VhKOXkJGjW5N5w6nZkvZGg5AQXjMvsNzG2EllP8IMAvwO1YscrMP7JdeMPmBHwA5claR
         TqGw==
X-Forwarded-Encrypted: i=1; AFNElJ8dOn3DV+w7yssMo5oeWQE3Y41UMXtjH37/5bHNOgtWZeWRKnEELTuQDVZIHfnJC7o5i1ZCY4RFXzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUa+tlU+zLxAZugLu0fjwDUeyi092ySGawxM5SdmWHqebJEQNe
	Hm7sAkwNW4dd35/te6ZyA6IYRKInjkZ9v4Jxkjm+HrzRSyO+q98nlGEA
X-Gm-Gg: Acq92OFq5T5FcjpNK5NJLn0y0Slpg/t30Y3btR0t32xFCEUTt7dAvgqC2w+qJIr8IYB
	P+PBLFWzwLJJz7qVKWJaXMyObGstEPJwhTU60ixD3ISkEfFQjZ8ymKnt5AKEb1FqIp1pjcC/xiM
	Ren32ftJRra8/zbNsRyFOi4O+sJKvjz7dyczJuRdSXNKU4mECpevsmaLCJf62EnwyTYeRYt2fnT
	5+hSjqs8KDlUszuW0swUyRKdDwDxoySY/uNHfNDYaQhhSUHX+pQ30NgGhHTw29YbZF8IH9Sxr8o
	aeQHHly1kdtSi9FDE9u9lZfvRLY5qRQe7RKUJv9XPPDXVz4845C8uHVSj9zEYKCNjs6RfyMkWFG
	CYgN7QF268zI/OQ9TJ22icJCjEs7peiS6xMSzpIP9EjT8lYHW5PpW8SLQ94zYzrmVqYZwVbuv64
	M7vNoypIYfMjpMw8JpKAPz8aQAqWouh+nDXLpRPrCIf6mU1Aw0/V9nuCM=
X-Received: by 2002:a05:6000:44c5:b0:44a:ba79:f039 with SMTP id ffacd0b85a97d-4515ecd6107mr13013695f8f.8.1778504402781;
        Mon, 11 May 2026 06:00:02 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6be40sm26772035f8f.12.2026.05.11.06.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:00:02 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	antoniu.miclaus@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] iio: frequency: adrf6780: replace usleep_range() with fsleep()
Date: Mon, 11 May 2026 10:44:41 +0500
Message-Id: <20260511054441.2980-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADRF6780 datasheet (Rev. D, page 23, ADC section) says:
"Wait approximately 200 us for the ADC to be ready."

fsleep(200) expands to the same usleep_range(200, 250). Use the
flexible sleep helper, which picks the right primitive for the
given microsecond delay.

Replace the generic "Recommended delay for the ADC to be ready"
comment with the datasheet reference so the "why" of the wait is
visible at the call site.

No functional change.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/frequency/adrf6780.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/adrf6780.c b/drivers/iio/frequency/adrf6780.c
index 257fd31a0..9911b5273 100644
--- a/drivers/iio/frequency/adrf6780.c
+++ b/drivers/iio/frequency/adrf6780.c
@@ -188,8 +188,11 @@ static int adrf6780_read_adc_raw(struct adrf6780_state *st, unsigned int *read_v
 	if (ret)
 		goto exit;
 
-	/* Recommended delay for the ADC to be ready*/
-	usleep_range(200, 250);
+	/*
+	 * Per ADRF6780 datasheet (Rev. D, page 23, ADC section),
+	 * wait approximately 200 us for the ADC to be ready.
+	 */
+	fsleep(200);
 
 	ret = __adrf6780_spi_read(st, ADRF6780_REG_ADC_OUTPUT, read_val);
 	if (ret)
-- 
2.43.0

