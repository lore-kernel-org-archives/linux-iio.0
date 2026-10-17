Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EE3233955;
	Sat, 17 Oct 2026 02:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202485; cv=none; b=kcLEuXlEBSkaZyibTRDdzVx9zMB9cYpJ9ypfqgQA4IqeErgVTMrsK7rAexvu6bCxDBN4iUtdZqX6dBsz92q2q9F3EA+uFmdFzJomWLkhkKYtUsij8m0rYLOO0caSIkne2R4iSbB/r/44NP0J6UffNOpXB5izC0W50BKh107DtFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202485; c=relaxed/simple;
	bh=A0oRvhlj1hA6Fs6rLqGJxNH1FAejZgwbGVdxKg4ol7U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bAZrjB6ZXycYb2Ehjsyyo6i1I27W5bOFH2eusBSlN14Izf8YYKHUChHVYZz0rJWiqhrOE8eKI6GsD1N022YysBTQrn5wZo7f1pPYDeZYoCAsylpkHXRjvWLOBMfCJI3LllU7WuRIuf3aQbBsaGI5+trbwbDUQGl4Sj3KHLkcg2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=ubCci6lP; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yi4Z9Fol; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="ubCci6lP";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yi4Z9Fol"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GNHCXr2042830;
	Fri, 16 Oct 2026 22:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=Yqi/CIkFc5wn3Vm5o5Y9ZfF3VhjExPotBr0VDluOrs8=; b=ubCci6l
	PPW3ldenGxuBI+M3xvY5ppHSas7UNSJ5X8uoV7PImYRE89rw2gZYbNDp9FImUsoz
	rUKJeH/aZq9tJIgj+M/iMhrZRnSuIAbOESsel+IpT9yuL6oi3hCJD6wTVW87/Os6
	YYXGy2kIUIiDvwzC7abUmIqURrz68ho1lEq/YTa6y2W3Dwq/+/cysD8RfPipDjvX
	1uRH/5lrDalfDchoB8EpDTmFmDARfJz1auiQF4W0rGZFqULvOLMs9znU2cpVCKuk
	1XTIobK+PENVdI1yhxnaNTMDC386KaeVFN1csPC/TBI12qEf6QhVqHTRB3hBu1Dq
	CsGJeZ3nQiRtTrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Yqi/C
	IkFc5wn3Vm5o5Y9ZfF3VhjExPotBr0VDluOrs8=; b=yi4Z9FolW/1gbUsf/994B
	zX/y9I8qE6CLg9rukgL8x+PJW7oS0sJOpFGkEoOLLGbQkG1oykGtu3SKIAdtGIaJ
	F1HrBnlTiHI3qkPjHPKTT93GH9TzwHBtdQxFwK9Xia3Eu3nIcQ5+6oSf8RQ+DTBk
	HGH3pCoM2f/giDu+LpShrSOm1ytaoGQb3t84E5OgquXE93RpNPB024+pn8Grx+td
	rhq4s8948KDMaAOigO7l1luag7auKgGLfV3cWRTKpbeR9FqU1mMYrjqnMeBGzb/3
	YZ41v/qEo4ocCxeQxPL99od7WtClIEh6SmT3SLOvO/mxPWP2PANvegIjWEWkhR/w
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hbajk6mnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 22:01:18 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69H21Hpp062792
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 22:01:17 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 16 Oct 2026 22:01:17 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 16 Oct 2026 22:01:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 16 Oct 2026 22:01:17 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69H212Bf005200;
	Fri, 16 Oct 2026 22:01:04 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v5 15/15] Docs: iio: Add AD4134
Date: Fri, 16 Oct 2026 23:00:55 -0300
Message-ID: <10d3d050af604a4f637bf88253af93cc7fe555ef.1792200021.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1792200021.git.marcelo.schmitt@analog.com>
References: <cover.1792200021.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfXwZ64piX7NLhz
 3quvK1xEXkweZ0roH/tK57MiHDRnbZSHt1rAwHf2F1Jn+Z9mdaSRQ+nwq+g+pN5eGsPsrcJjpZn
 thl2j8ljYDlMD+ocV4TjrDNHEHo+Fe/TtoUAII870sYuXmPOlSsG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfX7cow9gXsWvY0
 oc7Q7pVxfOPJRT9UpTKD2NwnCI98njS6pX4sPOxiCtcR5JDxdNHL/7/yIhDhdDeyKAhP6ifXm2/
 Y2uZOfkUikGvmT2Z/7te4mZtYeIiCEpBfGm4Q1+pom/0/VBq5x5/NZaGlOuxA0I33vp56G1zUyk
 YSW7ExIuvFI3QfpcHcxc0ZiifMeFlI075nAuCr2TTMlr/VhazFhN8YmcArXiqQwqWOgBbVte/i8
 +DFi+Y27JvMgCTd+EOZ5sTTRh87a+I0EFwIpBJIMqIpSSTTW2zltCI4LxNv19LgUHyt7u23agJR
 /yq9Mp0v3x8Qu+Yjx00wFwB2e8xRwZemNWis2oraDk3g5baz9fwK7AE+1WjBM4HWgrWPBf+CfaC
 wMUf9kYJMd55ksJDNdjGMelxHOgX+NLn0H9dQZsPQ2DTO7K/NJJMx647yYBa8pA4Uo6fSAMpMBW
 bXKrQ0n+OXOafyoDzxA==
X-Proofpoint-GUID: Kh2px4Nn84wRk8L7xlBJemUxrR_qg-Vu
X-Proofpoint-ORIG-GUID: Kh2px4Nn84wRk8L7xlBJemUxrR_qg-Vu
X-Authority-Analysis: v=2.4 cv=eLqGH3p1 c=1 sm=1 tr=0 ts=6ad2d6ef cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=wI1k2SEZAAAA:8 a=VwQbUJbxAAAA:8 a=5WHrTUun5MBT5U1ic48A:9
 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170007

Add initial documentation for the ad4134 IIO driver.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/iio/ad4134.rst | 127 +++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |   1 +
 MAINTAINERS                  |   1 +
 3 files changed, 129 insertions(+)
 create mode 100644 Documentation/iio/ad4134.rst

diff --git a/Documentation/iio/ad4134.rst b/Documentation/iio/ad4134.rst
new file mode 100644
index 000000000000..c0889a21cd77
--- /dev/null
+++ b/Documentation/iio/ad4134.rst
@@ -0,0 +1,127 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=============
+AD4134 driver
+=============
+
+Device driver for Analog Devices Inc. AD4134 and similar ADCs.
+
+Supported devices
+=================
+
+* `AD4134 <https://www.analog.com/AD4134>`_
+* `AD7134 <https://www.analog.com/AD7134>`_
+
+Wiring connections
+------------------
+
+AD4134 and similar ADCs can operate in a few different wiring configurations.
+Because AD4134 also supports control modes other than through SPI protocol,
+the following pins must be statically set for all of the wiring modes described
+below.
+
++----------------------------+----------------------+--------------------+
+| Pin Function               |         Level        | Description        |
++============================+======================+====================+
+| PIN/SPI                    |         High         | SPI control mode   |
++----------------------------+----------------------+--------------------+
+| MODE                       |         Low          | ASRC slave mode    |
++----------------------------+----------------------+--------------------+
+| DEC0/DCLKI                 |         Low          | DCLK input         |
++----------------------------+----------------------+--------------------+
+| DEC1/DCLKMODE              |         Low          | Gated DCLK         |
++----------------------------+----------------------+--------------------+
+
+Minimum I/O mode
+^^^^^^^^^^^^^^^^
+
+The minimum I/O mode wiring allows AD4134 register and data access with the
+conventional set of SPI bus lines. In this mode, the peripheral CS pin must be
+tied to GND. A possible connection schema that sets AD4134 digital interface for
+minimum I/O mode is::
+
+      +------------+         +-------------+
+      |  AD4134    |         | SPI         |
+      |            |         | Controller  |
+      |       DCLK |<--+     |             |
+      |       SCLK |<--+---- | SCLK        |
+      |        SDI |<--------| SDO         |
+      |        SDO |-------->| SDI         |
+      |        ODR |<--------| GPIO        |
+      |         CS |----+    |             |
+      +------------+    |    +-------------+
+                        V
+                       GND
+
+Set ``adi,spi-mode = "no-cs"`` in device tree to indicate the device is
+connected in minimum I/O wiring configuration.
+
+SPI 4-wire mode - single lane
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The conventional SPI 4-wire configuration except a multiplexer is used to
+select between SDO (for register data) and DOUT0 (for ADC sample data).::
+
+  +-----------------------+                         +-----------------+
+  |         AD4134        |                         | SPI Controller  |
+  |                       |                         |                 |
+  | SPI interface    SCLK |<------------------------| SCLK            |
+  | for register       CS |<------------------------| CS              |
+  | access            SDI |<------------------------| SDO             |
+  |                   SDO |------->|¯¯¯¯\           |                 |
+  |                       |        |MUX  >--------->| SDI             |
+  | Data interface DOUT0  |------->|____/           |                 |
+  | for ADC sample        |          ^              |                 |
+  | data read             |          |              |                 |
+  |                  DCLK |<------------------------| DCLK            |
+  |                   ODR |<----------------+    +->| Offload Trigger |
+  +-----------------------+          |      |    |  +-----------------+
+                                     |      |    +--| PWM1            |
+                                     |      +-------| PWM0            |
+                                     +--------------| GPIO            |
+                                                    +-----------------+
+
+Set ``adi,spi-mode = "4-wire"`` in device tree to indicate the device is
+connected in SPI 4-wire configuration.
+
+For SPI offload operation, a PWM is connected to the ADC ODR pin. The ``pwms``
+firmware property specifies the PWM that is connected to the ADC. The SPI
+offload will have a ``trigger-sources`` property to indicate the SPI offload
+(PWM) trigger source.
+
+To achieve high sample rates while meeting ADC timing requirements, an offset
+must be added between the rising edges of PWM0 and PWM1 to delay the SPI
+transfer until ADC sample data is available. This requires a specialized PWM
+controller that can provide such an offset.  The `AD4134-FMC HDL project`_, for
+example, can be configured to sample AD4134 at high speed sample rates.
+
+.. _AD4134-FMC HDL project: https://analogdevicesinc.github.io/hdl/projects/ad4134_fmc/index.html
+
+SPI 4-wire mode - multi-lane
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Maximum throughput rate can be achieved by reading 4 input lines simultaneously.::
+
+  +-----------------------+                         +-----------------+
+  |         AD4134        |                         | SPI Controller  |
+  |                       |                         |                 |
+  | SPI interface    SCLK |<------------------------| SCLK            |
+  | for register       CS |<------------------------| CS              |
+  | access            SDI |<------------------------| SDO             |
+  |                   SDO |------->|¯¯¯¯\           |                 |
+  |                       |        |MUX  >--------->| SDI0            |
+  | Data interface  DOUT0 |------->|____/           |                 |
+  | for ADC sample        |          ^              |                 |
+  | data read       DOUT1 |------------------------>| SDI1            |
+  |                 DOUT2 |------------------------>| SDI2            |
+  |                 DOUT3 |------------------------>| SDI3            |
+  |                  DCLK |<------------------------| DCLK            |
+  |                   ODR |<----------------+    +->| Offload Trigger |
+  +-----------------------+          |      |    |  +-----------------+
+                                     |      |    +--| PWM1            |
+                                     |      +-------| PWM0            |
+                                     +--------------| GPIO            |
+                                                    +-----------------+
+
+Each of SDI0 to SDI3 connect to a different SPI controller deserializer
+(``spi-rx-bus-width = <1>, <1>, <1>, <1>``).
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index d0fb32f4b80f..3a49e08a2366 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -23,6 +23,7 @@ Industrial I/O Kernel Drivers
    ad4000
    ad4030
    ad4062
+   ad4134
    ad4691
    ad4695
    ad7191
diff --git a/MAINTAINERS b/MAINTAINERS
index 3a2dfd1a4fd8..82a810ac788e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1533,6 +1533,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
+F:	Documentation/iio/ad4134.rst
 F:	drivers/iio/adc/ad4134.c
 
 ANALOG DEVICES INC AD4170-4 DRIVER
-- 
2.53.0

