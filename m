Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E1B4A387E;
	Tue,  6 Oct 2026 18:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310827; cv=none; b=uL/Im1H71kuXUiRkUukObCpohToRwDJUe7E4xKcrI7AmX1WIKbujLj2Dm2dTxjkpG9OabeHYsmOIvKpSBtAA4jSBAdloYJ4qO3qn26mODNE9fFwcom4xyBn4/57OFF6WMVSHyGt8xWKIhxMVZZ9fNFyGBJ3tTCuo1mz1A+9h8SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310827; c=relaxed/simple;
	bh=D/fqFJJmgk3W3q2oSz0m4mj/AzINb9KFaln8IfRz7d4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVFjBPHdNkySCdG6nZlfMbYg2DsyWnWXq3qoNuDOjoC2SxDn4L7eO67pk2z60Nl0WPJjfS5cQxDRBWLhmc2stWM52Hs1nL7HJNl9ozlMVROiXOPlODHIt2W+3DTYbXyY9zL5CWL3sPRK/ndmo4RTryw3IXEaKe49JbNsGd0Udl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=s/Cz9uD3; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mubi8SSP; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="s/Cz9uD3";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mubi8SSP"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696Hga2A1610019;
	Tue, 6 Oct 2026 14:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=g78t4aRzxVnpAiJB9bw5Mt7tVofb4ZCwTCbcZuMVaag=; b=s/Cz9uD
	3aNjOMqPNJ/dm8IQSg6p7+OR3bTzhw342mX4Q1lFpWzONVZLZW9UDVuo30UBZYP3
	yMbAvf6abUamXZhalEpVSb4nvR4Q3F2ekMO9BkhEsEynZXkjwejP7hIQePP8WzUI
	hyz5WPHLw8tN/xsDv8vfSGO0ENbKKjcKlbY72puzhOOUq1meXt9/1pxCabNYKZyi
	Akk8jTs8Hu6tYDGTBKMb0arjgY2TUet7uoPgfaGtdPA7MI65864Cn4xEIAc+bMgY
	7IVee0/Jmzyk5wqY91mlBohuZiNlmC6dgtrkiuH8kIG48ps/alXtlLdUdN2guj1N
	Zn+ZgLIyI3FZomA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=g78t4
	aRzxVnpAiJB9bw5Mt7tVofb4ZCwTCbcZuMVaag=; b=mubi8SSP2glzAhUthr0dT
	0LAWTM538Pj65MDHVamGzsFEv1Y9ibUnXXn1gsC7NgSZzIGSVsyjN6Zafu70POTG
	z6uCxTbWVIdQHV3I67daA0BBUtS5hFU60ousLRowUVj8vrT+r52ph1wfn4jOKprg
	/sd0u+sXDn7+yhG/12tDAWVPcP2drUMWODEKEmkCDh9wjRyjs0/80aDTiV3EiI+S
	TsjbfYHx3Z0LjsLvJ2TRIuN0oAbqL9gH4WBA9eC/wI4l5/mpiBYMu89JEFQhtsI3
	BDHg92CnI2XKFyzXb07baHI+H5j62643F24ZkuabfIPXF25Jh00a27fQXHVoIo/n
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h4ub43stj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 14:20:20 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 696IKJjQ010135
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Oct 2026 14:20:19 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 6 Oct
 2026 14:20:19 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 6 Oct 2026 14:20:19 -0400
Received: from work.maxim-ic.internal ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 696IK3L0001054;
	Tue, 6 Oct 2026 14:20:05 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 13/13] Docs: iio: Add AD4134
Date: Tue, 6 Oct 2026 15:19:58 -0300
Message-ID: <c5dbd4bfabb8b747e7286a09e86a472ec3d38b92.1791309733.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1791309733.git.marcelo.schmitt@analog.com>
References: <cover.1791309733.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: rl-mKce0JPn1RUIL1F8nc0YfKGoNGVCo
X-Proofpoint-GUID: rl-mKce0JPn1RUIL1F8nc0YfKGoNGVCo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA3MiBTYWx0ZWRfX2E1l1N9Fa73k
 PmSusegCITWBKM/cwr11YIA4GCV3LnP/gb+KflUN+f0IckKQbn2f9VD3YALIQtbXEP7ts4cBqwc
 OmwcdfTpWS+6OpnIDJylViimrSFA8lfsK5P3Yl8U1X3U2CxsL3RkmLpTKXlhsWg7eF1NpglRoXJ
 CMvd/lt2o/N1j1YRlRvDKn5WsRceL8PokuJcbY2m9EGxQmcGGEdW6HRc7yk7GkPsKexv9tGgW48
 FVgjs/nLscyp0CGnASmiOdtaEhBGH3gsitZdIdYaXm0BbberfYcX0nQD1R6GiNzDBJgvpIpAYJE
 Y6Htg9wgTMGiz+ykoNVmX5Bn5pCm8Cuwruo72vCVuownjVxakUpYaujstxX8pkIvd5zZsv9yfk+
 ZUpMb8UiwVvaB06XVDEBk++eDVgcYRXCLyVXFts2/RUjQuJiq4T5O8WaQwkC/b+w23K1TUAf8wc
 GQq/UmogTnxr2nTUOCQ==
X-Authority-Analysis: v=2.4 cv=O46sLx9W c=1 sm=1 tr=0 ts=6ac53be4 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=wI1k2SEZAAAA:8 a=VwQbUJbxAAAA:8 a=5WHrTUun5MBT5U1ic48A:9
 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA3MiBTYWx0ZWRfX/jQnDDYbagi3
 AitLanKB9fPxZvgtEx8zT9QQ44N2s6ZTx886mNHgJTvDV9XNxKmiOz075Dx064UfUSS49cr4nhR
 w2lHUXC78YqU/jXHGsGhmR7GObsw0cJG2OLKhQNw19Lrdn4CiXJ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060072

Add initial documentation for the ad4134 IIO driver.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v3 -> v4:
- Minor adjust to AD4134 IIO Doc that made the doc 1 line shorter.

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

