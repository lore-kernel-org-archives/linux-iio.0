Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC81F3890FC
	for <linux-iio@vger.kernel.org>; Wed,  4 Mar 2026 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772611622; cv=none; b=H4NkNLPRBrQVdE6gOR7p1aM7Sx9cejc2OqTkXQtblcwCMmtXjUnzgEQfqrEvCkvLQUaB+tvSppJJghEhIDybSxhv/h09sBMQY0Al+uJUFv1DjLSf0nVCvoFRNQlwqMYy5zVguhViuYVukvwyNAOhroidjVHIVJjCE3EIPdfK6i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772611622; c=relaxed/simple;
	bh=+5kKHgCbfIr6HZ3Ur8u9/0KCgquM6MW/BxUYCxIK5I8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uq03lbxPHcwSkzsPEUSgsxqzjDt+Y8J9pea9L4XO9idABTM6RlEFNCuchrdM9IxnfAQVv1lbJGngv0GV7Gg1w9axBhacrp8HLexb32mbK3eRPQFg7hSMqPnsXmACzdx1OuFXBdCROFswsHr0JfuGe/3D4HL6tYcVtPW8pDoPgPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W6L+jXLz; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W6L+jXLz"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439b78b638eso3105880f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 04 Mar 2026 00:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772611619; x=1773216419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZaP3R+BOklF7RhKo03SxE9I1TxjdRO6hcgS5F2nTkQ=;
        b=W6L+jXLzrfAxTdt9qJK2kS95KWTgMwPeNVXelnWQZ7vfPf5oEKhEuM1WbMDrt1fHK3
         OVlSD5lWKuNkpZOzSJnzG0EoUDggKiWLGCsOxcn+aN3GH9wGruLma3n4HV4+b0hyj79r
         R28U0IDqJ0RkrC3HT/5/Gr2xM7klq1/l9ejwmtppB/1mDWVfeudlHVdV4VaD67PfefGg
         UH6NRM+ppS1YqnHcC7xWHYcmPfqbJzdSnIRco2GRJ6EV0wIkd3Ns2fATq2fnxVcHy83g
         GS2b3UqaCPEri3G0641v38t2NkH//D3fiVybckUOwPg1yNL5ZhUTTQwSeX0bLdxmmQQp
         CL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772611619; x=1773216419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tZaP3R+BOklF7RhKo03SxE9I1TxjdRO6hcgS5F2nTkQ=;
        b=Qh9hKZajbTDAJHKqJoN8na6+++X+0bD8NI/4vQohQ1gYErRYp09zkXuTWsYrfBhz01
         E1GCkyoAUAt08MOodo578SR1VXNXT2YafUpmCNK3mPDKuF6B/zkxPJziLJFc/sKJFoFt
         uAnhKvuKhZNFgcIQ7Sr5gK7DIkHMJbalmFLLUq1RHdI7eYB19M1WBGJzD/0JWqSSaB2R
         E05w2KLuSJX2NPXVX1yuKanjLNPT2UYbORHUxugext7qOq0Bl/pYGeIBwUVsQLNwnqds
         s1fFVUU5Ictsx/cXWrqifk73SLpAyxa1qde4sdEG9tSnKFfTb00c2Zz4XTotcaBPF1Ts
         eJpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVch7Z3V69M4/UJVR5EwtKltgt1qEH/kuVfUmKS1nUT41B5/Xy2TeLLbaUxF2rdry18MF/pq4LUOAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkgo5a+k64DHmu26nPz3wfgU4FsgYVhtuFamHYiRoelRpGfBCs
	qxRynvOuv5LzDOu2LBzb3IRf1Xo6OjZzoCjvsygIVUw4jTznmu4sLmbw1qHf9v5gzHw=
X-Gm-Gg: ATEYQzyEjq9Ds5Id/mRBWFapGtdVEJoMHqtLNNtfyZ8Zvh93bdTe2OrWrs0X1afXj98
	tGxQ0NgZvwp5s1a3wkHOYftjO8DXznCkjckm56/sqKu/Q9x9E3TIvGiIE9lFl4+6s4Bw6y3AmoP
	enu7+Pe9ipEDqX1MXMDEUrL+FBu0jQRWGtKdlzHS6NeIpuu3voMrYs2an3arw6K7U8pLeWd3JRT
	BCW4HRmbY6p/zfikk5Ige0ZfXtSWLHpgjx3LSMUgbJkLjcG6Kbojx2EBDfpcTeLPB0hPNJdoha/
	DVclfQn/0uw3IMTFXwc+XNhF+Cqv7qTljWWOCLNJQPbZ4FH64LAv36rB4Xg2Ks1mDUk3QBWcyBb
	RKgKSoxwEkdD071ty2CcNBVjNrHschw3GAwMCCDrvxbBgmWM28bLQ8SuKcoZjYM0qyrUz
X-Received: by 2002:a05:6000:1842:b0:439:b7c9:2efd with SMTP id ffacd0b85a97d-439c7fd3e2emr1972255f8f.37.1772611619243;
        Wed, 04 Mar 2026 00:06:59 -0800 (PST)
Received: from localhost ([151.19.177.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b485a0b6sm24871128f8f.39.2026.03.04.00.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 00:06:59 -0800 (PST)
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
Subject: [PATCH v7 4/6] iio: ABI: Add support for floating-point numbers in buffer scan elements
Date: Wed,  4 Mar 2026 09:06:57 +0100
Message-Id: <20260304080658.2844434-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260304080519.2844101-1-flavra@baylibre.com>
References: <20260304080519.2844101-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5093; i=flavra@baylibre.com; h=from:subject; bh=+5kKHgCbfIr6HZ3Ur8u9/0KCgquM6MW/BxUYCxIK5I8=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpp+ghK4q2jVvRC8PObm6sJmhgdvHZvM9gDB29A M83+5Wz02WJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaafoIQAKCRDt8TtzzpQ2 X6slC/0XZSNizAK3tm1OWubsiLQa5nXOJpvHb8jg/m4uuPzciIyRHz5Q6VL81bbV6rXDqwveI9V JMMwKIvxIqz3HHM6MpUb7MDs+684wwHXFPm7gEXnyGIDDZxAGKEo8n74oFNoNNIzjCbV6xbrxhx hkFnKjc9GTZ5lTafjFxmosZvRG7oy+CKZroTMpeISDq42O3oVO4GshAOE9oE3BsvNrqQafX/xMi 6XhmhSYWRSWohKrgrihmLluiSVYrdBKnC/7gRBKNne9afD9ZAax4kYIl/zXLqWGr6NVZt2kNLIn x7UPPY1bBu94mymOlJRbd5BqSszVUF8FBXRMttMPW5nSv6+nVZ2mLgLqo0RGW2Iimvxj0qLzK2l L4cl4SCvS3XGIjrsmRdbUMgIqLLgFyUlVjM2Mm9x8EbnpnE4ALxSJ++OYoW5L05gqZjtPdhtnjr 97mpjcraJwlz9FsJV0JVhRM02yG7UiPQD2Ag+CH6Zk8kadHcpnbpI/tWFQXtygssqsEnE=
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
 3 files changed, 22 insertions(+), 17 deletions(-)

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
index f36e6d00173f..2fc9c2951a9d 100644
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
-- 
2.39.5

