Return-Path: <rickard.strandqvist@spctrm.se>
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Josef Gajdusek <atx@atalax.net>,
	Teodora Baluta <teodora.baluta@intel.com>,
	Marek Belisko <marek@goldelico.com>,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: magnetometer: hmc5843_core: Change type in printf format string
Date: Tue, 27 Jan 2015 23:21:37 +0100
Message-Id: <1422397297-9206-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-ID: <linux-iio@vger.kernel.org>

Wrong type in printf format string, requires 'int'
but the argument type is 'unsigned int'

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/staging/iio/magnetometer/hmc5843_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843_core.c b/drivers/staging/iio/magnetometer/hmc5843_core.c
index fd171d8..cd049bb 100644
--- a/drivers/staging/iio/magnetometer/hmc5843_core.c
+++ b/drivers/staging/iio/magnetometer/hmc5843_core.c
@@ -217,7 +217,7 @@ static ssize_t hmc5843_show_measurement_configuration(struct device *dev,
 		return ret;
 	val &= HMC5843_MEAS_CONF_MASK;
 
-	return sprintf(buf, "%d\n", val);
+	return sprintf(buf, "%u\n", val);
 }
 
 static ssize_t hmc5843_set_measurement_configuration(struct device *dev,
-- 
1.7.10.4
