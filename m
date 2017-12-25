Return-Path: <SRS0=BSDQ=DV=no-log.org=m.capdeville@kernel.org>
From: Marc CAPDEVILLE <m.capdeville@no-log.org>
To: Kevin Tsai <ktsai@capellamicro.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Marc CAPDEVILLE <m.capdeville@no-log.org>
Subject: [PATCH v6 1/4] i2c-core-acpi : Add i2c_acpi_set_connection
Date: Mon, 25 Dec 2017 16:57:20 +0100
Message-Id: <20171225155723.6338-1-m.capdeville@no-log.org>
List-ID: <linux-iio@vger.kernel.org>

Add a methode to allow clients to change their connection address on
same adapter.

On ACPI enumerated device, when a device support smbus alert protocol,
there are two acpi serial bus connection description. The order in which
connection is given is not well defined and devices may be enumerated
with the wrong address (the first one). So let the driver detect the
unsupported address and request i2c acpi core to choose the second one
at probing time.

Signed-off-by: Marc CAPDEVILLE <m.capdeville@no-log.org>
---
 drivers/i2c/i2c-core-acpi.c | 50 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h         | 10 +++++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index a9126b3cda61..47bc0da12055 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -421,6 +421,56 @@ struct i2c_client *i2c_acpi_new_device(struct device *dev, int index,
 }
 EXPORT_SYMBOL_GPL(i2c_acpi_new_device);
 
+int i2c_acpi_set_connection(struct i2c_client *client, int index)
+{
+	struct i2c_acpi_lookup lookup;
+	struct i2c_adapter *adapter;
+	struct acpi_device *adev;
+	struct i2c_board_info info;
+	LIST_HEAD(resource_list);
+	int ret;
+
+	if (!client)
+		return -ENODEV;
+
+	adev = ACPI_COMPANION(&client->dev);
+	if (!adev)
+		return -ENODEV;
+
+	memset(&info,  0, sizeof(info));
+	memset(&lookup, 0, sizeof(lookup));
+	lookup.info = &info;
+	lookup.device_handle = acpi_device_handle(adev);
+	lookup.index = index;
+
+	ret = acpi_dev_get_resources(adev, &resource_list,
+				     i2c_acpi_fill_info, &lookup);
+	acpi_dev_free_resource_list(&resource_list);
+
+	adapter = i2c_acpi_find_adapter_by_handle(lookup.adapter_handle);
+
+	if (ret < 0 || !info.addr)
+		return -EINVAL;
+
+	/* Only accept connection on same adapter */
+	if (adapter != client->adapter)
+		return -EINVAL;
+
+	ret = i2c_check_addr_validity(info.addr, info.flags);
+	if (ret) {
+		dev_err(&client->dev, "Invalid %d-bit I2C address 0x%02hx\n",
+			info.flags & I2C_CLIENT_TEN ? 10 : 7, info.addr);
+		return -EINVAL;
+	}
+
+	/* Set new address and flags */
+	client->addr = info.addr;
+	client->flags = info.flags;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(i2c_acpi_set_connection);
+
 #ifdef CONFIG_ACPI_I2C_OPREGION
 static int acpi_gsb_i2c_read_bytes(struct i2c_client *client,
 		u8 cmd, u8 *data, u8 data_len)
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 0f774406fad0..618b453901da 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -595,6 +595,8 @@ struct i2c_adapter {
 	const struct i2c_adapter_quirks *quirks;
 
 	struct irq_domain *host_notify_domain;
+
+	struct i2c_client *smbus_ara;	/* ARA for SMBUS if present */
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 
@@ -839,16 +841,24 @@ static inline const struct of_device_id
 u32 i2c_acpi_find_bus_speed(struct device *dev);
 struct i2c_client *i2c_acpi_new_device(struct device *dev, int index,
 				       struct i2c_board_info *info);
+
+int i2c_acpi_set_connection(struct i2c_client *client, int index);
 #else
 static inline u32 i2c_acpi_find_bus_speed(struct device *dev)
 {
 	return 0;
 }
+
 static inline struct i2c_client *i2c_acpi_new_device(struct device *dev,
 					int index, struct i2c_board_info *info)
 {
 	return NULL;
 }
+
+static inline int i2c_acpi_set_connection(struct i2c_client *client, int index)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_ACPI */
 
 #endif /* _LINUX_I2C_H */
-- 
2.11.0
