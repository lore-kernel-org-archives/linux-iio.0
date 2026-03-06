Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D54633B6CF;
	Fri,  6 Mar 2026 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772811579; cv=none; b=N835W94HP/GwUNRpXEKgX/MU4yOfCs9posCST7PA78I8ROfRlV0nGqWhgUlGTksE+0ERihFlbsQhKYIEndug1OXsdAdhTAC+GCC0+P5mQm0p3mxD9T3FFW4jimmCxt6vykOAvFzoEruGxd+2qjNCn+59trl2zPOundKGipZ1o/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772811579; c=relaxed/simple;
	bh=sBgiQ83baS66nD3AEFetTSsAy6LBnkXAvxtjg2Dyb4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2undgvvwVIhqGlAOdKQggEgQ6KMkP16Q9PDlTIaaSAPSmq67cBi6VAt5QpWQwEBdfeQa5P7h+b4H0JPKzf4fB7FpBay6ll5LQnPwa6YWjGU5F0CyHGqvDw01x28X0pRqMbSzsDjfDyjC71DGeR/b3vZef2Cz33bnwgo5ZOTB6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=icSK3TTA; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="icSK3TTA"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626D7qWB3330862;
	Fri, 6 Mar 2026 10:39:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SqkGC
	wE9hcf4vbigYQn7ZXjqMwIgxvCEZDUtKTeCFZU=; b=icSK3TTAv5v6bK4S+cHNO
	GWeipLGxsznH5hSprfydD80uGNnr0F4m+EX+EPx0qJzBb+RJ8gTNCA4LwwaH5A1x
	nt/Okye2VpltR/7PDNlJP0NYYUw20H+yKI0W+5ZH3Qhbaa+75F26COTtG/Hz7USn
	buJDxycxbO+nt38BuK3gK0Bp4t0+5esU+4UW99H28w06ry8X3FzKHFLoFHsKCQ6T
	KH6BWGGRCQulVtQtj4KyUV2BwA0PHejpnQNCeMcW3lsxLmbRW+y/ZNd1lcDFmWSt
	XXmj/kYmBubyFfCJl6JtUoWWYZK2oApsGlY8AUmIyxSLJMBuE7FHwntCBQhqhBlO
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cpb6jvn85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 10:39:20 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 626FdJLr045299
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Mar 2026 10:39:19 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 6 Mar
 2026 10:39:19 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Mar 2026 10:39:19 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 626FctKv002837;
	Fri, 6 Mar 2026 10:39:13 -0500
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
CC: Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 2/4] dt-bindings: iio: accel: adi,adxl372: add ADXL371 compatible
Date: Fri, 6 Mar 2026 17:18:22 +0200
Message-ID: <20260306151859.131934-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306151859.131934-1-antoniu.miclaus@analog.com>
References: <20260306151859.131934-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=J4inLQnS c=1 sm=1 tr=0 ts=69aaf529 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=XYAwZIGsAAAA:8 a=85po4vX9ZQbJAwHx--8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-GUID: x59Rft-MHDiulA_8defNrivKXO7rGmC4
X-Proofpoint-ORIG-GUID: x59Rft-MHDiulA_8defNrivKXO7rGmC4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE0NyBTYWx0ZWRfX1Wj6f0bGDie7
 8Cn/smi2hYujXCMpBKPmXvtQawvNKjaSXYzQhgcxP83VQY+KXZ64VXNMrq3bnMwZIuVICJsUGxI
 +yLZ5GrzNllHURxjwzczoz4/VU165sfQ2VgePUiY0nd/0qR3CvmFs66x71C7iaMEL3LIqPAeCiG
 gQpB8I6lKuXEOzkXZZ4dg+vmUM+9G2kdd4uplDOb0LjZrZMvGYCfzPgj1m8F8ExnQ7P+IW7dqOQ
 YymoI1FPHSupKpZp1Gu3F0QkDo7fhj/soj/P5b9EPv3yWoEeKa1eeg6ff5HRVpfTETarId2xYDG
 oo03ngGHxfa1NQmKBCdMSjsZmiQLpMdIB5xvJzRxV52n0obh1se+LBOmiL+EJpMid/FpxZl1XRE
 EPe+yWNfIAdD9SP3CBld8OgBDBmpk87P+cBrgQaZnvFmFzDvPVTsD1IhLglwzAjRftzPLd6qrs6
 B4HQSH7mp/RTAoQlNOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603060147

Add the adi,adxl371 compatible string to the ADXL372 binding. The
ADXL371 is a +-200g 3-axis MEMS accelerometer nearly identical to
the ADXL372 in register layout, differing only in ODR/bandwidth
values, timer scale factors, and a silicon anomaly affecting FIFO
operation.

Update the title and description to reflect both devices.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v2:
 - No changes.

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

