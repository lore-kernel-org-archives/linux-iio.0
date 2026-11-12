Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.249
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794475010;
	b=1Afv0ouojg05dSmjChNxkD9PNvS8UTehsXmetavFaDOF1xykVug/+eX+uCoxlcMC9NcI
	 w1HLkaiDn0lyiet2Jk818qBa6boE5l0igJLKgfxMd3HDY4nlhOhV/dB0n1ktDNN90vS1G
	 /gW1z5ReuQhBZ7n8Kq+SnswQa6wokkDeJVY2wLvQLwnBSztPKRujsk/sB11eHn5Fk9VLk
	 meycAiKR/EVGesuXCZzzVWiO3Jo9iQAKYexHfBgkl5WhpurKs4EEL+6xb5cgdtwBaFZ5o
	 JbaONjcRLKDMSNMUqoLjUBhm048yqCInfAQ9SKn2T8B4tRQvhP1GndrWvGjYZILq0bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794475010;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=RcXvCoMdLJYi6GmDhM4JTvoDN/7C+KjmozZsvv6/OHc=;
	b=eLORijKZCVBbl7pclw1JsDu3/rQHlxW9e1neDCK5ce1vANMm6TnVgzCHwuqGa1tULMbp
	 9wfj0MTElZuhbFik90KLNeQSXvHSriHsNG7PwV/6zQPMwOFyCuQrPXVCJJLNxL29mKs/d
	 eFNZraSlUWshivJDg342tCit9zqQoe1m1MJtF7m4VCzK4S/ZCmSrcMI4VGcTGA2aVIZw3
	 kzAHbN4kSBUaKBO8Sa5DN4hB5Cpi0tAG3WUkvYqbSYTI9E1NQuk7ONjDHdOKmi5bR82Q3
	 Jmhuj910ohhppx9rx//yC0AUId1zZHvWuCL9Z2/F9/Rkm+s4WZU2dwxe7CbBrzXeg5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=G0skzQcR;
	arc=none smtp.remote-ip=95.215.58.249
Received: from mta1.migadu.com (out-249.mta1.migadu.com [95.215.58.249])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8257606A31C
	for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2026 09:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8257606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=G0skzQcR
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fMZgcVx/gcqBs5iDs68FHCDKO3Houx0xKhQ1tRogK+s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794475007; v=1; x=1795079807;
 b=G0skzQcRZvhQmpzT6BpJ79e6qOqGyfiEkD2kL9GvBKgraCOHgIiUeEWDWaeWJv2krpj3anyj
 12GW6VX9D3a6Qln7dK9V0RLd1W63QmlPl2fAmrhcJsAJgo18FHyfJ3QiYjoHTI/DYediXg0KUTc
 +4BCH8/komi6nPMXnF4+GWRw=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4b26efd512e022c3;
	Thu, 12 Nov 2026 09:16:47 +0000
X-Mizu-Trace-ID: 4b26efd512e022c3
X-Migadu-Flow: FLOW_OUT
Date: Thu, 12 Nov 2026 09:16:41 +0000
From: Akhilesh Patil <akhilesh.patil@linux.dev>
To: jic23@kernel.org, andy@kernel.org, krzk+dt@kernel.org,
	dlechner@baylibre.com, robh@kernel.org, crofts@kernel.org,
	conor+dt@kernel.org
Cc: alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-rtc@vger.kernel.org, akhileshpatilvnit@gmail.com,
	akhilesh@ee.iitb.ac.in
Subject: [PATCH v4] MAINTAINERS: Update Akhilesh Patil Email address
Message-ID: <20261112091641.GA3643677@u5ce4748bae3b54.ant.amazon.com>
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

Move to my new linux.dev email address akhilesh.patil@linux.dev
I plan to use this email for kernel development going forward.
Also update email address in few yaml and driver source files.

Signed-off-by: Akhilesh Patil <akhilesh.patil@linux.dev>
---

Changes in v4: 
- No source change.
- Added entire change log for all versions.
- Link to v3: 
https://lore.kernel.org/linux-iio/20261110052942.GA2505113@u5ce4748bae3b54.ant.amazon.com/

Changes in v3: 
- Fixed order of entry in .mailmap
- Link to v2: 
https://lore.kernel.org/all/20261109104443.GA531570@u5ce4748bae3b54.ant.amazon.com/ 

Changes in v2:
- Updated email ID in relevant device tree source files and driver source files.
- Link to v1: 
https://lore.kernel.org/linux-iio/20261109063924.GA118887@u5ce4748bae3b54.ant.amazon.com/

 .mailmap                                                      | 1 +
 .../devicetree/bindings/iio/pressure/aosong,adp810.yaml       | 2 +-
 Documentation/devicetree/bindings/rtc/st,m41t93.yaml          | 2 +-
 MAINTAINERS                                                   | 2 +-
 drivers/iio/pressure/adp810.c                                 | 4 ++--
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/.mailmap b/.mailmap
index 7fb33babc931..d09fd3708023 100644
--- a/.mailmap
+++ b/.mailmap
@@ -27,6 +27,7 @@ Adrian Bunk <bunk@stusta.de>
 Ajay Kaher <ajay.kaher@broadcom.com> <akaher@vmware.com>
 Akhil P Oommen <akhilpo@oss.qualcomm.com> <akhilpo@codeaurora.org>
 Akhil P Oommen <akhilpo@oss.qualcomm.com> <quic_akhilpo@quicinc.com>
+Akhilesh Patil <akhilesh.patil@linux.dev> <akhilesh@ee.iitb.ac.in>
 Alan Cox <alan@lxorguk.ukuu.org.uk>
 Alan Cox <root@hraefn.swansea.linux.org.uk>
 Aleksandar Markovic <aleksandar.markovic@mips.com> <aleksandar.markovic@imgtec.com>
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

