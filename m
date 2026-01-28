Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24FA2DF12F
	for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 11:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599489; cv=none; b=DDOM9ZLkKJsOLIDn51Mdrdw3YqDMQIFrosUVaRqYGQsHaDZUeIVWqcrLDUMtgObEfvf6TOyo4iEZ5V3NM2SO3BPTdzKPjyZbF1zJdHxrHRfb83VCSUyNiajdu4lKzFlwuNMXdnD5/C8d2k+Ay/a1/meSbNVU5OCAiniaad4oRxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599489; c=relaxed/simple;
	bh=DbLPeovYiwjXpn5dbWMK4U8Irz//NWlC2tACaOAzwNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hTF13FVm1hJraQXveKEqAilTC8tO/GkonvA+EthUjjXTtCf3p4XVDikj25LXPGu4YMN6/Ak3TNoUt3sVU5WxMpAkZLZr3AnGoXCLXt2fZ5KivXmdfvidGE9t/i2k7ISLWaJZdVNa1RqWiU4qVVOKot7fNzzWIUFR2uwi4jcQeYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pXlzDfPq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g/bv2MSX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pXlzDfPq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g/bv2MSX"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S92URi254475
	for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 11:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+Sy9zUDZs56
	f6JnqKzFkwx6XwPXTc9MqxOFBhYwgs2A=; b=pXlzDfPqPTKlaz46J7jRQdlXg7Z
	WxENcRFC433nlc8E4DoqJlywKtUw9E++MFHibHEt5xi/qm5ltMsVnn456T9hx75X
	AwUcy6HD1u8+7FJZToCO747Ihj1xPkCjK+g6IvIOb5GWwzFCD5wO2iwnwyahKFH6
	mPPgVxVK88tjR/u6I/BEzr94maGzro+ySIKIq1PW/Ee5qVyoVosM5ZhPwwMMf6Di
	NTNd2lKXU20wIU8SfSAUgodddX/OtW4SaA/a0fNW4q1/MwiiTLOUg/uej9MiYBAk
	gWMAZ0pZ4gF9qswb0qmyGZB2imKx2G0n7FrCjKsB8pCDLptmimKgLgEcf7A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by20y34au-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 11:24:43 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a7a98ba326so12193345ad.1
        for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 03:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769599483; x=1770204283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Sy9zUDZs56f6JnqKzFkwx6XwPXTc9MqxOFBhYwgs2A=;
        b=g/bv2MSXVpSH0nEaj6PmIMvc5nKwKoDxWUydqYZOVP76Zcv0N3y3VpbzGGrVqn7GQZ
         Iq2sxMJ52fXxkzthO1jTu7aGf67y013QUhuDdWzrpH+PvFfYOqjGimfbtkbQ8VKPcpII
         v2VHH3SPlefe43DbQEn9WIglPSIxYBzoSrUfbzR8KJJPRNZOL602rnhhxbHyqrjqnhUv
         vmEH4uhXqNrljEIiiuEseJPZocoAaBF57e46xNEQkZm99w4NVPXeowyTjHJyhegDAgQJ
         tUK2MPLZVpG6307urE0llSwZtiMvydSAg2gJnr2G8Z9PDyUVaE8rrHwRF2odBd1fFc68
         S+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769599483; x=1770204283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Sy9zUDZs56f6JnqKzFkwx6XwPXTc9MqxOFBhYwgs2A=;
        b=ES25/PiT92v/9aA0dPorx81OYmYX8+MQmJOOCMLF9AkG2tKsikfiOjtD38ilK+4Hnp
         VEPDbtFzIQNdp4f51O7r/IOI2VmCgpyx0p5Bi7ZRuNFMmNF70Om2YJ9zcpDEtvk0jRBr
         jc12ReT0veMdhpwtnXU25NCQ3av5V5Ma0ptZ0iP6IY45ZF3cbdPsGXDnMcMoFQDQ9aIK
         NW7uGIAQ7gKRs4uozJjaxQZUGsl7o73hSjJ/lkwvBnC+TIc8dx47Iis5RFYJYbT5NQaQ
         JASJDABPxAvyopFdOXg2nMEnz+oZc0P1EwnQS3DgIGsvUKgHjbnTEczaacepvxlTao8t
         +yZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMZoQ5DfT+w1/R2sH5jBXA9FT/GAteYQPjCKfLvibdnFqnT0y9VbLtfgTCmzxJ4B9wYn63bqjRSCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpew3wjyjt5Rz5ANf2hE+9XSmDhACN0eyTTXNIq1uC48RL5MDF
	NvL9MSwx8SwOLdZJVc+0Afmvt6Smp8r58wKyckiaWpcdywYDi8IL0tjwS3U8/R5ct03zilzJThe
	RVvEcaG0A1OYS2qU7aZrm7sbGU06R5YLGBhi2kJYHUWMLkAi9/+svMJvwp1iOOlQ=
X-Gm-Gg: AZuq6aKF4vSifzBEf1d/pe4k1Fwdprls9ALGQa74n2tLO7AXBXyx9iGz4qxTYOm0HlU
	ZoYinuffJAV8n7QOhZ08njRAIz5AWx+qZTuCKxB3w2W2WM4Y/13HWiWjr/g20y9AGir8KX7XDmY
	nlzUFxY2blHy46WczXZLBkn+XLBK+AbNrOtkYrZ/WEOG7H0Nwi+WA8j394QgX1gXnbhadaOXvxn
	RPIrSNffwiLA0ih2eWzXOHlP2trkfVgBG2x+ISNepz7P7eaXEVBzHrd5V+TlpQEHS60h5oMc06w
	RoJn9HBOQ2zKuTsdbF0B/0T87kRfN9lGiVdy2mSF0oEKx+7E400/gCHKizJWhaY7XNuS/qfSJZA
	LqtikrbiwWINHfAPI/gr4tZo+FRJOEf787S5Xr030yz2Y
X-Received: by 2002:a17:902:d2cc:b0:2a7:bbe0:f01f with SMTP id d9443c01a7336-2a87120f624mr46348375ad.2.1769599482753;
        Wed, 28 Jan 2026 03:24:42 -0800 (PST)
X-Received: by 2002:a17:902:d2cc:b0:2a7:bbe0:f01f with SMTP id d9443c01a7336-2a87120f624mr46347955ad.2.1769599482206;
        Wed, 28 Jan 2026 03:24:42 -0800 (PST)
Received: from hu-jprakash-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c40a8sm21984605ad.51.2026.01.28.03.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 03:24:41 -0800 (PST)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
To: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, lumag@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, jishnu.prakash@oss.qualcomm.com,
        quic_kotarake@quicinc.com, neil.armstrong@linaro.org,
        stephan.gerhold@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH V9 1/4] dt-bindings: iio: adc: Split out QCOM VADC channel properties
Date: Wed, 28 Jan 2026 16:54:17 +0530
Message-Id: <20260128112420.695518-2-jishnu.prakash@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260128112420.695518-1-jishnu.prakash@oss.qualcomm.com>
References: <20260128112420.695518-1-jishnu.prakash@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -wsDeqal_dpLgrslCvTJQh2cmVLRNElk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA5MyBTYWx0ZWRfXydR9d0PjSJ2I
 +NKUZ6z0qtFhYvGD3372MgPXyLvdlzWJtpu8wcoLrXjbKJbMQ7o/7PtX7/tKcbHlO6WvxS9ACpq
 HKrw8Tahh0INQ/Drl1FzTaGvh6l3LOZARp7zLeMBSoMAgA2W9LxeNgTF5XkpGKeCh1KNuNZPMye
 LXewLdg3K0wlcs+jD8kty12Yh/6w8aJ4znYx0Zt1ixNRF4l0AEWq/gOYQdh/Mq/KKqDYLetJzKk
 iwRn6iH17sPPNWnzVJ+VDp7y5FCnt986sqxB7D3GYMObL/Sd8Z9RVNF7czH7x+JNLPFf4EigExV
 ZSfJOqfUBMis/h7Vo5yx0lP4Xi+bwg+kAGTsaEepDOXjwindkzwqwffK6gu9MEs4gV9fBTTMClY
 yBjMFnGMQc9oXszhni9PKg4MHAyezh85OWDUOjhBhZ4Xuwmxr0F6oa3rvM2waIuyIjWql3doypz
 N+e0jHOlvB505jUgyVg==
X-Proofpoint-GUID: -wsDeqal_dpLgrslCvTJQh2cmVLRNElk
X-Authority-Analysis: v=2.4 cv=IKgPywvG c=1 sm=1 tr=0 ts=6979f1fb cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=KKAkSRfTAAAA:8 a=i0EeH86SAAAA:8 a=EUspDBNiAAAA:8
 a=4vDKtjJwf6yegxfEYBcA:9 a=uG9DUKGECoFWVXl0Dc02:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280093

Split out the common channel properties for QCOM VADC devices into a
separate file so that it can be included as a reference for devices
using them. This will be needed for the upcoming ADC5 Gen3 binding
support patch, as ADC5 Gen3 also uses all of these common properties.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
Changes since v7:
- Removed binding file paths mentioned under `reg` property description in
  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml, and
  updated the description slightly, to simplify it and avoid any dependencies
  on patch 1 from the earlier series.
- Removed an extra blank line present in
  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
  in previous versions.

Changes since v6:
- Collected Acked-by tag from Jonathan.

Changes since v5:
- Collected Reviewed-by tag from Krzysztof.

 .../iio/adc/qcom,spmi-vadc-common.yaml        | 84 +++++++++++++++++++
 .../bindings/iio/adc/qcom,spmi-vadc.yaml      | 76 +----------------
 2 files changed, 86 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml
new file mode 100644
index 000000000000..3ae252c17b91
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/qcom,spmi-vadc-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. SPMI PMIC ADC channels
+
+maintainers:
+  - Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
+
+description:
+  This defines the common properties used to define Qualcomm VADC channels.
+
+properties:
+  reg:
+    description:
+      ADC channel number (PMIC-specific for versions after PMIC5 ADC).
+    maxItems: 1
+
+  label:
+    description:
+      ADC input of the platform as seen in the schematics.
+      For thermistor inputs connected to generic AMUX or GPIO inputs
+      these can vary across platform for the same pins. Hence select
+      the platform schematics name for this channel.
+
+  qcom,decimation:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This parameter is used to decrease ADC sampling rate.
+      Quicker measurements can be made by reducing decimation ratio.
+
+  qcom,pre-scaling:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Used for scaling the channel input signal before the signal is
+      fed to VADC. The configuration for this node is to know the
+      pre-determined ratio and use it for post scaling. It is a pair of
+      integers, denoting the numerator and denominator of the fraction by which
+      input signal is multiplied. For example, <1 3> indicates the signal is scaled
+      down to 1/3 of its value before ADC measurement.
+      If property is not found default value depending on chip will be used.
+    oneOf:
+      - items:
+          - const: 1
+          - enum: [ 1, 3, 4, 6, 20, 8, 10, 16 ]
+      - items:
+          - const: 10
+          - const: 81
+
+  qcom,ratiometric:
+    type: boolean
+    description: |
+      Channel calibration type.
+      - For compatible property "qcom,spmi-vadc", if this property is
+        specified VADC will use the VDD reference (1.8V) and GND for
+        channel calibration. If property is not found, channel will be
+        calibrated with 0.625V and 1.25V reference channels, also
+        known as absolute calibration.
+      - For other compatible properties, if this property is specified
+        VADC will use the VDD reference (1.875V) and GND for channel
+        calibration. If property is not found, channel will be calibrated
+        with 0V and 1.25V reference channels, also known as absolute calibration.
+
+  qcom,hw-settle-time:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Time between AMUX getting configured and the ADC starting
+      conversion. The 'hw_settle_time' is an index used from valid values
+      and programmed in hardware to achieve the hardware settling delay.
+
+  qcom,avg-samples:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Number of samples to be used for measurement.
+      Averaging provides the option to obtain a single measurement
+      from the ADC that is an average of multiple samples. The value
+      selected is 2^(value).
+
+required:
+  - reg
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index b9dc04b0d307..16c80709a3ee 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -56,7 +56,7 @@ required:
 patternProperties:
   "^channel@[0-9a-f]+$":
     type: object
-    additionalProperties: false
+    unevaluatedProperties: false
     description: |
       Represents the external channels which are connected to the ADC.
       For compatible property "qcom,spmi-vadc" following channels, also known as
@@ -64,79 +64,7 @@ patternProperties:
       configuration nodes should be defined:
       VADC_REF_625MV and/or VADC_SPARE1(based on PMIC version) VADC_REF_1250MV,
       VADC_GND_REF and VADC_VDD_VADC.
-
-    properties:
-      reg:
-        maxItems: 1
-        description: |
-          ADC channel number.
-          See include/dt-bindings/iio/qcom,spmi-vadc.h
-          For PMIC7 ADC, the channel numbers are specified separately per PMIC
-          in the PMIC-specific files in include/dt-bindings/iio/.
-
-      label:
-        description: |
-            ADC input of the platform as seen in the schematics.
-            For thermistor inputs connected to generic AMUX or GPIO inputs
-            these can vary across platform for the same pins. Hence select
-            the platform schematics name for this channel.
-
-      qcom,decimation:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description: |
-            This parameter is used to decrease ADC sampling rate.
-            Quicker measurements can be made by reducing decimation ratio.
-
-      qcom,pre-scaling:
-        description: |
-            Used for scaling the channel input signal before the signal is
-            fed to VADC. The configuration for this node is to know the
-            pre-determined ratio and use it for post scaling. It is a pair of
-            integers, denoting the numerator and denominator of the fraction by which
-            input signal is multiplied. For example, <1 3> indicates the signal is scaled
-            down to 1/3 of its value before ADC measurement.
-            If property is not found default value depending on chip will be used.
-        $ref: /schemas/types.yaml#/definitions/uint32-array
-        oneOf:
-          - items:
-              - const: 1
-              - enum: [ 1, 3, 4, 6, 20, 8, 10, 16 ]
-          - items:
-              - const: 10
-              - const: 81
-
-      qcom,ratiometric:
-        description: |
-            Channel calibration type.
-            - For compatible property "qcom,spmi-vadc", if this property is
-              specified VADC will use the VDD reference (1.8V) and GND for
-              channel calibration. If property is not found, channel will be
-              calibrated with 0.625V and 1.25V reference channels, also
-              known as absolute calibration.
-            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc7" and
-              "qcom,spmi-adc-rev2", if this property is specified VADC will use
-              the VDD reference (1.875V) and GND for channel calibration. If
-              property is not found, channel will be calibrated with 0V and 1.25V
-              reference channels, also known as absolute calibration.
-        type: boolean
-
-      qcom,hw-settle-time:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description: |
-            Time between AMUX getting configured and the ADC starting
-            conversion. The 'hw_settle_time' is an index used from valid values
-            and programmed in hardware to achieve the hardware settling delay.
-
-      qcom,avg-samples:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description: |
-            Number of samples to be used for measurement.
-            Averaging provides the option to obtain a single measurement
-            from the ADC that is an average of multiple samples. The value
-            selected is 2^(value).
-
-    required:
-      - reg
+    $ref: /schemas/iio/adc/qcom,spmi-vadc-common.yaml
 
 allOf:
   - if:
-- 
2.25.1

