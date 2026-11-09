Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221093;
	b=0IC3LUnfKP7TeJY9dumqN5/aXgUF2UhWxwGZUfWwp850Lk8soHW6UwO9+6dRq+vpW/5Z
	 qwjFlwkESzyUqzYy2Rn1XEpH7xZ/rip68UF4Fh3f/bx1mzefodYqPn9ZnyAY4F9PdxbtL
	 d8MG6TRTdhzbT3Q0o89SkLa3nts5JhZrCBHNfrx7gBCpy+BnKrDNScRGCCBeFanA4ZkKb
	 BwN0wh0Sm5BQ7WucNSkEPxMJ0OIgU2xvnz183gsy4wIYUSmKduOF8q7UAPi8qJsEAHOj6
	 qnmDriq6y0zG3x4yfQy8zIqS3462Pm9FIexzEPuAVJhQSr17Ez/L+WGdO5jAWEQ90pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221093;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jhRpB/3L64OWgVCzI6g0N4mh7LrBuRu768BeFhov7Os=;
	b=BSoSL55lsU4jUh5pjqCAoY60D8TxxFefaFIflYqFzfVQhK42Q+dHqaobAuKmSaLEPhPv
	 J6O3UbMcyvd/qQyhftFb9j7GHB9u+i+18P2njixPMbhMio8V8Kf2VAbbvsYIXBvGTFxut
	 Kvxcynu1bMxcIhyhEmLTH3XA9LYUNpAETr7+uZ5lzT1S8PBKXDXEA0o6jkdp/VdcU0I7Q
	 aNT7BSXnBIu/ivO9zDjBoTPp0gT6vNKuugvCoFqaDcJ45QmSTSUx3Jz2tAVI27F1rl0e5
	 uPeVDACP5jKoY09RRfQa/tzYRrFtxXdd261tUvOaxoqVWwZ8WHpHAeY2vN2v57eLoMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HOjhnVfY;
	arc=none smtp.remote-ip=91.218.175.43
Received: from mta0.migadu.com (out-43.mta0.migadu.com [91.218.175.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAD5606A322
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 10:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AAD5606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HOjhnVfY
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=n9yUochbuHx8y/anYILHlFK/BKbY5H9S/STmPJZqyQA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794221089; v=1; x=1794825889;
 b=HOjhnVfYEClUjmyKsoac8lXoaH6LKyaEf/4JwcwlXSJOtwpIK1c83pIlmEymvLFacBUEh6R7
 YZuXoZy01D81CK+EPNHqEDiV+U82Ai0/YJ1DO+zZayEIIvXj5Pg4DlANmpWrwLdNHCRO32BoKok
 y9+TYo9cGtJND6iyEygCo5/0=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 941375bb5fe624cb;
	Mon, 09 Nov 2026 10:44:49 +0000
X-Mizu-Trace-ID: 941375bb5fe624cb
X-Migadu-Flow: FLOW_OUT
Date: Mon, 9 Nov 2026 10:44:43 +0000
From: Akhilesh Patil <akhilesh.patil@linux.dev>
To: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, crofts@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, alexandre.belloni@bootlin.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
	akhileshpatilvnit@gmail.com, akhilesh@ee.iitb.ac.in
Subject: [PATCH v2] MAINTAINERS: Update Akhilesh Patil Email address
Message-ID: <20261109104443.GA531570@u5ce4748bae3b54.ant.amazon.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109063924.GA118887@u5ce4748bae3b54.ant.amazon.com>

Move to my new linux.dev email address akhilesh.patil@linux.dev
I plan to use this email for kernel development going forward.
Also update email address in few yaml and driver source files.

Signed-off-by: Akhilesh Patil <akhilesh.patil@linux.dev>
---
 .mailmap                                                      | 1 +
 .../devicetree/bindings/iio/pressure/aosong,adp810.yaml       | 2 +-
 Documentation/devicetree/bindings/rtc/st,m41t93.yaml          | 2 +-
 MAINTAINERS                                                   | 2 +-
 drivers/iio/pressure/adp810.c                                 | 4 ++--
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/.mailmap b/.mailmap
index 7fb33babc931..54238d2f04dd 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1030,3 +1030,4 @@ Zhu Yanjun <zyjzyj2000@gmail.com> <yanjunz@nvidia.com>
 Zijun Hu <zijun.hu@oss.qualcomm.com> <quic_zijuhu@quicinc.com>
 Zijun Hu <zijun.hu@oss.qualcomm.com> <zijuhu@codeaurora.org>
 Zijun Hu <zijun_hu@htc.com>
+Akhilesh Patil <akhilesh.patil@linux.dev> <akhilesh@ee.iitb.ac.in>
diff --git a/Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml b/Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
index ad5f26ce5043..ca4d4210f609 100644
--- a/Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: aosong adp810 differential pressure sensor
 
 maintainers:
-  - Akhilesh Patil <akhilesh@ee.iitb.ac.in>
+  - Akhilesh Patil <akhilesh.patil@linux.dev>
 
 description:
   ADP810 is differential pressure and temperature sensor. It has I2C bus
diff --git a/Documentation/devicetree/bindings/rtc/st,m41t93.yaml b/Documentation/devicetree/bindings/rtc/st,m41t93.yaml
index bdd995c5c1f4..837679dc01ac 100644
--- a/Documentation/devicetree/bindings/rtc/st,m41t93.yaml
+++ b/Documentation/devicetree/bindings/rtc/st,m41t93.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: ST M41T93 RTC and compatible
 
 maintainers:
-  - Akhilesh Patil <akhilesh@ee.iitb.ac.in>
+  - Akhilesh Patil <akhilesh.patil@linux.dev>
 
 description:
   ST M41T93 is spi based Real Time Clock (RTC) with time, date,
diff --git a/MAINTAINERS b/MAINTAINERS
index 222b7fc2c3aa..3aa8fa3c068f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4095,7 +4095,7 @@ F:	Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
 F:	drivers/iio/chemical/ags02ma.c
 
 AOSONG ADP810 DIFFERENTIAL PRESSURE SENSOR DRIVER
-M:	Akhilesh Patil <akhilesh@ee.iitb.ac.in>
+M:	Akhilesh Patil <akhilesh.patil@linux.dev>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
diff --git a/drivers/iio/pressure/adp810.c b/drivers/iio/pressure/adp810.c
index 82aa433548d2..832df6ba0ee3 100644
--- a/drivers/iio/pressure/adp810.c
+++ b/drivers/iio/pressure/adp810.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2025 Akhilesh Patil <akhilesh@ee.iitb.ac.in>
+ * Copyright (c) 2025 Akhilesh Patil <akhilesh.patil@linux.dev>
  *
  * Driver for adp810 pressure and temperature sensor
  * Datasheet:
@@ -219,6 +219,6 @@ static struct i2c_driver adp810_driver = {
 };
 module_i2c_driver(adp810_driver);
 
-MODULE_AUTHOR("Akhilesh Patil <akhilesh@ee.iitb.ac.in>");
+MODULE_AUTHOR("Akhilesh Patil <akhilesh.patil@linux.dev>");
 MODULE_DESCRIPTION("Driver for Aosong ADP810 sensor");
 MODULE_LICENSE("GPL");
-- 
2.34.1

