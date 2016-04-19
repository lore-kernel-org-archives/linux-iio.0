Return-Path: <gregor.boirie@parrot.com>
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, Denis Ciocca <denis.ciocca@st.com>, Linus Walleij
	<linus.walleij@linaro.org>, Giuseppe Barba <giuseppe.barba@st.com>, Gregor
 Boirie <gregor.boirie@parrot.com>
Subject: [RFC PATCH v1 7/9] iio:st_sensors: unexport st_sensors_get_buffer_element
Date: Tue, 19 Apr 2016 11:18:38 +0200
Message-ID: <467cc5525789973e7dced2d12e1e57abdee8767f.1461056711.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1461056711.git.gregor.boirie@parrot.com>
References: <cover.1461056711.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Remove st_sensors_get_buffer_element symbol export since not explicitly
used outside of st_sensors driver.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 drivers/iio/common/st_sensors/st_sensors_buffer.c | 3 +--
 include/linux/iio/common/st_sensors.h             | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
index a7f1ced..9343d74 100644
--- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
+++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
@@ -21,7 +21,7 @@
 
 #include <linux/iio/common/st_sensors.h>
 
-int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
+static int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
 {
 	unsigned int cid;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
@@ -45,7 +45,6 @@ int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
 
 	return 0;
 }
-EXPORT_SYMBOL(st_sensors_get_buffer_element);
 
 irqreturn_t st_sensors_trigger_handler(int irq, void *p)
 {
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index d029ffa..78a1934 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -251,8 +251,6 @@ struct st_sensor_data {
 
 #ifdef CONFIG_IIO_BUFFER
 irqreturn_t st_sensors_trigger_handler(int irq, void *p);
-
-int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf);
 #endif
 
 #ifdef CONFIG_IIO_TRIGGER
-- 
2.1.4
