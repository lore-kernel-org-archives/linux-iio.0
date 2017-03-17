Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54351 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751440AbdCQPGG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Mar 2017 11:06:06 -0400
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
To: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC: <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <kernel@stlinux.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <arnaud.pouliquen@st.com>, olivier moysan <olivier.moysan@st.com>
Subject: [PATCH v3 02/11] IIO: Add DT bindings for sigma delta adc modulator
Date: Fri, 17 Mar 2017 15:08:15 +0100
Message-ID: <1489759704-30217-3-git-send-email-arnaud.pouliquen@st.com>
In-Reply-To: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add documentation of device tree bindings to support
sigma delta modulator in IIO framework.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
V2 -> V3 :
	-Rename to suppress "simple"
        - add "ads1201" compatibility
 
 .../devicetree/bindings/iio/adc/sigma-delta-modulator.txt   | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
new file mode 100644
index 0000000..27f04a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
@@ -0,0 +1,13 @@
+Device-Tree bindings for sigma delta modulator
+
+Required properties:
+- compatible: should be "ads1201", "sd-modulator". "sd-modulator" can be use
+	as a generic SD modulator if modulator not specified in compatible list.
+- #io-channel-cells = <1>: See the IIO bindings section "IIO consumers".
+
+Example node:
+
+	ads1202: simple_sd_adc@0 {
+		compatible = "sd-modulator";
+		#io-channel-cells = <1>;
+	};
-- 
1.9.1

