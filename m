Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223C43B5F63;
	Thu, 20 Aug 2026 07:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787209769; cv=none; b=Pw8guK8IcE6/wHvxGTTKbTNo5S4scIqb2P+Yz0ysqKr/Kuj4LWg0u4+iDcYSIr0LJRWicuSCaHn7HMXLu0nzS7EeT35AxqeaE2BlaySIO8NbyRkHtQ6AV/eSaDFfB90E/If6+NbsfzBgDQJOzcuqUsTGJbnlICiCHa6WlD+G4Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787209769; c=relaxed/simple;
	bh=ZKN1B2gZYBwuyNnxocxDDBrNCih2O5jweGLmrMvotJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rOtFMeXjsmp8dR+9VXruJS/W8y8n5bHsipm7LdKn8KxQQ1aG+L0OWaJvNszAq1ylfhNA6VpIulvNrmknEiCJFVIy7wpkRrfeKV+zSrYycpPHq75HOzNGwxMM8jWxsDYUcID/+G9AFAsF8YShyDEsso+eE6pW1z9S22z7ai+IFY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=aPxtgK2n; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="aPxtgK2n"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K414g43166229;
	Thu, 20 Aug 2026 03:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=c8Rp8
	EOzkyMI8boZQTY40lparKG2slm87g2a/+q88n0=; b=aPxtgK2nk0GxLk4aMJIL1
	twcYACcEaPq1VLxioW2IAjxA7xjxcXVlJySRPqnDZr+k1oasKlgQhlR54HIzyV+v
	VvmWoH73qBBop9vL2wwoWb+GINlLfydY4KnQ1EWonq26K2JlD9QnjTuSS3rE0DSa
	J7mY2OecBrmLuR6bLhZZwGhMb67bq3Goc4tdP5i8TezIqP848Plok2G4xVi0Qln+
	FoxogNBLr6tzHhtUrp4xwR4f7xBQtcSAqyeDHX4a+I1igKKnMwKtYYmtLmY9W+zO
	agiZitEoz9NlqvOEMzl+UY/wEAam32W5lcgelyL3X/4xIUF0rOw4RhLcvwQ9m21y
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g4yfbh598-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 03:08:52 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67K78pjG018792
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Aug 2026 03:08:51 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 20 Aug 2026 03:08:51 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 20 Aug 2026 03:08:51 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 20 Aug 2026 03:08:51 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.68])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67K78OkZ003019;
	Thu, 20 Aug 2026 03:08:45 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 20 Aug 2026 09:08:21 +0200
Subject: [PATCH v9 1/3] spi: dt-bindings: Add spi-device-addr peripheral
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260820-ad5529r-driver-v9-1-ba62e0b2a816@analog.com>
References: <20260820-ad5529r-driver-v9-0-ba62e0b2a816@analog.com>
In-Reply-To: <20260820-ad5529r-driver-v9-0-ba62e0b2a816@analog.com>
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
        Kent Gustavsson <kent@minoris.se>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara
	<daire.mcnamara@microchip.com>,
        Paul Walmsley <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>, <linux-spi@vger.kernel.org>,
        Kent Gustavsson
	<nedo80@gmail.com>, <linux-riscv@lists.infradead.org>,
        Janani Sunil
	<janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787209704; l=1442;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=ZKN1B2gZYBwuyNnxocxDDBrNCih2O5jweGLmrMvotJQ=;
 b=enKpVGYoGz7FY2BNinLZVvp/ftfLGXdjoVVghGU86biCNk+K86Dq5QdYpSEhzqyG0GDoVb3VU
 M2tCLkxlw9JDetpeuk/wD63J98wnFj8j1BNe8/5AXwtZqS6I5jC/F15
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: aYdxdomK0ogdalLcYWCfNU-VbXALsyQF
X-Authority-Analysis: v=2.4 cv=KbTidwYD c=1 sm=1 tr=0 ts=6a86a804 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=XYAwZIGsAAAA:8 a=pGLkceISAAAA:8 a=p7DZuduEnTu05McJuzUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA1MCBTYWx0ZWRfXzNFA5vxlonkc
 MsMm/7/4aQyjMBC6zF54mwdH9QhK5fHVYAdftQYs0jOmHD/kApRbTT7pE+fWgN7o64ZQWYvdOD2
 6835JJ6YH87/cJoPB+OLukAf9dPqRh1DCLXkCpD8zC4CuHkCxxjFSl6mumVxngR76oR/vWHBAtp
 G8Nb5HSuUaqtDC3U2bAOZ9mK22cCLF9OgLwr9bcWLKf9MpsCGyji/N8fCwGxfvHclghBluXQCkW
 nioZHYEnNzoZl+tGpQWPYma+FTImE6J5d/WAKEBjSSzobhSkfHvKlzObU2LUNZWue0BM6jFPuW0
 7K8JldOb604BECo7RPniqD3e//BMxXmeB46rts6GL26e0q1LScN01pAu44bzuUzTmV3cIHqd9Ea
 tj3nM2O88IPdHCYwiU6NKNpAegwiSZXc7HEPInDDvx4Ym/ZT+DZUFTujTWKQ/zUayTunFUD3KKy
 xD9Ho8yYAWlcfgUp3AQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA1MCBTYWx0ZWRfX+rLpp9Jfxnwp
 W17a3XTdEC5y94YmECvUwLW3SW7YrImxs1bsvVuYiPuReIoNC5fP1W4ov+1K0aP376xecd/Hqf1
 mwci1/ZE1yQZD/5U5nHw4ZZwwRY9S5P3fJ7wi8VV9Yn4OQSb05pU
X-Proofpoint-GUID: aYdxdomK0ogdalLcYWCfNU-VbXALsyQF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200050

Some SPI devices support sharing a single chip select across multiple
physical chips by encoding a device address in the SPI frame itself.
Add the generic spi-device-addr property for describing these hardware
addresses. The property is placed on the SPI peripheral node and may
contain multiple addresses.

Acked-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 880a9f624566..4894196c8f9c 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -142,6 +142,13 @@ properties:
     minItems: 2
     maxItems: 4
 
+  spi-device-addr:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Device addresses used when multiple peripherals share a single chip
+      select. The array allows one logical peripheral to comprise multiple
+      physical devices, with one address per physical device.
+
   st,spi-midi-ns:
     deprecated: true
     description: |

-- 
2.43.0

