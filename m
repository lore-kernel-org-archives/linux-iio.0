Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842F93E3164;
	Wed,  5 Aug 2026 07:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914328; cv=none; b=Gl4rfA2KYE3xljQMs4Sjavlqrkdw9UN5+ErtnDYPkdN27GqgRs60ZmdhUPV6rSdHp6wGx1GbTEZkVrh7mgIm9CoiqWAlyv4ZnGdWRJHwQRrXGl6cmOK2MKWVQ3zsX3Yh90HBaPaiqGyHgXJ1CfKZc323L0UUZSMEUUiT3yUqZTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914328; c=relaxed/simple;
	bh=ZKN1B2gZYBwuyNnxocxDDBrNCih2O5jweGLmrMvotJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PTvXwBpW8OBg/v+KnQzDJcuTpNCXfK6SjoWgQvI07WN1Sq3d9s/wBFNxsPOPK1fRIOGBVgJ9+Lja5Ufhl4ZBvqz57zFYAhKb5W4IGjcAudChi1gHnpNotN9LtnOhmBMZGg7kn4vyikDoTmClbjq6AV8syxyXnjoMlF8Y7Qf8bVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=sPFuwKmm; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="sPFuwKmm"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6755iYWS4105096;
	Wed, 5 Aug 2026 03:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=c8Rp8
	EOzkyMI8boZQTY40lparKG2slm87g2a/+q88n0=; b=sPFuwKmmceZENMsVpuFBQ
	xdHxCS4frOuoDasrnz3a6p/rFnJ/xVZV3EOz9rV/T3BudyJ0QpdVIBe5HTwmU8eS
	rP5zAlhPEwT3OWkeNOJXZCGiXuM4r7uEEMj6GdkuAA2V+wjfc/Vz6765HBh0zGkv
	+fj2pdH/N4j/pTWO2uCOgqpb+JGy3aiGCpb8x9TL1Vh5ZNk6+hT7Y8JpQWTwPp0E
	3nq24S0qWUcNxp7isHmaNBGgCIycT+UQZB8CvLCbC80gtzvUeMUYQOS6RZanoXy2
	8ReddNJa3xfuS3vMUFmrKgSIKGNU3UTu9h/R/tTQob1T81rap7QgDBPmH0NaL++k
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4futjf1g5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 03:18:13 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6757ICVh052735
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Aug 2026 03:18:12 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 5 Aug
 2026 03:18:12 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 5 Aug 2026 03:18:11 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.60])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6757Hgx5021587;
	Wed, 5 Aug 2026 03:18:03 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 5 Aug 2026 09:17:41 +0200
Subject: [PATCH v8 1/3] spi: dt-bindings: Add spi-device-addr peripheral
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260805-ad5529r-driver-v8-1-b41781f5632a@analog.com>
References: <20260805-ad5529r-driver-v8-0-b41781f5632a@analog.com>
In-Reply-To: <20260805-ad5529r-driver-v8-0-b41781f5632a@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jonathan
 Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown
	<broonie@kernel.org>,
        Marius Cristea <marius.cristea@microchip.com>,
        Marcus
 Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara
	<daire.mcnamara@microchip.com>,
        Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>, <linux-spi@vger.kernel.org>,
        Kent Gustavsson
	<nedo80@gmail.com>, <linux-riscv@lists.infradead.org>,
        Janani Sunil
	<janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785914262; l=1442;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=ZKN1B2gZYBwuyNnxocxDDBrNCih2O5jweGLmrMvotJQ=;
 b=caP6c5QihYaTSJDv5bVwW4+5WT87Ah+A3NBwlbUmhR1mEelc44hfY73MB/UHgdNISVm3sCPwb
 CoM/taB7AtWA+VzNHbpg3fClVm25aPWEg5p918DO4D0xvOtvdbe+M/z
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=YuQ/gYYX c=1 sm=1 tr=0 ts=6a72e3b5 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=XYAwZIGsAAAA:8 a=pGLkceISAAAA:8 a=p7DZuduEnTu05McJuzUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA1NSBTYWx0ZWRfX23ozIHjxkrdE
 WtIYUEercaYBFbUGWcSl6xxrM8gWdKvVqjBJl/XRDCSVLRjrkJ96Imt/dDLoC4lCXcLlNTVUCs4
 HPe7My9mZkkvq06FQVG5MtE/lgOgroX3BXk+khcqVhvPbytAEoMN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA1NSBTYWx0ZWRfXxBmgUflCdtJW
 dsLgRZt9VYKM52z3EXA8gnCV1rSa2/nybPFYm4UOqhn10ZUHcsz3Gq9qzh8nMel77PC6ElU7vrn
 aZVwkhWYiwN7UZYcYoTDeBqIdjN1R9kxP8TJbrfVVJ9lU9bF0fCBcQWwDVXYh9qs12uJwPJnw5P
 8L5Q08r96W3b2sbqPTrJ765U900II7GgVpxzQzeGfasoD6JP4WtU3ILIW5YXqN+p7QP2YGO9YYO
 83+nE/Sf7avWkHngnljU3vAvlsU2P/nrLurg8n5iIRVxu8p9lsz8vFLx/nat7kldXonpUEnKL3y
 p/qH0bIMLhLaJu9IVlMtPrwfV4WN9lAy+JqLZTtK0TuzeEXu0UeByjkefDqwMl3cJVhTayYam60
 +MspoVRUI4NHeDKWlruZyFpbGSfNrV3hKGXYlfT0CGgnT0ddkU370qf7hSWNfBoWoQLEz/7rvFK
 zk6RXZlHBTK7+eNVINA==
X-Proofpoint-ORIG-GUID: ZgpJvYJSkv6nVvtWaZi_sn7sbSqGriOS
X-Proofpoint-GUID: ZgpJvYJSkv6nVvtWaZi_sn7sbSqGriOS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_02,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050055

Some SPI devices support sharing a single chip select across multiple
physical chips by encoding a device address in the SPI frame itself.
Add the generic spi-device-addr property for describing these hardware
addresses. The property is placed on the SPI peripheral node and may
contain multiple addresses.

Acked-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 880a9f624566..4894196c8f9c 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -142,6 +142,13 @@ properties:
     minItems: 2
     maxItems: 4
 
+  spi-device-addr:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Device addresses used when multiple peripherals share a single chip
+      select. The array allows one logical peripheral to comprise multiple
+      physical devices, with one address per physical device.
+
   st,spi-midi-ns:
     deprecated: true
     description: |

-- 
2.43.0

