Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619AE401491;
	Thu,  7 May 2026 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778171361; cv=none; b=b3WuIkwZbJjr7ShotKcDWiUgWK+T8eQFXAh+prPWJrXTLNNSwnYMVr+/0tzvaBZ6NIlY3ZFSCgb2tjdctKjrr3uuu69qkI7pygFHFea91g6fi7LtvGvFRxcjl9eYVjsllmC12Ngq/7mqowfaC18QotVSF0NHwgB2qbzZl1WaLJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778171361; c=relaxed/simple;
	bh=P9mXeJgXu3G094Z1prlgsGiO5LkUGbIg5tek83BKT0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=pMlVMV1Aiy5U3s3ZIvp3amInIHMkuYDWXjgEmmSmni8wwAz5bvK4BT2IJAiuOvz6ecDv9fzoNaoOyUax6k4ul3DCZcB8uxDWITXTgrki8cEnrkqQaYIkrB2MPmNW2hXzn4beEvPOrA6RwCL9SrqrJ/Uzxz5mA4qD1zqiY6Et94I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=i8g0tAv7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="i8g0tAv7"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647Eowd82002948;
	Thu, 7 May 2026 12:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=BWBQP
	8Qt6lKY3NoXv3Yso6JZ3IttCVoyJv3A637tjUg=; b=i8g0tAv7IYqXUbDr8d8uR
	ybDBgII4yLN7uy/CwAC2r7SHQn0AGkeUbUF2sQB++W/2dTTN/7skHHbppCqjf2I3
	oP6xlIUDua+U4GKokWv9wp4st8bAMfkRMSJkgfRdyOKEd6AyErjA+C2NA1+5IH/q
	00dBVSl12ofC7cgELStKAf7sK/nToKA6pvlr/6HOPJvzJEB/qLBZMe3VjUP1O4WR
	m50ZAtdvsVxFxSIiPls1wbq+NtpO7Hh6Asbotd55hnrdMejYpCjK6MwiRzjbt6OP
	0bFCqKpEo6I5a2S7Cw6pvK7ge5FWpDZCsdSRnoBqchTKMapvjUMfvNNT08tNPsRU
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4dyv3r802p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 12:28:50 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 647GSnsY021393
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 May 2026 12:28:49 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 7 May 2026 12:28:49 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 7 May 2026 12:28:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 7 May 2026 12:28:49 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.4.71])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 647GSMkO030829;
	Thu, 7 May 2026 12:28:41 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 7 May 2026 18:28:11 +0200
Subject: [PATCH 3/3] Documentation: iio: Add AD5529R Documentation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260507-ad5529r-driver-v1-3-b4460f3cb44f@analog.com>
References: <20260507-ad5529r-driver-v1-0-b4460f3cb44f@analog.com>
In-Reply-To: <20260507-ad5529r-driver-v1-0-b4460f3cb44f@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Jonathan
 Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778171303; l=8473;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=P9mXeJgXu3G094Z1prlgsGiO5LkUGbIg5tek83BKT0w=;
 b=aBAOCS6o93MnVTsO/7AtCOgVnf/+6gdxCgWrp39jNFCNtJJf6AcdCEWo08C3e8EcNzNPHoG0u
 Qme/VqJbcghCgFnnaUjQJy6XBJZd0nvl6Al5j3NmhtZnzKfkQMk/ibS
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=O7UJeh9W c=1 sm=1 tr=0 ts=69fcbdc2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=zj84cDznfa0kqzTLJ-AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dmxF1QgIyfKflIBwFpCt8EYsiL2KlROi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE2NSBTYWx0ZWRfX4DNozq/QCl+u
 fVtZ037n+PXBq5lWApQdQxcFHMk/a3ayJJqd3l1BuSjlco2UoJ1Wp81Wgh8w4v7G6gyT8hryl8F
 YGZ5dbg6NN5gSs3mQd2u9q6hPIVtxmKdLU2Cl3unvtxb3+S7JBYycAseGmBK3tQf0Opcr/E02xb
 skkvW9Z2FTFI72pQ5nDApqbcUfwCw0QeEsoPiLEzNk/HCk4FGoMSe29X3dcrr+kB49kOA6TzoUr
 pAxQmPmDCez1DPdFmdLetbkDmAoMly0uPNMsQAxwjQoZFLWqfDaSuPJw5g+vp6NaiHGk9UJsHbA
 CN6SVQWIFiLiY6WRnrjZKCEZTin9hPSYPcRaHBYI9YGfUgXcBBREO9dih2BtumktgUDko+cZ1KZ
 axA+cqd/VybPtSLcpJL3D9UMNKoyvNYlHUDMFqTFVTJrIjo+ropVL1GRqSk6ZPZ5S0TwUZ3Q3i5
 FsA0YnH9RPY9QHTIIzA==
X-Proofpoint-ORIG-GUID: dmxF1QgIyfKflIBwFpCt8EYsiL2KlROi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070165

Add documentation for AD5529R high voltage, 16-channel 12/16 bit DAC

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 Documentation/iio/ad5529r.rst | 214 ++++++++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst   |   1 +
 MAINTAINERS                   |   1 +
 3 files changed, 216 insertions(+)

diff --git a/Documentation/iio/ad5529r.rst b/Documentation/iio/ad5529r.rst
new file mode 100644
index 000000000000..c9760945eee7
--- /dev/null
+++ b/Documentation/iio/ad5529r.rst
@@ -0,0 +1,214 @@
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
+  - ±5V to ±15V
+  - ±10V to ±20V
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
+  Scale factor for voltage conversion (microvolts per LSB)
+
+  Based on the formula: VOUTn = A × D/2^N + B, where A=5V, B=0V, N=resolution
+
+  * 16-bit: 76.294 µV/LSB (5V ÷ 2^16 = 5V ÷ 65536 = 76.294µV)
+  * 12-bit: 1220.703 µV/LSB (5V ÷ 2^12 = 5V ÷ 4096 = 1.220703mV)
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
+    # Set channel 0 to mid-scale (approximately 2.048V with 4.096V reference)
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
+    # Read scale factor (microvolts per LSB)
+    cat /sys/bus/iio/devices/iio:device0/out_voltage0_scale
+    # Output: 0.076294 (for 16-bit) or 1.220703 (for 12-bit)
+
+    # Convert raw to voltage: voltage_uv = raw * scale
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
\ No newline at end of file
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 007e0a1fcc5a..4b1d0432a040 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -21,6 +21,7 @@ Industrial I/O Kernel Drivers
 
    ad3552r
    ad4000
+   ad5529r
    ad4030
    ad4062
    ad4691
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

