Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7790A38E8C5;
	Wed,  2 Sep 2026 06:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331479; cv=none; b=jDQceuWKNZok9ixrsRd5/OGRSz8wYJJSp7KAm8fIpZNWspGN9rAXW0syPzfPrHS+f3QCH7l+7Aq6fd3ZxzAhhUig7zoaFt/FL4MiUfnuUaxvIJ63YkjH4YYJ9TzFSGVXn8E5WFN66O8HjVh2nXfacOQE4ZPmAi/quuunMh3FQwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331479; c=relaxed/simple;
	bh=vUvWEcmPRP3UIP6Pj5AeDtedAIvR4ySrJjggAvpf64U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9fNgD+qy8/apkmn5hpMtXP77wLIZVVW9vs+OK1EnCrrrZQKYTsnepRLFA3+BBGADYRReMZxnH8fe2RSWJ/u/KH4PtSio3jZhEv0zVYPWKL4B/+3mIMUPMIDy/ZR5DdAuEBeVqKySr8Dje6sbuQTxRf9/jxw3U5GJPDFIS/NxJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=w6u7bue4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="w6u7bue4"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6826Tvwp2490726;
	Wed, 2 Sep 2026 02:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=JGe61
	c3iJdJ2nxMzCvwGAkMI05CkgJ053Wq1i9b1UV4=; b=w6u7bue4CviYc+e0DsYNQ
	aGQsUXQpHReUF4PToX0mI37BXT3oq7jGKyW+x2/JvD3sYwTpvOqYT/BHxOhaGL/I
	MkqLWesItnYm+/SXUyB8ZaxNbhMl4VTGLTJCiu+LnOH2LGi8rpbeYv9OoG11/d2c
	6KQS4lSp6D2Gh/Ej0AZBtC766LCnMErFf+P0HTzPQFWpqE+DzKcVUz0GaZQ9Lunh
	36aDu9rixG1XbSkCkQtU/ZRM2aLrfjtkx5bog1j8JmuBbty1nGFLzdx0fkNfpZHW
	TkLQBYMV7cO4RDw7nCpHIMClN4acx+xHW+TqUr7b5sTgMlVuC3oWs+95vD7jweV6
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ge469am6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 02:44:34 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6826iXjX061179
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 02:44:33 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 2 Sep
 2026 02:44:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 2 Sep 2026 02:44:33 -0400
Received: from HYB-li3PrmDPxTz.ad.analog.com (HYB-li3PrmDPxTz.ad.analog.com [10.48.65.159])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6826iJ61018111;
	Wed, 2 Sep 2026 02:44:28 -0400
From: Andrei Stancovici <andrei.stancovici@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Liam Beguin <liambeguin@gmail.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Andrei Stancovici <andrei.stancovici@analog.com>
Subject: [PATCH v3 1/3] dt-bindings: iio: adc: lltc,ltc2497: add LTC2499 to title
Date: Wed, 2 Sep 2026 09:44:10 +0300
Message-ID: <20260902064415.132588-2-andrei.stancovici@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902064415.132588-1-andrei.stancovici@analog.com>
References: <20260902064415.132588-1-andrei.stancovici@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: FsVHvGoKNnYhp6KHBtXqtm3sf3DE8E3C
X-Authority-Analysis: v=2.4 cv=LuCiDHdc c=1 sm=1 tr=0 ts=6a97c5d2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=EP9JJrKyo648RTWUWkgA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA1OSBTYWx0ZWRfXzWoxM7NCMSic
 0VmLpk683bPFJAPRtcgwOXXEdaSVCp+XKE4TV7fqTjfw5aIRkSgq6MUKdyLmgFhr/4p1NmhR6uD
 ppaZFk0io0uXCsWbrzxGoTd9mor2Efi/DeDJVZCdqwPmFwFpmWjzRY+Ob+ZkHy114SujndMssIc
 bHy0pS6WBOy+jIWN9s9RHA0dJc/xspb9csJ00sYFZQnT//YpoI0bBEB1yoaRrbBwAq175Q5w42F
 NJe0DVQN7jKzYj3iLILLVx8Ou2PdLWcVRMgAhGfJ9IL+h9tzHZHBdqh/nmmLvzBYd+2Rh/g3uvX
 uOV/8Oo2xCAs7wYtWt1/wLoTAgzDyLp/u+YVzphHuvzBg7Qb1EPLN2AYzMD2hzf1ElEJLkWqmpp
 hEImcp2BoYXAKo7KSjX0PfYuqqxPbRShYro6vAVjcIMU16CmMJKIyC1KwsA2gqMo8nrPE0FLakw
 ZV/HA+cSfjx5cyrp3Wg==
X-Proofpoint-ORIG-GUID: FsVHvGoKNnYhp6KHBtXqtm3sf3DE8E3C
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA1OSBTYWx0ZWRfX8+IAbODeGmEy
 U2ht/kIsy20Gd4FuI4hJqw3DF9DkOUH3MWGqyhdccJuWmAO3f1vNd/PAECKd780EJJDQO65VCmD
 bzfIMJwG81Ke/gN1J7CvJ+WHJkdAioGFA8GzU9cgV3mKlUIkO5J/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_01,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 phishscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020059

The LTC2499 is already listed in the compatible enum and covered by the
description, but was missing from the binding title. Add it so the title
matches the set of devices the schema documents. No schema or property
change is needed.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
index c884b6e03767..8aa1ba0a8728 100644
--- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/adc/lltc,ltc2497.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Linear Technology / Analog Devices LTC2497 and LTC2309 ADC
+title: Linear Technology / Analog Devices LTC2497, LTC2499 and LTC2309 ADC
 
 maintainers:
   - Michael Hennerich <michael.hennerich@analog.com>
-- 
2.43.0

