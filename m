Return-Path: <SRS0=T1uy=45=cogentembedded.com=nikita.yoush@kernel.org>
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Sanchayan Maity <maitysanchayan@gmail.com>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Matt Ranostay <mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Healy <Chris.Healy@zii.aero>,
	Jeff White <Jeff.White@zii.aero>,
	Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH/RFC] iio: hi8435: do not enable all events by default
Date: Tue, 23 May 2017 11:08:30 +0300
Message-Id: <20170523080830.20571-1-nikita.yoush@cogentembedded.com>
List-ID: <linux-iio@vger.kernel.org>

Having all events enabled by default is misleading.
Userspace should explicitly enable events they want to receive.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/iio/adc/hi8435.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
index ef5c286c8e67..0331739f235c 100644
--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -506,8 +506,6 @@ static int hi8435_probe(struct spi_device *spi)
 	idev->channels		= hi8435_channels;
 	idev->num_channels	= ARRAY_SIZE(hi8435_channels);
 
-	/* unmask all events */
-	priv->event_scan_mask = ~(0);
 	/*
 	 * There is a restriction in the chip - the hysteresis can not be odd.
 	 * If the hysteresis is set to odd value then chip gets into lock state
-- 
2.11.0
