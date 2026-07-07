Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C19306767
	for <linux-iio@vger.kernel.org>; Tue,  7 Jul 2026 01:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783388770; cv=none; b=KxDEk/umnyoozjz+eDKZnejEOF65icL4PF/+vsWrvm1DcS8gFDgt+V8dnIo1U6k5ymGfREUn3x7gXnQ4YnlJ2jAXq1tMzCE8Uqx+bjhPHFVXyOMKni0c3F8feIPVKKDz+5m/Uco4t0znYeC/h/gsuJbdiEvOylsntUCL4ZR7iWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783388770; c=relaxed/simple;
	bh=7meUaKuU2Q1RBkqc02u7nsEtzX6X6Pdwx919/VCNUWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbuD2iMiPFC+QiFlpgA+YjZ6PmlWbf+8kYg3utxHkImbb7fqAqQheCxRW53lXdpGlGlAYoqqtlDR2CS+IaRWsBmX/IAjof7HKa6eG6bfBRSPXiwyV1MGQwwtFl157ZFZCVEIPwidRQaJGvsAK+NK+LVpv/Fh8UaodpVLVU7WuS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMxJQt7d; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMxJQt7d"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-845e363246aso4036969b3a.1
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 18:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783388768; x=1783993568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htSE8r5Xs9VRlATzK36xLHWjp23eo9yLUaW8SZpZEH4=;
        b=KMxJQt7dKUHodojPExpJOoS7o2MbbQrkty8Hfy0RXD6kAwpuLCvc/S0soTKsfI/nER
         0rLv5mkeYKYvqcTbR1oO4yhU1BsVJkKQlrC/+CLRpJRbZT7Is67Pbsl1lxvnUN0YNNIj
         mXwnw2EYZXBUm3WYLN1o6QSUoXHRovyk/wOMT7AiNBjY2PeeCuFJGfDTDJ3jR/j3mRJq
         mH7n+yVn/KPgYKZ9kg1juxLLE+NuwJG/ejW/3PNWsPDZuOTyyUcPGTJvWwEyYGi4DiXZ
         wRT8A1GeFwOWVTEK5H/3Vo54wDQqcd2u8PwMxzEVDlhOjzfiMFmhZnTIwU7V3eB4MpCK
         UT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783388768; x=1783993568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=htSE8r5Xs9VRlATzK36xLHWjp23eo9yLUaW8SZpZEH4=;
        b=EfKHn69gSKYGus8CMex3Ob5HLvYjPXb3oTgIGcyUJnanG/uEfgTXyreCzACTE3xmAE
         LglizXcMpsmHvYCa5IvoqlMMLfw+s1jJFO1dHk9kTdohocqQUc1Au8rUzpaHkMD7mRwr
         k22L6MtaHr2j3IL9cj22FWtquEuzFzXsoqjOqhNU3PlkYQkX200n4dvao9Z4pQ8061zE
         QZ6RFUZkgxMsCcv+5vmKjPbOf+emiLdQmcGi7iaAlyGQErtGGuZedJVzbFjD4pECgvkV
         Ro/T6WhXM1+8JjpPtyTGksdDzJ0N4KOlHdMgCkwt5eBfxqXk8k3q/GOog4RZoZjynhKM
         qLFA==
X-Forwarded-Encrypted: i=1; AHgh+RqwIzOpx/jYgLj20FZDW4Tfa6mtHPK1AthD13eIOllG4rhfKVzPGX/J9T71iCxtZwsYbkcD2T98wbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzYQ/NbjpFPxEC4BQmnrtS6zxq6RteAEWzIOakv0jmzYPnhDmo
	GM+GfYOYSXws1cxgGRs0qNKMHMMja5HmNsVAtopCl83z8VYbhQVtV20psLjTZgaCnjjPrA==
X-Gm-Gg: AfdE7cmg3850ezu49BB43Rlt5uacv5wBwtR4kg+lhfJYqqFlWYY8GFHksFuhUJPhg+P
	ufOrRxI2Wss1Jsw9qWoBmECFz0JiUPEvGhCfRqvrt/x1kM5rsVcdnGOnKkB5qa4YsBaIwPQX/mr
	3sOjZupn5/9U+fROYLybAgAP/UZ8Q8aSWtBtq7eyDrsegDg805wthiCKZ+v4JJX4+EpFOi82LHL
	cvtxwjCerJLZxpK54qBWqa/rQHdJ3zMB3QkCHKU5deJFVpLhevwgm3AUrS0BciQj75litbmWGAa
	gH1hYxv82k7fCQhyAThhx+r8uJGdC8uINbuqbK1f9txekqlR7wIe+6cg4KGqE0NNnGLTA37cfsA
	ECox20MWkeodoC2ScCTgwX52U/lWLPgTK2c+Hc6/R0Ze4RLavJKhQ+8UYuR3I/0mBMr4IYS/4f2
	65HjmSMcxfmss8vLiBZ5QNd2g++yFTXi+58P5G2mCXlKnDpMsKTpgPun/s1tLjWaEwVDFZOR66R
	s/KsWZZ2bL/kWWJrL693PkWw8Nmlb/zCOKjoy4=
X-Received: by 2002:a05:6a00:90a2:b0:841:dc8d:8066 with SMTP id d2e1a72fcca58-84826cdc329mr3154757b3a.39.1783388768353;
        Mon, 06 Jul 2026 18:46:08 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d4e741sm4645653b3a.28.2026.07.06.18.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 18:46:07 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jinseob Kim <kimjinseob88@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/5] Documentation: iio: add Open Sensor Fusion driver overview
Date: Tue,  7 Jul 2026 10:45:22 +0900
Message-ID: <20260707014525.1015-3-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707014525.1015-1-kimjinseob88@gmail.com>
References: <20260707014525.1015-1-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the Linux IIO mapping for Open Sensor Fusion devices.

The overview explains that sensor channels are discovered at runtime
from mandatory capability reports. It also documents that OSF0 is a
wire-format detail and that protocol_major and protocol_minor carry
protocol compatibility information.

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 Documentation/iio/index.rst              |  1 +
 Documentation/iio/open-sensor-fusion.rst | 72 ++++++++++++++++++++++++
 MAINTAINERS                              |  1 +
 3 files changed, 74 insertions(+)
 create mode 100644 Documentation/iio/open-sensor-fusion.rst

diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index ba3e609c6..2713ec5e0 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -38,4 +38,5 @@ Industrial I/O Kernel Drivers
    adxl345
    bno055
    ep93xx_adc
+   open-sensor-fusion
    opt4060
diff --git a/Documentation/iio/open-sensor-fusion.rst b/Documentation/iio/open-sensor-fusion.rst
new file mode 100644
index 000000000..c28886f3b
--- /dev/null
+++ b/Documentation/iio/open-sensor-fusion.rst
@@ -0,0 +1,72 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+Open Sensor Fusion
+==================
+
+Open Sensor Fusion is a sensor aggregation hub interface. The Linux IIO driver
+receives OSF protocol frames from an attached device and registers matching IIO
+devices for the sensor classes supported by the driver. The actual sensor
+channels are discovered at runtime from mandatory OSF capability reports.
+
+This document is a driver-facing overview for the Linux IIO mapping. The full
+wire protocol, firmware behavior, and hardware model details belong in the Open
+Sensor Fusion project documentation.
+
+Device Model
+------------
+
+An OSF device sends binary frames from the device to the host. Devices using the
+``opensensorfusion,osf`` compatible are expected to provide
+``CAPABILITY_REPORT`` messages so the host can discover which sensor streams are
+available. Device Tree describes the attached OSF sensor aggregation hub; it does
+not enumerate the individual sensors discovered at runtime.
+
+The currently supported Linux subset exposes:
+
+* accelerometer samples as ``IIO_ACCEL`` X/Y/Z channels,
+* gyroscope samples as ``IIO_ANGL_VEL`` X/Y/Z channels,
+* magnetometer samples as ``IIO_MAGN`` X/Y/Z channels, and
+* temperature samples as ``IIO_TEMP``.
+
+Protocol Scope
+---------------
+
+The driver supports OSF protocol major version 0 for the IIO receive path.
+The current wire magic is ``OSF0``; that string is a wire-format detail and is
+not the Linux driver identity. Device Tree keeps the generic
+``opensensorfusion,osf`` compatible rather than naming a product such as OSF
+GREEN or a wire magic value.
+
+Protocol versioning is carried by the ``protocol_major`` and ``protocol_minor``
+fields at fixed offsets in the OSF frame header. The driver currently
+supports ``protocol_major`` 0. ``protocol_minor`` changes within major version
+0 are intended to remain backward-compatible within the fixed header layout.
+Incompatible wire-format changes require a new ``protocol_major``. A future
+device that cannot expose compatible version discovery through that fixed
+header layout would need a different Device Tree compatible.
+
+The Linux driver handles device-to-host frames for:
+
+* ``SENSOR_SAMPLE`` buffered and direct-mode sample data,
+* ``CAPABILITY_REPORT`` based IIO device registration, and
+* ``DEVICE_STATUS`` cache updates.
+
+Vendor-private message types are ignored. Command transport, calibration
+control ABI, fusion output ABI, and runtime capability removal are outside the
+Linux IIO receive path.
+
+Timestamps
+----------
+
+OSF frames include a device-side ``timestamp_us`` field. Buffered IIO samples use
+an IIO timestamp captured on the host when samples are pushed to IIO buffers.
+The driver does not correlate the device timestamp with the host IIO
+clock.
+
+Compatibility Notes
+-------------------
+
+The project protocol documentation should define the compatibility rules for
+reserved fields, optional flags, and trailing extension data. Until those rules
+are finalized, the Linux decoder keeps conservative bounds checks around the
+currently supported message layouts.
diff --git a/MAINTAINERS b/MAINTAINERS
index e4df9d8dc..17c80b55b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20015,6 +20015,7 @@ OPEN SENSOR FUSION
 M:	Jinseob Kim <kimjinseob88@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
+F:	Documentation/iio/open-sensor-fusion.rst
 K:	opensensorfusion
 
 OPENCOMPUTE PTP CLOCK DRIVER
-- 
2.43.0

