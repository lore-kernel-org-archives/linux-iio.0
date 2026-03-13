Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B9D387355;
	Fri, 13 Mar 2026 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773402980; cv=none; b=GGUl6L3/3XQ2PwqMAaZTnqa4MSzaCqLcb2RM9GGvW/FZ/BaWQu99ixKlSWBcWI8BGIhg08e4cL0TINn5YeR+f2OFjdqQPhWp82RZexZt0vwUzo9f8A2nec7TxhsVFr0eKkw4oulOfNgXFjx86WS0Cixxjpr3VLU98IVMYZUJblE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773402980; c=relaxed/simple;
	bh=VRx9jP0hM/FO/qxU0F16j//aIhAo7myqVHzbsDLMC0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kT5vJV8UDWNBEWfQyExbpR5ZaMrWTelj/y0wQoJD9tXXRQemeEMT00DogRG6rUMgM2kJv9AzTTnRRkopsnxhnakM4IbtkdKERjI1phvfCrtHkzozPiN+BX7u5t3tZyNN65mlPByXAcXJAh87wF9Ri3DdFyk519ogm5Er2hOGmSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wY6Mm7wL; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wY6Mm7wL"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DAA4l43650890;
	Fri, 13 Mar 2026 07:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=6b5KP
	1Z2wD99zTp4iSwVoWPt5ySl3sDnSa8+3w6grWM=; b=wY6Mm7wLXvC4mBj/L29Mh
	nhmfjpurMwI4yUsAP35qRbJkGIq+WOWtBT+7INUii5FQziB1xMLS1CN6riftMCpB
	G3G7PeYQOj97b7SK9K4s7CjMMioFjcLpKRvkwaQ22jtIulijPtK9kEGRoMkXoQTV
	hQtxJnFLlBCbe6404GQ8iF3uTN9vkg5KLQAAXR7rxO6MBEF1t1Af1zTKbF1TyL59
	Q/dEYOj/tKJKU4nxzPTWBERkj9UzM23n2//1oWcSHLEQBAvB6Q+Ol2LKzGHVwr0M
	XVpOw6e1J0t3l1tAMQjduJch3xuCRhktOPJqDbmtAnq81I7h7LmEjA2+RBxFYNzu
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cuh6bf0u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 07:55:59 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62DBtwKT017345
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Mar 2026 07:55:58 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 13 Mar
 2026 07:55:58 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 13 Mar 2026 07:55:58 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62DBtTxJ024500;
	Fri, 13 Mar 2026 07:55:49 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Petre Rodan <petre.rodan@subdimension.ro>,
        Jorge
 Marques <jorge.marques@analog.com>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v3 2/4] dt-bindings: iio: accel: adi,adxl372: add ADXL371 compatible
Date: Fri, 13 Mar 2026 13:54:55 +0200
Message-ID: <20260313115525.85435-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313115525.85435-1-antoniu.miclaus@analog.com>
References: <20260313115525.85435-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Bh5CyW02ll7svmIaFoOTdCfvLxFm74s9
X-Authority-Analysis: v=2.4 cv=c6amgB9l c=1 sm=1 tr=0 ts=69b3fb4f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=XYAwZIGsAAAA:8 a=85po4vX9ZQbJAwHx--8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-GUID: Bh5CyW02ll7svmIaFoOTdCfvLxFm74s9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5NCBTYWx0ZWRfXztG3FX8oQCut
 ZBfiOwBwUqCEng216QWOzOYNsg42gWnUjyHR+MMvcwYcZZyiSjOtqrb2uB04vwvyHgnBMNRp6pt
 ZhjIocdPTIiMPx2Di1hcr1N9ywFDSRLTJCaWRWkWXDQVBl4+BljZJePS1wKy8/Ge+Wv9tRYVhfj
 Ed+BKkiRLg7V8S8xM/nFECDhkQy+6E4ORYTOoNOF4MPizTua3AeWudN8Mz8L699K5XfB8MMlNaw
 4azrB9p/is3a878f/lU53efXp87yRtjI/DI83Ga0SLiPXVe91Y7rpfFSo6e3ayO4bbICMrC5CTh
 z9grrZ9FlyfyrOF9NW0tpVl+VeDI/XIm74T7absbby4g9c+h0blEjwK1NtVysNjy8Yr+SyPugpw
 ksOYxcS3zPucl+I6eG031uwRZ+W774m3DNc6JdJVVF611dfNB9JUYlugNM1PfPcK1rfMeqHyOAT
 covMiFa24UfWytLWaDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130094

Add the adi,adxl371 compatible string to the ADXL372 binding. The
ADXL371 is a +-200g 3-axis MEMS accelerometer nearly identical to
the ADXL372 in register layout, differing only in ODR/bandwidth
values, timer scale factors, and a silicon anomaly affecting FIFO
operation.

Update the title and description to reflect both devices.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v3:
 - None.

 .../devicetree/bindings/iio/accel/adi,adxl372.yaml       | 9 ++++++---
 MAINTAINERS                                              | 5 ++++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
index 0ba0df46c3a9..02e734946f44 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
@@ -4,20 +4,23 @@
 $id: http://devicetree.org/schemas/iio/accel/adi,adxl372.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer
+title: Analog Devices ADXL371/ADXL372 3-Axis, +/-(200g) Digital Accelerometer
 
 maintainers:
   - Marcelo Schmitt <marcelo.schmitt@analog.com>
   - Nuno Sá <nuno.sa@analog.com>
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
 
 description: |
-  Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer that supports
-  both I2C & SPI interfaces
+  Analog Devices ADXL371/ADXL372 3-Axis, +/-(200g) Digital Accelerometer that
+  supports both I2C & SPI interfaces
+    https://www.analog.com/en/products/adxl371.html
     https://www.analog.com/en/products/adxl372.html
 
 properties:
   compatible:
     enum:
+      - adi,adxl371
       - adi,adxl372
 
   reg:
diff --git a/MAINTAINERS b/MAINTAINERS
index dc82a6bd1a61..34a1e1386b66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -651,8 +651,11 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
 F:	drivers/iio/accel/adxl367*
 
-ADXL372 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
+ADXL371/ADXL372 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
+M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
+M:	Nuno Sá <nuno.sa@analog.com>
+M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
-- 
2.43.0

