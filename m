Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8115E480DCA;
	Tue, 15 Sep 2026 19:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499836; cv=none; b=Be7i8rLj11v7oeaKceK+ksg9u1rIOt+msJ+gAMPwIHvISm7+wbIbU3q/3cZa8XWHilB3u1PxItwwAJkJ25tFbdefHd4BCJYEeIGLF97GsJRlQ0+bic1z9Mm7CiV4JXfKThPe9io3gKjBcuK+LsNZY7okvFZZE90gY7NtYFkETIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499836; c=relaxed/simple;
	bh=+XxGeAxbgQbggrU1DFbFNqtQeMfxXGQ7QyamO2LnYd4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yfi74IoGtivVPj0nWoKuCr6yjdIC9rmH3VC3pvAOEdPuLAQDw/IKqcY6RilDXB4iWWQhDNXswyyalR4RVJmGECactW8t+g2FeVWNnpqg1o5cuZD17n3n0nP2OiKbFlOAQVIwjWXE2Q3NjHa78KgHtNr/sep2TGH15ZeEM/jOjVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=H2/Ka1i4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="H2/Ka1i4"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FIsR1h2052843;
	Tue, 15 Sep 2026 15:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=JFwYH
	kQPnmSO+iwYfiTSzkYMvT/mHNqp+O/pIc06Ji8=; b=H2/Ka1i4LCuwVV94mBxj/
	JxNGhe12cplFMJ8Q13Cv7annO4TZO/YLXdVS7MKtUWE/2HjebDv0hQXMdP8CQ38w
	YsFkDr5OwJAFcjrMrFmPMfd+Vji+mNsO0xMVpEC25gMmZjGMe2GWmJ1wYDRU1tNE
	KSOmU4whZ4D8u79/NfiX7W+gsZrUIYS6SoVQW5G+ANdq+cCuhxOY7kCLD2CIbT2T
	XXN6x9fR6UX5qpwB5Ac0JnGIfe3S8UolXJwLZVSt07GXs95h3sbRC3ayptysNEQF
	VF7Bx2aSG+0WXn6kvgqhRVRbclutd79k+AlSKr0SscssjAnc6J/abvyH65BBypqo
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gq57eadfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 15:17:08 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68FJH7uB019718
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Sep 2026 15:17:07 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 15 Sep 2026 15:17:07 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 15 Sep 2026 15:17:06 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 15 Sep 2026 15:17:06 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68FJGpif028239;
	Tue, 15 Sep 2026 15:16:53 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 15/15] Docs: iio: Add AD4134
Date: Tue, 15 Sep 2026 16:16:45 -0300
Message-ID: <b55156f0a9a8e1fcc973f747c85eb7ab4a2d1b66.1789494473.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1789494473.git.marcelo.schmitt@analog.com>
References: <cover.1789494473.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: QWACnvuHot_4KPWLyRAGxC-mKCqKQWvV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI4MiBTYWx0ZWRfX9Scga+Ex7zI8
 RnNkmw/+SURUOVnNmugRzJpyZjyPtIdo0wAPTXsXiF98T8RcYoFfizLpYiom9ktEPsVIboKkSe5
 lY+nHb5TCEeWx+jfW9/dyTixNTdM2pfMJFMwda8uxJ/cC6bl5+5uR/xbdFi9t3Qo66rbMolV6gc
 ZvaF2zfO6aG75ljhxl9hSWiFw1IW3GkRIa87A19WL8qkNDntbSFURY38Yld4vGavXtKnV+8t5ir
 XSnpchW//d+qB0bJ8xsddqpd/uXV3vKPZpl8ROeEquaNos1NUXuXxNEnketzM0LOlvbTuDHi3Pp
 F/yhzbwlOM478JKxQHX6xHKsnsyiiG2exyjPgUAkaKYKk7XXo6pIIrwtkAFNOYlkrxzn9JqG21T
 V4PHrrggNtfeTXKZbHnjCHEzHQT9N5XOZRgBw0RPo+9JRcAE69KsEC5t9+yZPvSsrgjMQAsgX+T
 NxHUWy+2nICPOkWvrnQ==
X-Authority-Analysis: v=2.4 cv=V9HoQuni c=1 sm=1 tr=0 ts=6aa999b4 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=wI1k2SEZAAAA:8 a=VwQbUJbxAAAA:8 a=UPGXaPcPnv3xC-afbpgA:9
 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-ORIG-GUID: QWACnvuHot_4KPWLyRAGxC-mKCqKQWvV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI4MiBTYWx0ZWRfX07pOutmuHch4
 CRXyCnu1o0QdMrvh6PInFaX64CUqzVEWqM7BMQAZ+xobFz8NQWGFLw6AjmtEanW6oyDi/rwdn71
 bTyoRDGqR/OWKFBZaYaigN0zt3C4tBkv8sOtfJsbEliB9MyAxw53
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150282

Add initial documentation for the ad4134 IIO driver.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v1 -> v2:
- More accurate multiplexer control signal portrayal in connection diagrams.

 Documentation/iio/ad4134.rst | 130 +++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |   1 +
 MAINTAINERS                  |   1 +
 3 files changed, 132 insertions(+)
 create mode 100644 Documentation/iio/ad4134.rst

diff --git a/Documentation/iio/ad4134.rst b/Documentation/iio/ad4134.rst
new file mode 100644
index 000000000000..7910cd665ad6
--- /dev/null
+++ b/Documentation/iio/ad4134.rst
@@ -0,0 +1,130 @@
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
+  | SPI interface         |                         |                 |
+  | for register     SCLK |<------------------------| SCLK            |
+  | access             CS |<------------------------| CS              |
+  |                   SDI |<------------------------| SDO             |
+  |                   SDO |------->|¯¯¯¯\           |                 |
+  | Data interface        |        |MUX  >--------->| SDI             |
+  | for ADC sample  DOUT0 |------->|____/           |                 |
+  | data read             |          ^              |                 |
+  |                       |          |              |                 |
+  |                  DCLK |<------------------------| DCLK            |
+  |                   ODR |<----------------+    +->| Offload Trigger |
+  +-----------------------+          |      |    |  +-----------------+
+                                     |      |    +--| PWM1            |
+                                     |      +-------| PWM0            |
+                                     |      +-------| GPIO0           |
+                                     +--------------| GPIO1           |
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
+                                     |      +-------| GPIO0           |
+                                     +--------------| GPIO1           |
+                                                    +-----------------+
+
+Each of SDI0 to SDI3 connect to a different SPI controller deserializer
+(``spi-rx-bus-width = <1>, <1>, <1>, <1>``).
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index b02b879b053a..e4ec8a05dded 100644
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
index 214aeee7642e..ca2c8667cdfb 100644
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

