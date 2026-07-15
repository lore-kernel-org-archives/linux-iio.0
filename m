Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F00432E86;
	Wed, 15 Jul 2026 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115718; cv=none; b=i0Ihb/AgGRFkxTiV36ThL7SiQUiOHRSPns4YSFQPscjj2pL8zUctWIaGo6XPo297Dzk+vyIANqvUZEFFOOUdb+tu/CoL2Hns61B9p79VNQX8tmEwjfOne//PN4iVJ3Jf+1i4UDiXp47FOf93G5ueccSwF4I2SzGjbeqv1Aw+EPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115718; c=relaxed/simple;
	bh=SNJI92VrprHtT5MzdFsRMm8PBprcV5VudH8UFNZRHUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oKTDGzUnYNDkteyBARdcEAleVy92wbF14mPoM6Ft7mrVJL9BCByEZeplp2xj4CrQYfj9Q8S8BC4KBePz0y9yesxU33w2hxphzuC2sRXadZnRyuMJMFMOD18LlbQNnWAesq0kA59jhf9RYASJdbWJvSmmdq4UqWnAqXU7rIswOo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vmRwTPna; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vmRwTPna"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FBZjUo874893;
	Wed, 15 Jul 2026 07:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=BE8eW
	SesmvUP52eRWrhETcYMR+9iEWP4oNF9iE59a/0=; b=vmRwTPna0MewKPr1yaSD2
	NlgFDeYCTd61bZkqWouOspTWRkiB53bgg9QYbG/lhpBq0YMrQ2tX28UkbBEXSt/+
	PGcZYgkEdi6x03vwc85bczhiyiPzGX+I8AmQG4mrTQFURW0c85gd0tRqfC9GGPnH
	iKglgDZrF90/YQS4TRFOL5GnF9NRHjRSFI2ZLgG6yjctdiNjY1r3M/Afe6M7zBwF
	5/7+1Ru8PlGKS3fg/Qt/GxA/xFvot2a9gk/fQzJJ6ufT/2Bcc2PdCEYlC4WPvU/N
	xwpxaeS5cst2gg+fLJJatwX1WGXJvAsnALh2KjnxKjfOYkzCLnxXV/VUX/NbVPHn
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fe8a8883w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 07:41:36 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66FBfZgr004882
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 Jul 2026 07:41:35 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 15 Jul 2026 07:41:35 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 15 Jul 2026 07:41:35 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 15 Jul 2026 07:41:35 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.54])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66FBfASq024964;
	Wed, 15 Jul 2026 07:41:26 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 15 Jul 2026 13:41:04 +0200
Subject: [PATCH v6 1/5] spi: dt-bindings: Add spi-device-addr peripheral
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260715-ad5529r-driver-v6-1-cfdf8b9f5ee3@analog.com>
References: <20260715-ad5529r-driver-v6-0-cfdf8b9f5ee3@analog.com>
In-Reply-To: <20260715-ad5529r-driver-v6-0-cfdf8b9f5ee3@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Jonathan
 Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown
	<broonie@kernel.org>,
        Marius Cristea <marius.cristea@microchip.com>,
        "Marcus
 Folkesson" <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>, <linux-spi@vger.kernel.org>,
        Kent Gustavsson
	<nedo80@gmail.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784115670; l=1148;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=SNJI92VrprHtT5MzdFsRMm8PBprcV5VudH8UFNZRHUM=;
 b=pzNNW1QbN+ccdNtmkPwTFxF9iqFGKbQUrmN0S7awc+xek4HDg6H3THNO8ijwYeBa/+I1P4H5W
 EvwBWa7adgTBrcABGeclidNoJbMWTGl+cKJ0NoRAH4KGkR4j/ctbzD8
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDExNSBTYWx0ZWRfX1hs7wp4VSwTz
 Q3EUt2AteiS47mKN1KWiy3Fe4QtNUZBbRPrss0FCokb8KBHaQUfIXTzo0jM1Nckq2kclTLnH1NW
 X4sl2SgjDCwnyYQc5I1uvVr9PqQfVHpBeehqKyAUOr4UemyBl6u2XxC2B8XUIv5sD86FcZTUvHu
 JKMz7fKLBDOz9hf1lxkXVp7jPoNiKChTHQvnGGnzHw2Aw4U8UZLfmCE8l1ZW+rbfGjkyn4/IOqJ
 z8W79uBepiKLU6wxL76QX4KgHESlqqyQhinkKX+yhGvDpiWx5oe0GY8ofw7A3s2bo3BJ4N7nI+7
 ryYoB/SkrzC8VOCqPFE2cJYurTI4Z1zqiKNtmc50AEeElP1FFCRcOpCFTEWltGdqwGks5LF58ZX
 3HZk5By3axn7kuhEQKCd3D4d/JA+JiXr8oqjkzooVBEDNbvPgZN4jcGSLC9cQOPdHm1gdhjQRgj
 5CAUKb0D7z+ZijMxmMQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDExNSBTYWx0ZWRfX7VunHA09cExb
 V/Lo1JX/hMo+mVonSF4yKirmlwDy28mIkaJ8z+zxZ3o1aJyjpsVEWw4xnvDq3h7tVo8Ilp5TlVZ
 bSjuREix5pMbXYl24SklRkpZz4ZH/7P3JdeqHhFVrcl5cV3kmOX0
X-Authority-Analysis: v=2.4 cv=R4sz39RX c=1 sm=1 tr=0 ts=6a5771f0 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=p7DZuduEnTu05McJuzUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 31ukvQkm1fW_4KvNVQb5YUvFd8FAehHz
X-Proofpoint-GUID: 31ukvQkm1fW_4KvNVQb5YUvFd8FAehHz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150115

Some SPI devices support sharing a single chip select across multiple
physical chips by encoding a device address in the SPI frame itself.
Add the generic spi-device-addr property for describing these hardware
addresses. The property is placed on the SPI peripheral node and may
contain multiple addresses.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 880a9f624566..135657582131 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -142,6 +142,11 @@ properties:
     minItems: 2
     maxItems: 4
 
+  spi-device-addr:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Device address used when multiple peripherals share a single chip select.
+
   st,spi-midi-ns:
     deprecated: true
     description: |

-- 
2.43.0

