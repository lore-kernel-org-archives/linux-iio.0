Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D9E481FAA;
	Thu,  6 Aug 2026 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030965; cv=none; b=si2GS66DX1G4TdsrvRRdf+IAGHAKNWCSV6Ww32rstc7vWklTXnMP3Hi7OpqzVVfaErJBHLCFwE3xIGj0pqX6ituGPxSitqk/BzRLgNUZczJxfguIBQEtkcgEyBDPmKmSuNZsDVVgijo34lat+dnGCiwwKFtxCu6smladiBSIJGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030965; c=relaxed/simple;
	bh=1ks0MtrgN84/U8zlbSUjz1xlNJazOkeWgbKqYUkAVSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EN3ymf+v8rdpmf5lvFDxL6KBku/3eAj6DiaoD/YmjXQsXInnfqc28wk/UxYCyljfW3JjE1wVZNawipVI8l/ShnRbg9mNdQjdPlWv/3j5Yp1RL/g42H4CRw3fvogP3Kkk2X9pS32KABuAZzYb2HNyMwn5g6HPMc440W4FKgzynjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=m9kKXEBO; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="m9kKXEBO"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676EqFxG4057041;
	Thu, 6 Aug 2026 11:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=sA/3k
	O5fABjHCB/Pho9WiHGXh5c8p+Dcv4n7IGcE1ec=; b=m9kKXEBODcz3LUBBfHQ0B
	OxarrwDOjzudIteaUco/nfqvVIQrUaZFk2KWEjIuet308p+jt4gLw3bPXNc12Vtd
	MPykbVJAAxk0JWyEsfCIlwxLqrWIzerfJG+kEeX0tBJ+ZPT0oMU+AbDA4+zUfdP+
	SVtxl+1DDBWwZUDrCJAJ2q14fmFl+9SA6GTqjKoUMZtQV/lgKgOpWbBFk2hY0040
	QVn3+IRYBcQc0gUgtMqnxwi5wCkq6ZC8Bwu/q5R4Pv3e7KG7M8BCb0Ya7SDsqole
	AMBA/WxyNXA1fQrAUENPMJE4LibIwKld3u/r1HmwPY6JRR/Pn9Vo2AwtwFzO117k
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fvp4ttnpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 11:42:26 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 676FgPiL007059
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Aug 2026 11:42:25 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 6 Aug 2026 11:42:25 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 6 Aug 2026 11:42:24 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 6 Aug 2026 11:42:24 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 676Ffcge008127;
	Thu, 6 Aug 2026 11:42:17 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 6 Aug 2026 17:41:26 +0200
Subject: [PATCH v2 7/7] Documentation: iio: Add AD7768 Documentation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260806-ad7768-driver-v2-7-027ac5e2a641@analog.com>
References: <20260806-ad7768-driver-v2-0-027ac5e2a641@analog.com>
In-Reply-To: <20260806-ad7768-driver-v2-0-027ac5e2a641@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Michael Walle <mwalle@kernel.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786030898; l=9520;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=1ks0MtrgN84/U8zlbSUjz1xlNJazOkeWgbKqYUkAVSQ=;
 b=WEwqp5cAYph5mSeeK8qgLTJDXmVL+nDIiZmzYhJv06X/mBWMKzFboO1wyl4U5QDWCLl2Helgx
 6WwZa0A+cA9Bp2XjDhmSTKRg8NR+JiMrZExVqvg1hxTVkUzC/qF1p4C
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: xCZ-jQYlIyuDojCAXs5FnLsYneIuPHq_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyMSBTYWx0ZWRfX/m5C20pcmr8y
 8AynjfRp8GFUpg87QMfOVNJU5wpA2pUobsQlSq04TYRtu7zOs1xuU2H+/OKmIFVco7aIUu2icyJ
 hS2zE/+DdvGI6+K2uVPXY9lHhk9WNe944oABPBrHNwvjY2F1dtKip6Nc9sqh5TGmpT2skG2SeLe
 hUzg7Gi7b+T66v6aAb5GZGX2FvHcTOi7BzPVQ/gaROBco2w5pfliLXrYaFbXiXyC/MIwL9nKe2m
 Ea2aw44c50f+SKR4czBVHe8lE51lfmcevxgf1NdSNyizO+HmnzxTt5MiNghN8ty4rTOQuvx90Qk
 qVEewD9N3gKmQlsRVPkGdsQ3D/PhDysGKO2l4R5qg4k0xWnpDdIYmZrLsaaORtCX3aHNhm5nIv7
 P13VH+j1qyDySX4dsuCkyJoGogAaP5vqQ6UgleqYZGX/Z9P8R7MpLPZnXEoZb+UGBwwsZ239+n/
 pSvuMPBQonbjX6a762g==
X-Authority-Analysis: v=2.4 cv=CIYamxrD c=1 sm=1 tr=0 ts=6a74ab63 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=oqaN6P3t42WLEIsmr8gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xCZ-jQYlIyuDojCAXs5FnLsYneIuPHq_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyMSBTYWx0ZWRfX4rSZ7TJbaBZK
 FqWLRXYE5/Q6P24zLUGS4x3uBInvE2zfFp7ld6JhRb8sT3BpNI0xG+VTVvfkVqbjMzHmOFsvlRK
 NANs0LmWEOQsIvHFlgGFXmYfa/xrdj7s7KneVIZDGKzj7ric4/GV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060121

Add driver documentation for AD7768.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 Documentation/iio/ad7768.rst | 240 +++++++++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |   1 +
 MAINTAINERS                  |   1 +
 3 files changed, 242 insertions(+)

diff --git a/Documentation/iio/ad7768.rst b/Documentation/iio/ad7768.rst
new file mode 100644
index 000000000000..928d4dbc0fea
--- /dev/null
+++ b/Documentation/iio/ad7768.rst
@@ -0,0 +1,240 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=============
+AD7768 driver
+=============
+
+ADC driver for Analog Devices Inc. AD7768 and AD7768-4 devices. The module name
+is ``ad7768``.
+
+Supported devices
+=================
+
+The following chips are supported by this driver:
+
+* `AD7768 <https://www.analog.com/en/products/ad7768.html>`_ -
+  8-channel, 24-bit simultaneous sampling ADC
+* `AD7768-4 <https://www.analog.com/en/products/ad7768-4.html>`_ -
+  4-channel, 24-bit simultaneous sampling ADC
+
+Supported features
+==================
+
+Power modes
+-----------
+
+The AD7768 family supports three power and performance modes:
+
+* **Low power mode** - Optimized for lowest power consumption
+* **Median mode** - Balanced power and performance
+* **Fast mode** - Highest performance with maximum sampling rates
+
+The driver initializes the device in fast mode and uses the maximum fast-mode
+output data rate as the default sampling frequency.
+
+When buffered capture starts, the driver selects the lowest-noise mode that can
+produce the requested output data rates for all enabled channels. Where output
+data rates overlap, fast mode is preferred over median mode, and median mode is
+preferred over low power mode. This prioritizes the lower RMS noise and higher
+dynamic range offered by a faster mode at the same output data rate.
+
+Data output configuration
+-------------------------
+
+The devices support flexible serial data output configurations:
+
+AD7768 data lines
+^^^^^^^^^^^^^^^^^
+
+* 1 data line (DOUT0) - Standard single-lane output
+* 2 data lines (DOUT0, DOUT1) - Dual-lane output for higher throughput
+* 8 data lines (DOUT0-DOUT7) - Maximum throughput, one line per channel
+
+AD7768-4 data lines
+^^^^^^^^^^^^^^^^^^^
+
+* 1 data line (DOUT0) - Standard single-lane output
+* 4 data lines (DOUT0-DOUT3) - Maximum throughput, one line per channel
+
+The number of data lines can be configured via the ``adi,data-lines-number``
+device tree property. If omitted, the driver uses the maximum supported by the
+selected variant: eight lines for AD7768 and four lines for AD7768-4.
+
+Channel configuration
+---------------------
+
+Each channel can be individually configured with:
+
+Channel modes
+^^^^^^^^^^^^^
+
+* **Mode A** - First set of filter and decimation settings
+* **Mode B** - Second set of filter and decimation settings
+
+The hardware provides two mode profiles (A and B), each holding one
+(frequency, filter) combination. When buffered capture is started,
+enabled channels are grouped by their configured (frequency, filter)
+pair. Up to two distinct groups are supported; the driver automatically
+assigns each group to a mode slot and programs the hardware accordingly.
+
+Precharge and reference buffers
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Per-channel buffer control for optimal signal integrity:
+
+* Positive input precharge buffer (``adi,prechargebuf-pos-enable``)
+* Negative input precharge buffer (``adi,prechargebuf-neg-enable``)
+* Positive reference buffer (``adi,refbuf-pos-enable``)
+* Negative reference buffer (``adi,refbuf-neg-enable``)
+
+Common mode voltage
+-------------------
+
+The VCM pin provides a buffered common-mode voltage output used to bias
+the analog inputs. The driver exposes this as a standard voltage regulator
+provider under a ``regulators`` subnode in the device tree. Supported
+output voltage levels are:
+
+* (AVDD1 - AVSS) / 2 - Mid-supply (hardware default), reported as half the
+  voltage provided by ``avdd1-supply``
+* 1,650,000 µV - 1.65V
+* 2,500,000 µV - 2.5V
+* 2,140,000 µV - 2.14V
+
+The regulator can be enabled and disabled at runtime using the standard
+regulator framework interfaces.
+
+The VCM circuitry is associated with channel 0. When VCM is used externally,
+``channel@0`` must be present in the device tree and channel 0 must remain
+enabled in the active scan mask. Placing channel 0 in standby disables the VCM
+output.
+
+Filter types
+------------
+
+Two digital filter types are available:
+
+* **Wideband** - Optimized for wide bandwidth applications
+* **Sinc5** - Fifth-order sinc filter for high rejection of out-of-band noise
+
+IIO backend support
+-------------------
+
+The driver integrates with IIO backends (e.g., AXI ADC) for high-speed data
+capture and DMA operations. Features include:
+
+* Automatic channel enable/disable based on scan mask
+* CRC on data interface. CRC replaces the header every 4th output sample.
+* High-throughput buffered data acquisition
+
+GPIO controller
+---------------
+
+The AD7768 includes a 5-pin GPIO controller for auxiliary digital I/O
+operations. The GPIO pins can be configured as inputs or outputs.
+
+Device attributes
+=================
+
+The following IIO attributes are available for each enabled channel:
+
+Sampling frequency
+------------------
+
+.. list-table::
+   :header-rows: 1
+   :widths: 40 60
+
+   * - Attribute
+     - Description
+   * - ``in_voltage<N>_sampling_frequency``
+     - Requested sampling frequency in Hz for channel N. Enabled channels are
+       grouped into up to two profiles at capture time.
+   * - ``in_voltage<N>_sampling_frequency_available``
+     - Available sampling frequencies in Hz for channel N across all power
+       modes, based on the master clock frequency. Buffer setup fails if no
+       single power mode supports the frequencies requested by all enabled
+       channels.
+
+Filter configuration
+---------------------
+
+.. list-table::
+   :header-rows: 1
+   :widths: 40 60
+
+   * - Attribute
+     - Description
+   * - ``in_voltage<N>_filter_type``
+     - Requested filter type for channel N: "wideband" or "sinc5". It is
+       grouped with sampling frequency at capture time.
+   * - ``in_voltage<N>_filter_type_available``
+     - Available filter types for channel N: "wideband sinc5".
+
+Per-channel calibration
+-----------------------
+
+.. list-table::
+   :header-rows: 1
+   :widths: 40 60
+
+   * - Attribute
+     - Description
+   * - ``in_voltage<N>_calibbias``
+     - Raw unsigned 24-bit channel offset register value.
+   * - ``in_voltage<N>_calibscale``
+     - Raw unsigned 24-bit channel gain register value.
+   * - ``in_voltage<N>_convdelay``
+     - Per-channel conversion delay. The driver exposes the phase/modulator
+       delay register in seconds with picosecond precision. Resolution and
+       valid range depend on the decimation ratio in use (see datasheet
+       Table 30).
+
+Device buffers
+==============
+
+This driver supports IIO buffered data acquisition through IIO backends.
+When used with compatible backends like the AXI ADC, it provides:
+
+* High-speed simultaneous sampling across all enabled channels
+* Hardware-triggered data capture
+* DMA-based data transfer for minimal CPU overhead
+* CRC error detection
+
+See :doc:`iio_devbuf` for more information about IIO device buffers.
+
+Example usage
+=============
+
+.. code-block:: bash
+
+	# Read current sampling frequency for channel 0
+	cat /sys/bus/iio/devices/iio:device0/in_voltage0_sampling_frequency
+
+	# Update sampling frequency for channel 0
+	echo 8000 > /sys/bus/iio/devices/iio:device0/in_voltage0_sampling_frequency
+
+	# Read current filter type for channel 0
+	cat /sys/bus/iio/devices/iio:device0/in_voltage0_filter_type
+
+	# List available filter types for channel 0
+	cat /sys/bus/iio/devices/iio:device0/in_voltage0_filter_type_available
+
+	# Update filter type for channel 0 to wideband
+	echo wideband > /sys/bus/iio/devices/iio:device0/in_voltage0_filter_type
+
+	# Buffer setup fails if enabled channels request more than two distinct
+	# (sampling frequency, filter type) combinations.
+
+	# Read calibration scale for channel 0
+	cat /sys/bus/iio/devices/iio:device0/in_voltage0_calibscale
+
+	# Read conversion delay for channel 0
+	cat /sys/bus/iio/devices/iio:device0/in_voltage0_convdelay
+
+
+Unimplemented features
+======================
+
+* CRC message every 16 samples (CRC_SEL configuration) - currently only
+  supports CRC every 4 samples
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index b02b879b053a..73c58cec7620 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -29,6 +29,7 @@ Industrial I/O Kernel Drivers
    ad7380
    ad7606
    ad7625
+   ad7768
    ad7944
    ade9000
    adf41513
diff --git a/MAINTAINERS b/MAINTAINERS
index 3de7ebcc4ee7..b93c77d3a4c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1639,6 +1639,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7768.yaml
+F:	Documentation/iio/ad7768.rst
 F:	drivers/gpio/gpio-ad7768.c
 F:	drivers/iio/adc/ad7768.c
 

-- 
2.43.0

