Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mano-163-64-shared.jabatus.fr ([109.234.163.64]:50963 "EHLO
	mano-163-64-shared.jabatus.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750890AbbG3JpC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jul 2015 05:45:02 -0400
From: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	ludovic.tancerel@maplehightech.com, William.Markezana@meas-spec.com
Subject: [PATCH V2 1/6] iio: Add meas-spec sensors common part
Date: Thu, 30 Jul 2015 11:25:40 +0200
Message-Id: <1438248345-25820-2-git-send-email-ludovic.tancerel@maplehightech.com>
In-Reply-To: <1438248345-25820-1-git-send-email-ludovic.tancerel@maplehightech.com>
References: <1438248345-25820-1-git-send-email-ludovic.tancerel@maplehightech.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
---
 drivers/iio/common/Kconfig                     |   1 +
 drivers/iio/common/Makefile                    |   1 +
 drivers/iio/common/ms_sensors/Kconfig          |   6 +
 drivers/iio/common/ms_sensors/Makefile         |   5 +
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c | 634 +++++++++++++++++++++++++
 drivers/iio/common/ms_sensors/ms_sensors_i2c.h |  54 +++
 6 files changed, 701 insertions(+)
 create mode 100644 drivers/iio/common/ms_sensors/Kconfig
 create mode 100644 drivers/iio/common/ms_sensors/Makefile
 create mode 100644 drivers/iio/common/ms_sensors/ms_sensors_i2c.c
 create mode 100644 drivers/iio/common/ms_sensors/ms_sensors_i2c.h

diff --git a/drivers/iio/common/Kconfig b/drivers/iio/common/Kconfig
index 790f106..26a6026 100644
--- a/drivers/iio/common/Kconfig
+++ b/drivers/iio/common/Kconfig
@@ -3,5 +3,6 @@
 #
 
 source "drivers/iio/common/hid-sensors/Kconfig"
+source "drivers/iio/common/ms_sensors/Kconfig"
 source "drivers/iio/common/ssp_sensors/Kconfig"
 source "drivers/iio/common/st_sensors/Kconfig"
diff --git a/drivers/iio/common/Makefile b/drivers/iio/common/Makefile
index b1e4d9c..585da6a 100644
--- a/drivers/iio/common/Makefile
+++ b/drivers/iio/common/Makefile
@@ -8,5 +8,6 @@
 
 # When adding new entries keep the list in alphabetical order
 obj-y += hid-sensors/
+obj-y += ms_sensors/
 obj-y += ssp_sensors/
 obj-y += st_sensors/
diff --git a/drivers/iio/common/ms_sensors/Kconfig b/drivers/iio/common/ms_sensors/Kconfig
new file mode 100644
index 0000000..b28a92b
--- /dev/null
+++ b/drivers/iio/common/ms_sensors/Kconfig
@@ -0,0 +1,6 @@
+#
+# Measurements Specialties sensors common library
+#
+
+config IIO_MS_SENSORS_I2C
+        tristate
diff --git a/drivers/iio/common/ms_sensors/Makefile b/drivers/iio/common/ms_sensors/Makefile
new file mode 100644
index 0000000..7846428
--- /dev/null
+++ b/drivers/iio/common/ms_sensors/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for the Measurement Specialties sensor common modules.
+#
+
+obj-$(CONFIG_IIO_MS_SENSORS_I2C) += ms_sensors_i2c.o
diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
new file mode 100644
index 0000000..f5d27b6
--- /dev/null
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
@@ -0,0 +1,634 @@
+/*
+ * Measurements Specialties driver common i2c functions
+ *
+ * Copyright (c) 2015 Measurement-Specialties
+ *
+ * Licensed under the GPL-2.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/iio/iio.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+
+#include "ms_sensors_i2c.h"
+
+/* Conversion times in us */
+static const u16 ms_sensors_ht_t_conversion_time[] = { 50000, 25000,
+						       13000, 7000 };
+static const u16 ms_sensors_ht_h_conversion_time[] = { 16000, 3000,
+						       5000, 8000 };
+static const u16 ms_sensors_tp_conversion_time[] = { 500, 1100, 2100,
+						     4100, 8220, 16440 };
+
+#define MS_SENSORS_SERIAL_READ_MSB		0xFA0F
+#define MS_SENSORS_SERIAL_READ_LSB		0xFCC9
+#define MS_SENSORS_USER_REG_WRITE		0xE6
+#define MS_SENSORS_USER_REG_READ		0xE7
+#define MS_SENSORS_HT_T_CONVERSION_START	0xF3
+#define MS_SENSORS_HT_H_CONVERSION_START	0xF5
+
+#define MS_SENSORS_TP_PROM_READ			0xA0
+#define MS_SENSORS_TP_T_CONVERSION_START	0x50
+#define MS_SENSORS_TP_P_CONVERSION_START	0x40
+#define MS_SENSORS_TP_ADC_READ			0x00
+
+#define MS_SENSORS_NO_READ_CMD			0xFF
+
+/**
+ * ms_sensors_i2c_reset() - i2c reset function
+ * @cli:	pointer on i2c client
+ * @cmd:	reset cmd. Depends on device in use
+ * @delay:	usleep minimal delay after reset command is issued
+ *
+ * Generic I2C reset function for Measurement Specialties devices
+ *
+ * Return: 0 on success, negative errno otherwise.
+ */
+int ms_sensors_i2c_reset(void *cli, u8 cmd, unsigned int delay)
+{
+	int ret;
+	struct i2c_client *client = cli;
+
+	ret = i2c_smbus_write_byte(client, cmd);
+	if (ret) {
+		dev_err(&client->dev, "Failed to reset device\n");
+		return ret;
+	}
+	usleep_range(delay, delay + 1000);
+
+	return 0;
+}
+EXPORT_SYMBOL(ms_sensors_i2c_reset);
+
+/**
+ * ms_sensors_i2c_read_prom_word() - i2c prom word read function
+ * @cli:	pointer on i2c client
+ * @cmd:	PROM read cmd. Depends on device and prom id
+ * @word:	pointer on word destination value
+ *
+ * Generic i2c prom word read function for Measurement Specialties devices
+ *
+ * Return: 0 on success, negative errno otherwise.
+ */
+int ms_sensors_i2c_read_prom_word(void *cli, int cmd, u16 *word)
+{
+	int ret;
+	struct i2c_client *client = (struct i2c_client *)cli;
+
+	ret = i2c_smbus_read_word_swapped(client, cmd);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to read prom word\n");
+		return ret;
+	}
+	*word = ret;
+
+	return 0;
+}
+EXPORT_SYMBOL(ms_sensors_i2c_read_prom_word);
+
+/**
+ * ms_sensors_i2c_convert_and_read() - i2c ADC conversion & read function
+ * @cli:	pointer on i2c client
+ * @conv:	ADC conversion command. Depends on device in use
+ * @rd:		ADC read command. Depends on device in use
+ * @delay:	usleep minimal delay after conversion command is issued
+ * @adc:	pointer on ADC destination value
+ *
+ * Generic i2c ADC conversion & read function for Measurement Specialties
+ * devices.
+ * The function will issue conversion command, sleep appopriate delay, and
+ * issue command to read ADC
+ *
+ * Return: 0 on success, negative errno otherwise.
+ */
+int ms_sensors_i2c_convert_and_read(void *cli, u8 conv, u8 rd,
+				    unsigned int delay, u32 *adc)
+{
+	int ret;
+	u32 buf = 0;
+	struct i2c_client *client = (struct i2c_client *)cli;
+
+	/* Trigger conversion */
+	ret = i2c_smbus_write_byte(client, conv);
+	if (ret)
+		goto err;
+	usleep_range(delay, delay + 1000);
+
+	/* Retrieve ADC value */
+	if (rd != MS_SENSORS_NO_READ_CMD)
+		ret = i2c_smbus_read_i2c_block_data(client, rd, 3, (u8 *)&buf);
+	else
+		ret = i2c_master_recv(client, (u8 *)&buf, 3);
+	if (ret < 0)
+		goto err;
+
+	dev_dbg(&client->dev, "ADC raw value : %x\n", be32_to_cpu(buf) >> 8);
+	*adc = be32_to_cpu(buf) >> 8;
+
+	return 0;
+err:
+	dev_err(&client->dev, "Unable to make sensor adc conversion\n");
+	return ret;
+}
+EXPORT_SYMBOL(ms_sensors_i2c_convert_and_read);
+
+/**
+ * ms_sensors_crc_valid() - CRC check function
+ * @value:	input and CRC compare value
+ *
+ * Cyclic Redundancy Check function used in TSYS02D, HTU21, MS8607.
+ * This function performs a x^8 + x^5 + x^4 + 1 polynomial CRC.
+ * The argument contains CRC value in LSB byte while the bytes 1 and 2
+ * are used for CRC computation
+ *
+ * Return: 1 if CRC is valid, 0 otherwise.
+ */
+static bool ms_sensors_crc_valid(u32 value)
+{
+	u32 polynom = 0x988000;	/* x^8 + x^5 + x^4 + 1 */
+	u32 msb = 0x800000;
+	u32 mask = 0xFF8000;
+	u32 result = value & 0xFFFF00;
+	u8 crc = value & 0xFF;
+
+	while (msb != 0x80) {
+		if (result & msb)
+			result = ((result ^ polynom) & mask)
+				| (result & ~mask);
+		msb >>= 1;
+		mask >>= 1;
+		polynom >>= 1;
+	}
+
+	return result == crc;
+}
+
+/**
+ * ms_sensors_i2c_read_serial() - i2c serial number read function
+ * @cli:	pointer on i2c client
+ * @sn:		pointer on 64-bits destination value
+ *
+ * Generic i2c serial number read function for Measurement Specialties devices.
+ * This function is used for TSYS02d, HTU21, MS8607 chipset.
+ * Refer to datasheet:
+ *	http://www.meas-spec.com/downloads/HTU2X_Serial_Number_Reading.pdf
+ *
+ * Return: 0 on success, negative errno otherwise.
+ */
+int ms_sensors_i2c_read_serial(struct i2c_client *client, u64 *sn)
+{
+	u8 i;
+	u64 rcv_buf = 0;
+	u16 send_buf;
+	int ret;
+
+	struct i2c_msg msg[2] = {
+		{
+		 .addr = client->addr,
+		 .flags = client->flags,
+		 .len = 2,
+		 .buf = (char *)&send_buf,
+		 },
+		{
+		 .addr = client->addr,
+		 .flags = client->flags | I2C_M_RD,
+		 .buf = (char *)&rcv_buf,
+		 },
+	};
+
+	/* Read MSB part of serial number */
+	send_buf = cpu_to_be16(MS_SENSORS_SERIAL_READ_MSB);
+	msg[1].len = 8;
+	ret = i2c_transfer(client->adapter, msg, 2);
+	if (ret < 0)
+		goto err;
+
+	rcv_buf = be64_to_cpu(rcv_buf);
+	dev_dbg(&client->dev, "Serial MSB raw : %llx\n", rcv_buf);
+
+	for (i = 0; i < 64; i += 16) {
+		if (!ms_sensors_crc_valid((rcv_buf >> i) & 0xFFFF))
+			return -ENODEV;
+	}
+
+	*sn = (((rcv_buf >> 32) & 0xFF000000) |
+	       ((rcv_buf >> 24) & 0x00FF0000) |
+	       ((rcv_buf >> 16) & 0x0000FF00) |
+	       ((rcv_buf >> 8) & 0x000000FF)) << 16;
+
+	/* Read LSB part of serial number */
+	send_buf = cpu_to_be16(MS_SENSORS_SERIAL_READ_LSB);
+	msg[1].len = 6;
+	rcv_buf = 0;
+	ret = i2c_transfer(client->adapter, msg, 2);
+	if (ret < 0)
+		goto err;
+
+	rcv_buf = be64_to_cpu(rcv_buf) >> 16;
+	dev_dbg(&client->dev, "Serial MSB raw : %llx\n", rcv_buf);
+
+	for (i = 0; i < 48; i += 24) {
+		if (!ms_sensors_crc_valid((rcv_buf >> i) & 0xFFFFFF))
+			return -ENODEV;
+	}
+
+	*sn |= (rcv_buf & 0xFFFF00) << 40 | (rcv_buf >> 32);
+
+	return 0;
+
+err:
+	dev_err(&client->dev, "Unable to read device serial number");
+	return ret;
+}
+EXPORT_SYMBOL(ms_sensors_i2c_read_serial);
+
+static int ms_sensors_i2c_read_user_reg(struct i2c_client *client,
+					u8 *user_reg)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte(client, MS_SENSORS_USER_REG_READ);
+	if (ret)
+		goto err;
+
+	ret = i2c_master_recv(client, user_reg, 1);
+	if (ret < 0)
+		goto err;
+	dev_dbg(&client->dev, "User register :%x\n", *user_reg);
+
+	return 0;
+err:
+	dev_err(&client->dev, "Unable to read user reg");
+	return ret;
+}
+
+/**
+ * ms_sensors_i2c_write_resolution() - set resolution i2c function
+ * @dev_data:	pointer on temperature/humidity device data
+ * @i:		resolution index to set
+ *
+ * That function will program the appropriate resolution based on the index
+ * provided when user space will set samp_freq channel.
+ * That function is used for TSYS02D, HTU21 and MS8607 chipsets
+ *
+ * Return: 0 on success, negative errno otherwise.
+ */
+ssize_t ms_sensors_i2c_write_resolution(struct ms_ht_dev *dev_data,
+					u8 i)
+{
+	u8 user_reg;
+	int ret;
+
+	ret = ms_sensors_i2c_read_user_reg(dev_data->client, &user_reg);
+	if (ret)
+		return ret;
+
+	user_reg &= 0x7E;
+	user_reg |= ((i & 1) << 7) + ((i & 2) >> 1);
+
+	return i2c_smbus_write_byte_data(dev_data->client,
+					 MS_SENSORS_USER_REG_WRITE,
+					 user_reg);
+}
+EXPORT_SYMBOL(ms_sensors_i2c_write_resolution);
+
+/**
+ * ms_sensors_i2c_show_battery_low() - show device battery low indicator
+ * @dev_data:	pointer on temperature/humidity device data
+ * @buf:	pointer on char buffer to write result
+ *
+ * That function will read battery indicator value in the device and
+ * return 1 if the device voltage is below 2.25V.
+ * That function is used for TSYS02D, HTU21 and MS8607 chipsets
+ *
+ * Return: length of sprintf on success, negative errno otherwise.
+ */
+ssize_t ms_sensors_i2c_show_battery_low(struct ms_ht_dev *dev_data,
+					char *buf)
+{
+	int ret;
+	u8 user_reg;
+
+	mutex_lock(&dev_data->lock);
+	ret = ms_sensors_i2c_read_user_reg(dev_data->client, &user_reg);
+	mutex_unlock(&dev_data->lock);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%d\n", (user_reg & 0x40) >> 6);
+}
+EXPORT_SYMBOL(ms_sensors_i2c_show_battery_low);
+
+/**
+ * ms_sensors_i2c_show_heater() - show device heater
+ * @dev_data:	pointer on temperature/humidity device data
+ * @buf:	pointer on char buffer to write result
+ *
+ * That function will read heater enable value in the device and
+ * return 1 if the heater is enabled
+ * That function is used for HTU21 and MS8607 chipsets
+ *
+ * Return: length of sprintf on success, negative errno otherwise.
+ */
+ssize_t ms_sensors_i2c_show_heater(struct ms_ht_dev *dev_data,
+				   char *buf)
+{
+	u8 user_reg;
+	int ret;
+
+	mutex_lock(&dev_data->lock);
+	ret = ms_sensors_i2c_read_user_reg(dev_data->client, &user_reg);
+	mutex_unlock(&dev_data->lock);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%d\n", (user_reg & 0x4) >> 2);
+}
+EXPORT_SYMBOL(ms_sensors_i2c_show_heater);
+
+/**
+ * ms_sensors_i2c_write_heater() - write device heater
+ * @dev_data:	pointer on temperature/humidity device data
+ * @buf:	pointer on char buffer from user space
+ * @len:	length of buf
+ *
+ * That function will write 1 or 0 value in the device
+ * to enable or disable heater
+ * That function is used for HTU21 and MS8607 chipsets
+ *
+ * Return: length of buffer, negative errno otherwise.
+ */
+ssize_t ms_sensors_i2c_write_heater(struct ms_ht_dev *dev_data,
+				    const char *buf, size_t len)
+{
+	u8 val, user_reg;
+	int ret;
+
+	ret = kstrtou8(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val > 1)
+		return -EINVAL;
+
+	mutex_lock(&dev_data->lock);
+	ret = ms_sensors_i2c_read_user_reg(dev_data->client, &user_reg);
+	if (ret) {
+		mutex_unlock(&dev_data->lock);
+		return ret;
+	}
+
+	user_reg &= 0xFB;
+	user_reg |= val << 2;
+
+	ret = i2c_smbus_write_byte_data(dev_data->client,
+					MS_SENSORS_USER_REG_WRITE,
+					user_reg);
+	mutex_unlock(&dev_data->lock);
+	if (ret) {
+		dev_err(&dev_data->client->dev, "Unable to write user reg\n");
+		return ret;
+	}
+
+	return len;
+}
+EXPORT_SYMBOL(ms_sensors_i2c_write_heater);
+
+/**
+ * ms_sensors_i2c_ht_read_temperature() - i2c read temperature
+ * @dev_data:	pointer on temperature/humidity device data
+ * @temperature:pointer on temperature destination value
+ *
+ * That function will get temperature ADC value from the device,
+ * check the CRC and compute the temperature value.
+ * That function is used for TSYS02D, HTU21 and MS8607 chipsets
+ *
+ * Return: 0 on success, negative errno otherwise.
+ */
+int ms_sensors_i2c_ht_read_temperature(struct ms_ht_dev *dev_data,
+				       s32 *temperature)
+{
+	int ret;
+	u32 adc;
+	u16 delay;
+
+	mutex_lock(&dev_data->lock);
+	delay = ms_sensors_ht_t_conversion_time[dev_data->res_index];
+	ret = ms_sensors_i2c_convert_and_read(dev_data->client,
+					      MS_SENSORS_HT_T_CONVERSION_START,
+					      MS_SENSORS_NO_READ_CMD,
+					      delay, &adc);
+	mutex_unlock(&dev_data->lock);
+	if (ret)
+		return ret;
+
+	if (!ms_sensors_crc_valid(adc)) {
+		dev_err(&dev_data->client->dev,
+			"Temperature read crc check error\n");
+		return -ENODEV;
+	}
+
+	/* Temperature algorithm */
+	*temperature = (((s64)(adc >> 8) * 175720) >> 16) - 46850;
+
+	return 0;
+}
+EXPORT_SYMBOL(ms_sensors_i2c_ht_read_temperature);
+
+/**
+ * ms_sensors_i2c_ht_read_humidity() - i2c read humidity
+ * @dev_data:	pointer on temperature/humidity device data
+ * @humidity:	pointer on humidity destination value
+ *
+ * That function will get humidity ADC value from the device,
+ * check the CRC and compute the temperature value.
+ * That function is used for HTU21 and MS8607 chipsets
+ *
+ * Return: 0 on success, negative errno otherwise.
+ */
+int ms_sensors_i2c_ht_read_humidity(struct ms_ht_dev *dev_data,
+				    u32 *humidity)
+{
+	int ret;
+	u32 adc;
+	u16 delay;
+
+	mutex_lock(&dev_data->lock);
+	delay = ms_sensors_ht_h_conversion_time[dev_data->res_index];
+	ret = ms_sensors_i2c_convert_and_read(dev_data->client,
+					      MS_SENSORS_HT_H_CONVERSION_START,
+					      MS_SENSORS_NO_READ_CMD,
+					      delay, &adc);
+	mutex_unlock(&dev_data->lock);
+	if (ret)
+		return ret;
+
+	if (!ms_sensors_crc_valid(adc)) {
+		dev_err(&dev_data->client->dev,
+			"Humidity read crc check error\n");
+		return -ENODEV;
+	}
+
+	/* Humidity algorithm */
+	*humidity = (((s32)(adc >> 8) * 12500) >> 16) * 10 - 6000;
+	if (*humidity >= 100000)
+		*humidity = 100000;
+
+	return 0;
+}
+EXPORT_SYMBOL(ms_sensors_i2c_ht_read_humidity);
+
+/* CRC check function for Temperature and pressure devices
+ * That function is only used when reading PROM coefficients */
+static bool ms_sensors_tp_crc_valid(u16 *prom, u8 len)
+{
+	unsigned int cnt, n_bit;
+	u16 n_rem = 0x0000, crc_read = prom[0], crc = (*prom & 0xF000) >> 12;
+
+	prom[len - 1] = 0;
+	prom[0] &= 0x0FFF;      /* Clear the CRC computation part */
+
+	for (cnt = 0; cnt < len * 2; cnt++) {
+		if (cnt % 2 == 1)
+			n_rem ^= prom[cnt >> 1] & 0x00FF;
+		else
+			n_rem ^= prom[cnt >> 1] >> 8;
+
+		for (n_bit = 8; n_bit > 0; n_bit--) {
+			if (n_rem & 0x8000)
+				n_rem = (n_rem << 1) ^ 0x3000;
+			else
+				n_rem <<= 1;
+		}
+	}
+	n_rem >>= 12;
+	prom[0] = crc_read;
+
+	return n_rem == crc;
+}
+
+/**
+ * ms_sensors_tp_read_prom() - prom coeff read function
+ * @dev_data:	pointer on temperature/pressure device data
+ *
+ * That function will read prom coefficients and check CRC
+ * That function is used for MS5637 and MS8607 chipsets
+ *
+ * Return: 0 on success, negative errno otherwise.
+ */
+int ms_sensors_tp_read_prom(struct ms_tp_dev *dev_data)
+{
+	int i, ret;
+
+	for (i = 0; i < MS_SENSORS_TP_PROM_WORDS_NB; i++) {
+		ret = ms_sensors_i2c_read_prom_word(
+					dev_data->client,
+					MS_SENSORS_TP_PROM_READ + (i << 1),
+					&dev_data->prom[i]);
+
+		if (ret)
+			return ret;
+	}
+
+	if (!ms_sensors_tp_crc_valid(dev_data->prom,
+				     MS_SENSORS_TP_PROM_WORDS_NB + 1)) {
+		dev_err(&dev_data->client->dev,
+			"Calibration coefficients crc check error\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(ms_sensors_tp_read_prom);
+
+/**
+ * ms_sensors_read_temp_and_pressure() - read temp and pressure
+ * @dev_data:	pointer on temperature/pressure device data
+ * @temperature:pointer on temperature destination value
+ * @pressure:	pointer on pressure destination value
+ *
+ * That function will read ADC and compute pressure and temperature value
+ * That function is used for MS5637 and MS8607 chipsets
+ *
+ * Return: 0 on success, negative errno otherwise.
+ */
+int ms_sensors_read_temp_and_pressure(struct ms_tp_dev *dev_data,
+				      int *temperature,
+				      unsigned int *pressure)
+{
+	int ret;
+	u32 t_adc, p_adc;
+	s32 dt, temp;
+	s64 off, sens, t2, off2, sens2;
+	u16 *prom = dev_data->prom, delay;
+	u8 i;
+
+	mutex_lock(&dev_data->lock);
+	i = dev_data->res_index * 2;
+	delay = ms_sensors_tp_conversion_time[dev_data->res_index];
+	ret = ms_sensors_i2c_convert_and_read(
+					dev_data->client,
+					MS_SENSORS_TP_T_CONVERSION_START + i,
+					MS_SENSORS_TP_ADC_READ,
+					delay, &t_adc);
+	if (ret) {
+		mutex_unlock(&dev_data->lock);
+		return ret;
+	}
+	ret = ms_sensors_i2c_convert_and_read(
+					dev_data->client,
+					MS_SENSORS_TP_P_CONVERSION_START + i,
+					MS_SENSORS_TP_ADC_READ,
+					delay, &p_adc);
+	mutex_unlock(&dev_data->lock);
+	if (ret)
+		return ret;
+
+	dt = (s32)t_adc - (prom[5] << 8);
+
+	/* Actual temperature = 2000 + dT * TEMPSENS */
+	temp = 2000 + (((s64)dt * prom[6]) >> 23);
+
+	/* Second order temperature compensation */
+	if (temp < 2000) {
+		s64 tmp = (s64)temp - 2000;
+
+		t2 = (3 * ((s64)dt * (s64)dt)) >> 33;
+		off2 = (61 * tmp * tmp) >> 4;
+		sens2 = (29 * tmp * tmp) >> 4;
+
+		if (temp < -1500) {
+			s64 tmp = (s64)temp + 1500;
+
+			off2 += 17 * tmp * tmp;
+			sens2 += 9 * tmp * tmp;
+		}
+	} else {
+		t2 = (5 * ((s64)dt * (s64)dt)) >> 38;
+		off2 = 0;
+		sens2 = 0;
+	}
+
+	/* OFF = OFF_T1 + TCO * dT */
+	off = (((s64)prom[2]) << 17) + ((((s64)prom[4]) * (s64)dt) >> 6);
+	off -= off2;
+
+	/* Sensitivity at actual temperature = SENS_T1 + TCS * dT */
+	sens = (((s64)prom[1]) << 16) + (((s64)prom[3] * dt) >> 7);
+	sens -= sens2;
+
+	/* Temperature compensated pressure = D1 * SENS - OFF */
+	*temperature = (temp - t2) * 10;
+	*pressure = (u32)(((((s64)p_adc * sens) >> 21) - off) >> 15);
+
+	return 0;
+}
+EXPORT_SYMBOL(ms_sensors_read_temp_and_pressure);
+
+MODULE_DESCRIPTION("Measurement-Specialties common i2c driver");
+MODULE_AUTHOR("William Markezana <william.markezana@meas-spec.com>");
+MODULE_AUTHOR("Ludovic Tancerel <ludovic.tancerel@maplehightech.com>");
+MODULE_LICENSE("GPL v2");
+
diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.h b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
new file mode 100644
index 0000000..a521428
--- /dev/null
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
@@ -0,0 +1,54 @@
+/*
+ * Measurements Specialties common sensor driver
+ *
+ * Copyright (c) 2015 Measurement-Specialties
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef _MS_SENSORS_I2C_H
+#define _MS_SENSORS_I2C_H
+
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+
+#define MS_SENSORS_TP_PROM_WORDS_NB		7
+
+struct ms_ht_dev {
+	struct i2c_client *client;
+	struct mutex lock; /* mutex protecting data structure */
+	u8 res_index;
+};
+
+struct ms_tp_dev {
+	struct i2c_client *client;
+	struct mutex lock; /* mutex protecting data structure */
+	/* Added element for CRC computation */
+	u16 prom[MS_SENSORS_TP_PROM_WORDS_NB + 1];
+	u8 res_index;
+};
+
+int ms_sensors_i2c_reset(void *cli, u8 cmd, unsigned int delay);
+int ms_sensors_i2c_read_prom_word(void *cli, int cmd, u16 *word);
+int ms_sensors_i2c_convert_and_read(void *cli, u8 conv, u8 rd,
+				    unsigned int delay, u32 *adc);
+int ms_sensors_i2c_read_serial(struct i2c_client *client, u64 *sn);
+ssize_t ms_sensors_i2c_show_serial(struct ms_ht_dev *dev_data, char *buf);
+ssize_t ms_sensors_i2c_write_resolution(struct ms_ht_dev *dev_data, u8 i);
+ssize_t ms_sensors_i2c_show_battery_low(struct ms_ht_dev *dev_data, char *buf);
+ssize_t ms_sensors_i2c_show_heater(struct ms_ht_dev *dev_data, char *buf);
+ssize_t ms_sensors_i2c_write_heater(struct ms_ht_dev *dev_data,
+				    const char *buf, size_t len);
+int ms_sensors_i2c_ht_read_temperature(struct ms_ht_dev *dev_data,
+				       s32 *temperature);
+int ms_sensors_i2c_ht_read_humidity(struct ms_ht_dev *dev_data,
+				    u32 *humidity);
+int ms_sensors_tp_read_prom(struct ms_tp_dev *dev_data);
+int ms_sensors_read_temp_and_pressure(struct ms_tp_dev *dev_data,
+				      int *temperature,
+				      unsigned int *pressure);
+
+#endif /* _MS_SENSORS_I2C_H */
-- 
2.3.7

