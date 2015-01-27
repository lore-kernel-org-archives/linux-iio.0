Return-Path: <rickard.strandqvist@spctrm.se>
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joel Porquet <joel@porquet.org>,
	Darshana Padmadas <darshanapadmadas@gmail.com>,
	Catalina Mocanu <catalina.mocanu@gmail.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: trigger: iio-trig-periodic-rtc: Change type in printf format string
Date: Tue, 27 Jan 2015 22:32:28 +0100
Message-Id: <1422394348-8057-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-ID: <linux-iio@vger.kernel.org>

Wrong type in printf format string, requires 'unsigned int'
but the argument type is 'int'

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/staging/iio/trigger/iio-trig-periodic-rtc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
index a24caf7..66d54a0 100644
--- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
+++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
@@ -52,7 +52,7 @@ static ssize_t iio_trig_periodic_read_freq(struct device *dev,
 	struct iio_trigger *trig = to_iio_trigger(dev);
 	struct iio_prtc_trigger_info *trig_info = iio_trigger_get_drvdata(trig);
 
-	return sprintf(buf, "%u\n", trig_info->frequency);
+	return sprintf(buf, "%d\n", trig_info->frequency);
 }
 
 static ssize_t iio_trig_periodic_write_freq(struct device *dev,
-- 
1.7.10.4
