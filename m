Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03865346E4F;
	Fri,  6 Feb 2026 19:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770404520; cv=none; b=h5yCoiRJMZf76lbD4tJ9EiAjvz74Zn6ghWs/z99pNzAg02vwoZ6R5ns3RDE5c+8fRG3d7s+rCmWtQb+GSPdT4V7ji6fLr3FvR4bsAypX50EOUBH3HtaKiMf6S1T6dh5zlSkyhhex9bN3xXN3eELb43JoB5EHWUzqr5SSymSQyDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770404520; c=relaxed/simple;
	bh=ImxRjUqLTd7MSzQV/1lQmCc0nXq3Fh00lJAgwH6Ymp0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dsPuw8SqecK6x2hKc1NUi7ItF1u9+qj0FIh5O0vizXSHNBpx9micYbq7h1BTloHazRNTthYodY1eqyy/TYrrS676XgJadJSGms0BWaPNHEd/HVSpi3NUWEH1rgNFWLtXv+M/xxyGt/Zlhh6IAykNUiGJ5PxnodI1g54B9pDv9gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mC3BtvW6; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mC3BtvW6"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616GLdNb1708598;
	Fri, 6 Feb 2026 14:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tiW7Z
	i7GaUCIE0LLmX+P4SP954s+emDE6PzhOjezIYo=; b=mC3BtvW6m67XpPu1/kdDm
	vVb7ymzUdIQTAcP1E1MpP0tSSz528pma+EVOBTQ/J9TnM3z22JjxgiG+v3rC+Ex6
	Qi+LxyUCICXcsssS3kptYQXqifD57FKPRoMMl9r55EU0ik5LeG81NTtea/fsdnCD
	stMlGiEozIKySkMudFnvrVmYKhYrl7wtzQkhCYjS4PAnH9jmqHUhCZpWYOyhaHib
	j3f9roGYntrHoP7I6yvfOpI4uNMY+iEwh3ie2bJA8501JHAUGNxANAA/nEGXnEd2
	5wqA5jCCLjIaPGvYscjtGKaC0Ia+gl2nPUJQPCni1hi5m/y4voSE1e0BYCxtRZ43
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c4q2feww9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 14:01:50 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 616J1FEn012774
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Feb 2026 14:01:15 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 6 Feb
 2026 14:01:15 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Feb 2026 14:01:15 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 616J0viu008975;
	Fri, 6 Feb 2026 14:00:59 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v8 3/8] dt-bindings: iio: adc: adi,ad4030: Add PWM
Date: Fri, 6 Feb 2026 16:00:56 -0300
Message-ID: <36bf61bf9106e43798b5ccac974d97eb7176e1af.1770403407.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-ORIG-GUID: 1DwLy3TzzRL84oQUjBj63oqtvvnH8T06
X-Proofpoint-GUID: 1DwLy3TzzRL84oQUjBj63oqtvvnH8T06
X-Authority-Analysis: v=2.4 cv=MpVfKmae c=1 sm=1 tr=0 ts=69863a9e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=IpJZQVW2AAAA:8 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8
 a=DUOLLnRY7vFq0fwDtzIA:9 a=IawgGOuG5U0WyFbmm1f5:22 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDE0MCBTYWx0ZWRfX3G/4A0n3+sQP
 NFwSVMlmtepMHRM2/onPtGXeoMZQadfJTCPrD0v+JxmD5bNpzkF60UgywJeAi35Vv9YL2bmCAyK
 PmEJJBf8Z/q6eiOxEcYskmQ3/av4U3Mc4ZGM3UeU3hhTtBd35a54XINm2KFm2PgiLlHS4Myq/mQ
 eewzelHgTuGs2z43qRvufL3sSV7CQRHA8JSZxeTBE8paOUNcSHX9XERPmcZ8WeTUMnK5L6jm/p0
 bMQvFb0cZvTXnbzlU8447pAWkTj/qRMf9bMKh2k1fT9KzOZyGzLSXk3InPnIIdFsQggM9V6sEfN
 Lsf+nxDozTAJeTZLPdDpJuiDsIBnSAJcwEuxOMcS/AF1B35iZcu0xJeD0eB6qv0PoXhBI6jLfKC
 LDHmNjMS0f/JKCKMeoTF5NSWHJZ4lJcElyWPG3bZUtsn8tLM7CFfDM+AuFT/qaLnTItzEIx/QgL
 7vh25uw5C81p+l7pJJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602060140

In setups designed for high speed data rate capture, a PWM is used to
generate the CNV signal that issues data captures from the ADC. Document
the use of a PWM for AD4030 and similar devices.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index 29e266865805..a135c66142df 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -72,6 +72,10 @@ properties:
       The Reset Input (/RST). Used for asynchronous device reset.
     maxItems: 1
 
+  pwms:
+    description: PWM signal connected to the CNV pin.
+    maxItems: 1
+
   interrupts:
     description:
       The BUSY pin is used to signal that the conversions results are available
-- 
2.39.2

