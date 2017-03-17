Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55064 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751112AbdCQPNt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Mar 2017 11:13:49 -0400
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
Subject: [PATCH v3 09/11] ASoC: codec: add DT support in dmic codec
Date: Fri, 17 Mar 2017 15:08:22 +0100
Message-ID: <1489759704-30217-10-git-send-email-arnaud.pouliquen@st.com>
In-Reply-To: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add of_table to allows DT probing.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/codecs/dmic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index c82b9dc..d04cac9 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -73,9 +73,17 @@ static int dmic_dev_remove(struct platform_device *pdev)
 
 MODULE_ALIAS("platform:dmic-codec");
 
+static const struct of_device_id dmic_dev_match[] = {
+	{
+		.compatible = "dmic-codec",
+	},
+	{},
+};
+
 static struct platform_driver dmic_driver = {
 	.driver = {
 		.name = "dmic-codec",
+		.of_match_table = dmic_dev_match,
 	},
 	.probe = dmic_dev_probe,
 	.remove = dmic_dev_remove,
-- 
1.9.1

