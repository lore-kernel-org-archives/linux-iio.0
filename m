Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795007046;
	b=hysiY69Fwhkii/e1C7MmARpfgVdG5nilXF/0/X+GvdLRqnwAwUO7pZY+3QTgl+bSZsPf
	 hgjpDfL6OEqdF77M9jMnyPLXfTwVTUtm7i8ni7EkInF5zgR1IJhLEAj35dsFF8+euOCDn
	 qTqa3O99mKfj3xmxOsP8n4cp6TXkTVmtcqNVveEu4+O2bRWSaEpUveKIlh3iiQst/uBbV
	 0GfZWEgMe6x+gfVRNSfzP8KUC4Jq3p/Qr/0wAlzy+ZAhRhB22edzzzVCiwpIl05F+SLCW
	 hhdkdPc3AZZdezaGbN1g2D9uFEeAX5zHo8iBcEHeHmakqRDNOkG3ff9a4gI5vR+7qKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007046;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=hT9exzjWm5WwHjFB3VXh9B0BCwt4OEQ1Vk3XePbwngo=;
	b=nXnzpTvUMWtJwn9EPHWrf7BsMQ0i1k32HGBjFMv/uZOCmJhoJoIhXgDdts7jhLgPrRvd
	 4kXmke1HWJCafgwwqQDbf46zxy4Dk1YcxV1jevrjLWWzIG67aOF9nq14omglg219SPd8k
	 tdhz/+lTfg462M6SBu+QPRty6O8clKjT22Y0SS3iLg3U6PnygzCgy43+QDw14NZTTuR4H
	 Q9RNpDua2mMGx4ZAl+r9gPzeIza8myK2Rr2QZz1iWKS09CmSI2GJJXkk+pDin+alwAEnW
	 5DT/F85xpSu7wvtZ5JLdVnjM61aBrHh5J7wX4XVqNNTufm4747rNlM+zg2AyiUuAWZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Opr+ga39;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=cQNIGI6e;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DE2606A325;
	Wed, 18 Nov 2026 13:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00DE2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Opr+ga39;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=cQNIGI6e
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIBKi752662516;
	Wed, 18 Nov 2026 08:03:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=hT9exzjWm5WwHjFB3VXh9B0BCwt4OEQ1Vk3XePbwngo=; b=Opr+ga3
	9JJFiGvZnOwzQwmTYunCt/VBH1RmDBQDgXqsL0xS0TxJUIDKQcuNaSCU0bBjFHls
	okISqPwNib14eJSEbS4VHb0sNNwn+YkCDHk+foTaxG/OyVtsVfg0QOgwRs1HwdqZ
	ORbwakSz1NRcQBpdaI7cZ1x+5jAwQOCKAq4ilBj9GDfHfdKtfEBOCpWdVTBEkMf/
	clzeHe+vmK069mHBjF1EVYHFlQr4CqQBcFEA6NZyE22ZuJ/e7pxguAvLFpFj6hhF
	LNtjaol91wDlyYLP7yxEHP6Zk8Q6pxIW2YH3K4b+MzZVllHzT+tDEVkXnz1M5Yui
	UVOC78/V5xVyADQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=hT9ex
	zjWm5WwHjFB3VXh9B0BCwt4OEQ1Vk3XePbwngo=; b=cQNIGI6eHhyfi9JatZeDU
	vPjDUenStWEZH+xlcAvroGgzRGPGzOKZCtXqpGfpgMlT1XNVErpackTzjM16u+Fe
	RAQvJ4nCF35HY+7bl2jJwcaHQ2eTqQX6LygyfP/qdQNfTN/SDjm/slrPP5aXFd1c
	OyQJgC9rMzQrwSnUmcePb9Sz0o8vrbnD3r1Fg8OQEyU8AhtRtIQhBzSxAp72R4NX
	hUOTr/U17pxHYZi+2WWS1gw3uKZs5hSFa3ATNdTKRu+s8L8ujidsH2gatay3CKHq
	lmhTkL0CZfI8kfv0plsfIHRfeiidE8/gWpelLYGG+Sn89l5MC/e3iuUt2WHbpld5
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j0yucm702-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 08:03:57 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6AID3uho057514
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 18 Nov 2026 08:03:56 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 08:03:56 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 08:03:56 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Wed, 18 Nov 2026 08:03:56 -0500
Received: from work.maxim-ic.internal ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6AID3g2e022823;
	Wed, 18 Nov 2026 08:03:44 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <olivier.moysan@foss.st.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 2/5] dt-bindings: iio: adc: Add AXI ADA4355 IP CORE
Date: Wed, 18 Nov 2026 10:03:36 -0300
Message-ID: <965f1ed0aee21bf9bb758aba0c89d60bb1e3dca1.1795003864.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1795003864.git.marcelo.schmitt@analog.com>
References: <cover.1795003864.git.marcelo.schmitt@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: JGDedYWtkPPbvetFficLOdSjGhpZG3Hd
X-Authority-Analysis: v=2.4 cv=TILQ2Fla c=1 sm=1 tr=0 ts=6afda23d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=wI1k2SEZAAAA:8 a=gAnH3GRIAAAA:8
 a=XfSV2S4ZjgUSoaWomOAA:9 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19
 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1MiBTYWx0ZWRfX/z9td7Wq9mZz
 RnFUdNDfXtDwr7QKK/DRlxKvmAnB+Pk5FhGeoS2uN448V5Mo7/5piTbBeQCLJInGYZO2DRxiz/X
 vTJWOcp2TDaYC1KNiLAzobJJGu/tyXLVVcGzsgSuUAxFfQFmqu4eNglkGE7bjgwtoNgGEhKzLq6
 EiEl7vHiNe+qA1gBQJWj8xarbmQZRKJOAxuAgIsFJ42QeB+OoignEM7+97r95APN9veU0WJUO50
 yUnEL+1zy10mT9ejyygAwyOl4Av6X/NUVQxacgyWFWOCp89p2NMjazHITtZMFMuh+9y85CmxAIL
 CDxqzzkWbN56emMXHyaPSRvvjQexUkMQD+nobQ1C8zPQ+6QSM4hJt5dBof0xxejMY9rFBdsyknl
 Cw+KJeKYIGQyjOCQwsgiMkdg+esF+rbQALMzZ0SiKuGIioENAxreRNlwF2wQGmiW8GiO2BZkP8b
 tTominP7UI9wytPOqIw==
X-Proofpoint-ORIG-GUID: JGDedYWtkPPbvetFficLOdSjGhpZG3Hd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1MiBTYWx0ZWRfX4JE1AVzqk9OD
 iTCJYRvvEDBg6ziGsraPvYiKEiUa8vWLuTJnupqYnfdSDmFphzqvJW/8gpRLd9Nu7/zF8cY8i4h
 ccAaeIwyksMsJ+uWExtP8ZvPPqmo+y2edXfZcd7twlLQh8gASF3P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180052

The AXI ADA4355 IP core provides the HDL interface to ADA4355 and similar
devices. It differs from the generic AXI ADC core in its register layout
and requires a data frame setup step in which the number of active serial
lanes is programmed.

Document a compatible string for the AXI ADA4355 IP core.

Link: https://analogdevicesinc.github.io/hdl/library/axi_ada4355/index.html
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
index e91e421a3d6b..fe0f526b0ee2 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
@@ -38,6 +38,7 @@ properties:
       - adi,axi-ad408x
       - adi,axi-ad7606x
       - adi,axi-ad485x
+      - adi,axi-ada4355
 
   reg:
     maxItems: 1
-- 
2.39.2

