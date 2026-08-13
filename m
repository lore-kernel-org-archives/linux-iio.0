Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA39A43BDA0;
	Thu, 13 Aug 2026 08:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608935; cv=none; b=r6B9i9Y7gFUrjp8be4UyOQc9JKY5AlV37Fh/JsxMYHxdTgPHlZOqGlljXFmprO2jSJzvKOeltcgz85EVsyiubQI+or/1c/BuBYB3zxKxr4CmUMykwp7EiqouBQC8rv2yjy0pmNTyWkf60QHDIUvXCDoUH1XRP9NE/tOf7XIUlMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608935; c=relaxed/simple;
	bh=dtxPjsHCXqoCKMTtz1bNEMgsUmzcySrZyYEQ1lOtjWE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWBbKuhzfPIG5v5R3Qj4iqCRRP5dcEy7qEoAeD++godrXeOqvIAY/vJwD1z6E9Y12foZUcdAVvBdmGxu/X5eMaSIg1kSUwwHZbtN5aWFmhoW/0PNeC3BckZZP5WMqrrm2/wyPS/6uXhSBWHblkXd4YtY6iVPDKAPes9jI0v+i+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=JIDi3gUL; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="JIDi3gUL"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D7wwbQ1310340;
	Thu, 13 Aug 2026 04:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=F6LWP
	GqSVnyElK9k2WFrzN6ckQrTWF1lL2HUEvhK//I=; b=JIDi3gULw/147o8kFdilk
	lj+05fiJrTn0IewzBlhGY6BmlVSmLOPeKeBLgGbZoIqo5HUfbVJRmYRCPlfF1sHl
	4pZQy84X7MstciG/QxScuHnOCAHz1H4NSP68qYpnJYtPiLTSDnwHWHffR/seqA8B
	5gyxAFsCd3ZuexJsQLqHE9/KuyOFonoYCfVKqZOo+pke7kIaV+hbPXdcSvD/1Ety
	TD122mmruqcRwlx8ImiFos4t6fimCBVWdLa5a5Py3Nde4Sao6ogc9p8dyQJ1hCIY
	OGu7XmWLWjadxPRe5a1dF6BWdHbCSJd+Ih3ZYf2H9T8su6ZAvxNHYOoZp74B+wWK
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g1a0ug441-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 04:15:24 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67D8FNog000780
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Aug 2026 04:15:23 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 13 Aug
 2026 04:15:23 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 13 Aug 2026 04:15:23 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.182])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67D8FArt008160;
	Thu, 13 Aug 2026 04:15:16 -0400
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
Subject: [PATCH v2 1/3] iio: accel: adxl367: update maintainer entries
Date: Thu, 13 Aug 2026 11:14:50 +0300
Message-ID: <20260813081452.4289-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813081452.4289-1-antoniu.miclaus@analog.com>
References: <20260813081452.4289-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: BjXASCT70f2dqN2GyDq9CfTZOHlho21P
X-Proofpoint-GUID: BjXASCT70f2dqN2GyDq9CfTZOHlho21P
X-Authority-Analysis: v=2.4 cv=QbJWeMbv c=1 sm=1 tr=0 ts=6a7d7d1c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=QO6Q6cfwFafb7JgrcAkA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA1NiBTYWx0ZWRfX35y8PoYPy/sM
 7k4NwDV1R+rx0meKNN7dQPL17uwVbchqSqX81xvJKk7rH3/EPOGYyA9NbrNlM+wEnW3l+yLDw3i
 EH9f+DAWb9VmG0bVtN0VK+GIWTa6kPeC3p9wUHpGOleXhlucqJCVntZI2DEhOSsm2QENO0WKDr8
 EbiFm6jQVSlPrwtDlrddM2a+IHn+Y3d3BwpVknC5JY2cN5VJ+P3o+mEdcy424E2Bk3G6xhQGTyV
 fonK4h4NbJ7RbJVuukq0Ul2YRkC9BgUrZCOeam5GrTiJtnHr5rLL1vd7Jb8v4eaIWYJ20MdZcoW
 6UNUpdKiW1yPCVQC2vhRCCCltwA0Zis9uYd312csOL1tgnLwueI33Z9aT+FHscebDsSLfnANUmI
 DDZPxAkn1t04SnXlF0GMGrtpINVj8nFQ11JiACwJBBDW4+3J/orAUaDGnbd04D9+wjUgLph3pIu
 pFH943vxzanQfZXNtJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA1NiBTYWx0ZWRfX2DFE9SfxU88g
 5IkSTDqzZSe15MWEaGwdf8Hn4P2w+WXRRv/9A3ILhbN4hWuQsEpOMlen85T1QhQI51Judem5co5
 iLC5JArw7XyJlqd/dVdakimv7T84EFN2XsJC+1qr39tvENAuGU+z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130056

Cosmin's Analog Devices address is no longer valid, leaving the ADXL367
binding without a reachable maintainer. Take over maintainership of the
binding and add myself to the MAINTAINERS entry alongside Marcelo.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v2:
- New patch.

 Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml | 2 +-
 MAINTAINERS                                                  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

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
diff --git a/MAINTAINERS b/MAINTAINERS
index 7077ed7c9efe..69e41b262a6d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -641,6 +641,7 @@ F:	drivers/iio/accel/adxl355_spi.c
 
 ADXL367 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
 M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
+M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
-- 
2.43.0

