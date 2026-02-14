Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702DA7404E
	for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 00:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771030431; cv=none; b=JkHoKOdeyynNqFJqj8OPkGDN4qYWdLxV+JftcHhbGbXiszYamZS+iogyEkBiVpJkzf1c5iEBAvxAReH16PpmjxPe3qFyYXOvpr/RT26qKZ9lTdjpwAIdP9x7tLyhna2+4EIrRY15eA7HBtdkME0U1fVUF6yf5L+9qIxAMgOhb9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771030431; c=relaxed/simple;
	bh=QYYZINt1LWkcTytk2g0wrYoIvMCsV7Crk2E7/cdK7o4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AffU+pt0zDQPl3EAk79K0I0JkkQaMHCK3fIR/1lCjIPisomfzxj6vr/gpyVHNNAEaQ/1CPlzdJAM2Ujk7wsN3ORn2am/ZmpUrmsdS5abndV8wxu7k92GPV+XpsjOPAeiviZLbX4DQwqZN7uGtqSnu0jJQAH0LSmbHDBQdqogCQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Spe5DRd/; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Spe5DRd/"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-649278a69c5so1491333d50.3
        for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 16:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771030429; x=1771635229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kT4ZLcabTstJMeBMLau6g+RNhZ1l0Yxf3jcGbnfdBIk=;
        b=Spe5DRd/Vl2OErWoxkihomW07NOsNCJ9xVIvBko40LDmLWTcwupbQ8TocTVkeJ1dvR
         z8hkBSGurEz/ySSOXAaGvu88avbsgw6lqoTTKmK26gcc02GPzU+6zU9o/HLJXfdFTIjc
         0KEUlUGTbYaOq5UeNrAo/RuxR7M2bleUktp7hi/SoFQy7qy8+57KrKVGqMXGGfCSD4Lz
         8YXKIXPViafSzxgQffo5y5l0rF5zpQd00qVRDDK0yq5fHiCeEVwdJlfgjVC/4iWaUr5e
         QGEqBHsDx8URhpMuADoc+xw6/z6SrA06cQt1W4EZVTFxZ6DshjhiTg0mUIifY6sjE3Yy
         QH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771030429; x=1771635229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kT4ZLcabTstJMeBMLau6g+RNhZ1l0Yxf3jcGbnfdBIk=;
        b=wHm5QnLTKMP49MpRah7Dy3TIzMqYOib5oe4nUGpEH274/HPqz7xPPGD6mA3f+WDypr
         0dqokXWRmkS5UJBI2t3bw0ZLx+DiGPaFLyvQyymsCsaweLGcszsUvLHDfYQlNZ4JMpY3
         dPGp0d/h4c28rynWO36DLF03NPiBJfj32hev92XZUiB9bvRrUwhLXZxJW4PhAGKDrM8E
         PNVeBx+E2cHA2lSD/og0EIZswFEp5pMCe9A8sCgxIsC+rXkok0v3em7hfLbntIIxSJ0a
         KZskVb8npFsLwqfNtJQmEC5Tw4c2UBLcWidCXOCPCi8sfVXGlKSIimOTCrWH9Jx3v7zl
         FFLg==
X-Forwarded-Encrypted: i=1; AJvYcCXH8qUm0kywpWGUYoougTcCvsL+j6A4etDCWM0e9z9M+4qrDYNsowDIjvzodR6kIO7K8s1HbJ0z1vo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6AmBrYTQy2pkXmQCF61OI8dfBRxTsXzq6tO1AWREkfeKYdKqF
	hDfvk5/yf4JY5Oaq7QA5mNw8CnKydfGkMnKmv9f/xIMsrToZDfy0lL3X
X-Gm-Gg: AZuq6aIzAI3F4vzXVtDt3nRY0B9EiVJkmQLLczZReNaPnkLusK2Rq+Kdz2L13ffuAjf
	gFqlRhYjOS61Y4wfibbSMEGvKdCGbg8gBHSTOGTwVPkzdFOjMrPluzxNP7bU2oBmK6nMMbhZANM
	QhGYAqsZAcBwFHPgYO4Kf1Usbg4u2h9yEKZ51vyLUqVQ1/SXDgeVaEPrGtpayP1YkyDJGfLMVW5
	w0PDEzBtdZ/o/6p75cOVtAv3v57fypBvX9Fb81p0mJ9nYBLY/Gfa+kpkCJtuF1I+kJcinqq5hFd
	/awuyBB13lE3jqlbuonTVpO2Li4a6XzZfsHT4Mv+UQSr7p0UDohCZHCuXOExF3TOHNP133IbDPN
	dmmPA7gm/lVfKXnWABEGSqxuWDmfig3D7+5e1p+ymq92ViHfK1TM08VEHuMwtrOPWFDuQR3b5rf
	K/3dfgHO7yj4ZAPGVMwj8I/0aZxos3MTQ7PX9n6L8baKZkD0FxTarnqXi910b7AY7xSN34a6897
	y0CIfrkVAo2CW+F7R3Gl4U+ep2RUvQR7nTVVtAQQao=
X-Received: by 2002:a53:de11:0:b0:649:3897:ba21 with SMTP id 956f58d0204a3-64c14d381f8mr3455938d50.52.1771030429324;
        Fri, 13 Feb 2026 16:53:49 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22fb1d2fsm352432d50.18.2026.02.13.16.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 16:53:49 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: jorge.marques@analog.com,
	jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH] iio: adc: ad4062: Add missing IS_ERR() check
Date: Fri, 13 Feb 2026 18:53:32 -0600
Message-ID: <20260214005332.29608-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the function ad4062_sizeof_storagebits() iio_get_current_scan_type()
is called which can return an error pointer and is not checked for it.
Also the function ad4062_sizeof_storagebits() returns type size_t but,
is only used once and the variable assigned from it is type u8.

Add check for error pointer in ad4062_sizeof_storagebits() and change
return type to int so the error code can be properly propagated and then
checked.

Fixes: 23cc92280302d ("iio: adc: ad4062: Add IIO Trigger support")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202512280539.AholFF7m-lkp@intel.com/
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/iio/adc/ad4062.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
index dd4ad32aa6f5..c864de3b46ba 100644
--- a/drivers/iio/adc/ad4062.c
+++ b/drivers/iio/adc/ad4062.c
@@ -1199,11 +1199,14 @@ static int ad4062_write_event_value(struct iio_dev *indio_dev,
  * The AD4062 in burst averaging mode increases realbits from 16-bits to
  * 20-bits, increasing the storagebits from 16-bits to 32-bits.
  */
-static inline size_t ad4062_sizeof_storagebits(struct ad4062_state *st)
+static inline int ad4062_sizeof_storagebits(struct ad4062_state *st)
 {
 	const struct iio_scan_type *scan_type =
 		iio_get_current_scan_type(st->indio_dev, st->chip->channels);
 
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
 	return BITS_TO_BYTES(scan_type->storagebits);
 }
 
@@ -1233,7 +1236,12 @@ static int pm_ad4062_triggered_buffer_postenable(struct ad4062_state *st)
 	if (ret)
 		return ret;
 
-	st->conv_sizeof = ad4062_sizeof_storagebits(st);
+	ret = ad4062_sizeof_storagebits(st);
+	if (ret < 0)
+		return ret;
+
+	st->conv_sizeof = ret;
+
 	st->conv_addr = ad4062_get_conv_addr(st, st->conv_sizeof);
 	/* CONV_READ requires read to trigger first sample. */
 	struct i3c_xfer xfer_sample[2] = {
-- 
2.53.0

