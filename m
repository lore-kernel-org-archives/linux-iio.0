Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225353822A1;
	Sat, 17 Oct 2026 01:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202389; cv=none; b=cW/Tb0yCPoAlYMz0dkdwn5gg3oP2C+o0ef80VDHlQPIAu/BCo9tSZ11XyqyoR/irWUZkxwm5dv1VdTvUOS/KWE8XNeOq5T5TfTen33BZZdsfhK+hvW3A8LNd9qpJbTQ27J3F6I1XxFSgeuZI1dilv1itxKWuHY9aQMk+OKZ646E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202389; c=relaxed/simple;
	bh=rsXpF2m96AHUblAcqbkW7IKoOiiuV/DxBFqwcdlYN1s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gmoJOBTPN1KzPqJABQJaDy01zA3g+M8+zrHTMQkS1wf1So5gQswFHHSLR2iUpZil8h0YjqY+mTgi90oEMS+FHe3qnvqE8eHZD7lGNEweYsdjatTUGVThbGdiawoHa73ZdUNdZ90lkmWfX5NEPc2Kl/cR3gU0nByuRUW/MtAhyG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=KHvRB7Gn; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xYrK9a5v; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="KHvRB7Gn";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xYrK9a5v"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GNHSaZ2680473;
	Fri, 16 Oct 2026 21:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=9ojgSP5FOoKQsN9fcVtGEd+YEXf4EdV5fFiS0EwomK4=; b=KHvRB7G
	nJVYbNtmNJ/zG6eN1YH7oBYCd2PxXhkpVS1WMQoeVvdEnDdnM/Jupz5cUdxH1KH6
	StfZu3iOm214wPy3K8dyWHV45QxAxWLipqxPUdLyfJQxu9D56h5vic4k36O5Qv1W
	XZz0+oRzagP4iow/7INAu79JUh7VxeNOrzoTSxa1Enex5tEn0ZsC5/57eEfK6o8b
	puPegwbXP5h8iw97RFlVp6Ggv4Jyj3zxuIAv7u0LNdJUuQKjKjC1N5cFZMcQyYYr
	kZ4clothAvVZoO+bbk0T/g5Kop07912zWRItVpjEs0+rzuQcOcZgU6cdIoa8Y1sW
	gPYdyO3rpHj16ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=9ojgS
	P5FOoKQsN9fcVtGEd+YEXf4EdV5fFiS0EwomK4=; b=xYrK9a5vmirPbLtANUefR
	PsFl+ARBJjtRaafGLJSd0rB9Jj3Yxb0M3bl1A+sh4SY5CAuvYJOcE2r/HDbHiSIP
	BP72H6QtJvJ4TGv4qzhhJs7WiuYj94nNUMwSUK662rRhU3/Jd6dG/txedgbP3DU8
	cIVFNJGdNOetkSql5C97vLqHq4ucrcfZV/e2yWS5VTBT/vlFZRIatEGFyeKjM8i4
	a6+dCzhI/IeeicDvWzsEk6TxzzhFD+1N51EYPPZHvWgzwG+h+zuUC/cETvPNXZ/r
	uYa65NooUX3p0jxqV8zwCIlEQgCdMsAhh8tOKVplTOOAX8+uOJ1CgnA8MW0IOnH3
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hbmr4uajw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 21:59:42 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69H1xfuM061952
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 21:59:41 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 16 Oct 2026 21:59:41 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 16 Oct 2026 21:59:41 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 16 Oct 2026 21:59:41 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69H1xQ2W004349;
	Fri, 16 Oct 2026 21:59:28 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v5 10/15] dt-bindings: iio: adc: adi,ad4134: Document SPI connection mode
Date: Fri, 16 Oct 2026 22:59:19 -0300
Message-ID: <a4f4172252c1b1bd32d152adb6cfedc1cc372443.1792200021.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1792200021.git.marcelo.schmitt@analog.com>
References: <cover.1792200021.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfX2VZynaHEhQfk
 jE+aCkMw5W5jpELE4uFKdLjUUcLDRo5NWcn5M7qlr6SCFBDOgeLQpeESnFHyyjIrE1DLsPcJvM5
 9xOOIw90SNUd+NQ91TWGyHq0vz2ip4xol7mj9QCRyFvVT8ESm1LQmVSmC/NXsq4AkRZzkg71vMM
 /F2bPJMJiIgkxpRjLvZapYT6Wm+IcJZedEyaH5Mqx/gMUECyOvW/U5zfxRfkzBZiO4P/X9lEWNC
 sLbrTmIknrgtpfIrtUeytQ5tAPCtrA84vp5x6X/GxWlQ56BRV+4YSm5oS/w//IV93vxxSrQoXmS
 QTtc0EkLyBnC7DugQJ+R7R7z6DwY8AdDWlQkKL0yIqIpQG+OQGb2kxJUjiWT8W1en8UL7mKEwgt
 lLJ2ZMUzLlKcfizfZJ0LoPrqm4g3dEpE60e3nRAYGd4EApjpaFtQIHE9b7wQaepzpDwn6QCUpVP
 QrvsIPC0nQ//OEFjE5Q==
X-Authority-Analysis: v=2.4 cv=TqtzFzXh c=1 sm=1 tr=0 ts=6ad2d68f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8
 a=GM_lWPo1lvwkKjjvybcA:9 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-ORIG-GUID: AgtvF7vHHuHXj9tGH58CsnjvYPBA4Byl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfX7SwNF6IaZM2q
 PC5Ar72fVHz9EYWiu2KOsfVL8dqrzN+zfo/iNbnOFQ6Dr9ZKxFfr+K1ya0QqwOjVKsk5uHAswpk
 1N+/JbH3wbYjVdY2MfNgBZG4pYTDJhYVqRuw5ALaxiV3wRKGRBBb
X-Proofpoint-GUID: AgtvF7vHHuHXj9tGH58CsnjvYPBA4Byl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170007

Document how AD4134 chips are connected to the host SPI controller
according to different wiring configurations.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes in v5.

 .../bindings/iio/adc/adi,ad4134.yaml          | 57 ++++++++++++++++---
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
index ea6d7e026419..970e7adb2405 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
@@ -131,6 +131,26 @@ properties:
     enum: [ free-running, gated ]
     default: gated
 
+  adi,spi-mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ no-cs, 4-wire, one-channel-chain, two-channel-chain ]
+    default: no-cs
+    description: |
+      This property indicates the SPI wiring configuration.
+      * no-cs: The datasheet calls this "minimum I/O mode". In this mode, the CS
+        line is not used (tied to GND).
+      * 4-wire: Specifies a conventional SPI wiring configuration.
+      * one-channel-chain: In this mode, the DOUT0 line of one chip is connected
+        to DOUT2 of the next chip upstream in the chain. Only the data interface
+        of the upmost device in the stream is in direct connection with the
+        digital host.
+      * two-channel-chain: In this mode, the DOUT0 and DOUT1 lines of one chip
+        are respectively connected to DOUT2 and DOUT3 of the next chip upstream
+        in the chain. Only the data interface of the upmost device in the stream
+        is in direct connection with the digital host.
+
+  '#daisy-chained-devices': true
+
 required:
   - compatible
   - reg
@@ -141,13 +161,36 @@ required:
   - clocks
   - clock-names
 
-oneOf:
-  - required:
-      - ldoin-supply
-  - required:
-      - avdd1v8-supply
-      - dvdd1v8-supply
-      - clkvdd-supply
+allOf:
+  - oneOf:
+      - required:
+          - ldoin-supply
+      - required:
+          - avdd1v8-supply
+          - dvdd1v8-supply
+          - clkvdd-supply
+
+  - oneOf:
+      - required: ['adi,spi-mode', '#daisy-chained-devices']
+        properties:
+          adi,spi-mode:
+            const: one-channel-chain
+          spi-rx-bus-width:
+            const: 1
+      - required: ['adi,spi-mode', '#daisy-chained-devices']
+        properties:
+          adi,spi-mode:
+            const: two-channel-chain
+          spi-rx-bus-width:
+            items:
+              - const: 1
+              - const: 1
+      - properties:
+          '#daisy-chained-devices': false
+          adi,spi-mode:
+            enum:
+              - no-cs
+              - 4-wire
 
 unevaluatedProperties: false
 
-- 
2.53.0

