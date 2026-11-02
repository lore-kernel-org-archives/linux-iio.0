Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621673;
	b=qAALSVk7n3uNxNjooXX4D/H+7coOzH5Tz/wx8j75ShPPht9Qt1tKvY60hofXSB2g/R03
	 rWMGbbWmQkEGM03OJhu3YBOLoz9pLVmW7+axzJhfMI4oSqhavUypGcaC8rsH8IokFBian
	 HGfigMzI1ZhiDNrWMhZ7M5/ZLawnnUhXEheiOEfUkuomqQ/xyuDN7HCAviv8CtxQ6cX4i
	 AI71nPxPegi/lmxdlXDUvhYl/8JNYoDWoshSoL7n4NgiVEA6UJoe7ouQpqOLT9VHrFjPJ
	 uG+M/QCkg8mtSDcFRM8VVh9xf9b1rBM54IZlsqFSIy/HINKKrolfstFf0m4CysXTQdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621673;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=LikTCEQpTBHnUb78g+7oBV9aCLVyUPu97O6g1ahevEA=;
	b=DpkH4OPOq4TdpbwFi5DUnbEcs8JggHaB5b1zhz8m2B373MsspoRYWjsF5Ri4el32r/KL
	 JDDNM8aEu2C77gCYXR75TKLarRKs2Pon1VoPKrgjXVJ/kFap0jrOqaTdFIAM/5jAyMoWE
	 t1qu3HOQcjTLgtIzQxsEi9AF86KTkn9kODG4dQ9TwOymr7BRoAjC+Rgb8rKuBFcL+0O9t
	 dZVEqulIX7DuHB8e4cZVUQO8X3gZ6OCGJymwE+Qi0RtL9mxDCaAbZZTeQxPx55eNW+0kQ
	 OdscklnQoCKDWQoyYQ/nnb/FYItZQsgsxzAmCvTVHHV3cmHEohlBFNbWVcQ8FegKzcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=YN+f9jfz;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ERZODWbn;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EA260A2602;
	Mon,  2 Nov 2026 12:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69EA260A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=YN+f9jfz;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ERZODWbn
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29CO1G858438;
	Mon, 2 Nov 2026 07:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=LikTCEQpTBHnUb78g+7oBV9aCLVyUPu97O6g1ahevEA=; b=YN+f9jf
	zTM08bvIMK2yBHBjgk3EK4UZacKFzSMHMViBqLrQXABWKOijCMdeVXPGyfq5zqEl
	4L6Pd7Q+KfQCt5UyI7ekIchyXbWlTRBkWIiL4n7DOMsC05su4fLXDDZRhEFVvWHt
	SLA93mCQbtP/w7G3/mbS7eSn1VKBd7SEe18D7rv5h1B6+auc1x8oObLh3J4ByNSc
	33pb0A9nUFd3sa2eXGGeXmeE/lq9gTHdwtxBJPKqbrU8fJlTUHc8rH/IcOWPFgTV
	0QRbo0IOh1dc7m6kaPHTIRiwgJIN73Qgsw9tS1PhZ71+vDCAfTgonPfIvW3El6Z5
	1AvcJryo1VwdEVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=LikTC
	EQpTBHnUb78g+7oBV9aCLVyUPu97O6g1ahevEA=; b=ERZODWbnJ+Y/EdAttmm9G
	uN4MiquMP58i4SmwFoW1HfS62AbLSku9RbVDqXvcGyXUZdUgM7nhg5XvTgpuXyUS
	Te8xijJGTkw70DuoucCqrzuRnn2IpT9CNxZ84OOBHf0GjAA8JW1gkOWeMXdbGi/b
	78DFX0Zgtg7Fvpcwb/Fb73mUZ6EbznFHuk++SBmKKLqnG4914IAaoXUpm67XbRWo
	K1w4v9WEBkqEzsYw6wkMAVZ81ST9aC82L5RskoRFxvE9bcN2uLnIjMizPndYrjn2
	cz1LmwUMlgay/U+WyQrnN2mMLHp0EfK6ejBFdUwGR2dsVCHmT5pVbgT56V+1FYIu
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hp2hmdhd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 07:14:29 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A2CESPB001893
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Nov 2026 07:14:28 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 2 Nov 2026 07:14:28 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 2 Nov 2026 07:14:28 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Nov 2026 07:14:27 -0500
Received: from HYB-0FPP35J6CsI.ad.analog.com ([10.135.2.44])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A2CEE0E021851;
	Mon, 2 Nov 2026 07:14:21 -0500
From: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
To: <jic23@kernel.org>
CC: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Dragos
 Bogdan" <dragos.bogdan@analog.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Subject: [PATCH 1/2] dt-bindings: iio: adc: ad7405: Add ADuM7801/7802/7811/7812 support
Date: Mon, 2 Nov 2026 14:13:51 +0200
Message-ID: <20261102121352.23741-2-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102121352.23741-1-pop.ioan-daniel@analog.com>
References: <20261102121352.23741-1-pop.ioan-daniel@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0OCBTYWx0ZWRfX5ixtNgs878IX
 eYkCMPNzM7KyNDqRkJ2oAmnwMo9hlcE7BQIlISivgggpIASZoK6x8cBKu7Q+sj8Judd+4yoyg2d
 NaLBb4PKxuSYnplxLFGjRFXzPan9fxqPtbgHpigeTBg5tXCtfMacIX4lwY49wzPSlTf1b/2RO8C
 RMMeBsLgDszJLq7+xOIF8kP6mOifDu0taPQiR6izta1m6vQy/kVniSqNeQuYYadltxnz3MermcU
 VTTWOvuQLmHXjV+0x+wAh5rgHL5yjEs0J+43lWda8DBcwMzEB0GxSqC7N8gj6fEzfV27FrbfWgi
 VwxHXK+AZvU/yhYp8iUIE+Xz7zRfqWocAN1RHqf5Er+KTMQqM5G0powiJiC594Glx7+ZoEWiRxw
 PlGYijJPYjuLdxDpeY82hrMxF8wcZuT0NrOcZoj2Pz2/5NMuHR1MeU4MuwYCchnM/CMzokaI/C8
 mfcn/vTPMOZ9eZeXfwQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0OCBTYWx0ZWRfXxjgCYUS240CB
 wrCujricRXh8TYn+/QYa7F0DDxJ+0/MOqhkZh5hrlpRvCEeMb+NsXJfXp03wJgPBGkzNKx9wA34
 DbpGS5Dh5YIPtKDbRF54+5eYzzD6SGJxh2M9N2SYoh75XrDjwtao
X-Proofpoint-ORIG-GUID: MhR-_7PXWhCA2BRP05veAB608UHplFBq
X-Proofpoint-GUID: MhR-_7PXWhCA2BRP05veAB608UHplFBq
X-Authority-Analysis: v=2.4 cv=V/roQuni c=1 sm=1 tr=0 ts=6ae87ea5 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=ss2qgMVrcG0Z0Yk_wrIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020048

Add compatible strings for the ADuM7801, ADuM7802, ADuM7811 and
ADuM7812 16-bit isolated sigma-delta modulators.

The ADuM7801 and ADuM7811 have a ±320 mV full-scale input range and
the ADuM7802 and ADuM7812 a ±64 mV full-scale range. The ADuM780x
support a master clock of up to 25 MHz and the ADuM781x of up to
50 MHz.

Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
index 57f0970257050..18de5b0d2f498 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
@@ -20,6 +20,10 @@ description: |
   https://www.analog.com/media/en/technical-documentation/data-sheets/adum7701.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/adum7702.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/ADuM7703.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/adum7801.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/adum7802.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/adum7811.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/adum7812.pdf
 
 properties:
   compatible:
@@ -28,6 +32,10 @@ properties:
       - adi,adum7701
       - adi,adum7702
       - adi,adum7703
+      - adi,adum7801
+      - adi,adum7802
+      - adi,adum7811
+      - adi,adum7812
 
   clocks:
     maxItems: 1
-- 
2.34.1

