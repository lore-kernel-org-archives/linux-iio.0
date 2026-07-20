Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107E3429803;
	Mon, 20 Jul 2026 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554895; cv=none; b=UnQf/7iQL2t7NMx/SQnnHZB9t5y/fefMh0DL0Ijq2S6HdSv1u9VHJYZldfYrczv7qTchKXts0QGMmoPMKEyEb5T22uYUBQutW2UGKrOhQ/BncE65HYo93NElSQqSSM4IiJbSEWlLDIZ0cIl5Yoxi765+C00fGszxkXaHv7XQ+fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554895; c=relaxed/simple;
	bh=p864XB23h/SuZHT1/pJRTJkt0M79xw0dQ8uRmCkN6Pk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WSNKzaMJPgKb7ebTMm+Z8R/BaoeZl4b8tvOFjNy9/UCjynHZ4B2Gknz4HM3EaPx+G1gEy1IzeoAT+mNZ/wABqM4GCzmKd70j6ZYYBEJBZbC/6ove8tH7VDuOBWwmiqC0dt7ea48VaCAM/dgZvz+CrBOSS6KDwBIVEHSSuKPy6m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XKmcFs/F; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XKmcFs/F"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KAx9H11485542;
	Mon, 20 Jul 2026 09:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Xlm16
	LBiwhyFznyCLF67U90TuG8lQnTNxt25OZ22Jgs=; b=XKmcFs/FoIhruVgaP8q0i
	pmmg6SKX4FTFLAd87KMjAedkSpTxSkk2sk+CPBOe+SiFda+C/wL1kT0gr8frJImY
	jc5Ua0nFwB0OkY+YJyZ8MIDH64r+dHcu384R8YYESHZZEhRDiHTICcA8gw2ZeR+5
	NzuX7EskhBB8kp56T54xTIQfxuGcm6Sn5vCRroKIBOTu1HWpk6+9T/8LljxftPE5
	Ni8EBy64oOpM/73n9SlP2aD/+S0jTtyokaN+cLCYgHPW0vb+rODkDHK+vUEC/j4I
	AAVqmVPV2kUa1ffdg2xXdZIJV+E4hAwFTVq9W7pdZQJofaURWS390lvugCX0FTKb
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fgqte4jne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 09:41:18 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66KDfH8p011950
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Jul 2026 09:41:17 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 20 Jul
 2026 09:41:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 20 Jul 2026 09:41:17 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.186])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66KDf5qH018405;
	Mon, 20 Jul 2026 09:41:11 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean
	<alexandru.ardelean@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: iio: adc: ad4080: add AD4883 support
Date: Mon, 20 Jul 2026 16:37:06 +0300
Message-ID: <20260720133707.103366-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720133707.103366-1-antoniu.miclaus@analog.com>
References: <20260720133707.103366-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE1MiBTYWx0ZWRfX0xAxYDmIG1Gt
 nHR4pPYv2tZrHCtZhY3XvrJWOksWhBBv3NU2csCposLkw37rG6N6naNy14JIUdDJ94N2dR07obq
 rirCnFXRWLr+AKCIqwsvJ0GonhrgbyMSys6EpdWe2J8t3iRw1rXF0MbbkxnFU3A9DgHJgnNOgDg
 Q37sNV3FX+4jNB/ce5tvb95FKtSVrDkmNiMW7tMhGdTmoLx3RvMbmV/CLpzkB0j2gklQsVOG3BS
 9foZkf1oTuAyvoBp3MuD6iqK5bLzbppdxcwhB4s/C0E8FaGyoiIEoitkgNXGuNLiz6AdhvAbA83
 Nx7b6yb42mT+ZP9sQpfrekhmuPaNTAqyFgGCl4RNtirKdh0NbuXpB4ofQZQusG4j4kUrAmtoisX
 P7w6cmBYC+2Q5lAV3/sETEHLGHkkqQBwlzk/omxW/T5mjgvNefs7WQfbWu3+0UixwVWgmGWSSYL
 cetsiGQasBgEVHkGB+g==
X-Proofpoint-GUID: 5WiqiJ_0tOoElQ1zG9ewBSmHtrLXQGX9
X-Authority-Analysis: v=2.4 cv=Ed/4hvmC c=1 sm=1 tr=0 ts=6a5e257f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=rwIziXOAKK6eP3GKzrkA:9
X-Proofpoint-ORIG-GUID: 5WiqiJ_0tOoElQ1zG9ewBSmHtrLXQGX9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE1MiBTYWx0ZWRfX7K6UmUFXmRCz
 SFgFZolNnWRXrNpi9KrnV3LLi4KS9HJWJgopIVQkmxsR5qtOqs/Xg+ffKat5ZU3xmkBcU1s6VHp
 9xt11TTgo7ikCi3Ou0VtJwLaj/t/NZLDhJKHe51BMohwAbI5mvz5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200152

Add AD4883 compatible string to the AD4080 devicetree binding.

The AD4883 is a dual-channel, 16-bit, 40 MSPS SAR ADC, sharing the same
register map and interface as the AD4080 family. Like the AD4880, it
requires two SPI chip selects and two io-backends for its independent
ADC channels. The AD4883 differs from the AD4880 in resolution (16-bit
vs 20-bit), which requires distinct channel configuration in the driver,
precluding a fallback compatible.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
index 4a3f7d3e05c3..db8467b98e67 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
@@ -39,6 +39,7 @@ properties:
       - adi,ad4087
       - adi,ad4088
       - adi,ad4880
+      - adi,ad4883
       - adi,ad4884
 
   reg:
@@ -102,6 +103,7 @@ allOf:
           contains:
             enum:
               - adi,ad4880
+              - adi,ad4883
               - adi,ad4884
     then:
       properties:
-- 
2.43.0

