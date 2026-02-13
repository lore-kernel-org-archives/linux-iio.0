Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C35E362136;
	Fri, 13 Feb 2026 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770994057; cv=none; b=jht9PjLHnk+5p02+FMsceF8CL3YGTD0kc4f4S31verTXSZCZj3n/AzRiTskM3EAFgI02ZAJv9PZqpThtVymyXVHftliE8cPGCsvcrjpe37gDfT3wSoxz66wtp23xGncIF4Dd2Y8P/kIiJ5F4C8jpkyJnxr3yAFVhgoD1J1QMl2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770994057; c=relaxed/simple;
	bh=qPMTIsI6X1hBJ+GN9s/Ih40OTfDnKJGZNyRf29awWEQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lcoYRNKGvUnynZpA9K0N9WS42fq3+7WcQ6ecgFAdcSp3PtA0m5Vl5TmGBRXsTgMKb1V4+elSQeJahyLxPXq8v+cOnLavn+oA0FbT82Yp2RxhzrWh1iM+BrlrGEtRXwqzK3mPQLDIDVeOYi7E/LoQP6+tsI2DfKK4aGF6m/sRj6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZDgRO7Gx; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZDgRO7Gx"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61DEEQlJ2059610;
	Fri, 13 Feb 2026 09:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=hUfGk
	V/7WVsOwAMnemm3oupVgJ+ONlhO8U2G7Ln8qMY=; b=ZDgRO7Gx4QmLVGl2bdszm
	QsOP3LOZdX1jjNoaO3XLBCxF190AECZg1ULChkNY4+5X3KA2y2uY8n1Uy2LwI5Jw
	nWmZufhJ9jlGDhIgei1fOfXGrNZbY2LWDrnCq0NJ1WSnmGIdvQmHDrv2yurYTpLO
	FBXLjcUP5F9w34kr674qXOTgw/3EWb8T/0QYGugpQeLrnJXeoTkZTYoGKOHZD64O
	tWLgGwBsqXbfLl8zxFvxMWJ5tSmpedBIcc7FgbhJB590M8vTiHqAqqCm1mf8QfJE
	2EBon4NMtWU3svPywO1isu6wTMnKjw5TAftMPpVAjYMHZCkq4Nx3n8z8ABBYuUnl
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c9ss6astf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Feb 2026 09:47:22 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61DElLTl041331
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Feb 2026 09:47:21 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 13 Feb 2026 09:47:21 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 13 Feb 2026 09:47:20 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 13 Feb 2026 09:47:20 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61DEkrH4018425;
	Fri, 13 Feb 2026 09:47:12 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/6] dt-bindings: iio: adc: adi,ad4080: add support for AD4088
Date: Fri, 13 Feb 2026 16:46:26 +0200
Message-ID: <20260213144629.16001-6-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260213144629.16001-1-antoniu.miclaus@analog.com>
References: <20260213144629.16001-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDExNCBTYWx0ZWRfXzMilZe2UIekF
 nUHpb+r061VVw0XE+BIiZzOK5uz09oN6Se+Nxucp1id0qD9a0/OZPOpjegF1zN5wTTiL/AhyTIg
 ZMSPapzAY2RJIQss5rlxpl3pgcweGhAT4TKTYHnh/TiW0uklGZgm1z0UuBUI8I/zodwvphhd0Y1
 41QnrpKP6oqnJj+UO8prlCli4a9OqSaIep+e493HSb5+Jy6RW56C4J/oQeTOnqeliGvdb5fXlIF
 c7MhRFRwYu1qKAoCFFCUfYmCxhJvl+YP7CPEszUQQJ3PMcZlTaI9Jef9DlL+76dr6TqHcjOzv0I
 oT0AltymS2CG+SosCXL+tAZn3MCUcbGG70leQNEiTq0k+V19MNTuoFq112XXgkKBwg2OnbaxFK4
 26Bk+djDqhRf/sVD1SIOQ14QbOVR77MkeXrDXABRcCgfTgqZelB3E/UsdaSVcqLKoKrQtjKYYVI
 LN1nm8HelztU40cCfmw==
X-Proofpoint-ORIG-GUID: 3s9X6UDakgpe_nne2V-Y_zujNgHDpUXG
X-Authority-Analysis: v=2.4 cv=YJmSCBGx c=1 sm=1 tr=0 ts=698f397a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=r1IkbUOa5G3b9l8KIE8A:9
X-Proofpoint-GUID: 3s9X6UDakgpe_nne2V-Y_zujNgHDpUXG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130114

Add device tree binding support for the AD4088 14-bit SAR ADC.
Add adi,ad4088 to the compatible enum.

A fallback compatible string to adi,ad4080 is not appropriate as the
AD4088 has a different LVDS CNV clock count maximum (8 vs 7), requiring
different driver configuration.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
No changes since v1.

 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
index 106267aee195..79df2696ef24 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
@@ -33,6 +33,7 @@ properties:
       - adi,ad4085
       - adi,ad4086
       - adi,ad4087
+      - adi,ad4088
 
   reg:
     maxItems: 1
-- 
2.43.0

