Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6925C3D091C
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773682114; cv=none; b=V7Qcfqbj3neAxITISB4lCoTHDKz7Svhqo+qNvAVO9yyPxxNBNGE0N22okKXEyv/G0XRInqo1EKHnR+cnZKqVs+8IAZayrEdYj6Io3rIyaY8oLvhfmtjQX3GXrPATMdWtLaKC1FbgTM90EIgDR6wP6MKwjHNYNZTJHT9uQPpqvnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773682114; c=relaxed/simple;
	bh=zYf7VeMtdzcRDka6izbJRgopwbG6G29T713ZvvFrKhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBSMi5DWLB2zNdcpyB2Q/qOVdUp4XWirggNLKjde5vGMZQccPsgUnbuO+RzXl86Ch33rMpJaopG2dahtb9PHlIm+H8VvSaBHHxofAhlo88254YHoLyLaT2fk7+1EBqg0KzBl2M2vNgLDFhW9dv8miojsLxI82BvG7w2OrPhOz+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oo4trN72; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oo4trN72"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8296d553142so2191646b3a.3
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 10:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773682113; x=1774286913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LlzPjbMiFY0hTPctjsTWTPQhw1G2jSbBBD7oXyALOo=;
        b=Oo4trN725DOon3NlKLv5mM2PbOXNEH5f93pBXfRcIC5JTA/5rm5L6y8vi630DZQfvM
         rLRkSIqBj9tjU4JY+Ld7ziamjSVmErSC3+qkRmUxywZC+Fs03Ev/WtGeFipFCLNfDvzm
         +2XKs9HpDjuPreHBpUj9Spi4Nj8N6QlTE8nO4kmqSRzvVTCELVloT0R7TnhwBpGJUDEw
         32cWyLtRSL0a7MllGZqjkt3u03IJ5xvrYt3QsgmnaJmPJEK5UeE2fXyt4yeDX/jmT0B1
         iDgJi6YLrZ+cgU0dulutPSVf0kp0e6FNlIJp6bpgWE4KmClqSQWWpph6Ho5cEH99+vr3
         iWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773682113; x=1774286913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4LlzPjbMiFY0hTPctjsTWTPQhw1G2jSbBBD7oXyALOo=;
        b=iUzzqNk50fPzjMDjzZ7Dh9duV12DfcafC5GAtkrVaJNWbNp7fMKYkXmhZ0lKy+nhCm
         YSIyomKaRNgu2PszivCBHZVHFSD2ZzTBe+yF/U1pIhYFg8ueU8mIFsfD5SChEA9XxOGp
         IHgZWzFPiUENs1C57rdar/FiCCb6Jj5WtYpZPyXsL2cwWKCXbyDgKmBS1axYQVTipy9b
         qr4fcHRfLxo1Q2gLmVCX69dPLUriPpv9nfiw3H/uVVuPfM1Zkq1NkFkpfhx0q+6Vz3mz
         YLJErBpll44JHegpu7ZZxOizAbs7ZRfX1nBLF2MoQsB5QssLXZy0JMGiwsBoGU3FJYsE
         qIRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3VLdxSKyJ8lCLRGaiNc3HIetrfGGSpOVzJe+W3ZEE51yATiOfOyROUs5KGsxXaMq5FzVstsWRr+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnZE/RkLDIY0Yx1Ksb+LbC1qrkZD40Jw39f2JEagtZVUJPmeW9
	9gPmguCwxkf/uUVbpAE4mB+IlPVFvNDPDyLfWei7uhJny+KnuriVJCac
X-Gm-Gg: ATEYQzzV5+HvQk8bvCQ8aeSjj/PcXRHW/8qmlUh3O0smlveF+h8LOquAzp+qHo6q+4i
	NjVyC+bgBVIGolJA4us07JjMCKOkxZADYfMoef9gbxHStWXbmJjTrg87kJa0dOp+Zo3CeSaC6Od
	GXdj30po6e2xpYLQ7YXth1OT1FeDQ29LfUWRj7mrH+uFbEz8x6fuu6gQuj6IHvwe8tEnYzWWBBx
	DMOE6clBHJrhq9bkCYSjI4E3LfIA7/NezVnRQTtdfRCUuXcN1NVcdpIVnRrg+y+b32zaYttpTnf
	Yf4ob2InrHINz/Rw9PcGRXLteSXxicKpkmqHPL1Fry5kJ1qYZHrH17LQUmfRavXAssibzKXKKh6
	MqcmUVvLe4PDOYYUJhHZN0NtT+ihJ16+/K9j8TX689jhaIMN1qCkU0aD3wmZM1tvMBBOSaedbtN
	G6AwQRFGD2p1EoYuuo/Wpgz9ngBuSlOXRZwfVuD6F0CzAFGj8LQBt8JtU7WBLwyHzQNva4gUOwI
	PEo
X-Received: by 2002:a05:6a00:4b12:b0:81d:dd3a:b8f5 with SMTP id d2e1a72fcca58-82a198cf743mr13133420b3a.38.1773682112603;
        Mon, 16 Mar 2026 10:28:32 -0700 (PDT)
Received: from atharv-HP-Pavilion-x360-2-in-1-Laptop-14-ek1xxx.. ([103.216.213.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07341986sm14016183b3a.32.2026.03.16.10.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:28:32 -0700 (PDT)
From: Atharv Dubey <atharvd440@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Atharv Dubey <atharvd440@gmail.com>
Subject: [PATCH 04/11] iio: adc : cc10001 : replace deprecated iio_push_to_buffers_with_timestamp()
Date: Mon, 16 Mar 2026 22:57:30 +0530
Message-ID: <20260316172735.11430-6-atharvd440@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316172735.11430-1-atharvd440@gmail.com>
References: <20260316172735.11430-1-atharvd440@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iio_push_to_buffers_with_timestamp() is deprecated. Replace it with
iio_push_to_buffers_with_ts(), which takes the buffer size as an
argument and helps avoid potential buffer overflows.

Signed-off-by: Atharv Dubey <atharvd440@gmail.com>
---
 drivers/iio/adc/cc10001_adc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/cc10001_adc.c b/drivers/iio/adc/cc10001_adc.c
index 2c51b90b7101..ef105458ffbd 100644
--- a/drivers/iio/adc/cc10001_adc.c
+++ b/drivers/iio/adc/cc10001_adc.c
@@ -178,7 +178,8 @@ static irqreturn_t cc10001_adc_trigger_h(int irq, void *p)
 	mutex_unlock(&adc_dev->lock);
 
 	if (!sample_invalid)
-		iio_push_to_buffers_with_timestamp(indio_dev, data,
+		iio_push_to_buffers_with_ts(indio_dev, data,
+						   sizeof(data),
 						   iio_get_time_ns(indio_dev));
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.43.0

