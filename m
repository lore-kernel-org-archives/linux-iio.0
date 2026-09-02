Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D492C384CF2;
	Wed,  2 Sep 2026 09:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341277; cv=none; b=iUKlGKB7g9GWoPXXXCXVF+7p21VF18tmUSaDZUpVWLnCb3Xp8zHMJVVp4gooKbnaihf41YYrzJi+IzrLuM25MOLasfiCQv7yuiHkKMbKOKKG2dAPPGZAi+nRYwabCTIN/h0GnsE837ITBQaM+dJuJxEJrH2/p70JxbrirY92oRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341277; c=relaxed/simple;
	bh=ZKN1B2gZYBwuyNnxocxDDBrNCih2O5jweGLmrMvotJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Ap8ROsyIujolYka1rJx6c5yjeyCfqofwsyngqSet3XofIeHpv+ZJt+f+k4DDq4FgFL+75Q8sxefmduobZ8uSK6+AJwNwB8cRWaqKXenVRAuC3B8bAaTzE+5Q9MXRk+2sMjrJ0NFJgxf9BmXpmb2AfAQAquge3mYcE4V4wCmpxMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dhQNi34G; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dhQNi34G"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6826Vkfq2268882;
	Wed, 2 Sep 2026 05:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=c8Rp8
	EOzkyMI8boZQTY40lparKG2slm87g2a/+q88n0=; b=dhQNi34GPtmEpMgqpZjfx
	c1JN7PV2F+8nAR+qyvx59EU1KVqJr+6C44PL1nZCQWfaz83QZZrOBzZUHPfcYHjy
	nju4DWFEGyWtE6uix+ydgpTy3Nz2D3mAFL0QMidsNbRof7GQp6WSZ1TdGxAtJ1rl
	qz/J1Kvs60UYRVA2b6zTeDDqoYdVdI6I4RCHfs06SGxgCAhaxX90JOjXISJquNrP
	W7dC1qTJhG3tRqtDO5GqVGUb1FsdpNKjKjEUYFD8toOcSNMKVsFW8YHIAfI43Wr0
	mkP7EJOA4tSCxGj/9uXu5MKCzx8OsnrAo7bAKZXET1hmY0zZT5Z1s1waLDWW3y8j
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ge0yqmax2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 05:27:15 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6829RENd029577
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 05:27:14 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 2 Sep 2026 05:27:14 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 2 Sep 2026 05:27:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 2 Sep 2026 05:27:14 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6829QU5Q032677;
	Wed, 2 Sep 2026 05:27:00 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 2 Sep 2026 11:26:15 +0200
Subject: [PATCH v11 1/3] spi: dt-bindings: Add spi-device-addr peripheral
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260902-ad5529r-driver-v11-1-301c491a0719@analog.com>
References: <20260902-ad5529r-driver-v11-0-301c491a0719@analog.com>
In-Reply-To: <20260902-ad5529r-driver-v11-0-301c491a0719@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Jonathan
 Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown
	<broonie@kernel.org>,
        Marius Cristea <marius.cristea@microchip.com>,
        "Marcus
 Folkesson" <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara
	<daire.mcnamara@microchip.com>,
        Paul Walmsley <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>, <linux-spi@vger.kernel.org>,
        Kent Gustavsson
	<nedo80@gmail.com>, <linux-riscv@lists.infradead.org>,
        Janani Sunil
	<janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788341190; l=1442;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=ZKN1B2gZYBwuyNnxocxDDBrNCih2O5jweGLmrMvotJQ=;
 b=YV6+BagmjHIANYKMpll8awUZGvHE9RXhITbbff+8bDx6XSROypy2AliYNpFziJAKJLWLVhICl
 5gDLTQQQ9P9DFdwvuwBOEsR2ze7gchNXegu7e3iSZH+FRPcc9FfFQik
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: vkC6VWBQxx7MQBNKck2Gg-VfjLxTmiNp
X-Authority-Analysis: v=2.4 cv=S93pBosP c=1 sm=1 tr=0 ts=6a97ebf3 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=XYAwZIGsAAAA:8 a=pGLkceISAAAA:8 a=p7DZuduEnTu05McJuzUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA4MiBTYWx0ZWRfX7k839VeRMWQL
 L9OgRK1TKLBM8j4Y8y8/2AQ+BRTe0pIJG3fUC7WFJSo9QfmLVyKDp63NFbPMt4m6+3w4VXqYilW
 HF6WbChA2sMKACX2NHZ4xJtKE0IMclv4l7BLNH5I0XM1Ik2sQKDoqw1zLln2bAQxbGrWI36V5rt
 nm7Ri1lbJKiTBvcfE/XGMTATOVBqL77c6QeJwnGGNTr2GlV7Y90K/hBXr6Do11ymhsZzyHT6b7Z
 KrHGXGiKc+pRaFwHOqKTlRuPqQDKHsDJVh2xw5Mf3cQuQt8CHn9bmo0EikPhw+yltVzeLebXRaB
 LgTiuCwQHOJu5DSwxcTeQ4ablo5arztyO6OHkvmk/VDskvcFBRNIclhKVVOFJIGZpDiBjpmQ3/H
 4DvSooe92jvz3XLVe5hZ9NVyaS5yKw03OI1XmrW4bxMN+s+Qu79yi44rHMktywa89FSE0jk/qhd
 AGuUcwU4Gzon3ath/Ig==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA4MiBTYWx0ZWRfX1ts2HLrsdW7h
 OTyZqSW6uH8c1MsjjPSPLufurMmjy6Vpil1yLlErmQ9DjF7jzXn20uXJQnE+dffqieue45JGxij
 VGIY1w7Mc4+twggkVRQyb0i5wJFIgSQCRfc30C9XAoJyjqgZvb5A
X-Proofpoint-ORIG-GUID: vkC6VWBQxx7MQBNKck2Gg-VfjLxTmiNp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_01,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020082

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

