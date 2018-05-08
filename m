Return-Path: <SRS0=2owl=H3=codeaurora.org=smohanad@kernel.org>
From: Siddartha Mohanadoss <smohanad@codeaurora.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	cdevired@codeaurora.org,
	rphani@codeaurora.org,
	sivaa@codeaurora.org,
	Siddartha Mohanadoss <smohanad@codeaurora.org>
Subject: [PATCH 1/2] dt-bindings: iio: adc: Add DT binding document for PMIC5 ADC
Date: Tue,  8 May 2018 14:38:21 -0700
Message-Id: <1525815501-27588-1-git-send-email-smohanad@codeaurora.org>
List-ID: <linux-iio@vger.kernel.org>

PMIC5 ADC has support for clients to measure voltage and current
on inputs connected to the PMIC. Clients include reading voltage
phone power and on board system thermistors for thermal management.
ADC5 on certain PMIC has support to read battery current.

This change adds documentation.

Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
---
 .../devicetree/bindings/iio/adc/qcom,spmi-adc5.txt | 137 +++++++++++++++++++++
 1 file changed, 137 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5.txt b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5.txt
new file mode 100644
index 0000000..c9268ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5.txt
@@ -0,0 +1,137 @@
+Qualcomm Technologies Inc. SPMI PMIC5 voltage and current ADC
+
+SPMI PMIC5 voltage ADC (ADC) provides interface to clients to read
+voltage. The VADC is a 16-bit sigma-delta ADC.
+
+ADC node:
+
+- compatible:
+    Usage: required
+    Value type: <string>
+    Definition: Should contain "qcom,spmi-adc5" for PMIC5 ADC driver.
+		Should contain "qcom,spmi-adc-rev2" for PMIC refresh ADC driver.
+
+- reg:
+    Usage: required
+    Value type: <prop-encoded-array>
+    Definition: VADC base address and length in the SPMI PMIC register map.
+
+- #address-cells:
+    Usage: required
+    Value type: <u32>
+    Definition: Must be one. Child node 'reg' property should define ADC
+            channel number.
+
+- #size-cells:
+    Usage: required
+    Value type: <u32>
+    Definition: Must be zero.
+
+- #io-channel-cells:
+    Usage: required
+    Value type: <u32>
+    Definition: Must be one. For details about IIO bindings see:
+            Documentation/devicetree/bindings/iio/iio-bindings.txt
+
+- interrupts:
+    Usage: optional
+    Value type: <prop-encoded-array>
+    Definition: End of conversion interrupt.
+
+Channel node properties:
+
+- reg:
+    Usage: required
+    Value type: <u32>
+    Definition: ADC channel number.
+            See include/dt-bindings/iio/qcom,spmi-vadc.h
+
+- label:
+    Usage: required
+    Value type: <empty>
+    Definition: ADC datasheet channel name.
+            For thermistor inputs connected to generic AMUX or GPIO inputs
+            these can vary across platform for the same pins. Hence select
+            the datasheet name for this channel.
+
+- qcom,pre-scaling:
+    Usage: required
+    Value type: <u32 array>
+    Definition: Used for scaling the channel input signal before the signal is
+            fed to VADC. The configuration for this node is to know the
+            pre-determined ratio and use it for post scaling. Select one from
+            the following options.
+            <1 1>, <1 3>, <1 4>, <1 6>, <1 20>, <1 8>, <10 81>, <1 10>
+            If property is not found default value depending on chip will be used.
+
+- qcom,decimation:
+    Usage: optional
+    Value type: <u32>
+    Definition: This parameter is used to decrease ADC sampling rate.
+            Quicker measurements can be made by reducing decimation ratio.
+            For PMIC5 ADC, combined two step decimation values are 250, 420 and 840.
+            If property is not found, default value of 840 will be used.
+	    For PMIC refresh ADC, supported decimation values are 256, 512, 1024.
+	    If property is not found, default value of 1024 will be used.
+
+- qcom,ratiometric:
+    Usage: optional
+    Value type: <empty>
+    Definition: Channel calibration type. If this property is specified
+            VADC will use the VDD reference (1.875V) and GND for channel
+            calibration. If property is not found, channel will be
+            calibrated with 0V and 1.25V reference channels, also
+            known as absolute calibration.
+
+- qcom,hw-settle-time:
+    Usage: optional
+    Value type: <u32>
+    Definition: Time between AMUX getting configured and the ADC starting
+            conversion.
+	    For PMIC5, delay = 15us for value 0,
+			100us * (value) for values 0 < value < 11, and
+            		2ms * (value - 10) otherwise.
+            Valid values are: 15, 100, 200, 300, 400, 500, 600, 700, 800,
+            900 us and 1, 2, 4, 6, 8, 10 ms
+            If property is not found, channel will use 15us.
+	    For PMIC rev2, delay = 100us * (value) for values 0 < value < 11, and
+			2ms * (value - 10) otherwise.
+            Valid values are: 0, 100, 200, 300, 400, 500, 600, 700, 800,
+            900 us and 1, 2, 4, 6, 8, 10 ms
+            If property is not found, channel will use 0 us.
+
+- qcom,avg-samples:
+    Usage: optional
+    Value type: <u32>
+    Definition: Number of samples to be used for measurement.
+            Averaging provides the option to obtain a single measurement
+            from the ADC that is an average of multiple samples. The value
+            selected is 2^(value).
+            Valid values are: 1, 2, 4, 8, 16
+            If property is not found, 1 sample will be used.
+
+Example:
+
+        /* VADC node */
+        pmic_vadc: vadc@3100 {
+                compatible = "qcom,spmi-adc5";
+                reg = <0x3100 0x100>;
+                interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+                #io-channel-cells = <1>;
+                io-channel-ranges;
+
+                /* Channel node */
+                vph_pwr {
+                        reg = <ADC_VPH_PWR>;
+                        label = "vph_pwr";
+                        qcom,pre-scaling = <1 3>;
+                };
+        };
+
+        /* IIO client node */
+        usb {
+                io-channels = <&pmic_vadc ADC_VPH_PWR>;
+                io-channel-names = "vadc";
+        };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
