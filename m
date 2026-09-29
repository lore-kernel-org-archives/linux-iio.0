Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942643515E9;
	Tue, 29 Sep 2026 22:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790722004; cv=none; b=HUwaxwEbB9Cze9Q7eiVIAIOgCjcB87zZFldi+HdyMYuDn4S6pGYJI2KhkxoPzwSQFrkUD6FUmEJ7OPwTGN7fsej1iGiX+8hFrFX9shYWrA0/Z6HRtXGShrpMkDG8oDibrJilS82k8ak0SAer6L3zYPQtcADtM7wfvGptm5RPlrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790722004; c=relaxed/simple;
	bh=JWso8YEnlrhdgGNz3015JJWxd2gMJ1mM6YFHYPD/XhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjnK8mBqiiEsa7p+54bbF3kK4BqvoHg0rVT3cF/1Ac8fGnF9PAtms+qb+HbxXfnaM/R/jyAgl2dpFjz4NIAoF0+brbrdRKgSxzCrXzCs1WaZqnS8/B8PKVQ0PnI7TBKyRUW3D0eOP4Pi9cqEOeQtKjC2oEXCPE+c7Xdp4cXt7iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=tIFmd5V5; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="tIFmd5V5"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TKO9gL1957960;
	Tue, 29 Sep 2026 18:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=QsoaU
	5tI55SrVfbq/MsP6mgsXraSPWR1v11QeOd9IyA=; b=tIFmd5V5oOKovKHBHz0CP
	wyPZBLG5jC7B3Dvm+aoxhw3r01j7Nj+RJguqliLYfAeH6ygmdQ683aMUUNUFU8D7
	7iyXr5SILpOXIHgRzq1u0UdXK0BJ5mZh7lRbSdKw5Y7XnBH5f0U1q2u8pfd55qsL
	jeUFKKlCHZCD8RKpItsNU4vkhQRkP7cXIWHnFBcIG+wtz7zfb4ahpZKGjxDTYLk8
	cP8VrDXzbZw+fruQmoKmp6Ny8WVQLrwsccOJIARKhuHC48pGI99ITqO2IRRqpnCs
	+sTtEfwRvsALqqc1wRxWSQF1a9A9L8281IQ1qHWjL06uO1SKQE6mntD9C9dR86z7
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gyy3vfgfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 18:46:36 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 68TMkZcW041730
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Sep 2026 18:46:35 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 29 Sep 2026 18:46:26 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 29 Sep 2026 18:46:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 29 Sep 2026 18:46:25 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68TMkBwB008278;
	Tue, 29 Sep 2026 18:46:14 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 13/13] Docs: iio: Add AD4134
Date: Tue, 29 Sep 2026 19:46:06 -0300
Message-ID: <267187e9a6b56315de343a84cf715a80d93a65a8.1790719425.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1790719424.git.marcelo.schmitt@analog.com>
References: <cover.1790719424.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: br9yIp1GkF_UWSLS8EBIaA-5vv72zFTX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA5MCBTYWx0ZWRfX1KCJV/WHx1Au
 UeejKNDukram2gbxqA+OXDPPBHkG5xPxQM19cAZ7JbOtssmsQS+/1AJSYwP8z0/nYWBfY66tGsX
 zIqTOJxC3GbHlaBgnPXsHN6X74hApak1+tvo6RngSwkWIf8fdK7ac9VNEAA9n1mvsCo2+XH1nf9
 9vDmdI4xYVDxpociEVfWWFOW4aAJ/DBfB+YXS+LXMyxuIXKU740v+kpVHdk1Rr6L6WGkzULbjep
 XviKknyhUvo4Ge85uD1ixHmStc6mPpC0OOC7oJZMSUjXVykxmg2bP/qnAyUKKXo2JV/7W4C3bcY
 qWzf+P17AEftEZhTV1GaQu+59KKcFycJ8XPPkmPoMeVZ/cH7lAuzItAkN6EFp7murIB8Dqoo27e
 pO02wixn/bXKr1Cb5n/H8254z81IVVckJFDtLYdwgSGOHgIYh06szfjZ5QOHIeBsDGLY4xrIB3m
 oHG0urEK64oWuuITexQ==
X-Authority-Analysis: v=2.4 cv=Y/ltIReN c=1 sm=1 tr=0 ts=6abc3fcc cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=wI1k2SEZAAAA:8 a=VwQbUJbxAAAA:8 a=5WHrTUun5MBT5U1ic48A:9
 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA5MCBTYWx0ZWRfXwyjKjmu0ZXIQ
 48b4B/0D4zMv0sRo1sNX4xrksrzAJxSm/pVhBoZpbkXukub7y97HqXBC0cwOrY8meRq0egLyAF7
 2toK1woBfM4/GlNBndHQkiYGRhvb0Ezk4qtspwTJXp8ZIMXnMisi
X-Proofpoint-ORIG-GUID: br9yIp1GkF_UWSLS8EBIaA-5vv72zFTX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290090

Add initial documentation for the ad4134 IIO driver.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v2 -> v3:
- Corrected AD4134 IIO Doc to only show the PWM connected to ODR on offload diagrams.

 Documentation/iio/ad4134.rst | 128 +++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |   1 +
 MAINTAINERS                  |   1 +
 3 files changed, 130 insertions(+)
 create mode 100644 Documentation/iio/ad4134.rst

diff --git a/Documentation/iio/ad4134.rst b/Documentation/iio/ad4134.rst
new file mode 100644
index 000000000000..cb16c710e1ae
--- /dev/null
+++ b/Documentation/iio/ad4134.rst
@@ -0,0 +1,128 @@
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
index ecc22d1149d1..97501bcab40a 100644
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

