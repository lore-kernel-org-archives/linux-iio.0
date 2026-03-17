Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C714E3EAC7E
	for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759857; cv=none; b=XU7R439Ff4+nv2gSE+qaeOD9SEVXHELjK+Q8WE84HtXduXPex6ZZSZWgh4gK2fuECg5ilihG5F2D0ZKxG/eKb0MTnvwrCqrLLetfWGv004AZcUtk/eC6y7oSNtO+Ax6wpd9fdzAVY7jRRTZmgWrK+3UzgdXe08l/i6n8y9IicW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759857; c=relaxed/simple;
	bh=nJstDZ/QxoZ2lCZSTohbFx88cUeNPJ2aHRDezpiEztg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CYdtNWzbDdOEQDGEfBZJcZT6Ah7dxz+hyyOUIORNUZMaRBP909ix+y+79s3bNphpg47kxEpesf1X8wN3siydsLex+pymrGUTVF/dqN3jGdlxMFFRijxfsAhmhiw54546CXZZfavlv9nxjqeauPWok+Ix3M6Jh831HTFZN/9ueJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vzGd9q3P; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vzGd9q3P"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so41562405e9.3
        for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 08:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773759854; x=1774364654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oof/EJX4ZjAg7qi0LTv1JyI3DSw6kCFAbKLxi0V35OE=;
        b=vzGd9q3P1man3wgFU8Ae/2FmCphz/ZIQYr9NxR3KvklRncYhwydgq2Fi5/OV745q1h
         1TVoWQ+G6hijXFGIvsCfNs3lE6xjFjHWwJys92XSwhQCBA30Kb/d/8abvK71UT/3/aYf
         FOHSScxLgqy+f6Clb/9qawXV08KHpTDuPhAhfLExztvvBAPX28ezB0M16lvBi0UN9HeU
         /j0C6qSm7fs/ogV1F7VUdMLzmhMqaB35YjVMs2MCCWCX07dQzRjI4TEbqWLFVhBVDhaE
         HdLKOSRVPyuICJy1ffHgr0j+bCIgjnGQjufpYtPyfguK6TNgNPkG0EAj/4cnffuYW998
         f+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773759854; x=1774364654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oof/EJX4ZjAg7qi0LTv1JyI3DSw6kCFAbKLxi0V35OE=;
        b=TolYZ7qsVxXoec8vz14Mt/VMt7ONUx8sAR3tFXHxqaBovAscMt4F5n8j2K9q2egjHs
         kDQCFaPtMmeqRJNwXxZNbh2gOwPQgDm4WTeyB7auJX29xw1U3+gt9jIh1ni5Nb62xJbO
         fQOrvtHsM1hj/SCfs9kp+8A6XVsed9J6sr+h66m/o73NdcIdFbs1bXd0du5tI2kuP38/
         9fbgqIGrSg4AA2lRk4uAiV+OXU8CG7HbZrCNkH4dGkrRxGvCFsUT4U7LqKk9/0QvwwEi
         b44OVfokhKiPEe3aKzHL8jQ+T9L2bm20RXKAXHYoo1v7azGIhrxbq1znJBRcg9iDK0xe
         eLWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxf/tzSrIOSK2gVgzg8tTxp18hh1vXjf9hJp0hdPtS6ZmqZ4B9slPCEKMqM1T2+Yto7RswXVOgmXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBBBYaI7UC927I66JPAXQiSgpGqZoEcKGzplYEQgS0bqOfcYMz
	+3VzYia1XxvymvEuUAnwANAn1WXMlJys/bFwuZtrj3tbh1kX2H0sO303SoGOMAtU7o4=
X-Gm-Gg: ATEYQzyMqVqmcuuDYZrRebOpObBxo6+D6QbYemArDOV3YfhoU+XXPmGUoV9I+XbteFt
	bLOTdQKfdffgdXI5XocR0ho2e0MTOF8ZZoqLsLnasKoE65ANxMpgPFjtn7NRMlFwF3DvfQAVrTV
	uo00gOisKjfl8cIrT5LTrT0AKNt9rmE4leDlvNP7qWcjaVnTGx+az+RWVmjgSV11lY1KBUcmdG1
	izC0q4qvWqEo6wdJLWMCxDSD4hX1NKj7hxohtPIVtAMYoIkRre3DrX92JN2f1OaNzEGkgw7ESRB
	spJs/f4IimTuiJCGoP26vgBJZc6bdgGvh7akSQVjN737r2QiRYnGHIS1ppw013NtUfShUyXWmsW
	qvdGOS6869QpwQKvoNQJThUKyNVO5jxXu8S7drqR1QYoroFkc6R+gzpjkfiM/CTnFFL1Rq7FsUt
	/nZHFOtrTKhH9FXg==
X-Received: by 2002:a05:600c:1388:b0:483:badb:618f with SMTP id 5b1f17b1804b1-485567050dcmr289431605e9.25.1773759854008;
        Tue, 17 Mar 2026 08:04:14 -0700 (PDT)
Received: from localhost ([151.37.101.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856eaeca12sm131699815e9.12.2026.03.17.08.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 08:04:13 -0700 (PDT)
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
Subject: [PATCH v8 4/6] iio: ABI: Add support for floating-point numbers in buffer scan elements
Date: Tue, 17 Mar 2026 16:04:13 +0100
Message-Id: <20260317150413.3878365-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260317150316.3878107-1-flavra@baylibre.com>
References: <20260317150316.3878107-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5769; i=flavra@baylibre.com; h=from:subject; bh=nJstDZ/QxoZ2lCZSTohbFx88cUeNPJ2aHRDezpiEztg=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpuW1t8z8jlx35g+4GGQ9DFdnRdXczS088/vY6/ 7I230SyTA+JAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCabltbQAKCRDt8TtzzpQ2 X77VC/4qIu1oMFG1fT+Ujce45VvyVrqPCWBtWmoJuSCMcE84ii/nMOAI8amjPmTrut/ZeSF3RMA tRQWc1HXiyrN9TXlLGFAI2I60729IxamVGmO2WN0qE/Xv1NcHsn2Vd/O1wZb+XhvD2ZKw3gcaTv 4Pr+X8uaNwof5k4AoCbIsXvuEyOxTU8bhQyDlsuPvTiQHqaYlC6p8SQv+agknLOP2lL4cg2AtTc o5/U248wVWXY7iTdCwL4h3QNY4ze7XLTs+eky4ZxO6a0+c2/gy8IcalxghC4LgB/5Im5BcpXvhL MhujgxqoGzmUBLB1bKMxMNPLDillRTPfcSBJkkuezC2Vs3M8iVcNQJh68teEBcsabsYGFi4fw5s 8g3TJ2rT4DIPWjiZa4MrZg8GtQiK0BR+7V2daqkH5HL5AUxsY5SXipYjcXY1JYxw3qj5shHK00O JGHJ+8hBqaWkz3aN9+YILQa++ryvU84lLiZinXyTbs8k4yEo0rk/OwYf4vmKA3XYt4/nU=
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
 include/linux/iio/iio.h                  |  2 ++
 4 files changed, 24 insertions(+), 17 deletions(-)

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
index d48a0ab01b8d..1f2c1cb03394 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -180,9 +180,11 @@ struct iio_event_spec {
  * Format values in scan type
  * @IIO_SCAN_FORMAT_SIGNED_INT: Signed integer (two's complement).
  * @IIO_SCAN_FORMAT_UNSIGNED_INT: Unsigned integer.
+ * @IIO_SCAN_FORMAT_FLOAT: Floating point.
  */
 #define IIO_SCAN_FORMAT_SIGNED_INT	's'
 #define IIO_SCAN_FORMAT_UNSIGNED_INT	'u'
+#define IIO_SCAN_FORMAT_FLOAT		'f'
 
 /**
  * struct iio_scan_type - specification for channel data format in buffer
-- 
2.39.5

