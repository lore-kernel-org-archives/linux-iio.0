Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112F32E22BD;
	Fri, 29 May 2026 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064078; cv=none; b=ZYYEoouHc38PrCYbAv6InSrwmXGUHcSULxO2x6JC+tNLgVi85XRUv18yyXWMsmzY4syhfESpktw/FG4P2kZKulaWgGRZmgpE3hilDB6smYjeJlotPx3a2mFYZZYc6OnGvnl1IBoMeiExYJfHrWJvfg4Osu2ltHtXUpwsqUo7lrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064078; c=relaxed/simple;
	bh=AhOaR+nHkvTg4yZMxCcUCKyv0aRAfbrC57y+JCU+aj8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gdf5+rMEtU2yVT+7Ekmbm1kL2WM9lssgAQe+u0WZPrrIG8en7CtGkTpJ7GiLdl8nOISsX4Z1Xwe851HglI/1VA81qAaL9oB63NdCuQ8uTdTdbuTOupdU2BESpwkzVtUzrOYVrI9maGguL+7KgO/dLPxsSUaQ4FlAet/6Y9iqT9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Yg4NWnq7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Yg4NWnq7"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TDbwU32266951;
	Fri, 29 May 2026 10:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=4B8cI
	WwmuA+TM8KId7MyZgluf6HMhvLBIKQm9WlFhPc=; b=Yg4NWnq7L8rT5O6G/p5j6
	mAOxh1x0J4LNcmsKbZItqB05HmONCQB4h1v8rWZmjnnJCmQOoFSho7Vjyx4KARvM
	a2fTHdExSFHvrviKMa9APn9P5SpxM0jdaQHjYOCXl0teT6mQ6p87Gsc4IYGFzgnN
	SzD7hV08RfZUm1jzw+OOr+KS2RtTWzkszgys3Y/dOpSrsX7AX3F8IqLuvVhtNsso
	77VyyGqKwlsGq1EQxBJ+U+jXwrXK9S2ZoFVA2amEjDoiTL8bPWZfP256InsAPfTi
	G42bHbnUu5I/VdpOMLApQ7MtQBE1pCHXpR8QTosYXcBmYxTOMkgXauGVjzE+h93d
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ef6d598hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 10:14:33 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64TEEWf0012821
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 May 2026 10:14:32 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 29 May 2026 10:14:32 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 29 May 2026 10:14:31 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 29 May 2026 10:14:31 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64TEE8Mb020671;
	Fri, 29 May 2026 10:14:24 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: ad4080: add AD4884 support
Date: Fri, 29 May 2026 17:13:52 +0300
Message-ID: <20260529141353.8492-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529141353.8492-1-antoniu.miclaus@analog.com>
References: <20260529141353.8492-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 3xjM2n8VOb9ksWuRsSmO0o5u_3yRyf-2
X-Proofpoint-ORIG-GUID: 3xjM2n8VOb9ksWuRsSmO0o5u_3yRyf-2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0MiBTYWx0ZWRfX3ZJRZ7jEHFUG
 BiVJJm633CulUZghLeiAlzDRG0ityKl109786RVgvrwS75/HMFM3J0i1r5beHmi7WdEWHGSi6fj
 lwaL2Pu1+0DoYjh6JeJ+5aFWSxD6U7BPSSly9NQvPBm1iYwUK241NY0zRmkHZetsNdqhtpFU40h
 VZ/pOY1E1+xCJm7XWmLUPNe+MfOhFuz7pGiqJxPCNR0TptNtaIFv76226bP8CaIQBvlB9JnkW5m
 gODfa/+eX3Nxen5ttPF0/cYX0RgLlNDf8/D5vhwAwO+QopGS0lUDsRVfMVZecsEz+FOHxCYDUQh
 XMuXxk6DYwQxDLFvLRCHkBR10C2vAGxByMQxNwrDWmVFsmiiiqafOtw1syNwhb1DHjtn82OlYKK
 Oa0TkC7nc0KJokDRWHhH1KxhTkgzLyKSKsdlKWP2mwcPIV+WStt38mMa9WKpazjMuIEVKc1prHr
 3U3FR3kCqs85S1Ye7Qw==
X-Authority-Analysis: v=2.4 cv=Bt+tB4X5 c=1 sm=1 tr=0 ts=6a199f49 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8
 a=w5vykfj34SSMQZsSxmwA:9 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290142

Add AD4884 compatible string to the AD4080 devicetree binding.

The AD4884 is a dual-channel, 16-bit, 40 MSPS SAR ADC, sharing the same
register map and interface as the AD4080 family. Like the AD4880, it
requires two SPI chip selects and two io-backends for its independent
ADC channels. The AD4884 differs from the AD4880 in resolution (16-bit
vs 20-bit), which requires distinct channel configuration in the driver,
precluding a fallback compatible.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v2:
- Add rationale for no fallback compatible in commit message.
- Collect Acked-by tag.

 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
index 9c6a56c7c8ef..4a3f7d3e05c3 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
@@ -39,6 +39,7 @@ properties:
       - adi,ad4087
       - adi,ad4088
       - adi,ad4880
+      - adi,ad4884
 
   reg:
     minItems: 1
@@ -99,7 +100,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: adi,ad4880
+            enum:
+              - adi,ad4880
+              - adi,ad4884
     then:
       properties:
         reg:
-- 
2.43.0

