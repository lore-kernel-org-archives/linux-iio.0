Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7771E3876B9;
	Fri,  8 May 2026 11:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778241404; cv=none; b=sjPEMosOAZEeQAW8u5MXxwHx/NOaOM3PnOvmxM32Di2Na6IcI6gAMA85oMoJyJEJPO6MFmKJNOjVm1kq3SBPIBmK/bPK5so4Bk0TMuFz82VXCJ8SHrll93yHHGfLxmFVI3Fi6blQeQrNQqQhKY3BvnlAUw/HDp1YWWjUHlzAHsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778241404; c=relaxed/simple;
	bh=A4EvjdopgY7BdwJgIdAwC/H6osQr/asc66H7sL+dL8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FXX3gWQURcC5e2ln+5u+vIZuk82s/f01Du4vzC5fRMhQOG6Mnzi2j9wB9byjk5WpQWFEqA1O1ydO2d2Bar3vGrn+PeMXKQk6y+716DX3hBhFxVGf0cXRg6/GJjuQqXAk083grCbnSUN2GKCOlgSzJhTDq8WZpyeQJ7jnUzKLrX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=F/Lm9aTn; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="F/Lm9aTn"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6488wMTa3611574;
	Fri, 8 May 2026 07:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=r24Jp
	jwg36ksCTw9IK2Av40LXZMa5iXNUGtUidaMnnQ=; b=F/Lm9aTn5wtYNbMidsJpJ
	xxi58F+SkeC/aCFSbubH3t0Ov5XkA4t5iJ7xCLRWiDEWjJoTZmPgyERoeYQQmc5N
	nZQTm9hLBEwuUYGkOoZ6UQgGBbyogQBT5b/sn9SwOKi0XcafvQNXB77+R1guZYoY
	q94XBb3dSoiGT1/3f1HwONXfeCyINNJuwfhoL0wWMAhzpAEi2Y6crC/TJpHxOLuU
	YVLCkZ91t/LogRJqnUInOf1A4qTym24I7vtidwIrF8DVqba+JI8s+pXUB32lP9wM
	ylrKxgMYu/LfOoC4PebE9jbM0BjKRmPwB9MFfvBd6HL0xHeBERT8IhSkUkEMJYGB
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e04pjj6nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 07:56:14 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 648BuDdQ041484
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 8 May 2026 07:56:13 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 8 May
 2026 07:56:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 8 May 2026 07:56:13 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.80])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 648BtmnB001846;
	Fri, 8 May 2026 07:56:07 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 8 May 2026 13:55:49 +0200
Subject: [PATCH v2 3/3] Documentation: iio: Add AD5529R Documentation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260508-ad5529r-driver-v2-3-e315441685d7@analog.com>
References: <20260508-ad5529r-driver-v2-0-e315441685d7@analog.com>
In-Reply-To: <20260508-ad5529r-driver-v2-0-e315441685d7@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jonathan
 Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778241348; l=8455;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=A4EvjdopgY7BdwJgIdAwC/H6osQr/asc66H7sL+dL8A=;
 b=cRW8ZP+omiXR0KUdCBLMbZMJUEUDhjcx/2m4846+tS+qLFwWSp8MJsU9d6c3RxdiRMDz5AAgB
 cdQWQYfbW3JABiTiComfnTqwfJFKPf0+R2SIgbaDlsqGI21DJXwxTF7
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEyMyBTYWx0ZWRfX0e/LEMbGsWcD
 QMXNEO+xL8Lzz88EK0Pwlrt8CgKfRCTT9LTYtgN4OHSUfxF25Iep4xx0JLRuG8MSL8in/i09U5b
 xdHHZlPAC2ttygipD4KYkTHdnYp4mETrd1dhvHfuzL85Hx1VBdoF1cGpLClMJoRI6p6pl6EYdme
 qU46vZ9JaKBByfmtopRvEMti02paxnD1cO6CoycO7ySEzTwCdEiBq3mCGaf8k6HBMKcljRlZ/j9
 M2UwolqSt+ohmJST751bKc2qfLrX+A/T2ueHsyqeEXYfCA6kkwZaiED6U2G0Yzhq9oXw9Vxo86w
 wZCvE0fZWT5F/XC+YrDYCOIQFbq5DSMI9UU5mC8EDbsn20wkm3yATLMk1Ni6GhM3waEuxwBgEx4
 D72qOYBPnjq7o9pC4FXBo+fd3TpXkEsEF1XSDNwLFPbyzLOR1aSEMEf8lS+P1sHEL6S0YBPuXyh
 LDQDiT00A9eKVmE4eIw==
X-Proofpoint-ORIG-GUID: JkXRA8UhsGynLTouoaNhYJQ2EeFm6iGY
X-Proofpoint-GUID: JkXRA8UhsGynLTouoaNhYJQ2EeFm6iGY
X-Authority-Analysis: v=2.4 cv=Fss1OWrq c=1 sm=1 tr=0 ts=69fdcf5f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=zj84cDznfa0kqzTLJ-AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080123

Add documentation for AD5529R high voltage, 16-channel 12/16 bit DAC

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 Documentation/iio/ad5529r.rst | 216 ++++++++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst   |   1 +
 MAINTAINERS                   |   1 +
 3 files changed, 218 insertions(+)

diff --git a/Documentation/iio/ad5529r.rst b/Documentation/iio/ad5529r.rst
new file mode 100644
index 000000000000..41fea1521790
--- /dev/null
+++ b/Documentation/iio/ad5529r.rst
@@ -0,0 +1,216 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+==============
+AD5529R driver
+==============
+
+Device driver for Analog Devices Inc. AD5529R 16-Channel 12/16-bit High Voltage DAC.
+The module name is ``ad5529r``.
+
+Supported devices
+=================
+
+* `AD5529R <https://www.analog.com/en/products/ad5529r.html>`_
+
+Description
+===========
+
+The AD5529R is a 16-channel, 12-bit or 16-bit, high voltage, buffered voltage output
+digital-to-analog converter (DAC) with an integrated precision reference.
+The device operates from unipolar and bipolar supplies and is guaranteed
+monotonic. It has built-in rail-to-rail output buffers that can source or
+sink up to 25mA.
+
+Hardware Features
+=================
+
+* 16 independent 12-bit or 16-bit DAC channels
+* Independently programmable output ranges:
+
+  - 0V to 5V (current driver default)
+  - 0V to 10V
+  - 0V to 20V
+  - 0V to 40V
+  - ±5V
+  - ±10V
+  - ±15V
+  - ±20V
+
+* 4.096V precision reference (12ppm/°C maximum)
+* Built-in function generation capabilities (hardware support)
+* Output voltage and current monitoring (hardware support)
+* Temperature monitoring with 8 on-chip sensors (hardware support)
+* Over-temperature protection
+* SPI interface with CRC error detection support
+
+Current Driver Implementation
+=============================
+
+The current driver provides basic DAC functionality with the following features:
+
+* Basic DAC output control for all 16 channels
+* Scale attributes for voltage conversion (0-5V default range)
+* SPI communication with regmap support
+* Reset control framework support
+* Automatic hardware variant detection (16-bit vs 12-bit) based on product ID
+* Debugfs register access for development
+
+SPI Configuration:
+
+* **Mode**: Supports SPI mode 0 and mode 3 (default: mode 0)
+* **Frequency**: Up to 50 MHz (typically tested at lower frequencies)
+* **Word Size**: 16-bit transactions
+
+.. note::
+   The device default configuration uses address decrement mode (ADDR_ASCENSION=0)
+   for multi-byte SPI transactions. Therefore, all 16-bit register addresses are
+   incremented by 1 in the driver to access the last byte first, allowing the
+   hardware to decrement and access the complete multi-byte register correctly.
+
+IIO Attributes (Currently Implemented)
+======================================
+
+Basic DAC Control
+-----------------
+
+For each of the 16 channels (0-15):
+
+**out_voltageY_raw**
+  Raw DAC code (12-bit: 0-4095, 16-bit: 0-65535)
+
+  * Read: Returns the current DAC register value
+  * Write: Sets the DAC output code
+
+**out_voltageY_scale**
+  Scale factor for voltage conversion (millivolts per LSB)
+
+  Based on the formula: VOUTn = A × D/2^N + B, where A=5V, B=0V, N=resolution
+
+  * 16-bit: 0.076294 mV/LSB (5V ÷ 2^16 = 5V ÷ 65536 = 0.076294mV)
+  * 12-bit: 1.220703 mV/LSB (5V ÷ 2^12 = 5V ÷ 4096 = 1.220703mV)
+  * Read-only attribute
+
+Debug Interface
+===============
+
+**Register Access**
+
+The driver provides debugfs register access for debugging and development:
+
+``/sys/kernel/debug/iio/iio:deviceX/direct_reg_access``
+  Direct register read/write access. Format:
+
+  * Read: ``echo <register_address> > direct_reg_access; cat direct_reg_access``
+  * Write: ``echo <register_address> <value> > direct_reg_access``
+
+Usage examples
+==============
+
+Basic DAC Output Control
+------------------------
+
+.. code-block:: bash
+
+    # Set channel 0 to mid-scale (approximately 2.5V with 0V to 5V range)
+    echo "32768" > /sys/bus/iio/devices/iio:device0/out_voltage0_raw
+
+    # Set channel 15 to full scale
+    echo "65535" > /sys/bus/iio/devices/iio:device0/out_voltage15_raw
+
+    # Read current value from channel 5
+    cat /sys/bus/iio/devices/iio:device0/out_voltage5_raw
+
+Scale Attributes
+----------------
+
+.. code-block:: bash
+
+    # Read scale factor (millivolts per LSB)
+    cat /sys/bus/iio/devices/iio:device0/out_voltage0_scale
+    # Output: 0.076294 (for 16-bit) or 1.220703 (for 12-bit)
+
+    # Convert raw to voltage: voltage_mv = raw * scale
+    # Formula: VOUTn = A × D/2^N + B where A=5V, B=0V
+
+Register Access for Development
+-------------------------------
+
+.. code-block:: bash
+
+    # Navigate to debugfs directory
+    cd /sys/kernel/debug/iio/iio:device0/
+
+    # Read device product ID (register 0x04)
+    echo 4 > direct_reg_access
+    cat direct_reg_access
+
+    # Write to a 16-bit configuration register (example: LDAC_HW_SW register 0x19)
+    echo "0x019 0xAA11" > direct_reg_access
+    cat direct_reg_access
+    # Output: 0xAA11
+
+    # Write to DAC channel registers (16-bit values)
+    echo "0x149 32768" > direct_reg_access   # DAC channel 0 mid-scale
+    echo "0x14B 65535" > direct_reg_access   # DAC channel 1 full-scale
+
+    # Read back DAC register values
+    echo 0x149 > direct_reg_access && cat direct_reg_access  # Read channel 0
+    echo 0x14B > direct_reg_access && cat direct_reg_access  # Read channel 1
+
+.. note::
+   For 16-bit registers, use hexadecimal format for addresses (0x019, 0x149, etc.).
+   Values can be decimal (32768) or hexadecimal (0xAA11). Register addresses shown
+   include the +1 offset required for decrement mode operation.
+
+Device Tree Configuration
+=========================
+
+Basic configuration example:
+
+.. code-block:: devicetree
+
+    &spi0 {
+        status = "okay";
+
+        ad5529r@0 {
+            compatible = "adi,ad5529r";
+            reg = <0>;
+            spi-max-frequency = <25000000>;
+
+            vdd-supply = <&vdd_regulator>;
+            avdd-supply = <&avdd_regulator>;
+            hvdd-supply = <&hvdd_regulator>;
+            hvss-supply = <&hvss_regulator>;
+
+            reset-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
+        };
+    };
+
+For complete device tree binding documentation, see:
+``Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml``
+
+Driver Architecture
+===================
+
+The driver is structured as follows:
+
+* **Core**: Basic SPI communication and device initialization
+* **IIO Interface**: Standard IIO DAC channel interface with scale attributes
+* **Dual Regmap**: Uses standard regmap-spi for both 8-bit and 16-bit register access
+* **Reset Framework**: Reset control support
+
+Development Notes
+=================
+
+* The driver uses standard regmap-spi for both 8-bit and 16-bit register access
+* SPI mode 0 (CPOL=0, CPHA=0) is typically used
+* Reset control framework support for device initialization
+* Register addresses are incremented by 1 for 16-bit registers due to decrement mode addressing
+* Scale attributes provide voltage conversion for 0-5V range
+* Automatic regmap selection based on register address (≤0x13: 8-bit, >0x13: 16-bit)
+
+References
+==========
+
+* AD5529R Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad5529r.pdf
+* Linux IIO Subsystem: https://www.kernel.org/doc/html/latest/driver-api/iio/index.html
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 007e0a1fcc5a..27f2ab41f05e 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -25,6 +25,7 @@ Industrial I/O Kernel Drivers
    ad4062
    ad4691
    ad4695
+   ad5529r
    ad7191
    ad7380
    ad7606
diff --git a/MAINTAINERS b/MAINTAINERS
index 143714e27d51..41f42eb1adf2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1513,6 +1513,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
+F:	Documentation/iio/ad5529r.rst
 F:	drivers/iio/dac/ad5529r.c
 
 ANALOG DEVICES INC AD5706R DRIVER

-- 
2.43.0

