Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74678429802;
	Tue, 15 Sep 2026 19:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499797; cv=none; b=jte/cje0JubpT6wO/SouFY5c5sKRY3hPFmeP0CsxJhR61R/5Gdf7Q04ACs2Lg9WVALoZDVH93dlApHyyp324cZsFwVpjniPGFvZZUCxNII9ETjaszVoH7UI2kNdnwvyZ9qWCKWwY1O4lm+/4Ff/KQyJdGmEsYH6z18QuV7e5b7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499797; c=relaxed/simple;
	bh=HlbMmkfrlmTOVnPPtHAZxCArk890rqxIGjjDydHPt4A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fs4wwo35xJ7C7sP+yUTWwh1AnNAqI95KgUUvb7bzGnlBAAZ97dg+jrY3gWgLFvsRl0lKWYoh6+hCsQfhS8rPlq8rhbXA5Fk2x6H3jEmOsvGA4cX12weNFjBRIAtltMatyvHzkJvg8DXuYrZhbqrwCZMoUBhzE+Hcywn1S7BtVnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=eQ7XFvDD; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="eQ7XFvDD"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FIsR1e2052843;
	Tue, 15 Sep 2026 15:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=eJv+G
	tGGBk94WVocDjB9Dh/5DSOft9RlfFQ2142o0kk=; b=eQ7XFvDD+8QN9URCoIJaL
	IdYYbcGR/mALJZEfVO6IGA5o711wILC1RFXf89OcBRKeP0nDHCV5qBxsSKwSpiHr
	AckSt+sdfHxBiDknXzyQ4lq7KNPdJavkq0JZe3socMD2fInjdWfem87I0jApiCrR
	yvnGNLFI3vrWssWwmTUHwLxCsZfaihBYyh26HLVdeil60mT+hbWY6vaPRQ7SHUhT
	Z6v8Yv4x2AUX3/efCafim9PtoixRSUxBJ5fOFqFxn6CkggRAH9LYg4VPXxHgwHZQ
	kn542ch3NfUZG071vMP6ERG1CY7XDXxM/hB5LI4aXEWERZgnrnq08g1/ucKzn+YI
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gq57eadc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 15:16:26 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68FJGPJJ019658
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Sep 2026 15:16:25 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 15 Sep 2026 15:16:25 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 15 Sep 2026 15:16:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 15 Sep 2026 15:16:25 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68FJGBXE028226;
	Tue, 15 Sep 2026 15:16:14 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 13/15] dt-bindings: iio: adc: adi,ad4134: Add high data throughput example
Date: Tue, 15 Sep 2026 16:16:06 -0300
Message-ID: <958894021cf7bd3012567d1dfabd7f2008fe8d31.1789494473.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1789494473.git.marcelo.schmitt@analog.com>
References: <cover.1789494473.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 58p6QgeXQg7qtyi16Iq4dUpsEepcVqS7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI4MCBTYWx0ZWRfX0y5JXT5xi3n6
 pLiE8hv8WBvmWZKnzf7i9UmfyYKBgSTGuO/s2CqNw0TJKK5Z8UrNJfo5B61PCdZJRlS7zvjIhQE
 gYu5ZYHAu4mdkTC0Ql24nXNFJN0k12pQn8TtVnXF1CVmMS999ORK3M94TjCEuWl1NQ/nrgugSbs
 MDE72uav8VRrMmwR4BPRALIqm+Zl8jOITW16dx5ljFUb37NleM5g6izRZGj0jh0m9k/CBoA/nmU
 tl8Z//71rFMtJEnX8fdAQbbehZSARoSgEh8/QEXIoNTD41NgcF0blbRxqyrnTPJzGF8Gz+BQMj/
 FZlwRnK1DrRIHb58j/5kPZj2BiBBxhxU8oswWp7qnQ64LCsswmfNFPoSDzO4cajOuSbsjLIqjMN
 wQhOt1DH8OE/5dE+kQz2LsrU1nwbIDe0pYL9gpQ0FuxAxtS4XM9EGBeiYzzRFajs/ibtq7c36Zn
 5jS6nUa/RY6+KhJjmeQ==
X-Authority-Analysis: v=2.4 cv=V9HoQuni c=1 sm=1 tr=0 ts=6aa9998a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=0FfWS_Qjr2VP3__5mywA:9
X-Proofpoint-ORIG-GUID: 58p6QgeXQg7qtyi16Iq4dUpsEepcVqS7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI4MCBTYWx0ZWRfX5wrNNg29fBZu
 tQ7nFJR8EOIB1leHa5PCWXVP+RvJvf8JHSb5d1SDtzAAttzzwP5ILX0bb/28E4R6ETIow4qinym
 IpM2jqtLxSd+qNURDAhZzcuLnbely79jbadG7d0Ed+SBiWvdRjgn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150280

Add device tree example for AD4134 operation in 4-wire SPI mode with 4
lines to transfer data samples to the host controller.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes since v1.

 .../bindings/iio/adc/adi,ad4134.yaml          | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
index ad67d1cdacec..133996917ee2 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
@@ -243,4 +243,46 @@ examples:
 
         };
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    ad4134_sdo_dout0_mux: mux-controller {
+        compatible = "gpio-mux";
+        #mux-state-cells = <1>;
+        mux-gpios = <&gpio0 100 GPIO_ACTIVE_HIGH>;
+    };
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad4134";
+            reg = <0>;
+
+            spi-max-frequency = <1000000>;
+            spi-rx-bus-width = <1>, <1>, <1>, <1>; /* 4 lanes of 1 bit each */
+
+            pwms = <&ad4134_odr_generator 1 1000000 0>;
+            reset-gpios = <&gpio0 86 GPIO_ACTIVE_LOW>;
+            odr-gpios = <&gpio0 87 GPIO_ACTIVE_HIGH>;
+            powerdown-gpios = <&gpio0 88 GPIO_ACTIVE_LOW>;
+
+            clocks = <&sys_clk>;
+            clock-names = "clkin";
+
+            avdd5-supply = <&avdd5>;
+            dvdd5-supply = <&dvdd5>;
+            iovdd-supply = <&iovdd>;
+            refin-supply = <&refin>;
+            avdd1v8-supply = <&avdd1v8>;
+            dvdd1v8-supply = <&dvdd1v8>;
+            clkvdd-supply = <&clkvdd>;
+
+            mux-states = <&ad4134_sdo_dout0_mux 0>, <&ad4134_sdo_dout0_mux 1>;
+            mux-state-names = "data_read", "reg_access";
+
+            adi,spi-mode = "4-wire";
+        };
+    };
 ...
-- 
2.53.0

