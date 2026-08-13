Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E41481648;
	Thu, 13 Aug 2026 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629512; cv=none; b=f14E8sF24SbirSWZuk1/vtEjrjaI4fwQz4+/uOIsB1GrzE7JMT91fCqBmcqeTH8PbUxP+J5CXUI/8xiWg+2VB7Y3GKiNkTOiXxLQ6LFRyCr5Pg3aeWTqK+rbmqPkoP1i8FCs68HZgmtG5P0WYcByTK1K7B67QPMRhsqLqinKeNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629512; c=relaxed/simple;
	bh=A/DEAakE0ROEa8wJFK1uJEHCCiy2SFC7S18g1ahfBF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=E00wDGnmZ7fUZ6En0EyYsWeIVR7JuFwdsPya7S/JASCiHUjVXMLFk2WpncHPs6JfYfBYtRCrBE8bZohE3vWockj8Coz+BezIMv2rFRhe7pcTNkpLhr00RP6Ax9MLZT+vE+abZ2X+q11g8aldJfLQbnyCnifOsC677mfhuMS22nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=lth2u2+C; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="lth2u2+C"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCdBXJ1876654;
	Thu, 13 Aug 2026 09:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=behPR
	wvmXFt3WByO+1AhdB1TniLCt4aIdt4XTcoJku0=; b=lth2u2+Cyugox1PxOvk4g
	i1Kxphg4GfkBYoTudRFLkbV5s7avYpZl8dprkRYPsd+xiTix2EFK0xoEAgOkzbMh
	vds+TXwOkwBbKDxArV9bOGM8gB5r+wRBq7wMgiSp+RSy77qqF1MxUWxw8R2I6JN+
	VrFa48qBc9sN78RCu2mFjjXOd5OLVY9cEsvbkgO01qYdr5AY0e35aS+r9bhc5crd
	/Vl0biEHnpx+0o7+togR4BPpMvKmBDWXygPXgEzUsfunREglEFAhVBvPUKVViu7P
	aQX77G2o8NNksxsIi95C8NbolFge8mhV+lpm8E4Uo102D6cdPrj+PhpT6ZAGnmSJ
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g1e4b0dca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 09:58:21 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67DDwKig024681
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Aug 2026 09:58:20 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 13 Aug
 2026 09:58:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 13 Aug 2026 09:58:20 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.60])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67DDvOwg006802;
	Thu, 13 Aug 2026 09:58:13 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 13 Aug 2026 15:57:07 +0200
Subject: [PATCH v3 14/14] Documentation: iio: Add AD7768 Documentation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260813-ad7768-driver-v3-14-cb554399ad26@analog.com>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
In-Reply-To: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786629444; l=9510;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=A/DEAakE0ROEa8wJFK1uJEHCCiy2SFC7S18g1ahfBF4=;
 b=HcjcalddGt4/egM7Q+ecr/y0K/SXyDJ1e81R0mxdFhPZdgXtMdt0sHT9PXFkEGyBUcu9Z3qBL
 RHNd5H2NcS0DGS9817ey9J4u3ihhosop8ARL3aeOc+50qTWCju0TbAU
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: GtQElIU_HuAIZZ3sfL0lAPw7UQw5ItW1
X-Proofpoint-ORIG-GUID: GtQElIU_HuAIZZ3sfL0lAPw7UQw5ItW1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfX2u+RxXsjFuIG
 V2WkZKwoWGZ0nI2l9iy9SBTYTcR10CQ1OEqUuw63Xn96UQm+f/XeFm5nG8rXAtTISLsClXBC+61
 LuuEy0BjxGm30X/DpCPWTHBu/E+ieBawPAZ57DlfcGKlBptNtgl6
X-Authority-Analysis: v=2.4 cv=ZZYt8MVA c=1 sm=1 tr=0 ts=6a7dcd7d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=oqaN6P3t42WLEIsmr8gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfX1/racxBy+Eg4
 5wCAYj/lorvrtgmeKMTjHQm7WNE6GsGddmD+YIMkqRP2diB8PZa3xXJsFJGjoqUST6OvmnvnwOJ
 enm82Fs+c1xi4fGwgY0vuFKjI1wODlfXsYUfKemCU2AmKWaZ8NUVFwDMES8zJ8dhFyjU+91+BlO
 7z+y4dKVXXtMGJbNbuW5FWs/CVNgn7UhmWRex29t/cz36fUTT2gmkR4txemrtm9r7mRlWvuNwwF
 2lgIj2Eot2YC1Gf7NlZVp8dYYLYOA8y1btlmyqDHuF3TyEG2I8ItmKdH0Bsxgx4S5u5NJ/MKSk7
 pxINHM9ECQo+g3c6evJpvJuIBxfJkV/JV77jbrTwKgr4IFeOdEi3gjrSv8E+BJ+ofmg+pzwRm6L
 UEEDa3LFxp3ndSR0YBw0wo8cqu6cJdM+oudRWLED0RFCPobtLIaAv0zg+zntzQv1PNSqh2x2w/6
 fcs5cOkJT64tSEXknqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130099

Add driver documentation for AD7768.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 Documentation/iio/ad7768.rst | 240 +++++++++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |   1 +
 MAINTAINERS                  |   1 +
 3 files changed, 242 insertions(+)

diff --git a/Documentation/iio/ad7768.rst b/Documentation/iio/ad7768.rst
new file mode 100644
index 000000000000..7c97179ff905
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
+     - Per-channel conversion delay. The driver exposes the sync phase offset
+       value in seconds with picosecond precision. Resolution and valid range
+       depend on the decimation ratio in use (see datasheet
+       Table 30).
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

