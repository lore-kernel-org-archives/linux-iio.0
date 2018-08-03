Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45144 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732067AbeHCDhe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Aug 2018 23:37:34 -0400
From: Siddartha Mohanadoss <smohanad@codeaurora.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Siddartha Mohanadoss <smohanad@codeaurora.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v5 1/3] dt-bindings: iio: adc: Add DT binding document for PMIC5 ADC
Date: Thu,  2 Aug 2018 18:43:38 -0700
Message-Id: <1533260618-12275-1-git-send-email-smohanad@codeaurora.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

PMIC5 ADC has support for clients to measure voltage and current
on inputs connected to the PMIC. Clients include reading voltage
phone power and on board system thermistors for thermal management.
ADC5 on certain PMIC has support to read battery current.

This change adds documentation.

Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt |  77 ++++++++++----
 include/dt-bindings/iio/qcom,spmi-vadc.h           | 115 ++++++++++++++++++++-
 2 files changed, 172 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
index 0fb4613..8498f11 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
@@ -1,7 +1,9 @@
-Qualcomm's SPMI PMIC voltage ADC
+Qualcomm's SPMI PMIC ADC
 
-SPMI PMIC voltage ADC (VADC) provides interface to clients to read
-voltage. The VADC is a 15-bit sigma-delta ADC.
+- SPMI PMIC voltage ADC (VADC) provides interface to clients to read
+  voltage. The VADC is a 15-bit sigma-delta ADC.
+- SPMI PMIC5 voltage ADC (ADC) provides interface to clients to read
+  voltage. The VADC is a 16-bit sigma-delta ADC.
 
 VADC node:
 
@@ -9,6 +11,8 @@ VADC node:
     Usage: required
     Value type: <string>
     Definition: Should contain "qcom,spmi-vadc".
+                Should contain "qcom,spmi-adc5" for PMIC5 ADC driver.
+                Should contain "qcom,spmi-adc-rev2" for PMIC rev2 ADC driver.
 
 - reg:
     Usage: required
@@ -45,13 +49,26 @@ Channel node properties:
     Definition: ADC channel number.
             See include/dt-bindings/iio/qcom,spmi-vadc.h
 
+- label:
+    Usage: required for "qcom,spmi-adc5" and "qcom,spmi-adc-rev2"
+    Value type: <empty>
+    Definition: ADC input of the platform as seen in the schematics.
+            For thermistor inputs connected to generic AMUX or GPIO inputs
+            these can vary across platform for the same pins. Hence select
+            the platform schematics name for this channel.
+
 - qcom,decimation:
     Usage: optional
     Value type: <u32>
     Definition: This parameter is used to decrease ADC sampling rate.
             Quicker measurements can be made by reducing decimation ratio.
-            Valid values are 512, 1024, 2048, 4096.
-            If property is not found, default value of 512 will be used.
+            - For compatible property "qcom,spmi-vadc", valid values are
+              512, 1024, 2048, 4096. If property is not found, default value
+              of 512 will be used.
+            - For compatible property "qcom,spmi-adc5", valid values are 250, 420
+              and 840. If property is not found, default value of 840 is used.
+            - For compatible property "qcom,spmi-adc-rev2", valid values are 256,
+              512 and 1024. If property is not present, default value is 1024.
 
 - qcom,pre-scaling:
     Usage: optional
@@ -66,21 +83,38 @@ Channel node properties:
 - qcom,ratiometric:
     Usage: optional
     Value type: <empty>
-    Definition: Channel calibration type. If this property is specified
-            VADC will use the VDD reference (1.8V) and GND for channel
-            calibration. If property is not found, channel will be
-            calibrated with 0.625V and 1.25V reference channels, also
-            known as absolute calibration.
+    Definition: Channel calibration type.
+            - For compatible property "qcom,spmi-vadc", if this property is
+              specified VADC will use the VDD reference (1.8V) and GND for
+              channel calibration. If property is not found, channel will be
+              calibrated with 0.625V and 1.25V reference channels, also
+              known as absolute calibration.
+            - For compatible property "qcom,spmi-adc5" and "qcom,spmi-adc-rev2",
+              if this property is specified VADC will use the VDD reference
+              (1.875V) and GND for channel calibration. If property is not found,
+              channel will be calibrated with 0V and 1.25V reference channels,
+              also known as absolute calibration.
 
 - qcom,hw-settle-time:
     Usage: optional
     Value type: <u32>
     Definition: Time between AMUX getting configured and the ADC starting
-            conversion. Delay = 100us * (value) for value < 11, and
-            2ms * (value - 10) otherwise.
-            Valid values are: 0, 100, 200, 300, 400, 500, 600, 700, 800,
-            900 us and 1, 2, 4, 6, 8, 10 ms
-            If property is not found, channel will use 0us.
+            conversion. The 'hw_settle_time' is an index used from valid values
+            and programmed in hardware to achieve the hardware settling delay.
+            - For compatible property "qcom,spmi-vadc" and "qcom,spmi-adc-rev2",
+              Delay = 100us * (hw_settle_time) for hw_settle_time < 11,
+              and 2ms * (hw_settle_time - 10) otherwise.
+              Valid values are: 0, 100, 200, 300, 400, 500, 600, 700, 800,
+              900 us and 1, 2, 4, 6, 8, 10 ms.
+              If property is not found, channel will use 0us.
+            - For compatible property "qcom,spmi-adc5", delay = 15us for
+              value 0, 100us * (value) for values < 11,
+              and 2ms * (value - 10) otherwise.
+              Valid values are: 15, 100, 200, 300, 400, 500, 600, 700, 800,
+              900 us and 1, 2, 4, 6, 8, 10 ms
+              Certain controller digital versions have valid values of
+              15, 100, 200, 300, 400, 500, 600, 700, 1, 2, 4, 8, 16, 32, 64, 128 ms
+              If property is not found, channel will use 15us.
 
 - qcom,avg-samples:
     Usage: optional
@@ -89,13 +123,18 @@ Channel node properties:
             Averaging provides the option to obtain a single measurement
             from the ADC that is an average of multiple samples. The value
             selected is 2^(value).
-            Valid values are: 1, 2, 4, 8, 16, 32, 64, 128, 256, 512
-            If property is not found, 1 sample will be used.
+            - For compatible property "qcom,spmi-vadc", valid values
+              are: 1, 2, 4, 8, 16, 32, 64, 128, 256, 512
+              If property is not found, 1 sample will be used.
+            - For compatible property "qcom,spmi-adc5" and "qcom,spmi-adc-rev2",
+              valid values are: 1, 2, 4, 8, 16
+              If property is not found, 1 sample will be used.
 
 NOTE:
 
-Following channels, also known as reference point channels, are used for
-result calibration and their channel configuration nodes should be defined:
+For compatible property "qcom,spmi-vadc" following channels, also known as
+reference point channels, are used for result calibration and their channel
+configuration nodes should be defined:
 VADC_REF_625MV and/or VADC_SPARE1(based on PMIC version) VADC_REF_1250MV,
 VADC_GND_REF and VADC_VDD_VADC.
 
diff --git a/include/dt-bindings/iio/qcom,spmi-vadc.h b/include/dt-bindings/iio/qcom,spmi-vadc.h
index 42121fa..bf54b5a 100644
--- a/include/dt-bindings/iio/qcom,spmi-vadc.h
+++ b/include/dt-bindings/iio/qcom,spmi-vadc.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2012-2014, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2012-2014,2018 The Linux Foundation. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
@@ -116,4 +116,117 @@
 #define VADC_LR_MUX10_PU1_PU2_AMUX_USB_ID	0xf9
 #define VADC_LR_MUX3_BUF_PU1_PU2_XO_THERM	0xfc
 
+/* ADC channels for SPMI PMIC5 */
+
+#define ADC5_REF_GND				0x00
+#define ADC5_1P25VREF				0x01
+#define ADC5_VREF_VADC				0x02
+#define ADC5_VREF_VADC5_DIV_3			0x82
+#define ADC5_VPH_PWR				0x83
+#define ADC5_VBAT_SNS				0x84
+#define ADC5_VCOIN				0x85
+#define ADC5_DIE_TEMP				0x06
+#define ADC5_USB_IN_I				0x07
+#define ADC5_USB_IN_V_16			0x08
+#define ADC5_CHG_TEMP				0x09
+#define ADC5_BAT_THERM				0x0a
+#define ADC5_BAT_ID				0x0b
+#define ADC5_XO_THERM				0x0c
+#define ADC5_AMUX_THM1				0x0d
+#define ADC5_AMUX_THM2				0x0e
+#define ADC5_AMUX_THM3				0x0f
+#define ADC5_AMUX_THM4				0x10
+#define ADC5_AMUX_THM5				0x11
+#define ADC5_GPIO1				0x12
+#define ADC5_GPIO2				0x13
+#define ADC5_GPIO3				0x14
+#define ADC5_GPIO4				0x15
+#define ADC5_GPIO5				0x16
+#define ADC5_GPIO6				0x17
+#define ADC5_GPIO7				0x18
+#define ADC5_SBUx				0x99
+#define ADC5_MID_CHG_DIV6			0x1e
+#define ADC5_OFF				0xff
+
+/* 30k pull-up1 */
+#define ADC5_BAT_THERM_30K_PU			0x2a
+#define ADC5_BAT_ID_30K_PU			0x2b
+#define ADC5_XO_THERM_30K_PU			0x2c
+#define ADC5_AMUX_THM1_30K_PU			0x2d
+#define ADC5_AMUX_THM2_30K_PU			0x2e
+#define ADC5_AMUX_THM3_30K_PU			0x2f
+#define ADC5_AMUX_THM4_30K_PU			0x30
+#define ADC5_AMUX_THM5_30K_PU			0x31
+#define ADC5_GPIO1_30K_PU			0x32
+#define ADC5_GPIO2_30K_PU			0x33
+#define ADC5_GPIO3_30K_PU			0x34
+#define ADC5_GPIO4_30K_PU			0x35
+#define ADC5_GPIO5_30K_PU			0x36
+#define ADC5_GPIO6_30K_PU			0x37
+#define ADC5_GPIO7_30K_PU			0x38
+#define ADC5_SBUx_30K_PU			0x39
+
+/* 100k pull-up2 */
+#define ADC5_BAT_THERM_100K_PU			0x4a
+#define ADC5_BAT_ID_100K_PU			0x4b
+#define ADC5_XO_THERM_100K_PU			0x4c
+#define ADC5_AMUX_THM1_100K_PU			0x4d
+#define ADC5_AMUX_THM2_100K_PU			0x4e
+#define ADC5_AMUX_THM3_100K_PU			0x4f
+#define ADC5_AMUX_THM4_100K_PU			0x50
+#define ADC5_AMUX_THM5_100K_PU			0x51
+#define ADC5_GPIO1_100K_PU			0x52
+#define ADC5_GPIO2_100K_PU			0x53
+#define ADC5_GPIO3_100K_PU			0x54
+#define ADC5_GPIO4_100K_PU			0x55
+#define ADC5_GPIO5_100K_PU			0x56
+#define ADC5_GPIO6_100K_PU			0x57
+#define ADC5_GPIO7_100K_PU			0x58
+#define ADC5_SBUx_100K_PU			0x59
+
+/* 400k pull-up3 */
+#define ADC5_BAT_THERM_400K_PU			0x6a
+#define ADC5_BAT_ID_400K_PU			0x6b
+#define ADC5_XO_THERM_400K_PU			0x6c
+#define ADC5_AMUX_THM1_400K_PU			0x6d
+#define ADC5_AMUX_THM2_400K_PU			0x6e
+#define ADC5_AMUX_THM3_400K_PU			0x6f
+#define ADC5_AMUX_THM4_400K_PU			0x70
+#define ADC5_AMUX_THM5_400K_PU			0x71
+#define ADC5_GPIO1_400K_PU			0x72
+#define ADC5_GPIO2_400K_PU			0x73
+#define ADC5_GPIO3_400K_PU			0x74
+#define ADC5_GPIO4_400K_PU			0x75
+#define ADC5_GPIO5_400K_PU			0x76
+#define ADC5_GPIO6_400K_PU			0x77
+#define ADC5_GPIO7_400K_PU			0x78
+#define ADC5_SBUx_400K_PU			0x79
+
+/* 1/3 Divider */
+#define ADC5_GPIO1_DIV3				0x92
+#define ADC5_GPIO2_DIV3				0x93
+#define ADC5_GPIO3_DIV3				0x94
+#define ADC5_GPIO4_DIV3				0x95
+#define ADC5_GPIO5_DIV3				0x96
+#define ADC5_GPIO6_DIV3				0x97
+#define ADC5_GPIO7_DIV3				0x98
+#define ADC5_SBUx_DIV3				0x99
+
+/* Current and combined current/voltage channels */
+#define ADC5_INT_EXT_ISENSE			0xa1
+#define ADC5_PARALLEL_ISENSE			0xa5
+#define ADC5_CUR_REPLICA_VDS			0xa7
+#define ADC5_CUR_SENS_BATFET_VDS_OFFSET		0xa9
+#define ADC5_CUR_SENS_REPLICA_VDS_OFFSET	0xab
+#define ADC5_EXT_SENS_OFFSET			0xad
+
+#define ADC5_INT_EXT_ISENSE_VBAT_VDATA		0xb0
+#define ADC5_INT_EXT_ISENSE_VBAT_IDATA		0xb1
+#define ADC5_EXT_ISENSE_VBAT_VDATA		0xb2
+#define ADC5_EXT_ISENSE_VBAT_IDATA		0xb3
+#define ADC5_PARALLEL_ISENSE_VBAT_VDATA		0xb4
+#define ADC5_PARALLEL_ISENSE_VBAT_IDATA		0xb5
+
+#define ADC5_MAX_CHANNEL			0xc0
+
 #endif /* _DT_BINDINGS_QCOM_SPMI_VADC_H */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

