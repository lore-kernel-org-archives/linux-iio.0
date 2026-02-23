Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3333E329E4D;
	Mon, 23 Feb 2026 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866593; cv=none; b=ODYlSqYXSUL4u9cQhwU35YrdrxD29IM7/UiEeiZumq62WXdFrwlvgGUkrIdYh7MOwfozV1lM4WYvao/PIUUHmX979bFzQBlQMPWyJczjj5joIgAFeV/ZhRI/qj5XXLKWHBNPvy4h3iU14WfSqUxrz8+QSrh7Xqsk4PLCoJdlFTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866593; c=relaxed/simple;
	bh=MxUKyMhgdvmsNM9V3eI6DC6SfIfeFnzWvofXm8IgkhY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=loP9zSx3uGvLbLjd6+QxhHI4ZC0e8vEigOyTGXx35XC3/JctirivvvZm/hyNLb3PeHyplaQlIVKsADyepXa6op54qmXCj/J8XqXB7JZLp2quMxyLtL7TCEP4fryHpWNDnBYx7q2txAYaNNyCZeMzATzKpX4iWysyOLNZ1yfETKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=TM1QAkpl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="TM1QAkpl"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NCW8Do1742937;
	Mon, 23 Feb 2026 12:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=2xqES
	hkq/P0C7VjOpk86VqYFQd9HxmMfTwPtT0KbkHQ=; b=TM1QAkplOSUHk38FFL5m/
	AKItr9N1L8dA+P7eaiFUfjxDvzcDdsYvZ48K2a0lSntzj6uwxZWNdFXqQYX4nWXf
	R25kp4OuJRBGyIcSPwXKDRlfEbDKPWYZriyF1T7vh6PJE8FYSPo3EaLT2cs3pW2C
	6P7dE7B5hKJJEdb+jqRulcqXJO+0oAdBWEPcYsBX/J1WuhSJc7lpqvZrN/1G9dRh
	BnM27uxJoPPHvzgylDjM2Uh3jK1n70Y+FVLoU2dquIQoU0sYKqXF4ismBvLbkvgY
	dvVjzpcIVhx4obwyI2jk7ft9LZItUQ/IDsgQQnAdpbZqC5V/+sh59ijsX3cFE+Qu
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7p4kv2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 12:09:46 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61NH9jhJ036387
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Feb 2026 12:09:45 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 23 Feb 2026 12:09:45 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 23 Feb 2026 12:09:44 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 23 Feb 2026 12:09:44 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61NH9Vo9017799;
	Mon, 23 Feb 2026 12:09:33 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v10 2/6] dt-bindings: iio: adc: adi,ad4030: Add PWM
Date: Mon, 23 Feb 2026 14:09:31 -0300
Message-ID: <614cfd84f466729784041edd8872afd830d0381c.1771865684.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1771865684.git.marcelo.schmitt@analog.com>
References: <cover.1771865684.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE0NiBTYWx0ZWRfXwCA3o9gnvGUm
 QnWH0FgPKDYbV/d67JmBIazIwBKHcY/M5y0oazabvSyu1teJMcs+c3Ii2aQx4srU60DUB7Q1VeC
 +TMNjatsUZCah5VFInFiJfKS1QXsCh4UDdaQjU56r4u6kx4qk1rgSfgzDM0wlhb/30y2yDBDy0u
 VADRJfg6XDaCI/NuioCjU3um5xxNfN1GggR12IpQ6eHB3HQ4OyLWpyikVsd0TQMZks7RIww13Sc
 PnvRqgnxS/qJ9FBV5E9j/tT6MDuup+hBxTnhCuASmYeIf/lS+64h/QniiE1O87OIeVjSQ9AEPzK
 YffsriqBjRm3a975ZNiIGD49lDHW3wV+MGgktfA7w4CJqFiGA+ybnniPImcCCPbfq3na4riGscG
 No4N+9dMMwIqpAVnvckPZjDrD4CyF7jfsCMMlnsUh7+B1Yp46SiJANv8kIFfJJzMuaZVpFezh+p
 vF5iM6O089QVQpHyF5w==
X-Proofpoint-ORIG-GUID: I3nmRvHyd2f-Ivm0b5FCHPCkKxJKD49I
X-Authority-Analysis: v=2.4 cv=LfgxKzfi c=1 sm=1 tr=0 ts=699c89da cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=IpJZQVW2AAAA:8 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8
 a=DUOLLnRY7vFq0fwDtzIA:9 a=IawgGOuG5U0WyFbmm1f5:22 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-GUID: I3nmRvHyd2f-Ivm0b5FCHPCkKxJKD49I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_04,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230146

In setups designed for high speed data rate capture, a PWM is used to
generate the CNV signal that issues data captures from the ADC. Document
the use of a PWM for AD4030 and similar devices.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v9 -> v10
- No changes.

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

