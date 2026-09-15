Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736BC37F316;
	Tue, 15 Sep 2026 19:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499734; cv=none; b=Z2AWxp0Od+4RUK03DwykNCsJQvonJcxV1rPECfiOcGKFm5AZJwIGPOGyc05Gj+BSfRUzf93eA7rYJhkXSPk2DxgpF3TloEQEwIDsZvhYkTJBbhosu2A8aVqd0wXFEx4GwLARXzKmsY5dthS3wylSn/KiqHV+zrKYbkZ1jXDgDyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499734; c=relaxed/simple;
	bh=bj2lPLay4+9QnQLUAj1h7hOxpKHU5sK2NctPq8WvL0o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDNZY+3Pb+tonYGHT1qlDH9mFSdiA3PW88hvdkYo7cJjRMuX2vWKUcMf/5c8SxVdx0IKpc46Z9Q+bwXMkBrdIacr1Z7e54In55NsEhx2QWrNtxySbQgrkTJnRh0v9J41xqi4/JqhMvLXX/NseisLGpWHxKlozgwCusCepUsgkSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FHohF8QO; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FHohF8QO"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FIsv8w1755574;
	Tue, 15 Sep 2026 15:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=t4WMy
	tu8X+bPC1eNX32rGs4KXrIfAWFWpPBbH5ZkDA8=; b=FHohF8QOjfWcuQ7fDvRzz
	m/izQ+E2jvFh2cWJ+cUkQC084rO8XbXcmKz0KzrQ0jRBeRbKjlKArWVVWbRtj9ri
	sYzotilxjhS8Yv6S4bQnt+q9d3wmT3RoMT6PfiWITK6MMKiLgtn99rw4EgGEQOC6
	ySyrrhTcjM1nALlb/A0sQDsofHudHz1DA7pWumpCpg1H5iSfaFc+iS+6XHsJrIg7
	563IFzy/XAj6KrFV23+4aiDKdEYm/xFj8gRfRW3oh6qi961T//4mADU0P6M2fsku
	qux6X33xbCV8X1B8aLAG+OV0QZtLo0d/j/SGNOOY0rgp7mqRD5wRNKxvJKhRAr6P
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gq43rjq8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 15:15:25 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68FJFORK019473
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Sep 2026 15:15:24 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 15 Sep
 2026 15:15:24 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 15 Sep 2026 15:15:24 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68FJFB7q028205;
	Tue, 15 Sep 2026 15:15:13 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 10/15] dt-bindings: iio: adc: adi,ad4134: Document external multiplexer usage
Date: Tue, 15 Sep 2026 16:15:05 -0300
Message-ID: <a2de3620e1d712b69ed121fbc340bd1f5e1a49e4.1789494473.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-ORIG-GUID: lZe5CNz8QYCUGGdTdYaC1F1IDeLv1gtf
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI4MCBTYWx0ZWRfX1PZP3xIghWKC
 EOUDgDKBlZLNOBj1WUJEQq17VinnawuIGvRkzeRTHcGD/sp+/QloIixEquu21TibFwodURWwHTe
 G53uA7Hswd+pg4EVN34FVf0F7BHjNgDzxgSxVw1BIJYVkp3CzjUj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI4MCBTYWx0ZWRfX2GX3qALSonMG
 VcyeL9QmOlx+aZ54GJVEoVzJ7a7M6ZZYoIQvEVgKFtWNn6bi7DROBePMLco9QGfmCzo8lGR04o7
 OIHuwLldE6NCI6G04lctHbflmHPqZIStcqa9VLwpwF4jDaObxKmakgemK8jpgF6/iNKcNFagh1f
 ezDm814Gr9Etfo1TUheu+6LSomfk+I3X/s7y3cek7ycfc3+u16TMuhElA+UadWJZrA/u0ODN3R7
 HrCyVX6jrw9zOMMrTZTd/e3WHYB1oJM7pv7k/W7HZYNSW3oLpOJ/kPQR+Kbgd3CYHps6RPMvga0
 7soHdJUVNwFt0edKYOonRiG+uBkHoA0jmO0q4zc51Mmz8IIuVQTWrvbjU2nSoSwMqHdThC9PlHC
 7H6dd8EOE910eukM00/5LS+uJxI3MjczNPdzJ5XM5Dlxmh+cDVWQuNyiAbj33BUqlHKtI33HIhb
 emvxxlJzEhdwzBJsMnw==
X-Authority-Analysis: v=2.4 cv=HZeB3SE8 c=1 sm=1 tr=0 ts=6aa9994d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=YjmlrVWy-zMJPE8JoxkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lZe5CNz8QYCUGGdTdYaC1F1IDeLv1gtf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150280

The AD4134 design has two data interfaces. One interface allows register
access for device configuration while the other (separate interface)
provides ADC sample data. One way of handling both peripheral interfaces is
to merge them into a single SPI interface by switching between register
access and sample access according to device user requests. Though, such
solution requires extra hardware, external to the ADC chip. The access mode
switch can be done with an external multiplexer selecting either AD4134 SDO
or AD4134 DOUT0 to connect to the controller. The external multiplexer
becomes part of hardware requested for AD4134 device operation and thus
must be provided for operating the peripheral in such merged interface
schema. Still, there are alternative ways of handling the two AD4134 data
interfaces so the multiplexer is not always required.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
New patch.

Detailed reasoning for the external multiplexer usage.

Before coming to the current solution, the following configuration was tried.

  +-----------------------+                           +-----------------+
  |       AD4134          |                           | SPI Controller  |
  |                       |                           |                 |
  | SPI interface         |                           |                 |
  | for register     SCLK |<--------------------------| SCLK            |
  | access             CS |<--------------------------| CS              |
  |                   SDI |<--------------------------| SDO             |
  |                   SDO |---+                       |                 |
  |                       |   |                       |                 |
  | Data interface  DOUT0 |---+---------------------->| SDI0            |
  | for ADC data    DOUT1 |-------------------------->| SDI1            |
  | read back       DOUT2 |-------------------------->| SDI2            |
  |                 DOUT3 |-------------------------->| SDI3            |
  |                 DCLK  |<--------------------------| DCLK
  |                 ODR   |<------------------+    +->| Offload Trigger |
  +-----------------------+                   |    |  +-----------------+
                                              |    +--| PWM1            |
                                              +-------| PWM0            |
                                              +-------| GPIO            |
                                                      +-----------------+

Though, because DOUT0 never goes high-Z, the DOUT0 pin keeps driving the data
line, causing register reads to fail. 

Alternatively, we could have something like

  +-----------------------+                           +-----------------+
  |       AD4134          |                           | SPI Controller  |
  |                       |                           |                 |
  | SPI interface         |                           |                 |
  | for register     SCLK |<--------------------------| SCLK            |
  | access             CS |<--------------------------| CS              |
  |                   SDI |<--------------------------| SDO             |
  |                   SDO |-------------------------->| SDI0            |
  |                       |                           |                 |
  | Data interface  DOUT0 |-------------------------->| SDI1            |
  | for ADC data    DOUT1 |-------------------------->| SDI2            |
  | read back       DOUT2 |-------------------------->| SDI3            |
  |                 DOUT3 |-------------------------->| SDI4            |
  |                 DCLK  |<--------------------------| DCLK
  |                 ODR   |<------------------+    +->| Offload Trigger |
  +-----------------------+                   |    |  +-----------------+
                                              |    +--| PWM1            |
                                              +-------| PWM0            |
                                              +-------| GPIO            |
                                                      +-----------------+

The downside of the above is the peripheral would need fine-grained config of
controller SDI lines to only read SDI0 for register access, and only read SDI1,
SDI2, SDI3, SDI4 for ADC sample data (currently available
SPI_MULTI_LANE_MODE_STRIPE reads from all SDI lines).

The currently proposed solution looks like the following

  +-----------------------+                         +-----------------+
  |         AD4134        |                         | SPI Controller  |
  |                       |                         |                 |
  | SPI interface    SCLK |<------------------------| SCLK            |
  | for register       CS |<------------------------| CS              |
  | access            SDI |<------------------------| SDO             |
  |                   SDO |------->|¯¯¯¯\           |                 |
  |                       |        |MUX  >--------->| SDI0            |
  | Data interface  DOUT0 |------->|____/           |                 |
  | for ADC sample        |          ^              |                 |
  | data read       DOUT1 |------------------------>| SDI1            |
  |                 DOUT2 |------------------------>| SDI2            |
  |                 DOUT3 |------------------------>| SDI3            |
  |                  DCLK |<------------------------| DCLK            |
  |                   ODR |<----------------+    +->| Offload Trigger |
  +-----------------------+          |      |    |  +-----------------+
                                     |      |    +--| PWM1            |
                                     |      +-------| PWM0            |
                                     |      +-------| GPIO0           |
                                     +--------------| GPIO1           |
                                                    +-----------------+

By being able to mux between AD4134 SDO and AD4134 DOUT0, the peripheral can be
connected to a single bus such that controllers able to read from multiple lines
will be able to gather ADC sample data from all SDI lines (SPI_MULTI_LANE_MODE_STRIPE).
With that, AD4134 maximum data throughput can be supported with what is already
available from the SPI core. See additional details on the AD4134 IIO
documentation (patch 15).

Yet another possibility would be to have the peripheral connecting to two buses.

  +-----------------------+                           +-----------------+
  |       AD4134          |                           | SPI Controller A|
  |                       |                           |                 |
  | SPI interface    SCLK |<--------------------------| SCLK            |
  | for register       CS |<--------------------------| CS              |
  | access            SDI |<--------------------------| SDO             |
  |                   SDO |-------------------------->| SDI             |
  |                       |                           +-----------------+
  |                       |                           | SPI Controller B|
  |                       |                           |                 |
  | Data interface  DOUT0 |-------------------------->| SDI0            |
  | for ADC sample  DOUT1 |-------------------------->| SDI1            |
  | data read       DOUT2 |-------------------------->| SDI2            |
  |                 DOUT3 |-------------------------->| SDI3            |
  |                 DCLK  |<--------------------------| DCLK            |
  |                 ODR   |<------------------+    +->| Offload Trigger |
  +-----------------------+                   |    |  +-----------------+
                                              |    +--| PWM1            |
                                              +-------| PWM0            |
                                              +-------| GPIO            |
                                                      +-----------------+

That may be a fallback option if what's currently being proposed fails to comply
to Linux code standards.


 .../devicetree/bindings/iio/adc/adi,ad4134.yaml    | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
index 012e09decf7a..d89134ce4af6 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
@@ -104,6 +104,20 @@ properties:
       GPIO connected to ODR pin. Used to sample ADC data in minimum I/O mode.
     maxItems: 1
 
+  mux-states:
+    description:
+      mux controller node to route SDO and DOUT0 signals from peripheral to
+      controller.
+    maxItems: 2
+
+  mux-state-names:
+    description:
+      mux state names for routing SDO and DOUT0 signals from peripheral to
+      controller.
+    items:
+      - const: data_read
+      - const: reg_access
+
   adi,asrc-mode:
     $ref: /schemas/types.yaml#/definitions/string
     description:
-- 
2.53.0

