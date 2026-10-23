Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792795008;
	b=f1J6lTKkkRNKyrckcOQNIMtW3Fe2hJ4RaSZfscI6ap4ObFyicvuLK8YuVp0v940it3Uz
	 pCDPhtjo3EpTTvCPZZvy0g/ovyncvKK9C6QJ9Ck6zM+gfo+HPPNSEAo2gM8KN/NlvOMfr
	 vMg73kfG1c2i+JOY0R67Wx9z/IriZXiHP1Rqs2Sph+QbGe3NHTyJDu0JkC5K65J2eYHBZ
	 KiV/UD4yb9dijwDS5dG/g7xsp0sotaPwcz6z2kUa4oBmBU6sTjiZthaJwWxhd9FFBZn6B
	 iriMBcSbMhjjkQjjbvWwh+XhpyqLXaC+nZcjEywcapALHPZMBBqX5YauDO3NkHkHgcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792795008;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=kqw9DN5etczbR8CcSNKzOyuQeWNkFnm/t2MMnaNGr5A=;
	b=bAUoZiQ6BW230PYJA9j1h39YfBIFXGoaX2hqKj3E3C17Xy2+JxJjzYGb2p8fPHb1dcVk
	 /Pq7DU5zLkwUBKLUQ2YX4nX3UIkvLKdbvTmfR3zE6tuLaKNb4nS1zilRzzdySpnaggw0C
	 q3KgMowCLU5L78laSHCtuKaiuNy5ZYPGC9E3A93S0XetFanTWXTPdVYzcXDa7/OmlGOfI
	 nzperMoSMIayMHWOj28IXwnMDWckewCCpGe4LwfKvhcmFfJqBqN6nhxT5CpFDahBt3BaM
	 F0d9pZeSGdm5NxvHSIgCsH7xCl8Vr/jDriZZkGuqEtsXA7Nu+WL82IGKuSc4hMObdZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=pGi9fz1u;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="Gh/ajHZE";
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DF8606A31A;
	Fri, 23 Oct 2026 22:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2DF8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=pGi9fz1u;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Gh/ajHZE
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NLw6GE1783279;
	Fri, 23 Oct 2026 18:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=kqw9DN5etczbR8CcSNKzOyuQeWNkFnm/t2MMnaNGr5A=; b=pGi9fz1
	uBp2wn9DGbJ+FJAxrqhFA/EJ4yttOgZqI1rzk+WWTkRzF+ALZ7lWH2FYt3BfgUpY
	H2oH7NRPURvDER1XJePtkzFIIg8Vqz8gIBeMJmvwpVuosYPV7bGGwIfCBs2oowNu
	vYm16OAfOvjeoBxJXZdFGBtwv1v/8N32UIPxWcCXVAmdD0XM6d2dN7nSqk2f+2Y1
	+gdfODfcAFBkqYw4qmscfMsnEkfTxetxiXKdelD4/wBHpVYV6Zp/IvFAwKAaYED+
	1xZqVbklPxYyGcJtZ+b/o+3byaXOGEvOk9x3FHUk5gkmLOhVvo82eyzMWwJu/X/7
	UHJImfp3c4EHJ1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=kqw9D
	N5etczbR8CcSNKzOyuQeWNkFnm/t2MMnaNGr5A=; b=Gh/ajHZEqeuuqJ8arzUxB
	EY5hWkb8AuLPSPoFd0Xy0Er8RsNq8ggeGdzGiXD9nBJMdTzkkKo2yQLaDXbcwXE7
	fKmU39Sv1IoJJ4tiCILpZsD3cpV4mNN6RQ8ODzm/ZKbrxotkj2oWBDE2ghE7B5Rd
	xflpKpmqPo9RESjch4Jc2TCGl9x+lACcfDjO7C45Zxn9L5T0ccghqfp0cnl1jiic
	T0BNeUb0RZQQICPBuVVLwq/aeWA5iJf1qQkN3l0N90WIaBsMh96AkmlX+aQ5ahCP
	mXrOMPT1rzmeY8Ndi9eriSktLxZ0Z0z677ICXx8rZyw9gtVIWEXeVnJnZO+GhIwh
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hg2mvmcjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 18:36:42 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69NMafah017656
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Oct 2026 18:36:41 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 23 Oct
 2026 18:36:41 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 23 Oct 2026 18:36:41 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69NMaPwv005897;
	Fri, 23 Oct 2026 18:36:28 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v6 11/16] dt-bindings: iio: adc: adi,ad4134: Document SPI connection mode
Date: Fri, 23 Oct 2026 19:36:20 -0300
Message-ID: <79f47885969f956c1daf004d0e52021c62b84d5d.1792792325.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1792792325.git.marcelo.schmitt@analog.com>
References: <cover.1792792325.git.marcelo.schmitt@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: r3_sQhT1dIQslfORPDOlQ7USK41s7GFW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA4OSBTYWx0ZWRfX1NCVAVAF6yMI
 ptyjdBwkQQyZ1J3VpLHa7RgGAl+Kw/FIU3z2i7ANH2oV2VX7+klt3uHyE/FbIjLYEX3Q5ABzjcB
 B7sEt9TVsdgx048Tx0Ooy+qQgMzbGva0BcCoUhEZuW0JHloLYleG
X-Authority-Analysis: v=2.4 cv=YJoKWhGx c=1 sm=1 tr=0 ts=6adbe17b cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8
 a=GM_lWPo1lvwkKjjvybcA:9 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA4OSBTYWx0ZWRfX8DdpB5wVqsdD
 X2FEG35PCoQF75UG5BHgWqtmmmkgNJvdWyqa9Q4N/sOTkpRHA+QQo4kt42M47ChbWYr+qVkIKvg
 9+HYFKvO3VUNkp7gbjFMzdIFrLitchpZnDbrevkFgeVaKsahxqA2HBE+AqYe+kNNc9PStKxizTo
 2iG0YAdJ7YZotCjcEvteYFYxOtrBx+3/Ny6ckNsB2OQwxIefn4d7td1tHCg3V9Q6cG/f2RnS5lS
 5jIWTEiuA0o+x6d9EMnB+Ub71/eWR5D3ADTNiXWRDGREH5NgGWCtV4AaggM04fDxbFOvyJSmhI1
 3jidit4fPJpFWt0s9SBjjdUkIp2F/LFfEv2VBu8soc+jilKwL6T04N5tT/W1go/HfMk0caylC+E
 x+cG5fQgpTkqgqoxPG3gxbXyEFYYV/t0ZD1HaSqoO6c5OG+wyzULgKvca+lBDx4pwDnHN3s6N6e
 zlWHHlDiX44RONOLHMQ==
X-Proofpoint-GUID: r3_sQhT1dIQslfORPDOlQ7USK41s7GFW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230089

Document how AD4134 chips are connected to the host SPI controller
according to different wiring configurations.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No change in v6.

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

