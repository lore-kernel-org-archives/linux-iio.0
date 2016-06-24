Return-Path: <zhiyong.tao@mediatek.com>
From: <zhiyong.tao@mediatek.com>
To: <robh+dt@kernel.org>, <jic23@kernel.org>, <knaack.h@gmx.de>,
	<lars@metafoo.de>, <pmeerw@pmeerw.net>
CC: <srv_heupstream@mediatek.com>, <liguo.zhang@mediatek.com>,
	<yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
	<erin.lo@mediatek.com>, <dawei.chien@mediatek.com>, <matthias.bgg@gmail.com>,
	<s.hauer@pengutronix.de>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>, Zhiyong
 Tao <zhiyong.tao@mediatek.com>
Subject: [PATCH 1/3] dt-bindings: auxadc: Add binding document for Mediatek auxadc.
Date: Fri, 24 Jun 2016 15:37:08 +0800
Message-ID: <1466753830-4542-2-git-send-email-zhiyong.tao@mediatek.com>
In-Reply-To: <1466753830-4542-1-git-send-email-zhiyong.tao@mediatek.com>
References: <1466753830-4542-1-git-send-email-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/related;
	boundary="__=_Part_Boundary_003_885214514.1012732643"
List-ID: <linux-iio@vger.kernel.org>

--__=_Part_Boundary_003_885214514.1012732643
Content-Transfer-Encoding: base64
Content-Type: multipart/alternative;
	boundary="__=_Part_Boundary_004_503899666.415208820"

--__=_Part_Boundary_004_503899666.415208820
Content-Type: text/html
Content-Transfer-Encoding: base64

PHByZT4NCkZyb206IFpoaXlvbmcgVGFvICZsdDt6aGl5b25nLnRhb0BtZWRpYXRlay5jb20mZ3Q7
DQoNClRoZSBjb21taXQgYWRkcyB0aGUgZGV2aWNlIHRyZWUgYmluZGluZyBkb2N1bWVudGF0aW9u
IGZvciB0aGUgbWVkaWF0ZWsNCmF1eGFkYyBmb3VuZCBvbiBNZWRpYXRlayBNVDI3MDEuDQpUaGVy
bWFsIGdldHMgYXV4YWRjIHNhbXBsZSBkYXRhIGJ5IGlpbyBkZXZpY2UuDQpTbyB0aGUgY29tbWl0
IGNoYW5nZXMgYXV4YWRjIGRldmljZSB0cmVlIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiBmcm9tDQov
c29jL21lZGlhdGVrL2F1eGFkYy50eHQgdG8gL2lpby9hZGMvbXQ2NXh4X2F1eGFkYy50eHQuDQoN
ClNpZ25lZC1vZmYtYnk6IFpoaXlvbmcgVGFvICZsdDt6aGl5b25nLnRhb0BtZWRpYXRlay5jb20m
Z3Q7DQotLS0NCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL210NjV4eF9hdXhhZGMu
dHh0ICB8ICAgMjcgKysrKysrKysrKysrKysrKysrKysNCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5n
cy9zb2MvbWVkaWF0ZWsvYXV4YWRjLnR4dCAgICB8ICAgMjEgLS0tLS0tLS0tLS0tLS0tDQogMiBm
aWxlcyBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkNCiBjcmVhdGUg
bW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvbXQ2
NXh4X2F1eGFkYy50eHQNCiBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9hdXhhZGMudHh0DQoNCmRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9tdDY1eHhfYXV4YWRjLnR4dCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL210NjV4eF9hdXhhZGMu
dHh0DQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMC4uNDdmY2QxYg0KLS0tIC9k
ZXYvbnVsbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMv
bXQ2NXh4X2F1eGFkYy50eHQNCkBAIC0wLDAgKzEsMjcgQEANCisqIE1lZGlhdGVrIEFVWEFEQyAt
IEFuYWxvZyB0byBEaWdpdGFsIENvbnZlcnRlciBvbiBNZWRpYXRlayBtb2JpbGUgc29jIChtdDY1
eHgvbXQ4MXh4L210Mjd4eCkNCis9PT09PT09PT09PT09PT0NCisNCitUaGUgQXV4aWxpYXJ5IEFu
YWxvZy9EaWdpdGFsIENvbnZlcnRlciAoQVVYQURDKSBpcyBhbiBBREMgZm91bmQNCitpbiBzb21l
IE1lZGlhdGVrIFNvQ3Mgd2hpY2ggYW1vbmcgb3RoZXIgdGhpbmdzIG1lYXN1cmVzIHRoZSB0ZW1w
ZXJhdHVyZXMNCitpbiB0aGUgU29DLiBJdCBjYW4gYmUgdXNlZCBkaXJlY3RseSB3aXRoIHJlZ2lz
dGVyIGFjY2Vzc2VzLCBidXQgaXQgaXMgYWxzbw0KK3VzZWQgYnkgdGhlcm1hbCBjb250cm9sbGVy
IHdoaWNoIHJlYWRzIHRoZSB0ZW1wZXJhdHVyZXMgZnJvbSB0aGUgQVVYQURDDQorZGlyZWN0bHkg
dmlhIGl0cyBvd24gYnVzIGludGVyZmFjZS4gU2VlDQorRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3RoZXJtYWwvbWVkaWF0ZWstdGhlcm1hbC50eHQNCitmb3IgdGhlIFRoZXJtYWwg
Q29udHJvbGxlciB3aGljaCBob2xkcyBhIHBoYW5kbGUgdG8gdGhlIEFVWEFEQy4NCisNCitSZXF1
aXJlZCBwcm9wZXJ0aWVzOg0KKyAgLSBjb21wYXRpYmxlOiAmcXVvdDttZWRpYXRlayxtdDI3MDEt
YXV4YWRjJnF1b3Q7IG9yICZxdW90O21lZGlhdGVrLG10ODE3My1hdXhhZGMmcXVvdDsNCisgIC0g
cmVnOiBBZGRyZXNzIHJhbmdlIG9mIHRoZSBBVVhBREMgdW5pdC4NCisgIC0gY2xvY2tzOiBTaG91
bGQgY29udGFpbiBhIGNsb2NrIHNwZWNpZmllciBmb3IgZWFjaCBlbnRyeSBpbiBjbG9jay1uYW1l
cw0KKyAgLSBjbG9jay1uYW1lczogU2hvdWxkIGNvbnRhaW4gJnF1b3Q7bWFpbiZxdW90Oy4NCisg
IC0gaW8tY2hhbm5lbC1jZWxsczogU2hvdWxkIGJlIDEsIHNlZSAuLi9paW8tYmluZGluZ3MudHh0
DQorDQorRXhhbXBsZToNCisNCithdXhhZGM6IGF1eGFkY0AxMTAwMTAwMCB7DQorCWNvbXBhdGli
bGUgPSAmcXVvdDttZWRpYXRlayxtdDI3MDEtYXV4YWRjJnF1b3Q7Ow0KKwlyZWcgPSAmbHQ7MCAw
eDExMDAxMDAwIDAgMHgxMDAwJmd0OzsNCisJY2xvY2tzID0gJmx0OyZhbXA7cGVyaWNmZyBDTEtf
UEVSSV9BVVhBREMmZ3Q7Ow0KKwljbG9jay1uYW1lcyA9ICZxdW90O21haW4mcXVvdDs7DQorCSNp
by1jaGFubmVsLWNlbGxzID0gJmx0OzEmZ3Q7Ow0KK307DQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9hdXhhZGMudHh0IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9hdXhhZGMudHh0DQpkZWxl
dGVkIGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IGJkYjc4MjkuLjAwMDAwMDANCi0tLSBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvYXV4YWRjLnR4dA0KKysr
IC9kZXYvbnVsbA0KQEAgLTEsMjEgKzAsMCBAQA0KLU1lZGlhVGVrIEFVWEFEQw0KLT09PT09PT09
PT09PT09PQ0KLQ0KLVRoZSBBdXhpbGlhcnkgQW5hbG9nL0RpZ2l0YWwgQ29udmVydGVyIChBVVhB
REMpIGlzIGFuIEFEQyBmb3VuZA0KLWluIHNvbWUgTWVkaWF0ZWsgU29DcyB3aGljaCBhbW9uZyBv
dGhlciB0aGluZ3MgbWVhc3VyZXMgdGhlIHRlbXBlcmF0dXJlcw0KLWluIHRoZSBTb0MuIEl0IGNh
biBiZSB1c2VkIGRpcmVjdGx5IHdpdGggcmVnaXN0ZXIgYWNjZXNzZXMsIGJ1dCBpdCBpcyBhbHNv
DQotdXNlZCBieSB0aGVybWFsIGNvbnRyb2xsZXIgd2hpY2ggcmVhZHMgdGhlIHRlbXBlcmF0dXJl
cyBmcm9tIHRoZSBBVVhBREMNCi1kaXJlY3RseSB2aWEgaXRzIG93biBidXMgaW50ZXJmYWNlLiBT
ZWUNCi1Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGhlcm1hbC9tZWRpYXRlay10
aGVybWFsLnR4dA0KLWZvciB0aGUgVGhlcm1hbCBDb250cm9sbGVyIHdoaWNoIGhvbGRzIGEgcGhh
bmRsZSB0byB0aGUgQVVYQURDLg0KLQ0KLVJlcXVpcmVkIHByb3BlcnRpZXM6DQotLSBjb21wYXRp
YmxlOiBNdXN0IGJlICZxdW90O21lZGlhdGVrLG10ODE3My1hdXhhZGMmcXVvdDsNCi0tIHJlZzog
QWRkcmVzcyByYW5nZSBvZiB0aGUgQVVYQURDIHVuaXQNCi0NCi1FeGFtcGxlOg0KLQ0KLWF1eGFk
YzogYXV4YWRjQDExMDAxMDAwIHsNCi0JY29tcGF0aWJsZSA9ICZxdW90O21lZGlhdGVrLG10ODE3
My1hdXhhZGMmcXVvdDs7DQotCXJlZyA9ICZsdDswIDB4MTEwMDEwMDAgMCAweDEwMDAmZ3Q7Ow0K
LX07DQotLSANCjEuNy45LjUNCg0KPC9wcmU+PCEtLXR5cGU6dGV4dC0tPjwhLS17LS0+PHByZT4q
KioqKioqKioqKioqIEVtYWlsIENvbmZpZGVudGlhbGl0eSBOb3RpY2UNCiAqKioqKioqKioqKioq
KioqKioqKgpUaGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRoaXMgZS1tYWlsIG1lc3NhZ2Ug
KGluY2x1ZGluZyBhbnkgCmF0dGFjaG1lbnRzKSBtYXkgYmUgY29uZmlkZW50aWFsLCBwcm9wcmll
dGFyeSwgcHJpdmlsZWdlZCwgb3Igb3RoZXJ3aXNlCmV4ZW1wdCBmcm9tIGRpc2Nsb3N1cmUgdW5k
ZXIgYXBwbGljYWJsZSBsYXdzLiBJdCBpcyBpbnRlbmRlZCB0byBiZSAKY29udmV5ZWQgb25seSB0
byB0aGUgZGVzaWduYXRlZCByZWNpcGllbnQocykuIEFueSB1c2UsIGRpc3NlbWluYXRpb24sIApk
aXN0cmlidXRpb24sIHByaW50aW5nLCByZXRhaW5pbmcgb3IgY29weWluZyBvZiB0aGlzIGUtbWFp
bCAoaW5jbHVkaW5nIGl0cyAKYXR0YWNobWVudHMpIGJ5IHVuaW50ZW5kZWQgcmVjaXBpZW50KHMp
IGlzIHN0cmljdGx5IHByb2hpYml0ZWQgYW5kIG1heSAKYmUgdW5sYXdmdWwuIElmIHlvdSBhcmUg
bm90IGFuIGludGVuZGVkIHJlY2lwaWVudCBvZiB0aGlzIGUtbWFpbCwgb3IgYmVsaWV2ZQ0KIAp0
aGF0IHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZS1tYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5
IHRoZSBzZW5kZXIgCmltbWVkaWF0ZWx5IChieSByZXBseWluZyB0byB0aGlzIGUtbWFpbCksIGRl
bGV0ZSBhbnkgYW5kIGFsbCBjb3BpZXMgb2YgCnRoaXMgZS1tYWlsIChpbmNsdWRpbmcgYW55IGF0
dGFjaG1lbnRzKSBmcm9tIHlvdXIgc3lzdGVtLCBhbmQgZG8gbm90CmRpc2Nsb3NlIHRoZSBjb250
ZW50IG9mIHRoaXMgZS1tYWlsIHRvIGFueSBvdGhlciBwZXJzb24uIFRoYW5rDQogeW91ITwvcHJl
PjwhLS19LS0=

--__=_Part_Boundary_004_503899666.415208820
Content-Type: text/plain

From: Zhiyong Tao <zhiyong.tao@mediatek.com>

The commit adds the device tree binding documentation for the mediatek
auxadc found on Mediatek MT2701.
Thermal gets auxadc sample data by iio device.
So the commit changes auxadc device tree binding documentation from
/soc/mediatek/auxadc.txt to /iio/adc/mt65xx_auxadc.txt.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
---
 .../devicetree/bindings/iio/adc/mt65xx_auxadc.txt  |   27
 ++++++++++++++++++++
 .../devicetree/bindings/soc/mediatek/auxadc.txt    |   21 ---------------
 2 files changed, 27 insertions(+), 21 deletions(-)
 create mode 100644
 Documentation/devicetree/bindings/iio/adc/mt65xx_auxadc.txt
 delete mode 100644
 Documentation/devicetree/bindings/soc/mediatek/auxadc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/mt65xx_auxadc.txt
 b/Documentation/devicetree/bindings/iio/adc/mt65xx_auxadc.txt
new file mode 100644
index 0000000..47fcd1b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/mt65xx_auxadc.txt
@@ -0,0 +1,27 @@
+* Mediatek AUXADC - Analog to Digital Converter on Mediatek mobile soc
 (mt65xx/mt81xx/mt27xx)
+===============
+
+The Auxiliary Analog/Digital Converter (AUXADC) is an ADC found
+in some Mediatek SoCs which among other things measures the temperatures
+in the SoC. It can be used directly with register accesses, but it is also
+used by thermal controller which reads the temperatures from the AUXADC
+directly via its own bus interface. See
+Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
+for the Thermal Controller which holds a phandle to the AUXADC.
+
+Required properties:
+  - compatible: "mediatek,mt2701-auxadc" or "mediatek,mt8173-auxadc"
+  - reg: Address range of the AUXADC unit.
+  - clocks: Should contain a clock specifier for each entry in clock-names
+  - clock-names: Should contain "main".
+  - io-channel-cells: Should be 1, see ../iio-bindings.txt
+
+Example:
+
+auxadc: auxadc@11001000 {
+	compatible = "mediatek,mt2701-auxadc";
+	reg = <0 0x11001000 0 0x1000>;
+	clocks = <&pericfg CLK_PERI_AUXADC>;
+	clock-names = "main";
+	#io-channel-cells = <1>;
+};
diff --git a/Documentation/devicetree/bindings/soc/mediatek/auxadc.txt
 b/Documentation/devicetree/bindings/soc/mediatek/auxadc.txt
deleted file mode 100644
index bdb7829..0000000
--- a/Documentation/devicetree/bindings/soc/mediatek/auxadc.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-MediaTek AUXADC
-===============
-
-The Auxiliary Analog/Digital Converter (AUXADC) is an ADC found
-in some Mediatek SoCs which among other things measures the temperatures
-in the SoC. It can be used directly with register accesses, but it is also
-used by thermal controller which reads the temperatures from the AUXADC
-directly via its own bus interface. See
-Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
-for the Thermal Controller which holds a phandle to the AUXADC.
-
-Required properties:
-- compatible: Must be "mediatek,mt8173-auxadc"
-- reg: Address range of the AUXADC unit
-
-Example:
-
-auxadc: auxadc@11001000 {
-	compatible = "mediatek,mt8173-auxadc";
-	reg = <0 0x11001000 0 0x1000>;
-};
-- 
1.7.9.5

--__=_Part_Boundary_004_503899666.415208820--

--__=_Part_Boundary_003_885214514.1012732643--
