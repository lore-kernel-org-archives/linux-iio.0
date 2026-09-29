Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D43E4D37C1;
	Tue, 29 Sep 2026 22:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721950; cv=none; b=G/j0ujlhh5viNJleA4jBxeRhJS4E04RhJ4VS4eQSsmKWM9MGKbU+AVKMP74PRrvaKpxN02kYwUlDT3jpqn7oVYiutz2MuPLNAROwFvtU+PF4ClXvX9ZHt6/Ne3vgpUjvp59c2BhjxsYkJV8st8xDsxt1ZBqqRZ0Xx77YXKPcwQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721950; c=relaxed/simple;
	bh=y13dgMGRY1eIqdswzkNPttm4zXSPYSu/TzsZp38vxWk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i48VVBkmxsUc3R9Kxam7wjdwcmCOXlM8wQkSMY4TfBT2TDK4YbobXeV4pdd3GRPD8XHRPuUb1kMmpta3ca9TFy9igj3dj++odGlB3MTeN24t69GwIfI83RtgjykIZk0BzpEqEalmo6AWeL1iTuKrxzb+ycoJXdi9E6MW0WrByEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZRaO0WLa; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZRaO0WLa"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TJjee81957967;
	Tue, 29 Sep 2026 18:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=4X6QH
	bYPkaNESehwlubDvVHWtDreRavWW8oDqh78PHw=; b=ZRaO0WLakjK/M40L0DSx+
	ZQi6feup6eCt8R3D1bxTwTfkC4uefT8CfbJMcKnRo/vOsBTvGR8ZrZkIcsvq3RqM
	E4DKSGvhAZVZgxe9+8vD2FWJCbwRVfUxxkq1F2RTJp/vzKx1cFMYE0I6k1IduQ0T
	/O130wOA8WGLSMTDGRKq5eHKgAyCK/nVnOZ90X6ps9wu8gkU+ccgaGPeBIkRL9Qu
	PQiXJl2YBf8h/1z1Vu1oqwaL939P544vbpweeRZpyvcnbD2nmKjMVDP7JT4rWE05
	vQKOS0DPvVUkPyhncoBTFQ97rX/zXAXdZW4sC7/8/ohq+DNYbI3DIzc+bhl373cS
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gyy3vfgc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 18:45:43 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 68TMjgXY041662
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Sep 2026 18:45:42 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 29 Sep
 2026 18:45:42 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 29 Sep 2026 18:45:42 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68TMjRpF008263;
	Tue, 29 Sep 2026 18:45:29 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v3 11/13] dt-bindings: iio: adc: adi,ad4134: Document PWM usage
Date: Tue, 29 Sep 2026 19:45:21 -0300
Message-ID: <4a03fafd8df060679c8f078392c2f417a9efa2d0.1790719425.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1790719424.git.marcelo.schmitt@analog.com>
References: <cover.1790719424.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 5IhnT4L47h5QBeZA_ZTMAuoDOM8yPLrd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA5MCBTYWx0ZWRfX04J1K5bxjcd8
 x1HrJ7ems+hGGvHLdlYN7jj9Wf+CCYwWiCKPAXnYQcYmw0JzmpkQIbhK+aXwKXbM5rIRcwPLyV3
 mBkU+0Mvs73BfWBdh7moXncI/kcltmZMl5f9LyUC8+0IjC2EL7OJkPlS6y0w+sNhFPqu8AD8W4j
 5ksVhS33xc5O5/2PexTRmLUful9W3KvMhhjDkyDWQ6ceXoKVtQL4HkW3IEb2TQpX4iHwKjXqLHe
 fTZ0gsb4TIZnVWYaedFQiY3IdpZY8SyFQYDVbnUuHOZS/PCCgR5gqDAdUu/S2BGXfJ4/mR9usGN
 FlVmcN87BImckzukHiyjlksd/MncHZ18/pYvEFLX3meFiicVWlgXHucw3qK4YrAD4YonGzl7jQH
 mK5BPRGqrqntsZ5RdLuZFm0giIIji9rfWX+kf3f8L0N1aPc0GA3cOK1O0RpO7SoFIuvm3mRSwAS
 poclgTXOFUX+UlFnGeg==
X-Authority-Analysis: v=2.4 cv=Y/ltIReN c=1 sm=1 tr=0 ts=6abc3f97 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8
 a=J-Vyfb8du_z7m07cT4UA:9 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA5MCBTYWx0ZWRfXxeMIstaNgEn9
 U9L/QIOIQddys4d4QInniX1r4krrMLD/7Mt9l175YcYNBJAjIAWHrcP+0mWfHBl3FaEw365MTpc
 jISFRjQR3fe0YN1Tfz/iP0iISSEXsZN1s3F09AovPSgqvBsKGGSs
X-Proofpoint-ORIG-GUID: 5IhnT4L47h5QBeZA_ZTMAuoDOM8yPLrd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290090

Advanced setups may connect a PWM signal to AD4134 ODR pin for faster
output data rates.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v2 -> v3:
- Dropped odr-gpios from offload example.
- Now that the 4-wire example comes earlier, the pwm is only now added to that.

 Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
index 27de44719903..f585243b624a 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
@@ -104,6 +104,10 @@ properties:
       GPIO connected to ODR pin. Used to sample ADC data in minimum I/O mode.
     maxItems: 1
 
+  pwms:
+    description: PWM signal connected to the ODR pin.
+    maxItems: 1
+
   mux-states:
     description:
       mux controller node to route SDO and DOUT0 signals from peripheral to
@@ -251,9 +255,11 @@ examples:
             reg = <0>;
 
             spi-max-frequency = <1000000>;
+            spi-rx-bus-width = <1>, <1>, <1>, <1>; /* 4 lanes of 1 bit each */
 
             reset-gpios = <&gpio0 86 GPIO_ACTIVE_LOW>;
             powerdown-gpios = <&gpio0 88 GPIO_ACTIVE_LOW>;
+            pwms = <&ad4134_odr_generator 1 1000000 0>;
 
             clocks = <&sys_clk>;
             clock-names = "clkin";
-- 
2.53.0

