Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	devicetree@vger.kernel.org
Subject: [PATCH 1/2] devicetree: Add Xilinx XADC binding documentation
Date: Mon, 17 Feb 2014 15:10:42 +0100
Message-Id: <1392646243-5538-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The Xilinx XADC is a ADC that can be found in the series 7 FPGAs from Xilinx.
The XADC has a DRP interface for communication. Currently two different
frontends for the DRP interface exist. One that is only available on the ZYNQ
family as a hardmacro in the SoC portion of the ZYNQ. The other one is available
on all series 7 platforms and is a softmacro with a AXI interface. This binding
document describes the bindings for both of them since the bindings are very
similar.

Each of them needs:
	* A address range where the registers are mapped
	* An interrupt number for the device interrupt
	* A clock. For the the ZYNQ hardmacro interface this is the modules PCAP
	  clock, for the AXI softmacro it is the AXI bus interface clock.

Additionally the bindings specify whether an external multiplexer is used and in
which mode it is used. The devicetree bindings also describe which external
channels are connected and in which configuration.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Changes since v1:
	* Remove duplicated paragraph in the description
---
 .../devicetree/bindings/iio/adc/xilinx-xadc.txt    | 113 +++++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
new file mode 100644
index 0000000..d9ee909
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
@@ -0,0 +1,113 @@
+Xilinx XADC device driver
+
+This binding document describes the bindings for both of them since the
+bindings are very similar. The Xilinx XADC is a ADC that can be found in the
+series 7 FPGAs from Xilinx. The XADC has a DRP interface for communication.
+Currently two different frontends for the DRP interface exist. One that is only
+available on the ZYNQ family as a hardmacro in the SoC portion of the ZYNQ. The
+other one is available on all series 7 platforms and is a softmacro with a AXI
+interface. This binding document describes the bindings for both of them since
+the bindings are very similar.
+
+Required properties:
+	- compatible: Should be one of
+		* "xlnx,zynq-xadc-1.00.a": When using the ZYNQ device
+		  configuration interface to interface to the XADC hardmacro.
+		* "xlnx,axi-xadc-1.00.a": When using the axi-xadc pcore to
+		  interface to the XADC hardmacro.
+	- reg: Address and length of the register set for the device
+	- interrupts: Interrupt for the XADC control interface.
+	- clocks: When using the ZYNQ this must be the ZYNQ PCAP clock,
+	  when using the AXI-XADC pcore this must be the clock that provides the
+	  clock to the AXI bus interface of the core.
+
+Optional properties:
+	- interrupt-parent: phandle to the parent interrupt controller
+	- xlnx,external-mux:
+		* "none": No external multiplexer is used, this is the default
+		  if the property is omitted.
+		* "single": External multiplexer mode is used with one
+		   multiplexer.
+		* "dual": External multiplexer mode is used with two
+		  multiplexers for simultaneous sampling.
+	- xlnx,external-mux-channel: Configures which pair of pins is used to
+	  sample data in external mux mode.
+	  Valid values for single external multiplexer mode are:
+		0: VP/VN
+		1: VAUXP[0]/VAUXN[0]
+		2: VAUXP[1]/VAUXN[1]
+		...
+		16: VAUXP[15]/VAUXN[15]
+	  Valid values for dual external multiplexer mode are:
+		1: VAUXP[0]/VAUXN[0] - VAUXP[8]/VAUXN[8]
+		2: VAUXP[1]/VAUXN[1] - VAUXP[9]/VAUXN[9]
+		...
+		8: VAUXP[7]/VAUXN[7] - VAUXP[15]/VAUXN[15]
+
+	  This property needs to be present if the device is configured for
+	  external multiplexer mode (either single or dual). If the device is
+	  not using external multiplexer mode the property is ignored.
+	- xnlx,channels: List of external channels that are connected to the ADC
+	  Required properties:
+		* #address-cells: Should be 1.
+		* #size-cells: Should be 0.
+
+	  The child nodes of this node represent the external channels which are
+	  connected to the ADC. If the property is no present no external
+	  channels will be assumed to be connected.
+
+	  Each child node represents one channel and has the following
+	  properties:
+		Required properties:
+			* reg: Pair of pins the the channel is connected to.
+				0: VP/VN
+				1: VAUXP[0]/VAUXN[0]
+				2: VAUXP[1]/VAUXN[1]
+				...
+				16: VAUXP[15]/VAUXN[15]
+			  Note each channel number should only be used at most
+			  once.
+		Optional properties:
+			* xlnx,bipolar: If set the channel is used in bipolar
+			  mode.
+
+
+Examples:
+	xadc@f8007100 {
+		compatible = "xlnx,zynq-xadc-1.00.a";
+		reg = <0xf8007100 0x20>;
+		interrupts = <0 7 4>;
+		interrupt-parent = <&gic>;
+		clocks = <&pcap_clk>;
+
+		xlnx,channels {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			channel@0 {
+				reg = <0>;
+			};
+			channel@1 {
+				reg = <1>;
+			};
+			channel@8 {
+				reg = <8>;
+			};
+		};
+	};
+
+	xadc@43200000 {
+		compatible = "xlnx,axi-xadc-1.00.a";
+		reg = <0x43200000 0x1000>;
+		interrupts = <0 53 4>;
+		interrupt-parent = <&gic>;
+		clocks = <&fpga1_clk>;
+
+		xlnx,channels {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			channel@0 {
+				reg = <0>;
+				xlnx,bipolar;
+			};
+		};
+	};
-- 
1.8.0
