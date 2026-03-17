Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EA43EAC62
	for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759845; cv=none; b=jYEzWtTkRd6cRcKaopQ2hvzVCz5Bdus3jUGXJctGMD9vDzgZlvTXWykS29Di26psnO0k+7zpGXRbwYmzahYjbfLJR4P5QR2tVy6MSo+xTWgIeRwIX4cLfuc4ZjhA0ypYTpn5206yVuLwy6WIrWFstLuSYhZFpsjnEK0YsGWOy1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759845; c=relaxed/simple;
	bh=3gJuZXgHzE2rXI2domcIKlpvuPEWhFJR3203rfyOu8M=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O11NAIZtYcnjgY6i4JbZ/BjlYfrhmfL8zMlEmZUZrAkeUVLQwkTwy2e2rA9+hHbUQ6o3Ut/gslM2vcgyyMLfusz676U7sCR1NKyGmlOdsjgpWm8pZXtZYTYmhaMyh//6wxZ4zSLPxgi2cw3OrYgC5TthSaJbQHdZ7WZD9I00NB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0xRNsv0n; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0xRNsv0n"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439c9bdc1eeso5803452f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 08:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773759842; x=1774364642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfDNVGPIN2le5n46HwmmKt51w/MhetLaeIkD5JM163s=;
        b=0xRNsv0nD+VHXoC38gnW3k1RGqDejLthpxdk2Nq0PserZeUBy6rE1UALNE6A2wlIWj
         +5Rj+yLWIlgVECggNZbAqTmVPZi2JSOvfZkaYe/ejcN3UoRZanBQmG0QKedQRnTBzOKp
         vrmx0ib/vackG7y4z5Jj5Rxa8XFLdQYobF7gWLgJtjXs6J2iyh6DhQWOwgUn58qKtqst
         Taj5Y+tfgUAD91TZwLqUJ0qZ+X0rdhUQnCmTBkjl65XqziTzP4pCam/HzvY4mTJmTFI+
         20NIz+91f1Rpx+By9fwaKPiO3cn/tDrbxb0ipsn8VOKsqRckt6zYNeIw5GPHK/yoGWYe
         Xw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773759842; x=1774364642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GfDNVGPIN2le5n46HwmmKt51w/MhetLaeIkD5JM163s=;
        b=rmu6Z9kfIlfgzf4rHa7b3Vib1Vl++4s5JhKugVSPoI9ch3BFCueR6loW+h8v+vGKTg
         6wGobQbT/cxljQZXzN01IZCmGjN6GujSrX+5c8/JrBddecoyJKn1YtVi3+2fMGZeMYjS
         ja4UuQaoP65Ct30gcDNLDRy576216ALFnWW1kqMdNkF3Oiik1U/z53L2pOKiIJPjXfa7
         5x6UhrLJQ7hfvCtykdHbrm7vrk/9Gr3Xc/mgdGJt7KArrJzLXuYzbEILV7O7095xsXzq
         pv4Qolu5BElBsqueNHB91Xlca0z6KxzjLskt1Y7KpyQLwg/zy8JV6/ZJNJyDetu+KCp7
         nD3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXspS3+TyTDw2aDoQnUu1o5KRwoVh+KIS16FiA7mgQMhDBikC6MC+WgzbKNQ+6+d0vk5k7K7aFtiqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5q0bHNthwYoMDfWXg8HzWE5tliCT7u8pls2h8yDL1NMxeINBR
	75n9LC3fkftR39GLzDA/SCeDk29Nx6j9lk3wBIZW6nzBTKreeh+fD+bIMflUiD3J4fY=
X-Gm-Gg: ATEYQzzjFZ2PXqOrkgpCTAlV4dD4HDyN+E6Dk7WRvM/NSqC2gpDTeBBl5AeTtSdjCYV
	VQposrNXho9LaJK63ka6qOkfPCERdpj801k8zkql8nfKE+z1AzuW8MyDohvN7o5B0p3jhfeADOO
	HTvmX3EQ0wEGcvMWqmGlQGbW1b365syF6hTmSwLV9lAIn0OkCCimMsZ9ZvbDG1HqZ68EYpfEep8
	1JlS+fIQCVPftMs5eroABLcANIjBuDfov5we8t7l+PnZy4VuWcnJ4jqr1Prd8hgv//JloYmAd+H
	nPfPFm9dP+NE76Aa5hGGdxJiZwxIcTJtJFxiBozfWCRW1bdYCr4WZ/HmkNDWse4xPHJjheXXu6f
	isIz0F90rt2nnRLtucmGXNdA6jUNjhyO5ywC5PfRqalmZ7uyx21bASvFCbo7VD1Fti66+Sw==
X-Received: by 2002:a05:6000:230f:b0:439:b79d:b99f with SMTP id ffacd0b85a97d-43a04dc0568mr31062236f8f.40.1773759842112;
        Tue, 17 Mar 2026 08:04:02 -0700 (PDT)
Received: from localhost ([151.37.101.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51852aa8sm89261f8f.15.2026.03.17.08.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 08:04:01 -0700 (PDT)
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
Subject: [PATCH v8 2/6] iio: Replace 'sign' field with union in struct iio_scan_type
Date: Tue, 17 Mar 2026 16:04:01 +0100
Message-Id: <20260317150401.3878294-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260317150316.3878107-1-flavra@baylibre.com>
References: <20260317150316.3878107-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2677; i=flavra@baylibre.com; h=from:subject; bh=3gJuZXgHzE2rXI2domcIKlpvuPEWhFJR3203rfyOu8M=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpuW1h1uYuWrYCw/6uqGVTi6n5o9bz5kSuOfvy1 L61H6lo4CCJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCabltYQAKCRDt8TtzzpQ2 X9qWC/9ql0gkurGhYbfnfbYoMG+f/91ADwASWY5YXLGiPA5G3QMNu/I+kMij7XDcyxiN6rA2CJu 7jYFCUtQD/AgLCiNvuI+8rkTLSUW5Ugy+xDso9bg+qZGNP9CeISr4yFfG8xj1CNmWQrFbWVjouz ROZ19D8K9+JkXvvV1JO9bjdGWOUnVaNKKTWTgM3ZUbfIEYk7xAA0UZG1Ngk7kYfjImit+LwmJl2 qeXkPBtfY9AJZb6mEzqFWLmnDBH1HJbuD73enxc4M41tQeq/rmSzefdNxay6ZSi2dEM5xW08Rz3 uOkiTduKfdhV4F+OhUIMrbu5gAUycX+9Kob/OUDsQYn3Y4qn8OTB99LzxMXbWD4LWQzLMA79dz7 h4XDvOXxuLrPOAgwzY98066xPi8wSVsk9zjgprt+0XU+U4sPM0VallOWJwLU8eOGvvA92+k7e0m 0n/5LFcO9JY9pq3GyZtILwcgn+5BjXMLUkc1Cl+sJC8nYIabutM+dsL8TysSpeHuby8n0=
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
 include/linux/iio/iio.h                  | 17 +++++++++++++++--
 2 files changed, 17 insertions(+), 4 deletions(-)

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
index a9ecff191bd9..d48a0ab01b8d 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -176,9 +176,19 @@ struct iio_event_spec {
 	unsigned long mask_shared_by_all;
 };
 
+/*
+ * Format values in scan type
+ * @IIO_SCAN_FORMAT_SIGNED_INT: Signed integer (two's complement).
+ * @IIO_SCAN_FORMAT_UNSIGNED_INT: Unsigned integer.
+ */
+#define IIO_SCAN_FORMAT_SIGNED_INT	's'
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
@@ -189,7 +199,10 @@ struct iio_event_spec {
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

