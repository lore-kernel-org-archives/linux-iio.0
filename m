Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F834AF9F2;
	Fri,  4 Sep 2026 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531409; cv=none; b=KdhB3dyq5Zl/GEqVa5IbJVqwg/U0Feaeqgv6lNWMp9R+BvKbK4YaA1JqXwKklAupCVl8aFAmmt8rn9KzBen9bTtnLp5r1v/d9ZW/PwBel/WTqjNyvLITqMUi7y3Znb7gJvh2Nwp3BJgarZjz041w4NBw17HaAk6XYV8zrvW5qgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531409; c=relaxed/simple;
	bh=C6kVitUYJGPe5tGfS3y2hr4h73phfW6MRFgei643zKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=svH58CtWpdD3Rd5ROQNNhIWpWo/4PVH8XoP1SYfXqRLcFMD/st1mhdk/Lp11x0ab598KuGpe2JTOn/iieHuWOhYXUOmTzmLgApUrRhYcY1G34e9qzzGPfL4EmUgyd+48ZWOAHf0jgAUpHRw1v2f8Z1ZLCNJBsTW0C54YCdmTKJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qnoAV/uQ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qnoAV/uQ"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684Dgbq0332992;
	Fri, 4 Sep 2026 10:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=hMlHd
	fP911EjZ+zw3LGCw3e93G3IlmCtQHurZ5y4dMQ=; b=qnoAV/uQ0fnWpeSkqfbbf
	HlzFk5MmQkS+gs24HhHj7bUIg6ZbAy4qUQ2q4cyegeLpsGDKRtetKCTWVieHbsu8
	CNQM93SbmL0SYK7DYUlzWSCVMtofdIwh61gZITuIoa6zmDIExC7imf6zIv97HYHP
	mu9ySUwZW9L/Z2OSIvLq/t8zqccwTaYZcasymwhommK/iL2PmATrCfuo6aRUVcry
	ALowVtuAMII8sPaixs/S2xNC7197HPIhzHes2ta93/1kvNcSJGuINbGBhBf6fJKP
	s2HnYXQb02Fe11qYkSCRGYWKmd5e1iblNUIzvOWHA4nOeso9uc8td2iEA6kbj7PO
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gffkkmffk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 10:16:28 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 684EGR8I036424
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Sep 2026 10:16:27 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 4 Sep 2026 10:16:27 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 4 Sep 2026 10:16:27 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 4 Sep 2026 10:16:27 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 684EF2dL026210;
	Fri, 4 Sep 2026 10:16:19 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 4 Sep 2026 16:15:09 +0200
Subject: [PATCH v6 17/17] Documentation: iio: Add AD7768 Documentation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260904-ad7768-driver-v6-17-e4378f946bfb@analog.com>
References: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
In-Reply-To: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
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
        Michael Walle <mwalle@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788531302; l=10704;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=C6kVitUYJGPe5tGfS3y2hr4h73phfW6MRFgei643zKQ=;
 b=VwK/rymDrvyMrOGzT3UEOYqOmxpCFGO3j8NF7tBLU9BbhIYL88Fb6OydAFvz040GRONkg7mEt
 Alci0vVpx1IC7nTYhGuYRyH7+LX3Uhg84hWzocP88SY0gDqVhc1PPCT
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 5P6IFDxgTfDp_NV4oOQwN2WdnDSCqhz5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEzMCBTYWx0ZWRfX41CbdECZJLn7
 sglZjKSUHBXE4khQ6gnvO2zlNDUmsLf4dtDs00JR8Mp3S9xbASMzbPeGWOkHaRBjs/BB91RNnHN
 GDh238QyeKQTppkowuXT5LNgB618cCNrWy86HPzC7IqfFAYfVWbrooiBnszkLFQwv+zbEtFDv5v
 CIpbJBh3A1Gm+N3c+pdhJrC61+F7ZSOfwhsKKWpNx8IhdFo2O26T9+RKGh3k0CAUC19AnhpcpOA
 aXbE58zBvmdIoyRdm1RWQJbFiYLLiXJgcZ8qwGi81wuQgmEgsiyfKqp/iwQTeYbkIcD0eFxPSex
 Te7Ij2GwWKw0hWjxcUsYnOmKSjOj1RA8Hrs3Q71clD3ktI8L9hdKZba7vekMgJtb/EWn2VyEHcA
 lw77APVCDlGVwT7e7dgNHZLx+k6+edacNfovXMITiKCz/fwsfyp5behnKKfGhTUBKBwuKrbOHZZ
 yZXROPQ4+R5dVa1vXRA==
X-Proofpoint-ORIG-GUID: 5P6IFDxgTfDp_NV4oOQwN2WdnDSCqhz5
X-Authority-Analysis: v=2.4 cv=F6NnsKhN c=1 sm=1 tr=0 ts=6a9ad2bc cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=-vtaFOnmicWHHgfH-jcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEzMCBTYWx0ZWRfX1x42NKSyY8aS
 M5QoEDycy85qpzzb8KiJjroVD9v1QnHJ0Zd6XoNjJdvApWazcImtHRSfmyjZYbSpeHbgNleRAhP
 2GpGvxglSmd6gVuas53elvJk4ftZZYE4qC/IlLnHqtgGx260rIsW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1011 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040130

Add driver documentation for AD7768.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 Documentation/iio/ad7768.rst | 273 +++++++++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |   1 +
 MAINTAINERS                  |   1 +
 3 files changed, 275 insertions(+)

diff --git a/Documentation/iio/ad7768.rst b/Documentation/iio/ad7768.rst
new file mode 100644
index 000000000000..49aeff27b00a
--- /dev/null
+++ b/Documentation/iio/ad7768.rst
@@ -0,0 +1,273 @@
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
+Clock sources
+-------------
+
+The master clock source is selected using the ``clock-names`` device tree
+property:
+
+* ``mclk`` selects a CMOS clock on XTAL2/MCLK. CLK_SEL must be low and XTAL1
+  must be connected to DGND.
+* ``xtal`` selects a crystal connected between XTAL1 and XTAL2. CLK_SEL must
+  be high. The driver drives FILTER/GPIO4 high and keeps channel 4 on the
+  AD7768 or channel 2 on the AD7768-4 enabled to maintain crystal excitation.
+* ``lvds`` selects a differential clock on XTAL1 and XTAL2. CLK_SEL must be
+  high. The driver drives FILTER/GPIO4 low before enabling the LVDS input.
+
+GPIO4 is reserved when ``xtal`` or ``lvds`` is selected.
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
+GPIO4 is reserved when a crystal or LVDS master clock is used. GPIO0 through
+GPIO3 remain available in these configurations.
+
+Device attributes
+=================
+
+The following IIO attributes are available for each enabled channel:
+
+Voltage scale
+-------------
+
+.. list-table::
+   :header-rows: 1
+   :widths: 40 60
+
+   * - Attribute
+     - Description
+   * - ``in_voltage<N>_scale``
+     - Scale in millivolts per least significant bit for signed 24-bit data,
+       calculated as twice the differential reference voltage used by channel
+       N divided by 2\ :sup:`24`.
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
+     - Per-channel conversion delay. The driver exposes the sync phase offset
+       value in seconds with picosecond precision. Resolution and valid range
+       depend on the decimation ratio in use (see datasheet
+       Table 32).
+
+Device buffers
+==============
+
+This driver supports IIO buffered data acquisition through IIO backends.
+When used with compatible backends like the AXI ADC, it provides:
+
+* High-speed simultaneous sampling across all enabled channels
+* Hardware-driven data capture
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
index de91903b0b45..93eab996c529 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1663,6 +1663,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7768.yaml
+F:	Documentation/iio/ad7768.rst
 F:	drivers/iio/adc/ad7768.c
 
 ANALOG DEVICES INC AD7780 DRIVER

-- 
2.43.0

