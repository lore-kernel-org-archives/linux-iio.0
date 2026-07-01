Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C8F3B0AD8;
	Wed,  1 Jul 2026 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782888099; cv=none; b=KnRRan2oNhNySAlr5X4jsooWo9tq5t5N4Zyy3z/E9BCZyY7G0YKk04UsqflpUGG84xI8QqssIn1NN6ruaI7n5UPtSsGhci/liQXgKOR4iRQsSZizW3PcBJU/bY4EPTAhRUygfEKsoBvg7gIRxnjJMj+ZGg36Vedc+1ffYZD/Cto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782888099; c=relaxed/simple;
	bh=xO8qN1TBsqkbgTp82ZIlQcy1+L2pBMvbjcPy3LxRZ3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=utA5yECBfmc+wruvZw4iHbZInwtxfZ/pru6EXKBs+r4ynEU3hUpIGwRlu8dwpleceZlGZPfW4O8T533b+T7TT1Y6WfN83HcV/sNTsR8/+wng+JRF36mbzuh+6c6fWIPDY//cV2THTaSmkHT8djZaPYP43X0yexrD96fwdplWQwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=T56IFYaH; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="T56IFYaH"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6612vGQA2494013;
	Wed, 1 Jul 2026 02:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=HOksV
	+nKssbQlk4op7PMp3sTyIr3dpGaBStdSlqZ/JU=; b=T56IFYaHvKTo8IsnCaDPu
	C+iQ2AMqNyhdG4VJ/lKjNEroHtiJCgbdZGX+gejnK2Pdt3jPQs8U60LpsaoWq2yP
	/p1WEB1IzGZC2iggNZ5lqdo/pZHfgTfmNXWmsJTnPfPuALzbHQtqwmyR+syKipZ6
	C6FHrTWUzayFbqZgV9T7SkX/LR7ltJrhfSMGLgM02IDZTMvz+5H1i/DPTeoOb71I
	UudqxiI0AmFzP8dfKXZKikAp82g/D16cIChrUIGFIKr6EqhNFY0w6R593CexkhAn
	aMSzz5NbSjweudSNFwN5lWjSCvayQ3tkmlVvbV5SI0YUll6yrQmOdRY0H8U+hdEu
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4f3sava1ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 02:41:19 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6616fHq2061216
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 1 Jul 2026 02:41:17 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 1 Jul
 2026 02:41:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 1 Jul 2026 02:41:17 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.62] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6616etN9002283;
	Wed, 1 Jul 2026 02:41:08 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 1 Jul 2026 08:40:39 +0200
Subject: [PATCH v5 1/3] dt-bindings: spi: Add spi,device-addr peripheral
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260701-ad5529r-driver-v5-1-ed087900e642@analog.com>
References: <20260701-ad5529r-driver-v5-0-ed087900e642@analog.com>
In-Reply-To: <20260701-ad5529r-driver-v5-0-ed087900e642@analog.com>
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
	<broonie@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>, <linux-spi@vger.kernel.org>,
        Janani Sunil
	<janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782888055; l=1155;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=xO8qN1TBsqkbgTp82ZIlQcy1+L2pBMvbjcPy3LxRZ3U=;
 b=oZZR3RA15clOjersxLTdmiKSD3E8dSkil2U3VN1WFF6nRJVoqggivikdZpdGS7qqrfa9uuNFZ
 +DwADRQ3yOBB2OwadysBk60EeMrohF7hV/puFbS4QlH2VYGASf+zYbq
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=avWCzyZV c=1 sm=1 tr=0 ts=6a44b68f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=p7DZuduEnTu05McJuzUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: NaVuDlKh8V0Au6mKC6E6q-7oBNJIPx0d
X-Proofpoint-GUID: NaVuDlKh8V0Au6mKC6E6q-7oBNJIPx0d
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA2NyBTYWx0ZWRfX5pgOI43Hm5vC
 waZyKvN8IejeuUZiU6Ynvs7FbBcXUCrn00/jG00ebWrnTktDWJVUyKpLv+39dOgQ9lbYa3D2IHo
 A+i4W6S9qyO/JezA1PZyA8LeggYh56mlyUssHlyDYOlcUqMx9fAV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA2NyBTYWx0ZWRfX1pLrViEWf+3x
 Hz3JBmn3gRLaG0BuE0RZM0Qa88X4RKJoL9WhCMQ078I2GrxhyXi+Dkxn5vJev/zjj4NXMhUT4EW
 iOdlxjXK3vmF6roWRhODNC1jFA/5X/Jvxtu6/m2cA8mEb9aHjR0BD6hSITcZ61HJ7lC8Ric67cs
 /JhFpTZR9a9UuRj/C/O4vq4ndDuIoPhJlKd80Sc8Na9B2HoKO9Ptwk1kbB7dqKDY0YT6v0dNFzD
 t7i8lt26Z0+K5r+AczIJ41yIuayAz9Rrd1PVt+BmGuFr8bSMkNMLW0g7G1qJQ7OBun/m4VfBzNK
 rL7n5PiSzPkkQWBZo7vZoIwMpjZJIBaCNKPTU0wlgkU48TtwfvTAn3ax1cNg0fwbTrFR1pG7LkQ
 0e8C0M4aOPCY1oqUodSRRN3GyiWKK3hqlXcq+AbQNqk1QwLzwbCzlOvAxlU1gL/xaJqzLCgMzCs
 TzXZCpIT+0H87J052sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010067

Some SPI devices support sharing a single chip select across multiple
physical chips by encoding a device address in the SPI frame itself.
Add a generic spi,device-addr property to document this per-peripheral
address. This property belongs in channel or sub-device nodes of
peripherals that use this addressing scheme.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 880a9f624566..3774e8018355 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -142,6 +142,11 @@ properties:
     minItems: 2
     maxItems: 4
 
+  spi,device-addr:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Device address used when multiple peripherals share a single chip select.
+
   st,spi-midi-ns:
     deprecated: true
     description: |

-- 
2.43.0

