Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3023D6CA3;
	Mon, 31 Aug 2026 08:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165132; cv=none; b=c4URWiVElA30+lSCj0Joi21cF6SQLPYcuqCBVl/K+sYt9F20ODLmx/HJccgWsmJ3nvp6o4S5UxcbC/XZKyTvn75hFWW1DtfHMg+pHVYVOB3Hm9e3226ylWbKwquK5SChwZoEhHMwupQug5oUmnVm/Id3rwxWY3Y38LONYXWa6dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165132; c=relaxed/simple;
	bh=6HZGSsKDpxQJsjdmsWeFZk+TtCdbK8GJ2TRZmJXQgK0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OiA1dwyb++BRDfL62hcZp8lnBxCdSj/2nm1UDr8pajKSUOAS5IZbYTqeH/+R9KcmnF6TxrS/QHsZ51Gg6sOEDsdG5mI0LDb85FOOoG1yjmmbuawylvZpopj3PMdv6BLbhONmNqU3XPqGRwEiAP20wPG1axW+LBXrKC37PgmI4JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=m5lemVTg; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="m5lemVTg"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V82w0I1288846;
	Mon, 31 Aug 2026 04:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=XHfZw
	SH6hfGMqnzF6k1hyxx/PVsM+w1vfot49Sl5jX8=; b=m5lemVTgogej7LX2b3U50
	OQMUw+wuklxSKkpVtLZSI3ToZDZO6LwqPErEorYKXawRDMhKt2JoA/L7XEpjZaQu
	xjsbqbREe9FMUJHPIeKL3WQYqFx+0wCboISPh4uthaqtYERNtJ6iHcy5xvhvV7et
	BaOxICVTVuBKj7uTd1+0AABD4VnfepV0S1lnwNdG4UUEG8RqOBa9gALfpvSJSqOF
	Nt3qz180UdnfRIbhE6PbLAbbfWeRNAlgD1DO+KpWBV9TDhnOLmTtvYj7ShqAtIDU
	gpjVeR5bEPMmEBjhEcIFtpJFJ4AnkThEFGMmftx+T7XPinq70KhaIjZ0EE/6sxNk
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gbs90y3ne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 04:31:49 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67V8VmIu012503
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 04:31:48 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 31 Aug
 2026 04:31:48 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 31 Aug 2026 04:31:48 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.222])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67V8VVag006721;
	Mon, 31 Aug 2026 04:31:41 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/4] dt-bindings: iio: update unreachable maintainer entries
Date: Mon, 31 Aug 2026 11:31:19 +0300
Message-ID: <20260831083122.3486-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831083122.3486-1-antoniu.miclaus@analog.com>
References: <20260831083122.3486-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MiBTYWx0ZWRfXz/r1KunpI8ab
 1S47+e0/tYZhIgfu6JILnEAio8uv2n1bhTNvsAUlZ9Eydxbq+PEdPj5TymczzVDg006OsuUP9qG
 9/g3eftuuOUh/2fOApLeHUfND7McVXceFuZ3cxe8qDuVG9WH2B/Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MiBTYWx0ZWRfX61Ee4jN/N2sR
 cQa9hKP7i+RJrcL9Gnh0GhMoj0k7BX7am4El7rRxR/RDRqh6JHFVs2Yj8STEwpAmaiu1X1AHg48
 PaA+5gdohxpBayAA2d2ZIRiO/1V+nDLyubF1B8pueKS8QhhR0lvL4h8C6XnfyyXEheUaChCX+mr
 rcwXLTQLLdEV6Y9799ahRAKcmTK+7KVXompK0C82Q/J+gMf4/WSZzkIfZwOTerUNyg5xq6Q1uo0
 +2kQ6GWS7d6uBUw2BOmjyZvP0zlhhr1O+6aLw9LEpzVI0lDuCkpVsMDQVWq5NABQOj/0mNLz8tx
 3/Jd5X2C2Mwpvamdw86JXdcoD0rAorWTaPUUCNSv+aDclVc094+keKdnGGltsC7WtQGgTvinr1H
 T9uhiFPe3dKG60Q+Xp9bCG64U8QoZi80A6NplRvdm5tJ2ktMD6MYzHNRhedy20nKDC5/w7II3TP
 7V+hkDklugdC8FPFdwA==
X-Proofpoint-GUID: 80qHS_XGIxN2AqQjMRBGP0gF34neapt2
X-Proofpoint-ORIG-GUID: 80qHS_XGIxN2AqQjMRBGP0gF34neapt2
X-Authority-Analysis: v=2.4 cv=c9Cbhx9l c=1 sm=1 tr=0 ts=6a953bf5 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=0BJKTBZvRJlxmc1XXDQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310072

Cosmin's Analog Devices address is no longer valid, leaving the ADXL367,
AD4130, AD74115 and AD74413R bindings without a reachable maintainer.
Take over maintainership of those bindings and add myself to the
corresponding MAINTAINERS entries alongside Marcelo.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Changes in v4:
- Collected Reviewed-by from Marcelo Schmitt.

 Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml  | 2 +-
 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml     | 3 ++-
 Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml  | 3 ++-
 Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml | 3 ++-
 MAINTAINERS                                                   | 4 ++++
 5 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
index f10d98d34cb8..29689bc38b90 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Analog Devices ADXL367 3-Axis Digital Accelerometer
 
 maintainers:
-  - Cosmin Tanislav <cosmin.tanislav@analog.com>
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
 
 description: |
   The ADXL367 is an ultralow power, 3-axis MEMS accelerometer.
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
index cc38617bb829..a4ab6adef1c6 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
@@ -8,7 +8,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Analog Devices AD4130 family ADCs
 
 maintainers:
-  - Cosmin Tanislav <cosmin.tanislav@analog.com>
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
 
 description: |
   Bindings for the Analog Devices AD4130 family ADCs.
diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
index 2a04906531fb..6aa86cb56032 100644
--- a/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
+++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
@@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Analog Devices AD74115H device
 
 maintainers:
-  - Cosmin Tanislav <cosmin.tanislav@analog.com>
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
 
 description: |
   The AD74115H is a single-channel software configurable input/output
diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
index 590ea7936ad7..5318a00e7669 100644
--- a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
+++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
@@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Analog Devices AD74412R/AD74413R device
 
 maintainers:
-  - Cosmin Tanislav <cosmin.tanislav@analog.com>
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
 
 description: |
   The AD74412R and AD74413R are quad-channel software configurable input/output
diff --git a/MAINTAINERS b/MAINTAINERS
index 04fa5322d9f7..ade07e6637bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -641,6 +641,7 @@ F:	drivers/iio/accel/adxl355_spi.c
 
 ADXL367 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
 M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
+M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
@@ -1493,6 +1494,7 @@ F:	drivers/iio/adc/ad4080.c
 
 ANALOG DEVICES INC AD4130 DRIVER
 M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
+M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
@@ -1598,6 +1600,7 @@ F:	drivers/iio/dac/ad7293.c
 
 ANALOG DEVICES INC AD74115 DRIVER
 M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
+M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
@@ -1606,6 +1609,7 @@ F:	drivers/iio/addac/ad74115.c
 
 ANALOG DEVICES INC AD74413R DRIVER
 M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
+M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
-- 
2.43.0

