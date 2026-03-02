Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC33329E79;
	Mon,  2 Mar 2026 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454135; cv=none; b=KdHWZUN/REkZ0vh2z8jj0jN0KUS/Cgq2GcoNNfo6N4G1llILb9s+/5Bj7W7zCo1ZAmn0zbPMzgnlDxbjhzLho7JE5l0M+lnj0xjlcUYXPg+ZaBSOteKtAwM2kzlLSoHl95l8X1LhIBGOrOPQzLg+9ryNaSKeV7uli0IlBMxekDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454135; c=relaxed/simple;
	bh=k1BJG7QVBJ6j/4I0JFHz7ByKDxRwEt5ClbKRBX+Say4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OxC4NvL8xx/WggXz4LboR/PAW/ilG5qcwX1Zgmw/5Q8XaCxLAAw+hsZQ1EBIZOzw5meoo2hPctVHTF2YZiyC8iTA8nFBuVUbTE2aDkr6AYMxXpyqkoVHF8VmPbuQvcqpinIwWnpVoeq/NlieUCBmlOISfFpuU5bc2WTTNYjsYU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=AGri+1Kr; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="AGri+1Kr"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622A4rfM3241933;
	Mon, 2 Mar 2026 07:21:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=fguzQ
	AiYBCbLsinIoNq8v3El7xvbwrFf1utABEi33FE=; b=AGri+1KrnjMVGbQFgqBgJ
	s02+5lrNsbx20fjC+Ss71qcLky+uSRdtHcX3ae3iDBPhYh4baIgMBcnScrstoP2u
	wjDcwyvM8yHsoZfQcZhDmfyszUVKBrbdbU+1JP4S+/9K+W1jQDIKkecRcb6Y+/cX
	/3ZsJ6Gua5TITvgOexH3Ivx7PRFjonTqyTTIv8cEcJQF9qtybqGUAJcq8ALI80Fl
	0JsnAMiYqcswp0pI/Rzd4T2swctQRChzhMqg3/97p/CCNWRmh1JuJe0COG4dh9zF
	rvkdXEL7BjjesvMdA5aM2ajvQy/BvFFwtI9ikRmF7sy33BzCINQSp2zruJBmGgtQ
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cmn4kbq94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 07:21:51 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 622CLoU0002144
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Mar 2026 07:21:50 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 2 Mar
 2026 07:21:49 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Mar 2026 07:21:49 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.225.130])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 622CLQqa010564;
	Mon, 2 Mar 2026 07:21:42 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Michael Hennerich <michael.hennerich@analog.com>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Petre Rodan <petre.rodan@subdimension.ro>,
        Jorge Marques <jorge.marques@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] dt-bindings: iio: accel: adi,adxl372: add ADXL371 compatible
Date: Mon, 2 Mar 2026 14:20:58 +0200
Message-ID: <20260302122116.1282-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302122116.1282-1-antoniu.miclaus@analog.com>
References: <20260302122116.1282-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEwMyBTYWx0ZWRfX7m8J3dwk2fQX
 IJep1H/p4lItl7ezBK3x148dK/0y6HS7m4tKHsggkN5gt4EEFuzgAC1vjqfJ5aanoy4dJJLa7Ax
 qq55PrwNt2OfhJl8skxVoZIX0d2dFeBSL/SinlHsmZPAGsR0GoMrj6AOEKQmNjQxlOKiMvvpIsp
 1zpMoodU/DhtUvMSCf6yYhVoou8BUafNiInuqEX4WyT9bSla8p8839aWqDhTd+MXovmmQmNg7Lt
 2beVbHebiWsuypXzqF8ha6uzzi9Dz9qgP69aBWMeutuAAeADHI77cqDIBAaA5KuCubk36XFLgpm
 1aDR6n7Oko1nUUH8w4B767XPf9wb16dHkx17I99YEeQ7ASBWrZGc1zKF4gPhxtKmHxbrxByk3/l
 +R6qwZNncQZB0+Qm1Te57wD9ouiwqYp5EMQ6Kkvgv01Qkyus9JH+ktQVKNiIu/JXiyOsAi8zSjj
 AXtmN0vy44LhYl3v0aA==
X-Authority-Analysis: v=2.4 cv=Y7P1cxeN c=1 sm=1 tr=0 ts=69a580df cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=85po4vX9ZQbJAwHx--8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: 9CyshAq5Hq76CQKamDpS1GbzFLbn2vy6
X-Proofpoint-ORIG-GUID: 9CyshAq5Hq76CQKamDpS1GbzFLbn2vy6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020103

Add the adi,adxl371 compatible string to the ADXL372 binding. The
ADXL371 is a +-200g 3-axis MEMS accelerometer nearly identical to
the ADXL372 in register layout, differing only in ODR/bandwidth
values, timer scale factors, and a silicon anomaly affecting FIFO
operation.

Update the title and description to reflect both devices.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
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

