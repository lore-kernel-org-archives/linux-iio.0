Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182CC1C84DE;
	Fri,  6 Feb 2026 19:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770404448; cv=none; b=u6w/CeG3E/xb0RJG1rrq76inK+Xsd1Z9166tQ+/xdAkzdszXpsbWMYY4BO+7UcAD1zikE8R67fKXtCF3RGtJFM105JMCIPz/8B4/2mC0sKrmVr3ueZAELEt4wXZ6CbBYkl41BxLLB9xHfQndVAuc+qR1WaRkqvVoNzELS89wK+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770404448; c=relaxed/simple;
	bh=adSjX2UpOkyJj/sBCT1RL8auPMy93T83fL/KA1ih2Ys=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YbZoKiSO9K4uOGCq6zUGtW7VzGxG+hCvZBtTOxVdp8XAroXhfU+vqokY9/tPAXo/ogeL+HuXavuFfXVwmkxiOkBwhqBGbXgQcTY3/PC00b9tHjkJtAZRsK9EqJy0mYCrl0SgWELCEW8ArsNfYfZexdfbeMA4WXXYPByBmB4+RsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=iNY8jJic; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="iNY8jJic"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616GLgsQ452354;
	Fri, 6 Feb 2026 14:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=+CnSX
	z86jFUOk9ZAWFBrXnEKhswUkaQmNSXH9YVarRY=; b=iNY8jJic40xGLtvmiV2cS
	Y8yAKzGPvo4ck3iEmU5hMgZskzv4P5HsdC5tkPY/KE4UAlgYc8CioMT/dxC2IrV0
	PLJJYe/8Ton7R0EiaFYEClgwOQKxgH8pwC7Lv1EhZFJ4j2uNgfnOL00/NglEXREP
	9Lw8JutopvkeGqQikt1rPzCGA3MBH/3HCWuS9IDaSvc750NGjgT0Bjhu9Ge4G88d
	U1mroHIKRaWj6XgRMq7hT9FoTvGu6/f7nHLywsknrXupjPMgjhnin3povxOoXIFK
	Ivt21gUZwJ1CNdrBqOBfaFmTdlKDoNnWJZyfbtd0FdGmpvliI2CuJT/2L/mHrd5z
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c4ygqw0xh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 14:00:40 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 616J0dYp012615
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Feb 2026 14:00:39 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Feb 2026 14:00:39 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Feb 2026 14:00:37 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Feb 2026 14:00:37 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 616J0NJw008942;
	Fri, 6 Feb 2026 14:00:26 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v8 1/8] dt-bindings: iio: adc: adi,ad4030: Reference spi-peripheral-props
Date: Fri, 6 Feb 2026 16:00:23 -0300
Message-ID: <c81ce2f8e6851cd2ac3620d7eece7aa41c188544.1770403407.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1770403407.git.marcelo.schmitt@analog.com>
References: <cover.1770403407.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: vzB1QbkUkf-GyByBUP1-mKiJ3xQ-bbGq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDE0MCBTYWx0ZWRfX1HvTK4ePbVXG
 2mp+XAajUusmruLKXbiPOTQObODz2oo11cY5lik2R0ZbXBezlo/FbWqC6nkLc/wHtk9C3sp5SZ5
 98CrlIJlJkw3t9800TaiSBhWC9T1l1PfII9soDT4Alodhhsv7IHSqBgawFzgvSUePnAyEh9pIHh
 gfJxDjFZOnOYjhfr2cBDHbBBfkotP5iVqen97gprz5RMgUBNZ5X/g2KdZZNo5N8i30VC3Jaze6+
 kgH5htqr2mYqX9VU0gYDVRBT8TeCZlifqPwVkKzNyTjy6WgD94xeEdfyCnizxlDsOdvHkkeaSPe
 VdE80XiM4rn2qS2PKJUFKbh1HFm1cuBMMyFiRvcTOshMtSUNVt74ZSjE7U/Ys4C2B+AnmKgSB86
 M48taSO7JlHRbv46tcmgK0Uin/zrSEcnUl8axuoBp+GH30pIUry7emLzCqFQawAauOM/2TZds00
 E+yYwONdO4RuuV+Bavw==
X-Proofpoint-ORIG-GUID: vzB1QbkUkf-GyByBUP1-mKiJ3xQ-bbGq
X-Authority-Analysis: v=2.4 cv=CLUnnBrD c=1 sm=1 tr=0 ts=69863a59 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=XYAwZIGsAAAA:8
 a=EfQ9L3lKGMo9VN_2EekA:9 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602060140

AD4030 and similar devices all connect to the system as SPI peripherals.
Reference spi-peripheral-props so common SPI peripheral can be used from
ad4030 dt-binding.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index e22d518135f2..29e266865805 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -20,6 +20,8 @@ description: |
   * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-24_ad4632-24.pdf
   * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-16-4632-16.pdf
 
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
 properties:
   compatible:
     enum:
-- 
2.39.2

