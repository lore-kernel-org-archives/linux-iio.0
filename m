Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792795102;
	b=kfnZlqN0d/nWrKpH5hjJ1djasWXRuUldbxOslPTEbx2yGmHeoe+/5j1iB2WSdKN0tTCE
	 YOLajuMJxq4vsJl7T89gMcfGdOlv4QeGhe7vYTgmQdadco7rYPNRyr726pZasrnIUsb9i
	 a4DnWAHRegCXorIUlMv7vHrHRVIbfj6ZHUsHHDKv9+Fm+7ygjbUE1rd7saec3cRsBTHcn
	 UtB2AtXY7uWk4qUVQh5yuhO4IM663oEUGEyyUI6M6MIzrds8IA3ihEVvcORHEcy5510Nk
	 rFQNfDqyImwuaE6kDZW1PjPtqdcIdhEJuVlrFF5mwkK6IeAnQjPZm8OoFXEYFr3sg+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792795102;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=UOZ6WSueaHCJ9DyUcKOnlyq8dCc+epWLmpmO/pZb0C0=;
	b=XTSrPfDCYQpreJwmH7l4awyooNnitc4f6fWiZ74Kv92tkhXSt8RxCfBiXXc0V9FVuiqu
	 ma27WXn6t2zFe2tLDySMWYczgiBwrsE4d0ZfjOydjSQtT3melpqR9ZVj1qU5t+JpQyLen
	 rJm5Ot/0vjfTHiWnlzZcNcLBcu942Ko9pagk0QPrAC9t75irVp/EupwrBO5lwTGQ1tF2D
	 7ISzcn65GowjpHU9Q5ZJKYnNgAqN9zp/jXxkcrfF70bIu65Cki/paLWyQa4cuCy9Q0Pza
	 BYey2+Bs/UKflFve70+osH6+ZkXPl+9SGxb4fM+TWRo3vmr91q57ig7Lqaqk5ybYt1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=sFoJeMOj;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Ghh71+GK;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD174606A31A;
	Fri, 23 Oct 2026 22:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD174606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=sFoJeMOj;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Ghh71+GK
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NLwaOZ1784476;
	Fri, 23 Oct 2026 18:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=UOZ6WSueaHCJ9DyUcKOnlyq8dCc+epWLmpmO/pZb0C0=; b=sFoJeMO
	jSVVyT5k4zqG7aQ/MGDWcegY+rTUarEZU3I3jS21CLgMy251Es3IXT5ibyvwoZpr
	hV9dXrppfzMzj5pNfjB41Q8gNcr6Cq4GptlMSGoSk+in9vS+R8UHncyFdt3MbnuG
	8YjjzY8BLLF6yALt23n/Sx7RsGW1xacYQyBWgXndZ+MpM5RXmHlMnR1dl1Sd3SY+
	e082SijXW7GFl+ru2BGMF66JaXp+c7/ZYbpxzcuJvcNkcL/+gEOfCXcZ6cFj+h3Y
	D9ZnRDJfhwPxRxQ2EzQ+QS1Wbd4Zko77yS+y9aVSM2s3xIlKTCZAwXfnXQDBf36h
	xS/IumMccoxUxjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=UOZ6W
	SueaHCJ9DyUcKOnlyq8dCc+epWLmpmO/pZb0C0=; b=Ghh71+GKAC+hoMAV3zu9y
	NY+Nk8is/xsgYByY8uyR1TfLL5bhjXv/Dhm5bHHK0ZmLSa3OvXVl/oOhAkLonTYX
	QO+HEPD9RAMox6XCfi8wGntHYSNj207kpDKmlQuhWJA0Uom54oLYFVULFeYESz7F
	/eGXZDz9k9Ze0WfsQOthskgaTN8dk93Ei452O93CBvneV4fWjTtRoMOR0CrpO2Y5
	PmtEvYVMlq6VlcrHLnC70nv5QbtiW2PVJrfn4r+EapzhdF+Et3rdH0UMa3zNc/QS
	4C7Kqr2+wQ9lHntu/hXDZep4Skalz+a78C/nhhOxorxRv13zs34geUsZYhPduJnS
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hg2mvmcq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 18:38:16 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69NMcFwP027073
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Oct 2026 18:38:15 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 23 Oct
 2026 18:38:15 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 23 Oct 2026 18:38:15 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69NMbxLd005932;
	Fri, 23 Oct 2026 18:38:02 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v6 16/16] Docs: iio: Add AD4134
Date: Fri, 23 Oct 2026 19:37:54 -0300
Message-ID: <9d06595a505406598d1585d883226561e2a1c739.1792792325.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1792792325.git.marcelo.schmitt@analog.com>
References: <cover.1792792325.git.marcelo.schmitt@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: rnfggMxlM9UkoGQNXcGSdM-2536i_eRD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA4OSBTYWx0ZWRfX+xWqp+1zM/iI
 9+rAHHFc5UyvrkzOxsd60Ql6nuAJ+KP9coHmFKzMpAXfEEQrXdGdikwSCREXva/Gb3TPSpY9n9b
 UOYt5zz/0JCWEt9TDnUlSZyz/LECMVFwNQmAwybGBS1QYbZxvMHY
X-Authority-Analysis: v=2.4 cv=YJoKWhGx c=1 sm=1 tr=0 ts=6adbe1d8 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=wI1k2SEZAAAA:8 a=VwQbUJbxAAAA:8 a=5WHrTUun5MBT5U1ic48A:9
 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA4OSBTYWx0ZWRfX+zXFkUt9X0xB
 jJTEo/lx9cH00bAaw+FZiK0QBnlOsnZ+dkJxlevyjQmpTnCPANHqyPqFln6Ub3FQs5mxarWZpaD
 PKhTMCDwmLkmzZV6L+dst7CW995pRnsRn0TZeDNxm8MleCGV4IOVrws7Z6gb/07yVGV6JBWwoVH
 gFXz3ktGMDI59Fk4rZLA2fiOA3gXB1N3a1H8ilMW2lKsVjspX5tyDZpZKjMwlheZvHfeptsajeA
 hdfOAi8wdwkIltVLTu7o4/8VrVCHUVzHvUKRrlBa/5tCooNRFh9k/uHNcRthy0w7QuB7IVdB+h5
 i8sbdWsEUeKDuAvGMBViLdIu0eQDyfgQeYxU82jxwbn/KsRfE4gGSNVsRb90TLBWOdkhCNO9poy
 GSifa8ZdSKiG8/9gU/VMSlI3pjWZi/nDUSIuDcXOsFvPp6e/eAMXkSs2+4SaAmGqyWRbR+jQ2Pv
 GOkVMuEnxpqtVsdE5sw==
X-Proofpoint-GUID: rnfggMxlM9UkoGQNXcGSdM-2536i_eRD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230089

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
index 571ee7e5dc8e..8376c73c29f1 100644
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
index 02426f316faa..800eaff4176d 100644
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

