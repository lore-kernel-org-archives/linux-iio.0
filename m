Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716676;
	b=AK/qvJyELXSA9jLVYQezHUyG5fuir+6akot+ZbhttNacuOfNCk6msw4t4UcvKCGAPs8I
	 K5CNXgNnEjVV4ym7jyIPPlTxXrgK4BGwdA/VU2JOs/1r6qUd1LLEHmwlcpO8UVLJxi8R0
	 Yzd/F2VT/UgY91Drc/WKzRtz21dccLVp1gFyjL4i60cpOYdx/9hNuUZDG2C+eY9SBtAPM
	 aIw3srHRwdqyTisjncvZr2GuRlue5fSwI+ydVFsZ5OuJjRjo4sFwgiumYfhdOphMfZonf
	 Vk3ECcRrLEQPCUSp+W7jJK00qbysDdL3kJM9Cj/ZcDfnfyYev0i0e2C3lTZUs1i3eOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716676;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=9aaHUaZ+v66t3YydydbToNbzzq2UxbY/jPxKZ6dEeQw=;
	b=YCPJf4u/3nfDTgSyhM1noPLFMFDnDwi24medJB6hSt7ixq86k2nrWIFPezHoqQaSIjBp
	 VMHY4STFAXjsyZD+y8kvAINtZuTxKQsLWjCXNCkWaGDwFVOpyq1c8y5v8+/+f8O7W3v6B
	 A48eS6A8Qlj+VbsYi7Iv178/V5mzhhbKU3O0ieX5tW7srpws/BBSyh3rJPgl+XuVVk7Aj
	 1slIo+z3+XMa+Yb2lvRh5K83XXwQFW8AAIOiY4PBhWnZgi74cbgX+7NRtx+pbCRl3FZb9
	 3ZEfkQydXjO37P8A30UsHcjbZwlw56340Kys4wOlPIjYsblf6bk3IdD+VPu+5sC/R+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=cOQyqPLz;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26600606A33D;
	Tue,  3 Nov 2026 14:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26600606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=cOQyqPLz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793716675; x=1825252675;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=gXvajI6GzObRwvMjgyeEqoXV7MnuP0WEg5kBk1+v4+U=;
  b=cOQyqPLzFtRJ7W4bwrDRod6/hWnhFPMWsGRBtYB2ezzT68mSS1hIjQGY
   tbqJh+gptXqfwchxh6GF/5U1fytRRayp6idqkExk3v3AR/uqc9SFkIusX
   4q5gQqBq1N1FFWVLkjcaapEu4zBaY13Afq24JmMqgtn3Sscfvm72i/kDT
   doD1oxlUkrzYHqOzA/XBs6dshqdrNaNBuSdXPx6Ul/Q7CbmDA4I2mO0Qo
   I2iadD71JvoGM0B1hwJnCuY/95CF5R4vg/5gnEPmpCSslEhMFtGaTCev0
   zdvg5tqLLr7vaYQGk1MUYlZa5veXQpMHLRo+Alu1DAgkPCKNfSKivfk4K
   A==;
X-CSE-ConnectionGUID: XoY6bCqIQH2mEUri3H6BCw==
X-CSE-MsgGUID: vfcH5ztgSFCXXQNzXelJ2g==
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="76535163"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Nov 2026 07:37:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 3 Nov 2026 07:37:55 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 3 Nov 2026 07:37:52 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Tue, 3 Nov 2026 16:37:12 +0200
Subject: [PATCH v5 2/5] iio: core: add IIO_CHARGE channel type
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261103-pac1711-v5-2-71c20101a52e@microchip.com>
References: <20261103-pac1711-v5-0-71c20101a52e@microchip.com>
In-Reply-To: <20261103-pac1711-v5-0-71c20101a52e@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	David Lechner <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, Marius Cristea <marius.cristea@microchip.com>,
	Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793716664; l=4074;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=gXvajI6GzObRwvMjgyeEqoXV7MnuP0WEg5kBk1+v4+U=;
 b=8ExPqrmrFAudI84YiX1903QSc1HX1G5kly6uwWd+dlw5hxjfsuTafuh7JvK55TO6zMBAiZGn5
 90MNnW1c+RwAjwtL+KeTftPqpctAZSpKbhgtErn27Bg/CFHPpNIYEMt
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Add a new channel type for Coulomb counters, which accumulate current
measurements over time. The sysfs attribute is in_chargeY_raw and after
applying in_chargeY_scale, the value exposed is in milliCoulombs,
following the SI convention used by the IIO subsystem.

This new channel type will first be used by the pac1711 driver to report
Coulomb counter measurements.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 13 +++++++++++++
 drivers/iio/industrialio-core.c         |  1 +
 include/uapi/linux/iio/types.h          |  1 +
 tools/iio/iio_event_monitor.c           |  2 ++
 4 files changed, 17 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index a4f5595722ade77e81b49efffc68c971e60a2e5b..3d569a2169c2100b3fc81d38bd63124fb8b67e84 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -510,6 +510,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflow_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflowY_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_charge_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_chargeY_scale
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -1781,6 +1783,7 @@ What:		/sys/.../iio:deviceX/in_energy_en
 What:		/sys/.../iio:deviceX/in_distance_en
 What:		/sys/.../iio:deviceX/in_velocity_sqrt(x^2+y^2+z^2)_en
 What:		/sys/.../iio:deviceX/in_steps_en
+What:		/sys/.../iio:deviceX/in_charge_en
 KernelVersion:	3.19
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -2509,3 +2512,13 @@ Description:
 		Raw (unscaled) volumetric flow rate reading from the channel.
 		To convert to standard units (cubic metres per second, m^3/s)
 		apply the channel's _scale (and _offset, when present).
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_charge_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_chargeY_raw
+KernelVersion:	7.4
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw charge value read from the channel. The device acts as
+		a Coulomb counter by accumulating current measurements over
+		time. Units after application of scale are milliCoulombs. X
+		is the IIO index of the device.
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 767a7794624a5026742087eb8885eb2a5ded05f0..90c92e57e8605d2ab443541b88944dab7084babc 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -100,6 +100,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_ALTCURRENT] = "altcurrent",
 	[IIO_COVERAGE] = "coverage",
 	[IIO_VOLUMEFLOW] = "volumeflow",
+	[IIO_CHARGE] = "charge",
 };
 
 static const char * const iio_modifier_names[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index d0fb714ca0fd97421d2c8345e3bc34329f1cb1b9..8acf4105216c11718c07f76ac67b93a8ba7fd6a0 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -55,6 +55,7 @@ enum iio_chan_type {
 	IIO_ALTCURRENT,
 	IIO_COVERAGE,
 	IIO_VOLUMEFLOW,
+	IIO_CHARGE,
 };
 
 enum iio_modifier {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index b5c5479b9d78f70cab9d6939ceaab32e42b3f718..50c12395767c0c91916eabc420c62631e834a4e5 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -67,6 +67,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_ALTCURRENT] = "altcurrent",
 	[IIO_COVERAGE] = "coverage",
 	[IIO_VOLUMEFLOW] = "volumeflow",
+	[IIO_CHARGE] = "charge",
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -198,6 +199,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_ALTCURRENT:
 	case IIO_COVERAGE:
 	case IIO_VOLUMEFLOW:
+	case IIO_CHARGE:
 		break;
 	default:
 		return false;

-- 
2.43.0

