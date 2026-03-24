Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDCD3D88FD
	for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 08:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342077; cv=none; b=GGonoAsjYLUyzabvLC+ZS4AuhNgq+YqzcyY2t4Li/Y2ETMZgz+N/rfRO83ZyIm4GnSq0rqGsk6OjSfGb7asRJtgUbGF7ZnysjgGdrPe6vZtB6Ba2dDe8AOXV5zTSS4rS5VkkBftWfgXiOzEk3zfLIbgr40/PxvmgR0S8YB+QlJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342077; c=relaxed/simple;
	bh=xFpob9c+xdUrGxlB4E2lbBybpHAq+lDyjDXxB70k3Yw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z8oyvxtvdZilvDet62sDpfgCUgTMKyks0tnS274B0nITLG4Bmmswtvud38fEOf6EP3R9rFJ+vsENlV+iCL4MmmSKhoeytnTsS4zBB21h+wR612G9ffcmgfZ3MqjUkiQpe5DUzBCljhUosk63NsmhptbvxwvRVe5aVKg8nlQxO7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=apnL3AwH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="apnL3AwH"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-486fb14227cso9736095e9.3
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 01:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774342074; x=1774946874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eF1e1Cyy5V3LKfwsAPdeSvaTgNGlIqK/dZZ0MK0ok9s=;
        b=apnL3AwHZVba907nCL5CURBmZKXKIiIA/RtBTxo91xN49zSRRmAZhfYlKkZSoomKv5
         8FSQGZXdO6Emy8qhNttAZ/d16E4nxuLySaJA0AzOuFS+cqhg6OtkCyiNE5y+jAnghrrp
         2YojOkzB+BTOgsOY7DIxbLTvmrZn/Y/cdzRs0sq7mSZiDvNDAOanRcdlRhrK5ReCkvr3
         2N6+9iAWhOtxUcZgaKeoJbR5oitMoaRr/6IhASIXmqfHVfl6lcZPJdzNvoVqFeIf6SAf
         mWFXsWRpTYyZCt9rDNSTKlJqJnGr5QqzYz75heOaE00fH7VAq6IBKH3QDnrik4XZpkJB
         kSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774342074; x=1774946874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eF1e1Cyy5V3LKfwsAPdeSvaTgNGlIqK/dZZ0MK0ok9s=;
        b=Cm70ruH01+rtK6h5sfhcUowT65IruvU4eNxwZroqGvC6ekyh16KfZoRKtAvbSptmLb
         XbU9Cn2r+XtW3U776O1Z/mKaU/ZDS3jGNj/+5P2+120m4ig1OuXFqFj/zDU2mvJlj1/a
         up+DsG0wPZlFMIPicQCKWWmHKr3XlnX+vnjiAehnr0uL5qSZK/d+kYbVHeqJ8WnOjE4u
         fG/R2pRBUbTRSDgFNPPSDEIOu45tCMYI8mb4jYBDMv1AuDLt8yCoztZ2CCfMHibR3W2m
         UPsCQIB4UnptLR+F6UVQpKkIJs1QqzCBlm0YkaVd2dfONT7IeHtjNudPi+D2OITYBZlj
         GElQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbOeQOMzrabaoZyA5BEMtq21I/D34ushtfTu5adTeOdxR8Rn91WyZKzPCS/hTUEEL/JkavM6GOs2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkAh7RhK+fIW2DU7LpupA5xeoRUUQ/fQocnOZoxSgNuvm5M11v
	moTryvXdVMnNw6REG48bxvjUV3VXcFG+sHzx54CeA5+8eg5GXcEhKN689JaL/8haRGk=
X-Gm-Gg: ATEYQzzqU819mvt7TjgCMHYRCaphfefzbmyUONCm7xrPOAOSDLhJ9VXmdHIwC/z14Bs
	IhL6WBR/G6YaY5qUybRuFluu54jDinJb53Dr4fFaJAd3KJsB/p2uj5j3NCzWvruUmpUetYEQkx+
	p9N1MlIjepNHHiqW3S+PL/6gP2yds0S06qF9pnlk/5n4Pk1gyx/DJwVqdxfU7AZ8c09J2JJPlqr
	9eT5I1Y8PsN9nmpe3v609yB7FSxzIt2p6mGRleD+3EW+BCbdzJSfqL1It9pu8ev5a5lormTsE3J
	gWAucwEiJotNps6+oxrYvz9ylENLgOwqhjOiEvfqflmsIX1qe3yzEwo8FqRs72Xn3ghnY9MZoaI
	xIB9EnAj7FZCu/E6QV5DlGN2LiHo/XNOKP9fS75eJnLceN4M7vZreQ7wlbZY9YQe9PoE=
X-Received: by 2002:a05:600c:3b07:b0:485:4278:2558 with SMTP id 5b1f17b1804b1-486fedab705mr205574955e9.6.1774342074389;
        Tue, 24 Mar 2026 01:47:54 -0700 (PDT)
Received: from localhost ([151.43.230.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871105c7a5sm13620915e9.16.2026.03.24.01.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 01:47:54 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v9 4/6] iio: ABI: Add support for floating-point numbers in buffer scan elements
Date: Tue, 24 Mar 2026 09:47:53 +0100
Message-Id: <20260324084753.654037-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260324084655.653781-1-flavra@baylibre.com>
References: <20260324084655.653781-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5730; i=flavra@baylibre.com; h=from:subject; bh=xFpob9c+xdUrGxlB4E2lbBybpHAq+lDyjDXxB70k3Yw=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpwk+47k6zuOvuU9cHfiHzsxR9jkRQJzMMrJo3m Jv+TAeOEyKJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCacJPuAAKCRDt8TtzzpQ2 X57EC/43WSzXh5yhYFg1UnElcKGkaOMJShfdS/lwgczqeTfBJX3nWtBAGKO5qHT3g5BtxM6DpjF GA0BGtlK9AMIQKDY8G4fJuKl3S5S1ruusuJHMYzo5Ro040Llo7L0vpdQsQAiINabLg3nL4xfts+ iEk+xEJvusQ5aBPcHvf+EDOI9AAdcC+TMc5HVRmjWt2vw9yT+6hN0guZ8tB8blTHQ1kxCVifiTf ZuPak3ArdPOCgfCCU1DfS8AHfYtnqt7i2WdIY/fu4YzrzmHl6Vk9TuIaJO9Wz3iWYmW3vkC10Kd E29UnD4RPr5AhrXQXaD810MTg/sJ7Z5R70X7fTeU/WmBe4P3QbwDMqOYy2P3DiWXwRAK5pFVIEt IrimJoKIxV1JJZdAdme76Hd7a9DHrXTi92e7gSLZVyhdhUQflwWOg5ayxZodI5TKS+57O7RxL5k EMLCXLHrfdFH3KJQjaXMOKOzHqxBVAW+000wg/z/Kz3ihIYj3YN66UPh+26g03QJizqPo=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

In the data storage description of a scan element, the first character
after the colon can have the values 's' and 'u' to specify signed and
unsigned integers, respectively.
Add 'f' as an allowed value to specify floating-point numbers formatted
according to the IEEE 754 standard.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio  | 33 +++++++++++++-----------
 Documentation/driver-api/iio/buffers.rst |  3 ++-
 Documentation/iio/iio_devbuf.rst         |  3 ++-
 include/linux/iio/iio.h                  |  7 +++++
 4 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 5f87dcee78f7..bd6c3305dd2b 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1510,21 +1510,24 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Description of the scan element data storage within the buffer
 		and hence the form in which it is read from user-space.
-		Form is [be|le]:[s|u]bits/storagebits[>>shift].
-		be or le specifies big or little endian. s or u specifies if
-		signed (2's complement) or unsigned. bits is the number of bits
-		of data and storagebits is the space (after padding) that it
-		occupies in the buffer. shift if specified, is the shift that
-		needs to be applied prior to masking out unused bits. Some
-		devices put their data in the middle of the transferred elements
-		with additional information on both sides.  Note that some
-		devices will have additional information in the unused bits
-		so to get a clean value, the bits value must be used to mask
-		the buffer output value appropriately.  The storagebits value
-		also specifies the data alignment.  So s48/64>>2 will be a
-		signed 48 bit integer stored in a 64 bit location aligned to
-		a 64 bit boundary. To obtain the clean value, shift right 2
-		and apply a mask to zero the top 16 bits of the result.
+		Form is [be|le]:[f|s|u]bits/storagebits[>>shift].
+		be or le specifies big or little endian. f means floating-point
+		(IEEE 754 binary format), s means signed (2's complement), u means
+		unsigned. bits is the number of bits of data and storagebits is the
+		space (after padding) that it occupies in the buffer; when using a
+		floating-point format, bits must be one of the width values defined
+		in the IEEE 754 standard for binary interchange formats (e.g. 16
+		indicates the binary16 format for half-precision numbers). shift,
+		if specified, is the shift that needs to be applied prior to
+		masking out unused bits. Some devices put their data in the middle
+		of the transferred elements with additional information on both
+		sides. Note that some devices will have additional information in
+		the unused bits, so to get a clean value the bits value must be
+		used to mask the buffer output value appropriately. The storagebits
+		value also specifies the data alignment. So s48/64>>2 will be a
+		signed 48 bit integer stored in a 64 bit location aligned to a 64
+		bit boundary. To obtain the clean value, shift right 2 and apply a
+		mask to zero the top 16 bits of the result.
 		For other storage combinations this attribute will be extended
 		appropriately.
 
diff --git a/Documentation/driver-api/iio/buffers.rst b/Documentation/driver-api/iio/buffers.rst
index e16abaf826fe..8779022e3da5 100644
--- a/Documentation/driver-api/iio/buffers.rst
+++ b/Documentation/driver-api/iio/buffers.rst
@@ -37,9 +37,10 @@ directory contains attributes of the following form:
 * :file:`index`, the scan_index of the channel.
 * :file:`type`, description of the scan element data storage within the buffer
   and hence the form in which it is read from user space.
-  Format is [be|le]:[s|u]bits/storagebits[Xrepeat][>>shift] .
+  Format is [be|le]:[f|s|u]bits/storagebits[Xrepeat][>>shift] .
 
   * *be* or *le*, specifies big or little endian.
+  * *f*, specifies if floating-point.
   * *s* or *u*, specifies if signed (2's complement) or unsigned.
   * *bits*, is the number of valid data bits.
   * *storagebits*, is the number of bits (after padding) that it occupies in the
diff --git a/Documentation/iio/iio_devbuf.rst b/Documentation/iio/iio_devbuf.rst
index dca1f0200b0d..e91730fa3cea 100644
--- a/Documentation/iio/iio_devbuf.rst
+++ b/Documentation/iio/iio_devbuf.rst
@@ -83,9 +83,10 @@ and the relevant _type attributes to establish the data storage format.
 
 Read-only attribute containing the description of the scan element data storage
 within the buffer and hence the form in which it is read from userspace. Format
-is [be|le]:[s|u]bits/storagebits[Xrepeat][>>shift], where:
+is [be|le]:[f|s|u]bits/storagebits[Xrepeat][>>shift], where:
 
 - **be** or **le** specifies big or little-endian.
+- **f** specifies if floating-point.
 - **s** or **u** specifies if signed (2's complement) or unsigned.
 - **bits** is the number of valid data bits.
 - **storagebits** is the number of bits (after padding) that it occupies in the
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 745290bd9af4..97ac4961585f 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -190,6 +190,13 @@ struct iio_event_spec {
  */
 #define IIO_SCAN_FORMAT_UNSIGNED_INT	'u'
 
+/**
+ * define IIO_SCAN_FORMAT_FLOAT - floating-point data format
+ *
+ * &iio_scan_type.format value for IEEE 754 floating-point numbers.
+ */
+#define IIO_SCAN_FORMAT_FLOAT		'f'
+
 /**
  * struct iio_scan_type - specification for channel data format in buffer
  * @sign:		Deprecated, use @format instead.
-- 
2.39.5

