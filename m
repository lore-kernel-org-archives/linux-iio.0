Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370EF3D7D81
	for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342065; cv=none; b=PnhW9I0mIn6+oFTfulevLRhlL39Y3/K8XNDLMapiu1/t+1Ha4cDsVYFtkrZkg6s8OxO2QZA7iVDIioQ5SZaf+KYuG/G4+H4hfuR/nSqE9n/K28HXenRjFN5M3YF3oto4qY/EE4QaijDtea3MvT2r0ghikVWvPvYMSRjwjMCYZWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342065; c=relaxed/simple;
	bh=zgp8NTdUREy2MLh20H6a+tMiC/1Tlmkrf0vlY1q2WQU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WiFsKNyEcAqxX6M23HnKckv0PmzPIm0bhAMxhQKzhmuktgPY4O6PKiAuuov2Yu9ABk9KS8gTcu0kg6K3MKXMKEGL4ss2I6NJAp+pqQ1WKwRDfBTvaS7D2GmuftVTSGUBdV4idDZDOROFCE1guvD+4SrjyXEA213B7Wi2cJh7F2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kV8jtjox; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kV8jtjox"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso7323725e9.2
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 01:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774342062; x=1774946862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cAfHzDr51uvPOkiugJ4Kjtulax/W7M8Q/janGYkUI3o=;
        b=kV8jtjoxsru5ULi6IxtF9IAp3DD1WcWwyjhzNmwc5+4JslaOEcd1nr9Z9oOiW4BsOA
         i3b62bGuJPZ2vNNRXRqe1pVox1rCdKrDswzb+2ZCPCoDH/Y+q0nYlZ1Uz9xWcVTehHCD
         c7nOc6WyFEdsFrsrzvZn9unPYEJN2f3LwIEWhgrgkWLnsKEvMZrcFPUbi9AfJdZYhIRM
         b2+e8ZC/jf+vH7yGBW80X9DMk5pgXZCKguioUfbap0UokANtdbZ9NK2LXM7/DvKuQvuH
         qcitEyeYiu+MsKliIew46UR+HEZboNgWxloN7aNaHqjbgAz5iVjpDpN+OklINMYSMJUL
         QX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774342062; x=1774946862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cAfHzDr51uvPOkiugJ4Kjtulax/W7M8Q/janGYkUI3o=;
        b=YevBqs19mLvcVSL5CQxI0QguQj8ldRH09R11v5mxs3BVGpRiD3m53OZwmOZZiOjgFk
         YfEhiQhdM3+QcAX9fSGvLNMbnuYmEr7a1xhNodYceTWKraCSztPHEGmkWr1QJhPQifUI
         fz/CNym5W8GAr7aBTWHg0Qwf9H2LpSMBSkS34+78E8fHLLtwdxAy1MJXw8CFL54p0GoI
         WYTSsRlKWIA8V9iwIzeYuwOjIXmos+nSobtdxaTXTQARECRkZ2QYzJTERz6ewtIzvDaX
         INeks+xZjC7KRjGcI0CrIv4i8G7GXNuAww7qpitBgwGsEuiB0TYcvo6DN2POh9hP2JkJ
         AD4w==
X-Forwarded-Encrypted: i=1; AJvYcCUz/UTcR1g6cye7GaKDVg49CX0ozQSNxrTn7uFBzaqIBUeMe77uoPy09CvuiD9UkGXOkUfM7uslWXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFWAUZAH8QytEjw3eWlqjVVZQGhDGwmINEVJhr8BmQIMzz5iID
	rQWwvzO5+l7SUWiaqRJYQ9jD4vOODC5DaQ7mMZIYmfyixqMR4AYx5Z3GqgBQBpBBbuQ=
X-Gm-Gg: ATEYQzx2UqfHIvLKvLK49K8LDGzSsRgfpW1B19f63u+VMf1fTmkWokkOSftiZlk+DB9
	qEudvZ1z3wYKxkeICejNIR3HuVPzcaNrS0CvIpBct+ABFikS+nGT7D1ND8N+l3NEL/bGD31mRW/
	w0hQsqymfAraJfTx3P8ZXNOQste6AIXzUJf5sYvR+PFOzcBaFYvHFpa3B+OEg0MS2odG6atz9GF
	E0kah5C0cg9Q7PWtRcPMtmxIQcKYuLONXBk6PHGLohBAc5VrYeiT42ZeJkCcB5mhlJA6InI5+80
	SuFubNlf03PUsrTED0b7nWuPp60uahRUmdYYOQJKShFQ5QrrucKniTOBdow7PEwNwkSnaYOAhWh
	ln7VwUJ/4e5hciSEgJ5ShBbR8E1NuacBO0/Uydr5WUK3faeAFP8SNaDr0j5OcwNZtm48=
X-Received: by 2002:a05:600c:a47:b0:486:fc46:be9e with SMTP id 5b1f17b1804b1-486fee265demr224481385e9.24.1774342062456;
        Tue, 24 Mar 2026 01:47:42 -0700 (PDT)
Received: from localhost ([151.43.230.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871174f2cesm33827245e9.10.2026.03.24.01.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 01:47:42 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v9 2/6] iio: Replace 'sign' field with union in struct iio_scan_type
Date: Tue, 24 Mar 2026 09:47:40 +0100
Message-Id: <20260324084741.653947-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260324084655.653781-1-flavra@baylibre.com>
References: <20260324084655.653781-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2823; i=flavra@baylibre.com; h=from:subject; bh=zgp8NTdUREy2MLh20H6a+tMiC/1Tlmkrf0vlY1q2WQU=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpwk+sqeS/zfgDOZiBZSkdRU3R1Qf8Cd1bbq5y4 gzJi2myTLmJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCacJPrAAKCRDt8TtzzpQ2 XxnqDACRZgIzL9sjnA3P7g6oBaKS1FYPPr2rjtJE6XkxXXVkBlM4QUEIBrGlgDWllpblvh9QfsK K+63M2UmJJMM2SqOBcAqCv6Oi/CyN42A3LX8MIHcX4bdbsWE7rwFJX6wapr5/66xCO1oDBdA3eC /jnSCQU+HK8/iSgaPG1ojwPm5e2RORKbURQmq72K6/rC/FmTkDvRpHwq4LmyvLTjZfugZbIk6XU X9VyfjvQcPoniIhndyNH2vNfZ/7R36lSJspy+gkETGpzBq6u6aj7PHi6j5NY8cS5B8qie1jzfZj Pdr7C1Gb2zUPP2Qamp2x5UuDxV23rVhjOHxuG11K78IlwKYBE1o66ywcK+DygFk//rEVH9zgGuD c4Q8D5JppPBEBFOqG0fS7FAT7b+F4YAJqjDjaZM9PJfT74wVfAicJHlorxQS7teN2a0mVKP/QSl Juh2dyOjTvKGDJY509nfXn5Y84c1L3Dks+kFU0JoIwQR6w/lDLZiS/GSZKeiX977ejm28=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

This field is used to differentiate between signed and unsigned integers.
A following commit will extend its use in order to add support for non-
integer scan elements; therefore, replace it with a union that contains a
more generic 'format' field. This union will be dropped when all drivers
are changed to use the format field.
Opportunistically replace character literals with symbolic constants that
represent the set of allowed values for the format field.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 Documentation/driver-api/iio/buffers.rst |  4 ++--
 include/linux/iio/iio.h                  | 23 +++++++++++++++++++++--
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/iio/buffers.rst b/Documentation/driver-api/iio/buffers.rst
index 63f364e862d1..e16abaf826fe 100644
--- a/Documentation/driver-api/iio/buffers.rst
+++ b/Documentation/driver-api/iio/buffers.rst
@@ -78,7 +78,7 @@ fields in iio_chan_spec definition::
    /* other members */
            int scan_index
            struct {
-                   char sign;
+                   char format;
                    u8 realbits;
                    u8 storagebits;
                    u8 shift;
@@ -98,7 +98,7 @@ following channel definition::
 		   /* other stuff here */
 		   .scan_index = 0,
 		   .scan_type = {
-		           .sign = 's',
+		           .format = IIO_SCAN_FORMAT_SIGNED_INT,
 			   .realbits = 12,
 			   .storagebits = 16,
 			   .shift = 4,
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index a9ecff191bd9..745290bd9af4 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -176,9 +176,25 @@ struct iio_event_spec {
 	unsigned long mask_shared_by_all;
 };
 
+/**
+ * define IIO_SCAN_FORMAT_SIGNED_INT - signed integer data format
+ *
+ * &iio_scan_type.format value for signed integers (two's complement).
+ */
+#define IIO_SCAN_FORMAT_SIGNED_INT	's'
+
+/**
+ * define IIO_SCAN_FORMAT_UNSIGNED_INT - unsigned integer data format
+ *
+ * &iio_scan_type.format value for unsigned integers.
+ */
+#define IIO_SCAN_FORMAT_UNSIGNED_INT	'u'
+
 /**
  * struct iio_scan_type - specification for channel data format in buffer
- * @sign:		's' or 'u' to specify signed or unsigned
+ * @sign:		Deprecated, use @format instead.
+ * @format:		Data format, can have any of the IIO_SCAN_FORMAT_*
+ *			values.
  * @realbits:		Number of valid bits of data
  * @storagebits:	Realbits + padding
  * @shift:		Shift right by this before masking out realbits.
@@ -189,7 +205,10 @@ struct iio_event_spec {
  * @endianness:		little or big endian
  */
 struct iio_scan_type {
-	char	sign;
+	union {
+		char sign;
+		char format;
+	};
 	u8	realbits;
 	u8	storagebits;
 	u8	shift;
-- 
2.39.5

