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
Subject: [PATCH] iio: hi8435: remote ampersands from hi8435_info definition
Date: Tue, 23 May 2017 11:07:46 +0300
Message-Id: <20170523080746.20512-1-nikita.yoush@cogentembedded.com>
List-ID: <linux-iio@vger.kernel.org>

C syntax allows apersands when initializing structures fields with
function pointers, but in Linux sources ampersands are normally not used
in thix context.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/iio/adc/hi8435.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
index 28fc699f00f6..ef5c286c8e67 100644
--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -414,11 +414,11 @@ static const struct iio_chan_spec hi8435_channels[] = {
 static const struct iio_info hi8435_info = {
 	.driver_module = THIS_MODULE,
 	.read_raw = hi8435_read_raw,
-	.read_event_config = &hi8435_read_event_config,
+	.read_event_config = hi8435_read_event_config,
 	.write_event_config = hi8435_write_event_config,
-	.read_event_value = &hi8435_read_event_value,
-	.write_event_value = &hi8435_write_event_value,
-	.debugfs_reg_access = &hi8435_debugfs_reg_access,
+	.read_event_value = hi8435_read_event_value,
+	.write_event_value = hi8435_write_event_value,
+	.debugfs_reg_access = hi8435_debugfs_reg_access,
 };
 
 static void hi8435_iio_push_event(struct iio_dev *idev, unsigned int val)
-- 
2.11.0
