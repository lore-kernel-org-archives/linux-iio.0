Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871383;
	b=ok3Uy3mwHmUhj7cjR3JqOX2SXvr5i+XSbnaBj+WP8QHCKWidVQBEVg50U08+tGiXBS3e
	 F6fshM//g9xUcHnu61jRANLOB1+JxwLyptFXUrySywRA80Tt9WMlIj3glK8snTFtFVJaQ
	 wKEUESJhtgVj64IWxX/wBqLsf1UUgOfSd3/Pk3K+WMbnHCL90c6LHKZqTBZT1QgR+SuMQ
	 d6WBF9UgiaVEJ6QcaUuK16TiR2yAOl/yYjA9/7sdJ9S1QJLMvbM619382IN/93YZRzXVy
	 zo3GFcglDYnSXlCtiFpiX9yORh30n6qAo35BKIiQoqSkhE9ORCQ+4VdTFpyL4LXRfSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871383;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=MumIVYPiJUww4r0IEseLvlrMWFg+FDiS1WSf8u8LEug=;
	b=2EqF52HCm7lK/6W5YCoD9zMZlDCa1sHkw3G+5vwmndZc+7sJ1CwrmxnTbLk4VM+8Bu2e
	 Mq4jffEetCPMFzDsM6QGuTZk9Z91J0MVy/95+dLoXE01nNVCOo500J39StTEuQl5w1NZA
	 UWAQMznMukWKREH34+gl2rBIlJB4XMkZpsasZ1OnZjAnPp17vvhJPRc8rpteU3gwgmj3l
	 Fx56GgU4eruF1EzkjbQI4t8sU81K584RoAMH8Ls5ZQHb7KdwarLgeZqp/PlbbMKmNkXq8
	 01+tU0mHqC0VKb0UBcm3tvZisZUMgn7/gK6J30OAW0iu9jG1+JgC9lWyDXWH/8+98DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=MJKCWBY5;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=rbbjJf0U;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F07606A32D;
	Thu,  5 Nov 2026 09:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1F07606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=MJKCWBY5;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=rbbjJf0U
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56WUNX1458013;
	Thu, 5 Nov 2026 04:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=MumIVYPiJUww4r0IEseLvlrMWFg+FDiS1WSf8u8LEug=; b=MJKCWBY
	5+CGybTps7PJwaLLFz15PZCppG7MDanNebmU9pCn8h4x1GgybQf/6OxON7sYgLmk
	bCDU0j8mNIprpWoeCtJR8yWmosLd93Po2/X0GDJgok5USOFdx4UVSM13Kb6cGOLR
	J/DpfFXzH0xkrP/SH4w/yC6QkCJDegzX+jwNRJJpqNtzgTYfPIUhlGqyZr6wYKkq
	/UqPCD9vM7lffM9j8+2k9jUBti5Yd5K/GwQiKohtOWl54knnrgstGcEfKGNn1D8b
	0Tp+t51y6fbZGv6ObE2Zyp82RExa3/o/BzVAKQtgKXHW01kDDsq0tkJX/PXch79G
	CRsjN0bsW+8m4kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=MumIV
	YPiJUww4r0IEseLvlrMWFg+FDiS1WSf8u8LEug=; b=rbbjJf0UbdQS1KejM3epc
	u7qjlTpQ0XbPVXqOgaR0cDMm4J2CXA+LanuqQwYdgKmpfOmmf6DaQuikuFjHgUKQ
	xacF9nkBbF5CUIXtZNWw4jqjikOZQf9Yr/SWU77lc3Ije4/NnfKHgmFgE0Ceqkl9
	28tzKZ+apGENnFb7Q/P6ZInywcYyPSf27+EzNADWfiAcHm+ofG2i7U8D8Sok1Xo8
	Vxu4PCe5JKSE2OXqfOKbac1zMm2BFaseqIAo2l/cyqGyvu1/+1eIlN3QXez4Fx3J
	uv04AvBGeo3bLypcEu476iYdSuz1UEFrOfwkYyehrruqqGIA97eD5NOLVPqz8ZqW
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hr873d4jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 04:36:19 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6A59aICD010832
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Nov 2026 04:36:18 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 5 Nov
 2026 04:36:18 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 5 Nov 2026 04:36:18 -0500
Received: from HYB-0FPP35J6CsI ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A59a69P024433;
	Thu, 5 Nov 2026 04:36:09 -0500
From: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
To: <jic23@kernel.org>
CC: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dragos
 Bogdan <dragos.bogdan@analog.com>,
        Ioan Daniel <pop.ioan-daniel@analog.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: ad7405: Add ADuM7801/7802/7811/7812 support
Date: Thu, 5 Nov 2026 11:35:30 +0200
Message-ID: <20261105093531.7562-2-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105093531.7562-1-pop.ioan-daniel@analog.com>
References: <20261105093531.7562-1-pop.ioan-daniel@analog.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzOCBTYWx0ZWRfX6b0M0xtrBN1L
 m/bpKDBadeBz/peovRc6iCojEptZhWNji2FBzr6rSs0gigle6MH2Wdh+lwQSr6RqWA4zuEKwSxN
 Du3EzkTJU9KXeSJvLACFZUziLOMap/9lgsGbF5frBTTj6yBECRKx
X-Proofpoint-GUID: KC9pQ9fQTZdAbqvTBNOi1s7G1r-0NJYD
X-Authority-Analysis: v=2.4 cv=S4tMU4sP c=1 sm=1 tr=0 ts=6aec4e13 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=MMREOpu7j-QvK7y3GyIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: KC9pQ9fQTZdAbqvTBNOi1s7G1r-0NJYD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzOCBTYWx0ZWRfX8WAQEJRzYhZT
 BI99Kldh4DPr9f3JgNjJqbogXRELUOozkavWUJKG8DRSrFoGekGac/jfZaC12yLBUeUhS0HJ1tX
 cRwA/M6Ax5V4jNixK8gEXah+Yj/4gw4+ULTMqTDucN+yJXO41d+QTwyIWr91PbT3SQhYkN88sWV
 Toqi2zLdfSrmybUrcqfxero75o1kGuojtpqX/Gu5Oft1EasgZKU4JCxuvkts97R+AyFlkGx8jEg
 IjazcngpJwfeEqLeW7VeUsZBo0lGEBSQ9W2QTvbZ5mmyyblh7+Ps0I70agRLNClXz9cv9ZbwNfT
 XUbP2faS/VuuTdoKLWtxAZFJJI2fHTWVZifTjE8LlB4I4aDuVv8Bw8Y6RL+L3rvXVn7zXaLCAiq
 TcoyHb/1oyrQDfm/DRCFRoiRTVr2nEvuEzayE263/ncccIbYiU4xwWTXKro0OTApQLl1iMhTlFm
 mPRAw1T5WOB+SLCqh+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050038

Add compatible strings for the ADuM7801, ADuM7802, ADuM7811 and
ADuM7812 16-bit isolated sigma-delta modulators.

The ADuM7801 and ADuM7811 have the same ±320 mV full-scale input range
as the ADuM7701, and the ADuM7802 and ADuM7812 have the same ±64 mV
full-scale input range as the ADuM7702. Apart from that, software
handles them the same way. The ADuM780x support a master clock of up
to 25 MHz and the ADuM781x of up to 50 MHz, which needs no special
handling. Use the ADuM7701 and ADuM7702 as fallback compatibles.

Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
changes in v2:
 - use adi,adum7701 as fallback compatible for ADuM7801/7811 and
   adi,adum7702 for ADuM7802/7812

 .../bindings/iio/adc/adi,ad7405.yaml          | 25 +++++++++++++++----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
index 57f0970257050..41eef107e9f0d 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
@@ -20,14 +20,29 @@ description: |
   https://www.analog.com/media/en/technical-documentation/data-sheets/adum7701.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/adum7702.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/ADuM7703.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/adum7801.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/adum7802.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/adum7811.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/adum7812.pdf
 
 properties:
   compatible:
-    enum:
-      - adi,ad7405
-      - adi,adum7701
-      - adi,adum7702
-      - adi,adum7703
+    oneOf:
+      - enum:
+          - adi,ad7405
+          - adi,adum7701
+          - adi,adum7702
+          - adi,adum7703
+      - items:
+          - enum:
+              - adi,adum7801
+              - adi,adum7811
+          - const: adi,adum7701
+      - items:
+          - enum:
+              - adi,adum7802
+              - adi,adum7812
+          - const: adi,adum7702
 
   clocks:
     maxItems: 1
-- 
2.34.1

