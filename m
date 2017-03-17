Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:50107 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751127AbdCQO46 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Mar 2017 10:56:58 -0400
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
Subject: [PATCH v3 08/11] ASoC: Add bindings for DMIC codec driver
Date: Fri, 17 Mar 2017 15:08:21 +0100
Message-ID: <1489759704-30217-9-git-send-email-arnaud.pouliquen@st.com>
In-Reply-To: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds documentation of device tree bindings for audio DMIC codec.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 Documentation/devicetree/bindings/sound/dmic.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/dmic.txt

diff --git a/Documentation/devicetree/bindings/sound/dmic.txt b/Documentation/devicetree/bindings/sound/dmic.txt
new file mode 100644
index 0000000..eb2a9d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/dmic.txt
@@ -0,0 +1,11 @@
+Device-Tree bindings for dmic codec
+
+Required properties:
+	- compatible: should be "dmic-codec".
+
+Example node:
+
+	dmic_audio: dmic_audio@0 {
+		compatible = "dmic-codec";
+		status = "okay";
+	};
-- 
1.9.1

