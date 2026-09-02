Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5482E4A8A38;
	Wed,  2 Sep 2026 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369978; cv=none; b=TfFMZaj0ww/YiRcABJp2T4cVC/SmjKrUrWziYWDY5uSxm5BsQr0pI8uCtgtg5rD9CMvOIPoBu0Hh9r9+wjDxC2ZqUbfsoVBrJaZ/u0J60TO8aUqx0JjkKv63cluoj05BoyPQxeoHnU+8jdMDRyrXECr2z26C2y+XABb4Yikx5UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369978; c=relaxed/simple;
	bh=7K7lR5cdOG1lxpYjITmE2m44b05EYAoX3GX69B0NKmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ky9IgaV9fkHTMA6gUCsCvplaFuKjHexQ3P/12+bx9ULKjpkafmYJ8Dj2td4zvz+EuVwidiETUH7y18PmPKkFj3YSxF5Sy3XWqoSNW35GeUMvCqeos6WBl2pW8BNlok939oy0OB+TI6NMwxKpg2fDy5wIcSqGMB/UQut5m69Qrms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=HGvUJUkz; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="HGvUJUkz"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682HDNBn3087941;
	Wed, 2 Sep 2026 13:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tZnvJ
	b/MRE2T7Cb58cJ5Rb2kXWspMrsG2Lko9/beEsw=; b=HGvUJUkzdu3zihgjIgzkJ
	bMYs+OkE7i9YHq8R/2RB3ZyJEkSqjk3Ype/AtWAovHL+KO60LX2prTuRFV06zRLT
	CKNrTbdJSR/1y1xUVy1lD1Tm4xeFtUGngE3RCRmhIDwsLHfUx4ZZJK+NINsz3mE4
	rtG4f4MqlEBrN7fu8XOAHxnWsKigs8eqX2bTqz6AdVTlg54kz+N61H6306Gxgazt
	viqq043GK7A7DeJ9TnMdpvSxjRICCstkNLYvBqV613Pl60PpVwF6EzeFe+dMQpiQ
	7UZmV83tfpiponp5iE0P+I2sScx2Tt0C0nf4f8Luzt5Hfaydqziz7z7Rh7kAiN9V
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gea7ubt93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 13:26:10 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 682HQ9PK041666
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 13:26:09 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 2 Sep
 2026 13:26:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 2 Sep 2026 13:26:09 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 682HPtRv004317;
	Wed, 2 Sep 2026 13:25:58 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 13/13] Docs: iio: Add AD4134
Date: Wed, 2 Sep 2026 14:25:49 -0300
Message-ID: <81f7df476a37fbdbb4f16373742c1b04e1e782c7.1788368334.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1788368334.git.marcelo.schmitt@analog.com>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfX0zo1r/Eu5eis
 afSAS2pYOCtuwjG/fM7QdWUnHQmYF3clKRzEzgAWIsGBvsgBvqrYqait6s/p2ifBBIEfbkwCmZI
 9KoFbgXjhlzNTlAenbaIkORK/KGtr1nMrgqlyp5VeykewkOc3b3y4VTDUdE8kGD/Ab4dEsi6wf3
 dcWGBY/k5dV6ivESDBbVpCH3TStYy/Xwcxn/yx/TMyN/0AyyAgIhTYJ7PsK4dDfvNODEu6QZc60
 3TIic5rwSFKZWa1NxBTrSEEeCsvo6jVP5KnR8KWuAppEHpHysi5uGIfUjWoer7VM/W1wEH5Ickk
 WbLVKTyV2ERNGrEuVWFr1AmVi3hwcIo9igqfk+bR73EvN4GLssJgRKCgfB4RuSR70HNTIaVfyH9
 Wowb0AAXJ1Ivc2TZ8Crio6Y5QwhwV3x1KULnDVpmNU+iC9C1Hx5ysmx3M+W+HJO7X+n9ivA8s45
 jWFQMq1ayBY/xGXXkIw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfXxVG/gB5kMLue
 +aVMFc2Ybo5PHrcpF/xbDK1boKIaGft+lTuTjj1AIDMHeUebmFuqFsCQW2dyZ1h0wDkC7Cdo2i3
 yYbfaXlxQe4D48+fEFJyUmb0yjrX2wt4Y1HRGrSTN3lD+Pxt9KGk
X-Proofpoint-GUID: Dg23zS1boR19c8PANkJvBhAPj2sj1Dto
X-Authority-Analysis: v=2.4 cv=a6EAM0SF c=1 sm=1 tr=0 ts=6a985c32 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=wI1k2SEZAAAA:8 a=VwQbUJbxAAAA:8 a=5WHrTUun5MBT5U1ic48A:9
 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-ORIG-GUID: Dg23zS1boR19c8PANkJvBhAPj2sj1Dto
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020153

Add initial documentation for the ad4134 IIO driver.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/iio/ad4134.rst | 128 +++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |   1 +
 MAINTAINERS                  |   1 +
 3 files changed, 130 insertions(+)
 create mode 100644 Documentation/iio/ad4134.rst

diff --git a/Documentation/iio/ad4134.rst b/Documentation/iio/ad4134.rst
new file mode 100644
index 000000000000..4e93d670e2db
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
+  |                       |          +--------------| GPIO            |
+  |                  DCLK |<------------------------| DCLK            |
+  |                   ODR |<----------------+    +->| Offload Trigger |
+  +-----------------------+                 |    |  +-----------------+
+                                            |    +--| PWM1            |
+                                            +-------| PWM0            |
+                                            +-------| GPIO            |
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
+Maximum througput rate can be achieved by reading 4 input lines simultaneously.::
+
+  +-----------------------+                         +-----------------+
+  |         AD4134        |                         | SPI Controller  |
+  |                       |                         |                 |
+  | SPI interface         |                         |                 |
+  | for register     SCLK |<------------------------| SCLK            |
+  | access             CS |<------------------------| CS              |
+  |                   SDI |<------------------------| SDO             |
+  |                   SDO |------->|¯¯¯¯\           |                 |
+  | Data interface        |        |MUX  >--------->| SDI0            |
+  | for ADC sample  DOUT0 |------->|____/<--------- | GPIO            |
+  | data read       DOUT1 |------------------------>| SDI1            |
+  |                 DOUT2 |------------------------>| SDI2            |
+  |                 DOUT3 |------------------------>| SDI3            |
+  |                  DCLK |<------------------------| DCLK            |
+  |                   ODR |<----------------+    +->| Offload Trigger |
+  +-----------------------+                 |    |  +-----------------+
+                                            |    +--| PWM1            |
+                                            +-------| PWM0            |
+                                            +-------| GPIO            |
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
index f3be900e5b9d..7b972c1f9833 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1514,6 +1514,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
+F:	Documentation/iio/ad4134.rst
 F:	drivers/iio/adc/ad4134.c
 
 ANALOG DEVICES INC AD4170-4 DRIVER
-- 
2.53.0

