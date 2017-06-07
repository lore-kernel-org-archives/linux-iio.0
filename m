Return-Path: <SRS0=W4DQ=5M=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH 1/2] iio: imu: st_lsm6dsx: support active-low interrupts
Date: Wed,  7 Jun 2017 20:17:10 +0200
Message-Id: <20170607181711.16195-2-lorenzo.bianconi@st.com>
In-Reply-To: <20170607181711.16195-1-lorenzo.bianconi@st.com>
References: <20170607181711.16195-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Add support for active low interrupts (IRQF_TRIGGER_LOW and
IRQF_TRIGGER_FALLING). Configure the device as active high or low
according to the requested irq line.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index b19a62d8c884..2a72acc6e049 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -37,6 +37,8 @@
 #define ST_LSM6DSX_REG_FIFO_THH_ADDR		0x07
 #define ST_LSM6DSX_FIFO_TH_MASK			GENMASK(11, 0)
 #define ST_LSM6DSX_REG_FIFO_DEC_GXL_ADDR	0x08
+#define ST_LSM6DSX_REG_HLACTIVE_ADDR		0x12
+#define ST_LSM6DSX_REG_HLACTIVE_MASK		BIT(5)
 #define ST_LSM6DSX_REG_FIFO_MODE_ADDR		0x0a
 #define ST_LSM6DSX_FIFO_MODE_MASK		GENMASK(2, 0)
 #define ST_LSM6DSX_FIFO_ODR_MASK		GENMASK(6, 3)
@@ -417,6 +419,7 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
 {
 	struct iio_buffer *buffer;
 	unsigned long irq_type;
+	bool irq_active_low;
 	int i, err;
 
 	irq_type = irqd_get_trigger_type(irq_get_irq_data(hw->irq));
@@ -424,12 +427,23 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
 	switch (irq_type) {
 	case IRQF_TRIGGER_HIGH:
 	case IRQF_TRIGGER_RISING:
+		irq_active_low = false;
+		break;
+	case IRQF_TRIGGER_LOW:
+	case IRQF_TRIGGER_FALLING:
+		irq_active_low = true;
 		break;
 	default:
 		dev_info(hw->dev, "mode %lx unsupported\n", irq_type);
 		return -EINVAL;
 	}
 
+	err = st_lsm6dsx_write_with_mask(hw, ST_LSM6DSX_REG_HLACTIVE_ADDR,
+					 ST_LSM6DSX_REG_HLACTIVE_MASK,
+					 irq_active_low);
+	if (err < 0)
+		return err;
+
 	err = devm_request_threaded_irq(hw->dev, hw->irq,
 					st_lsm6dsx_handler_irq,
 					st_lsm6dsx_handler_thread,
-- 
2.12.2
