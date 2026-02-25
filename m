Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A846B1E376C
	for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014673; cv=none; b=NQBbiZnTCGwtWjKXBEJtzkc6lxT2YI0aNvwOTn5oqzcZQJQremZty59yr+oL9v6fvJzYEbFrg43Au0vH8Yyn9EZ4h7sDnYVt/ee3D7uDP3RdZyJYukH54XJzZKogYDA/vtTTK1BqJUGFTtP+NP64Qr/zxg0Uc7sep4ROKYGKALs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014673; c=relaxed/simple;
	bh=OUTw+IZ7nvZ0bRHe3v+kMpcU/KJZUTpiBhUnfw/Y2E4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YoDKtbtMbIHcrYcnleDDFVnslJGSTN1TWIh79xupMFRqaJP1V4Q+t+fPrVgU8eWXPa3/jZnkagiZU4FfH68QOSUspmD0LjCMCiAAKS/OwRniYgox7BLRJBSqHjIt8gRARE/oayr0j0iKvDZvNbL34PNp+C4daDwJd1WzqZcsvkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wGt/ZSXe; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wGt/ZSXe"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43992e14638so167993f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 02:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772014669; x=1772619469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bfequrh/RHjbP4wgWQJnqugNFeY3tpsmLATDEKfrZHg=;
        b=wGt/ZSXeaKK2bd2szmFKTDid55d8mhegLtCBl/9DVcCneZUKiFuNF+l3fDD1y/5yWZ
         jhcDaVrM0boKjShJTMOsO5TLSLjZbr3Cyw79fLwBAm/kNsqh3a370RrMVOLpAwNQLpHN
         ochfcSJfOdoLt/JZYLJUplzECrxwBN+IaPOiRoZzLny7VNkQanmNWSEB+MRYBUZgDEl/
         QrwUOJlH2fnjv3jRokg40txdMyiZcaU7KXsCMGDfSXY/R5A+Ogk6FDXEDJGX4eU6ZCFr
         mwl2If91Mipa7NIMic1kFOIxWfrAEQ5AbcI8gePARS9Vhh2sBBr9qRsi4hEqgmOocJgH
         4MIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772014669; x=1772619469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bfequrh/RHjbP4wgWQJnqugNFeY3tpsmLATDEKfrZHg=;
        b=vBZ3Jhtcs16hHHykTDmtToUqu1XRCSSwtLr2XwM4aar67eFLqNSnz5WF1GEatGWK2m
         BqTHJkRAfkz6JzRiyDZLqeiHIzikWwGIK6KthRnn2jNWJ87T1WlqmYgJvuNhAf/SyPUU
         sEyIwDuuaY6i7bXyveeuUAsykC3uaHtxZwmiJo2+1tSCtI+i+jazVxNHzcUCZ62fjjV+
         mRaB1TS6cb67rO04GKksm1/988jIri078W7guwt0wMBFuPij1bdb3E0CGVYHU8QViIZO
         UnAeyGJoexL0dwTGpeEtq/TLiHSP4qWgma3P7YtE93z7/nxy11m1nWSbvOFuv0s/JYfB
         P0GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwi7Q5Wlt5EZ7CP1pKf+jW94fw2laaIStHG7Yw5RuTgbDxIhSC9T9Ek+xlDqarK1oo37Z3Ubjmoxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYJ7+aueRXVIMxIXlHYiRd/Zbsevm0dxznEhBA1hrufB4eYPrr
	PuWWBWn+BCq675f1p6QXzmCNVd+WcrtS/7UeH0m6R3Xqq5uuWb0TBjfYzHd5Pbn3RiU=
X-Gm-Gg: ATEYQzxXORTvXc8qmmIa8UlNqFqhmFHZ1C9ggiEs+CE8R9ksetD2TJatN1PtqS4vKoR
	sCK1lrwWyF86D6A+n8cJIh/g2uOpUWi7ahObPifhXBdg7qU1r1dDxvCeCN2tASeJ2yLzjE4O0fQ
	7x8dR41ZM6VFXPz0uMgJe/nujIw4GBfmrL4d/+JH7tXYYTOwu8NHoH64Lw+JfkQpx7p0gsn2Fth
	iwvVthXcnhccBVgyZZfhPwCYkqTqimw2bDf2UNRadY8zb9JDKGszvv9cOxylBis5g8MUGKdFYyQ
	xM2YhOC1WOdVcgtT9j1Ux+DKxMghxrineEOH64EztdZN6djglOsCaiXZidDjoVR8TIjkcSQMXfC
	9zrZse6u/v7nu+5j4GO/ggmIztPHiZppeVoLR/lX+GKzILG6wo9ixRtgWZKVumB8PI9ReUw==
X-Received: by 2002:a05:6000:250a:b0:431:c73:48a8 with SMTP id ffacd0b85a97d-4396f17b061mr27548223f8f.29.1772014668925;
        Wed, 25 Feb 2026 02:17:48 -0800 (PST)
Received: from localhost ([151.35.220.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399037aecesm3282900f8f.15.2026.02.25.02.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 02:17:48 -0800 (PST)
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
Subject: [PATCH v6 5/7] iio: ABI: Add support for floating-point numbers in buffer scan elements
Date: Wed, 25 Feb 2026 11:17:47 +0100
Message-Id: <20260225101748.2368295-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260225100421.2366864-1-flavra@baylibre.com>
References: <20260225100421.2366864-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5020; i=flavra@baylibre.com; h=from:subject; bh=OUTw+IZ7nvZ0bRHe3v+kMpcU/KJZUTpiBhUnfw/Y2E4=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpnsxL2KWraQGWFT7ps0G1BE/xWgXMxvGyYbf+w 0nHZei/3imJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaZ7MSwAKCRDt8TtzzpQ2 X6SdC/9nSberRI8aDPTLhZ/27D4R4qq2EwpOVEHwj25osFiAxJqIqhFzdlsoGfLTWk2nhuCpqOP Wq1xrXbq6yuRfwiUolNejqjmNto69BTt11geT6IbySiWQ9vm8HLy7MTS8jCcsPyBER5cq+AyIzY MXrtFTTPYnwLcoAVGNlQsCfOe6PhwxoXPq08bPFy/lZ6NALgxpuuZgozz7ZUK2+VKzD/tB1LjTR PCwj53+93gU+CMxyOUORHgO9kDokLHUrwSXxADsQGm4nBAJrzYduSog6fyWZJKcf63Vpuw3xVY8 PTW6HD8rsNBo9Ns7qA7J3I4i89PZAFOtXbRhZFF2MYpon8Ll/etAIV+fMt7DxGAE09Ei86BWBmI EBs/zpvGmLthmpmmf7c13s6Dl5XdFGf+etFKE93mOEdAWojGqvuONqQU393IzjrSv+kwaodfNEt EFA4qI/85+p4JOVPJce4bVE5cyczN0Hk+MmaIcxKZT4ixYgj4Q4YMnTOEbSak9uuje1tM=
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
 Documentation/driver-api/iio/buffers.rst |  5 ++--
 Documentation/iio/iio_devbuf.rst         |  3 ++-
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 5f87dcee78f7..61961bca4dce 100644
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
+		Form is [be|le]:[s|u|f]bits/storagebits[>>shift].
+		be or le specifies big or little endian. s means signed (two's
+		complement), u means unsigned, f means floating-point (IEEE 754
+		binary format). bits is the number of bits of data and storagebits
+		is the space (after padding) that it occupies in the buffer; when
+		using a floating-point format, bits must be one of the width values
+		defined in the IEEE 754 standard for binary interchange formats
+		(e.g. 16 indicates the binary16 format for half-precision numbers).
+		shift, if specified, is the shift that needs to be applied prior to
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
index 00398472ce59..43410b5053d2 100644
--- a/Documentation/driver-api/iio/buffers.rst
+++ b/Documentation/driver-api/iio/buffers.rst
@@ -37,10 +37,11 @@ directory contains attributes of the following form:
 * :file:`index`, the scan_index of the channel.
 * :file:`type`, description of the scan element data storage within the buffer
   and hence the form in which it is read from user space.
-  Format is [be|le]:[s|u]bits/storagebits[Xrepeat][>>shift] .
+  Format is [be|le]:[s|u|f]bits/storagebits[Xrepeat][>>shift] .
 
   * *be* or *le*, specifies big or little endian.
-  * *s* or *u*, specifies if signed (2's complement) or unsigned.
+  * *s* or *u* or *f*, specifies if signed (2's complement) or unsigned or
+    floating-point.
   * *bits*, is the number of valid data bits.
   * *storagebits*, is the number of bits (after padding) that it occupies in the
     buffer.
diff --git a/Documentation/iio/iio_devbuf.rst b/Documentation/iio/iio_devbuf.rst
index dca1f0200b0d..6d7e7dcc2d80 100644
--- a/Documentation/iio/iio_devbuf.rst
+++ b/Documentation/iio/iio_devbuf.rst
@@ -86,7 +86,8 @@ within the buffer and hence the form in which it is read from userspace. Format
 is [be|le]:[s|u]bits/storagebits[Xrepeat][>>shift], where:
 
 - **be** or **le** specifies big or little-endian.
-- **s** or **u** specifies if signed (2's complement) or unsigned.
+- **s** or **u** or **f** specifies if signed (2's complement) or unsigned or
+  floating-point.
 - **bits** is the number of valid data bits.
 - **storagebits** is the number of bits (after padding) that it occupies in the
   buffer.
-- 
2.39.5

