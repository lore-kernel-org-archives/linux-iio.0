Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136B3363083;
	Thu, 27 Aug 2026 07:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787816164; cv=none; b=OfL593A0smLFleD3sSkqw/O9eQzkAbBLdVpN99ratIXT9LrEQ4dfERWLEHqrr7P5F4RmnGkINvwWWybKe3mAs+55xvR8bAGqvSmGMwUKuMNg+spClYv5LsE7ArVpWRmok5Duk6bhwfmTaex4w7nrdXLSAoHQVQNL2d50datAjIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787816164; c=relaxed/simple;
	bh=ZKN1B2gZYBwuyNnxocxDDBrNCih2O5jweGLmrMvotJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=YsKxcWpziQukmirtUfdUTphpPpAS5KQt3s8kP/nXoBOWa9K58tTBKNVa9iEiOkQHB5c7xSBS/edZRnFGra97LT2ZRrcwvoW9/fWs9+S2ayKdqzyRkQc+ytmcWkgnBVYY5B1B7ukPJLlVzEpf69BEwm+evOPI63SGjHCzx3Cz9qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=PuDH3Fgy; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="PuDH3Fgy"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6PKNI2769927;
	Thu, 27 Aug 2026 03:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=c8Rp8
	EOzkyMI8boZQTY40lparKG2slm87g2a/+q88n0=; b=PuDH3FgyU8vSzMgOZX2Y0
	cHTintKCSA12FIhJ8E5lGpwtAO+7IXhKMSE2XS9eYzFBAFIFwWS9w9d8ULFT2AQY
	EPaTSCwUO/IS/DE/1HfdyC3YyxFkTnfZSZZT9He1Mt7I4fhrGtG8UhmjjdyEgANA
	CxvICRsa5w9PEF/XCYZ+EUsgB0vscCxu/+IuDYm+cqSsip9aLxdHW2jIdHqSHej2
	MBZ5CpZwq628qkqR0++5GOoYyJR+HJkpSO6nDdvHqAY0q9C+nw5WBTPICNDudLrR
	q7Y+Bt4jjgnbgCuHkVtoFTAzRWS/CBpO6WGrolB17PTMzeTtyN+DRRhvv2BMX7VE
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g963pupdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 03:35:27 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67R7ZQ81015141
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Aug 2026 03:35:26 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 27 Aug 2026 03:35:25 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 27 Aug 2026 03:35:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 27 Aug 2026 03:35:25 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67R7Yroo011772;
	Thu, 27 Aug 2026 03:35:15 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 27 Aug 2026 09:34:46 +0200
Subject: [PATCH v10 1/3] spi: dt-bindings: Add spi-device-addr peripheral
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260827-ad5529r-driver-v10-1-38f2be07b824@analog.com>
References: <20260827-ad5529r-driver-v10-0-38f2be07b824@analog.com>
In-Reply-To: <20260827-ad5529r-driver-v10-0-38f2be07b824@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787816093; l=1442;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=ZKN1B2gZYBwuyNnxocxDDBrNCih2O5jweGLmrMvotJQ=;
 b=IZRbWAbXqG/TRJNMABwCNtxNbZapal+ZyJDbLC1opUGm9jhZuYyWKmyJJUjlVBLq1APcaTqXl
 xZBaxnHFMCzBT8S1BFUGhttWlsW1dxFaFauF/0voU6QdTFVp8HV0y4G
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA2MSBTYWx0ZWRfX4Hd7zt0Z6oov
 G7LwT+7SAn6yK5UcZ+6xTV5CshpCwWeFaBBS34Ra80mLCk6+vtrFwBV6upwSp/wcE3Qnwro8axS
 KBHW+8cLBL7xU5qKhpMAiYYXcW9iQNQWzoanvG8IF5BU9gZ483WI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA2MSBTYWx0ZWRfX0Qgo7PAXYOWL
 8GOL7uZc/720pUuGNLMpZj0Bi375KOvRSTqN/lE+VatXs2/kBL59zIirewtcnJuIsSJT/CN8dD/
 thuDQ+UMtJaAzqObpYQtX8nqHqgePi7AiOrresgro2PkkG2TpjvHpuj+FRIpA4B7YpiJYMDm7wm
 PBnzggP8tAvoAfwYuIAj8VZ5zaHC2caft2hPNu+v9utINCgMobBrYztWVnAZAqKORU517MskmVa
 hmUrZyuE3ZpftygkGj5q1/9O4cFvXkfgPRO+QE2e5An81tHLJc5j/E3zbUuTyRDhzmcxiT3k/mP
 QqqR3gklYadUKfFrPBer1CHFkgX2exdUjKkTL62xbUMQqZ134WF8gKuh1hx6Wm+FyskcfjYbVBw
 TW86kxo37joR7DXfXAX5OE7YJUlLMnI9U7NrMCIu1/C83Y/k1IRXyseebV0tddtoKzVhPRpnj8Q
 g1AMnlQmW4LJx38tOBw==
X-Proofpoint-GUID: zrUg4agh5wTfD4kyFf1AkZso6reSFg6j
X-Proofpoint-ORIG-GUID: zrUg4agh5wTfD4kyFf1AkZso6reSFg6j
X-Authority-Analysis: v=2.4 cv=GNc41ONK c=1 sm=1 tr=0 ts=6a8fe8bf cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=XYAwZIGsAAAA:8 a=pGLkceISAAAA:8 a=p7DZuduEnTu05McJuzUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270061

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

