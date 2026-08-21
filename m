Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288AA385519;
	Fri, 21 Aug 2026 18:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787335700; cv=none; b=NmPEwbNYQa+tcle2kWK4j+EhmBaP3WTeZku4qoNNpo3IyxNWva7Ml+C4au+qe+IEM3fHB56yTCuabPw2unrZMvP29EQDljPfuPViH46bL8d/HrXfJ4zdiWZZb/pRfdcFpdul2zx+eSGfyCGmdISxq2VikViE75oitIvnZCBN8ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787335700; c=relaxed/simple;
	bh=czCZLlzYJfvUjnJjFsEazB9Ss+RU9pWOcPJyLdmflq4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uNjpLbZ8LySBpLpTOZjDm99okt+EzHZbSrz65guHWWvFXceRj5CkmA90my42tMr/9l+Q2ZSjzD45S1Hvfc2WhBqtn4vQfnmrA0rSlEReDyiF3P+rji7KdNQfqPZlKCrBzZ+2YqONrMDEy7JJZgsiq+QVPE2wIzIcj7fYsHb7bLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=JaBaGCdI; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="JaBaGCdI"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LI4bh53681586;
	Fri, 21 Aug 2026 14:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=9lTJ5
	5akiwY8tZNEGKx+8zmUHTSjQlAXkIahlG9jKtk=; b=JaBaGCdIovSXYtcmP7zYz
	s+P0YuGbqJqGoHkq5N7LdfTeA2iNGpULkVqImQdrXYMmm87Stwi5v14efs4ybWP1
	6laBt1uCKRd0w5/qJCNeXj2VLLDpxVR21bvH3VzY5fQH1XrHPAtCJoDfJzwxQJzY
	AEtIbRbQF0Zu7oeJygMaD9VhsA11i9IYCcvxhcomLZwh4XCjyezU0iNWB2ZEKAB3
	fdalTeVcg0LZ4rWp1xL2ZxgQDNmF8F2VPq9zTZttZg+mUTcWe89XrugTzLCVZVVJ
	itLWUi0Bk+Odvp4RIVKS+LXI7qcvEKPdqhXfxXrA94snatT2fVJUJkR7mat8lyC8
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g5rk90d9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 14:08:15 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67LI8Eec064940
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Aug 2026 14:08:15 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 21 Aug 2026 14:08:14 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 21 Aug 2026 14:08:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 21 Aug 2026 14:08:14 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67LI80fL032181;
	Fri, 21 Aug 2026 14:08:07 -0400
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
Subject: [PATCH v3 1/4] dt-bindings: iio: update unreachable maintainer entries
Date: Fri, 21 Aug 2026 21:07:50 +0300
Message-ID: <20260821180753.4633-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821180753.4633-1-antoniu.miclaus@analog.com>
References: <20260821180753.4633-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE0MyBTYWx0ZWRfX+ATAqpWYldYq
 jNQhygl10sEVg84Aw3q7fzg+MqEMFy/Q32qu3jf6EsxJyFN12S0hf4KZX7SGydtAmyofVFbGEbM
 PqTwhuTL8ZxRhLM9Qt5Uj++79/Ik+fzJz2uaG50ScI/2ON5sOrBf
X-Proofpoint-GUID: aiIhhW1liVEQ9LH-ZpTKe4TrhaZxpfF7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE0MyBTYWx0ZWRfX/hU69/mLsCrR
 TFLIu4Q5ATcClwpOBwyK5e/7QCAX3V3YPcWk8N0TOVJO3op+L+SexAGQ1Ljk5lcZpSDIqKc+W9C
 dcB4SZNZiSsAbV+D8lw9L34zVD6DLNY+T3hOByli0p3rEU45U5BzoHAQprXEnuINQrw8jKZKCvL
 s7CTdL6Lc0BLmg9gHJWPSaqDXF64B1BBkUQlufF82IeAHIw/mSrANVKnRnEm4qdii6A4Kx0KWJp
 WDl0FN3kUCxk685h+Ni4/zjndIlQgGp1BiueZ2cGCafAWZTv0JxiHZab/bKgfPVru13O2QVWMzc
 uQuuYxGK5fWBOZgp6wzD0h2tMk3PB+ll54eUL79L9WZ4jl+3QeBbwYAPyeHhq9ZTUYyZrkvEH0n
 V0L3ITg6YxMwBBsj4L8qlm2/XSshWs67rAT8C8M37hX4JdsgxjztOdFp51x2dhxuK0bKnYKveEU
 oS6G30Hfs156zI3d6dQ==
X-Proofpoint-ORIG-GUID: aiIhhW1liVEQ9LH-ZpTKe4TrhaZxpfF7
X-Authority-Analysis: v=2.4 cv=P+YKQCAu c=1 sm=1 tr=0 ts=6a889410 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=0BJKTBZvRJlxmc1XXDQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210143

Cosmin's Analog Devices address is no longer valid, leaving the ADXL367,
AD4130, AD74115 and AD74413R bindings without a reachable maintainer.
Take over maintainership of those bindings and add myself to the
corresponding MAINTAINERS entries alongside Marcelo.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
---
Changes in v3:
- No changes.

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

