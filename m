Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477362EC54C;
	Sat, 21 Mar 2026 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774087722; cv=none; b=PKWki34xupkMyiS3b4xxZe8SngCv4pAEkZgA19soSeoAsmdBbEzIpzS1WI+RXsPdP6C8CSY8rel3WeLmKMF91/VifChXNBk3M6ysmi6ZiOJVLEcDaMVXeYFWlvK6F2HLpnqmP2pr0eDhaNWby7QmZIBus9YvervCY2RAJXWnXyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774087722; c=relaxed/simple;
	bh=i42kPBtMAxsdh94IYQ1R9RK00+hwdpG/RwU8nHWVIBQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQMkeCNtSFETFt3eAKo4/VW4i1mP+rVWQFuoOw29snBAX3MmbHM5BIzYNkIZcsJDQQQ8Ord+LA2ooo3k07cI973uhZ8k4UL0UaNJuGXgx+WGqe3X5rUS7L/Ar4KsVyCZwN7FzTjOg5Da5pUUUREzCoqRDO0fmxdRCYT+X6XMtkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=05CB6g7Q; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="05CB6g7Q"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62L4pgio4101438;
	Sat, 21 Mar 2026 06:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=eICa/
	2mAWhd/A9sXj7mNFrNn90mT+hl0T+qTC9TrGpY=; b=05CB6g7Q9KWQOvBHqqpUd
	qwC/ClNTQjBq15Ox09QDONy3+pT10CL2fN9n9yR+9c88prH6qyDUaOnnawHUgQx8
	fKtQEv0+cCNwKdgC42rgYpNtfbqF8l3tHQETZDmNvAPdgizlusk2x5M6YySaRy1/
	CFwtJs/FEyHx8QR37IEyrNRCN72OyaQ3G863JkqVOhjYtkO68syHsh2Q5NwfXhym
	xVI3T7hA1WcZvPnB+N4TLSGPVpHL0FY2wbOQrp9OYYhSVyVDUt9OlzteGanuI66Q
	IXcM06STMO/dTyNx3OzwpGkBQd5nZBFocf2HG6L65mRtrss0xwqGQOSfJ+Hjwxqt
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cyxn24nc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 06:08:18 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62LA8HAM041656
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 21 Mar 2026 06:08:17 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Sat, 21 Mar 2026 06:08:17 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Sat, 21 Mar 2026 06:08:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Sat, 21 Mar 2026 06:08:16 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.226.156])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62LA7nOK016475;
	Sat, 21 Mar 2026 06:08:07 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Michael Hennerich <michael.hennerich@analog.com>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Petre Rodan <petre.rodan@subdimension.ro>,
        Jorge Marques
	<jorge.marques@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 2/4] dt-bindings: iio: accel: adi,adxl372: add ADXL371 compatible
Date: Sat, 21 Mar 2026 12:04:57 +0200
Message-ID: <20260321100729.2440-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260321100729.2440-1-antoniu.miclaus@analog.com>
References: <20260321100729.2440-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=PejyRyhd c=1 sm=1 tr=0 ts=69be6e12 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=XYAwZIGsAAAA:8 a=85po4vX9ZQbJAwHx--8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-GUID: u2loBGukDEOOsBXnkTwoFMv_p8j8Tq_c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDA4MiBTYWx0ZWRfXxoZMft3rknAx
 q/N2UTd1a8kEl1rsBycQU+nhn61BtVTpE2jZ6jrQNIDw/j5mhe+HlsvDtdr2FoO3TXL8HVmJoDt
 OgeNQ3o3ryfpVRWK+eUz2eKzgWYNM9ICBGvcVRKrMxBXQiAgMrZEPrzyMYTNvIJYVG+JAXYdXgY
 EfxR5QPBy2Lo/m3we7XinbqPSdBZ/hPssDiaFnzWdi8bjbA84mbAxiU8m2lTQeKgZpk7EFNz3C3
 SoV38OvF8RAdDduXzXpel8CKOgh+cAiUPEwQXkhQ3/qItyuGuHI5IjE55nmRQmCTUVuQaVJUV9+
 JWTjbxb21OxQ/OLsvQOm2tqvpZJ9Nb9PafIcL2PD1evZmX7sd583fT3++iYBSnDpc6YwNiiv3Ah
 TuE88iEvg0hU0oK8At9qilHFCKEpJlTILoJY5d1J63AFr7Gtkp9L7H7sytSb6HNI81xbZaFR+Tp
 Fn1HoODj40wxvM9b/yg==
X-Proofpoint-ORIG-GUID: u2loBGukDEOOsBXnkTwoFMv_p8j8Tq_c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603210082

Add the adi,adxl371 compatible string to the ADXL372 binding. The
ADXL371 is a +-200g 3-axis MEMS accelerometer nearly identical to
the ADXL372 in register layout, differing only in ODR/bandwidth
values, timer scale factors, and a silicon anomaly affecting FIFO
operation.

Update the title and description to reflect both devices.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v4:
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

