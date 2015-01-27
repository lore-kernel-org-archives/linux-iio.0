Return-Path: <rickard.strandqvist@spctrm.se>
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Marek Vasut <marex@denx.de>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Darshana Padmadas <darshanapadmadas@gmail.com>,
	Aybuke Ozdemir <aybuke.147@gmail.com>,
	Vaishali Thakkar <vthakkar1994@gmail.com>,
	Robert Hodaszi <robert.hodaszi@digi.com>,
	Brian Vandre <bvandre@gmail.com>,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] staging: iio: adc: mxs-lradc: Change type in printf format string
Date: Tue, 27 Jan 2015 23:23:33 +0100
Message-Id: <1422397413-9447-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-ID: <linux-iio@vger.kernel.org>

Wrong type in printf format string, requires 'int'
but the argument type is 'unsigned int'

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/staging/iio/adc/mxs-lradc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index f053535..887767b 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -1001,7 +1001,7 @@ static ssize_t mxs_lradc_show_scale_available_ch(struct device *dev,
 	int i, len = 0;
 
 	for (i = 0; i < ARRAY_SIZE(lradc->scale_avail[ch]); i++)
-		len += sprintf(buf + len, "%d.%09u ",
+		len += sprintf(buf + len, "%u.%09u ",
 			       lradc->scale_avail[ch][i].integer,
 			       lradc->scale_avail[ch][i].nano);
 
-- 
1.7.10.4
