Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BF23612DB;
	Wed,  2 Sep 2026 17:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369869; cv=none; b=KUYTh75se9kZ1/Ki2NLeTQ0bfhebjfroP8WzxgL5Td+Is0LiB9PgCXslDjVYCtgXc2dThpLISjOO59FANaN89xYHaBL09P3hjqIfJPOBCzb2jY7a1PYBiycmcTg4xdej1b8nYS1NxRfFFYnAzWHQVJc6mAQfsDlbAo06dAJlEb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369869; c=relaxed/simple;
	bh=imMIROgbIYKdS/W2LCXJDHNQiqmrSLNhI2Rz/8sZtls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPI2OcKIIuKWWvrbpKLqgaCNTPIwoNDnJ64Q2rQpPGBuo1snNs6NB4F/Us+0Ecq+nU38prVsviu2c/LS2iSD7X8p0usFcpBuX4S9av9nahF2sGdwnFzN8CyYMB/vQGnUxEWOEklKTiz3MO45oCieK0HjCbwrFEwRr/GHxgpdnKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ant9p5uZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ant9p5uZ"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682HBcV03745056;
	Wed, 2 Sep 2026 13:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=OObyt
	Tjq+zRLVCoziljDRsaCR72qZVcFLih2nmEu7nA=; b=ant9p5uZhqdCSKwpEkqn8
	uoXZnjJhxbnXVFUMrqTBPEeNRmht/UYfWqkUIAgBxffgPhl5H+AtEGv7mSC4RPfZ
	uMF6uTz3rcxIAH+KlLe38oyUoSPRh27udB6m9ePMqw8N7CkZ5OMFgBPG7O8Mm20W
	QcauCakgSn9nEmjHrzsU79BKDwJvPmxwyWvbsHaEvhXbNj8bRyVuEv5aZDRdOLVr
	1XHqBKtS7Nwe9VkfnHqC1Y3bP/KwPWr366aDPsPRRypYJZHZ1Iq5oc0KazPTKa9x
	zrp/iGp8jFkhpkOQ+6SLdgMQvXDK1gtgMl7wHMoKS4R/p8zCD40qP036bfck6/N+
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ge469d5ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 13:24:22 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 682HOLwf041388
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 13:24:21 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 2 Sep
 2026 13:24:21 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 2 Sep 2026 13:24:20 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 682HO7Ja004246;
	Wed, 2 Sep 2026 13:24:10 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 08/13] dt-bindings: iio: adc: adi,ad4134: Document SPI connection mode
Date: Wed, 2 Sep 2026 14:24:02 -0300
Message-ID: <d9b759d29fa8ca12b6cf083e180b2556ca4533f0.1788368334.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1788368334.git.marcelo.schmitt@analog.com>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: aBShun3MLcI7Ma5pIUoaUu5IWAXBMCOF
X-Authority-Analysis: v=2.4 cv=LuCiDHdc c=1 sm=1 tr=0 ts=6a985bc6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=BEYee7nrBUFf7RGVO14A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfX7xso/MdxGjsy
 fqtQz9sdmgFtCzBXtZSEINPTYwC0WD/LZOgUwGeg/9chvrKIX3AOwADrJ+ZRVIKQoK1GAFOxiJO
 sIgqrso30FLK4cEyH8c6eChla4n0EwUnddsRHqnkfmlVOENr+gaa1D+dUTvNvsWELp+lDqP8aM2
 UnrrwJIWOC+deB6wZJ4hQTvoMjwlhvnsyuUagqSx+Orox2iE5lAtduxTLzpyRBbWSxcEr29/c1x
 McV+RTLkfKmvjFenLJPaow3A8xUMT82sU/eTSFF79TSPx4qlYqzS2BaN+HLC0b36sc6zu5TZ++4
 UD7lNGY3dRfNddUTi8lE3kruFI38tSmMpY3BorbMVj5RsJuE2GU+hOW6kBai/DkbG0PK97t5fLw
 P79gpEu44wcpoK+H+/PSLIsiCSz+DZ9b2GXkzFCTU8EiQAA8q7qWzFtESc/MBIVNklRSMTpsI7e
 fCdklgr/P2m4tX6tPew==
X-Proofpoint-ORIG-GUID: aBShun3MLcI7Ma5pIUoaUu5IWAXBMCOF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfX0YGt5pDn9L2G
 KhKYOviuVhaMr3ImMb2fiXTHNSBURpK0guV/w8cY7HHgIY4VWZQbh4PtjjOIjbnCG8iJIQGq2y8
 xeBZSpTkHLmkydWbkuRmKxpoaUphFVhBAdc/XXadxA8ZSiirVSDg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 phishscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020153

Document how AD4134 chips are connected to the host SPI controller
according to different wiring configurations.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 .../bindings/iio/adc/adi,ad4134.yaml          | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
index ea6d7e026419..d843c02a394a 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
@@ -131,6 +131,28 @@ properties:
     enum: [ free-running, gated ]
     default: gated
 
+  adi,spi-mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ no-cs, 4-wire, one-channel-chain, two-channel-chain ]
+    description: |
+      This property indicates the SPI wiring configuration.
+
+      When this property is omitted, it is assumed that the device is using
+      'no-cs' wiring. When this property is present, it indicates that the
+      device is using one of the following wiring configurations:
+
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
 required:
   - compatible
   - reg
-- 
2.53.0

