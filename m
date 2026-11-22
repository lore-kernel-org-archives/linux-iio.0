Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795329129;
	b=vvajIeQ86cmK4UGNvSgrfJpILZZEGdGMFLEcOJLxq0puzcL/ySslb2aMu0rikOof6ISi
	 NUxuT44V+QV/wg0urUxn8l7rglnnQpnUB4H2LP1e5ci2J0xMOrR/o3aYIhzgpTEi/SlaZ
	 rsuMWOg1Y6WMM9DYd8OVr3wTWmkFwfQksRvNEIvbwpWcfm4yqCKW2Qc3t/mWP+jfWFtw2
	 6Vf+mJx33H2GTky+a47jk4tHpbDUzBFPasm/ceMZ+ls6NMTIVUqugqmH8FJFYpykM2h83
	 nK2W5LZFaFpfo6n9Mgy6J0w5rp6e3hNMhhqG5W6OJLnwOCX+jPRfwbk6TwZZZ371jNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795329129;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Wsg3BjglTLTmRLGyC57EsYH3YV9hlJeE0KAaIAYSe7U=;
	b=kWRYhzEXWqEX5mzUIBOg/k2qtGfLae9vs6Qmk5GX/JBWKH6yXnB3CSD5YxHU3EY+llBX
	 4Xg712AeGhKL+LnrAvwXUwUdRQL5hvQzGWn+d/jMOKNYslWdBUPRjHUiAFb0WBI6wJWMd
	 nYe5CSmN9mVgwTfiZhyjfG814sYK3Nz79xnGa1XAIEZ8YTopvFsWTCWmI8jT/U7OivXqK
	 zY17CQEnlnRp5M2Vb9cBeoZsFT4hbO5676kC6qL9p7Ms/RpU3hUBxl7sFng4vdcqD7XYk
	 53Jbc6cYt7yKJbZSCKwy18Vfy7LqZZg4TRAYx1GD7Nwo/lHbBsjDNj7Z5XiByxnhJ8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="aBWG/Upu";
	arc=none smtp.remote-ip=91.218.175.156
Received: from mta0.migadu.com (out-156.mta0.migadu.com [91.218.175.156])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5745F606A320
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 06:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5745F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aBWG/Upu
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fy4214U4nEGoGa3smWlKi7CUDB4S9Rd1+HeWfT3oEV4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795329126; v=1; x=1795933926;
 b=aBWG/Upu9FKXA5cM+IgwH7+D8o/6PXis4xo3+rThp1+XEQVBH38impwhagJFd3X5iFWwKDv3
 lLvvpgpAj41fWEkaYbfyiZ7taIkWMKv0GBaA/zNmKoniCj0gNxrK+43okp7nVv61BxVv9fPYRF8
 8Kq3wOfMAYkh4V1NJZohZojk=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bfac500b101236c2;
	Sun, 22 Nov 2026 06:32:06 +0000
X-Mizu-Trace-ID: bfac500b101236c2
X-Migadu-Flow: FLOW_OUT
Date: Sun, 22 Nov 2026 06:31:56 +0000
From: Akhilesh Patil <akhilesh.patil@linux.dev>
To: jic23@kernel.org, andy@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, conor+dt@kernel.org,
	joshua.crofts1@gmail.com, maxwell@maxwelld.cc,
	u.kleine-koenig@baylibre.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com,
	akhilesh@ee.iitb.ac.in
Subject: [PATCH 1/2] dt-bindings: iio: chemical: Add aosong acd10
Message-ID: <45372cd111b6f23539227e6b568fd807a0b7cd91.1795326744.git.akhilesh.patil@linux.dev>
References: <cover.1795326744.git.akhilesh.patil@linux.dev>
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
In-Reply-To: <cover.1795326744.git.akhilesh.patil@linux.dev>

Add bindings for acd10 CO2 sensor. This sensor has UART serial interface
with 1200 baudrate and can measure CO2 concentrations in the range of 400
to 5000 ppm.

Signed-off-by: Akhilesh Patil <akhilesh.patil@linux.dev>
---
 .../bindings/iio/chemical/aosong,acd10.yaml   | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/aosong,acd10.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/aosong,acd10.yaml b/Documentation/devicetree/bindings/iio/chemical/aosong,acd10.yaml
new file mode 100644
index 000000000000..bd6bad01550f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/aosong,acd10.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/chemical/aosong,acd10.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: aosong acd10 carbon dioxide sensor
+
+maintainers:
+  - Akhilesh Patil <akhilesh.patil@linux.dev>
+
+description:
+  aosong acd10 is NDIR CO2 sensor with measurement range of 400 to 5000 ppm.
+  It provides serial interface over UART communication with fixed baud rate of 1200.
+
+properties:
+  compatible:
+    const: aosong,acd10
+
+  vcc-supply: true
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    serial {
+        co2-sensor {
+            compatible = "aosong,acd10";
+        };
+    };
+...
-- 
2.47.3

