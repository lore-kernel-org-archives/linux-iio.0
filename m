Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11EC2EDD53;
	Tue,  6 Oct 2026 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310789; cv=none; b=IaVbVyz1OWvZwvcNWHbRoclyRJbCIdUGJie1aZrWxUql6WkS7Kdtpp+GTnX40gwRzC7CwFWUVPsIxP/UL8t0GRbnh87ALAsxmBQ33T/XOrwf3LL/xZ0KC1PBOTwnM0WhqZA2MapERPZRBXBqVqNk8/gcVgGf+aIio6x0A9CoXH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310789; c=relaxed/simple;
	bh=iCqQ2SHa/UOxdxSh2pebp4p0Jndrc9hHbQFBjWacjA0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S1jlu7hKCqD6TicvYG7xAn3A4ipSgYG+1DuTOeyZldQZJy1dehDpbtR5/ZlTFxlIlRDJQWUeaYLTkSzP46BvTrdkOeBYb/pKqPa7QidIZRySIVFjLUkNHhaaHrABARwlmd2mrnIu+TanrbTsuHNUOsZ7VP2T7wqmhdCHQq0ersg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=FUh5Xtvc; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Ne1no1tZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="FUh5Xtvc";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Ne1no1tZ"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696HhgrX2853281;
	Tue, 6 Oct 2026 14:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=cMEICVZm6qdHXkykKzO80G4iZavXuc2tFHMrlcapoBg=; b=FUh5Xtv
	cp7ZSST04O7L+o6qIJ0/dIu/pNt7n3CYVuU8ZWxr6FBbKYP04nNupUjufBRaY3TJ
	mPPwDpTZSIrUxtRS5hbkMwXEqRvZEw2Gn27hIWUQbBohTPegqMrGchR5syMJHFax
	SfPXN5Y0FYPl99FPzmHAeENQ/AvMZ5EjqQTn5dVWdIN0Ge74R3beW/yR9fWng9mD
	AeiQjJMezmswV9lhDTHNjivC24xAWhUW8OldrYHwDCG5CyJdh3RA5DsYulXXwEEq
	vb0bi2GYzBbWBEvseehHR2aROsKK6V/o+i3n76Ub+O9UJQDINKkjVBhFKjQPQHeb
	XnvygPp+ckK1yWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=cMEIC
	VZm6qdHXkykKzO80G4iZavXuc2tFHMrlcapoBg=; b=Ne1no1tZIxJhE3gnZs1D8
	YrRK0GuL7fD6O45RsJWKI2q+v0i6ZT+xWggA5zVtqWUKmCA0l5EVTtVMzGpH0oIJ
	ny49X4PBSc7MzpCxvRXhJpcNJmzC15LH/D0V+7cekLolhDdEjFfNcQnI7AiDTRbx
	pu9DFcdFfa8fjy2DEaFNbu29q/laRGOLkG5S9EgP+9Y3B+hH5E/DUUaCooZvxW/A
	BBaF9BMnES1lnEFhWmuxxSaXU++4VH0GNiEb33UxzkJkzt4tXcUPltgHHl/hdyLG
	HvIknh+X3dOWWWRoFP03NhtzYcycBdkuyit3nm8vZhxDV0OcyUSKUII9+t8+mkbL
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h4j2exu8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 14:19:42 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 696IJfJV010084
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Oct 2026 14:19:41 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 6 Oct 2026 14:19:41 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 6 Oct 2026 14:19:41 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 6 Oct 2026 14:19:41 -0400
Received: from work.maxim-ic.internal ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 696IJP6V001041;
	Tue, 6 Oct 2026 14:19:27 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v4 11/13] dt-bindings: iio: adc: adi,ad4134: Document PWM usage
Date: Tue, 6 Oct 2026 15:19:20 -0300
Message-ID: <d7b7074d048a1ced9d37178a529051ec0e1f0cb4.1791309733.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1791309733.git.marcelo.schmitt@analog.com>
References: <cover.1791309733.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: KHmiv42ny3KEoWERz7bTEZkz7Msem5zo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA3MiBTYWx0ZWRfX5Q4Pc69WkART
 II3wobYbpkc19HVK19S7OUvAhD4fdTzLJ7WWaFxSx3ScF9Flm5uOrSAUGXmjwRTw/y9e5Iru8DV
 DWc9ojXhHkHPG5Ur0nC8/JXWKFfSo3ZVhfsM3VXcb54wre6rzBV7Yt/MdOLv76rqfzcQ6cvXPBF
 IgPuC/WHOcNdGJiz2YTg5KZcskVi80IYSDrM12fbMdyyZbz5ITtNnKqj+UvkIJMA13p5+QeNM5f
 WYLMGLJYjlG4YZfVcMfivrgklb5qXaRbJz4ZNUpACn9ypc9/A60/Qnk0pmUowb81jhtFJwQ5An6
 gfFX5vMjqsr6FMdgWR3AYWDFPXGtXWb00Ex48HqTFTRK+I/IeU6chVydcjM4/HgHOnd0VDnspai
 Ys48+VUslyVPyABxzB6vXDUFJsrjU2nF6U1QWiv/953n7zZ1uFstKIVwX8rRls74uKm+bELIEVU
 ro1sn8NssoIE/8F/TnQ==
X-Authority-Analysis: v=2.4 cv=JvtkP84C c=1 sm=1 tr=0 ts=6ac53bbe cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8
 a=J-Vyfb8du_z7m07cT4UA:9 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA3MiBTYWx0ZWRfXygbZSaQ8xaO0
 p/x3j2GUF7Kvlknpwso+cefzoCK4MB1vCjNw94dwpgkoZEjW1u+isSxgS66NFeEio9i8bUhGXWU
 NN2LY1ACVtc6eYnTUE9XKcPaOkEgsmO+Qh80BUSd1gx8+N4ppU0l
X-Proofpoint-GUID: KHmiv42ny3KEoWERz7bTEZkz7Msem5zo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060072

Advanced setups may connect a PWM signal to AD4134 ODR pin for faster
output data rates.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes in v4.

 Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
index c70b9113cd67..6a190b7a9311 100644
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
@@ -257,9 +261,11 @@ examples:
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

