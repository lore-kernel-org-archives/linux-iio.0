Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EA747F793;
	Wed,  7 Oct 2026 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791384128; cv=none; b=rI2699uPJlMS4zyyALNOX6RRmy0OiOmdRmAPmayefB9Yr/N9WajRiGTDvZ7hmxi7EwVYDjAttGQPIDsE8GXNS1PU6LX3zU2PGh4/lfIE9pM+LoRx9zF1geHRMY760KwnY6z3dtMWXKPwGAjk8Wy+WWzAud2TIRc1fnLoUhvoBso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791384128; c=relaxed/simple;
	bh=gXvajI6GzObRwvMjgyeEqoXV7MnuP0WEg5kBk1+v4+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=VFlQikt66LxESgdK/XYHA4M6/GQogDNp/dTSET9I2HvWr85cJEUDaRmMSxfNCqsPjQfkQPEN6SAusCHSsx6VFSKCXGTrvmn95dl9cecsOKZcf7lVrXwA6r+Zi8w96csGLLN0OiF1jxEpwYIMKV64766ka3CV+22zl21vCrS3tmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ntR1wfXK; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ntR1wfXK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791384127; x=1822920127;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=gXvajI6GzObRwvMjgyeEqoXV7MnuP0WEg5kBk1+v4+U=;
  b=ntR1wfXKgPJGMI1xePiSXnctIc2raqtC4Fko/nmQKGd5oE7WBaJ5wmqV
   G9Af+r03JGWi+xrXCBM0jZir/GS8tL1MsHpC4E3iFwiKKIseNbvQNbrO9
   h/+Qt+p0UY5SlJVxR1o45ohxaEXPkw/ZXiRHwZHHMLb9CbFQLjkhARXeU
   j+7uHJirKxW6rjF21Jo6y6VCV0yXMbL6DtDf8aIhtacintKzrl3EpNqSc
   ZBXixMgjuXxfYu0Naxjbop5sXTGCx1oJ3n2lYYbc+apYhwURJZ8WE9xK6
   5IhnYK2V46pLCAZrm1CATDKv28252aAzGKBklSMOL20jgph1kHzsTjY4+
   g==;
X-CSE-ConnectionGUID: ksDJq+2hR7WM/FzRfIVEgQ==
X-CSE-MsgGUID: rXssK1nYSqOr/u1k9Tj3oQ==
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="231797356"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 07:42:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 7 Oct 2026 07:42:00 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 7 Oct 2026 07:41:57 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 7 Oct 2026 17:41:53 +0300
Subject: [PATCH v4 1/3] iio: core: add IIO_CHARGE channel type
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261007-pac1711-v4-1-6ef34d7a7947@microchip.com>
References: <20261007-pac1711-v4-0-6ef34d7a7947@microchip.com>
In-Reply-To: <20261007-pac1711-v4-0-6ef34d7a7947@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	David Lechner <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>, Ariana Lazar
	<ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791384113; l=4074;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=gXvajI6GzObRwvMjgyeEqoXV7MnuP0WEg5kBk1+v4+U=;
 b=lgoygvhH5v3gY17QOvXh55OdxyAdZalLyUnbxD0tvxCD+GZYAmQOoSvPOwGWfxhw9QwRn0uB/
 WGuFxgGtVMIDSyDA3InsweX5V9RGL6vriAm6g0pzm5jVbnAaZOY/x50
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

