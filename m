Return-Path: <SRS0=BSDQ=DV=no-log.org=m.capdeville@kernel.org>
From: Marc CAPDEVILLE <m.capdeville@no-log.org>
To: Kevin Tsai <ktsai@capellamicro.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Marc CAPDEVILLE <m.capdeville@no-log.org>
Subject: [PATCH v6 2/4] i2c-smbus : Add client discovered ARA support
Date: Mon, 25 Dec 2017 16:57:21 +0100
Message-Id: <20171225155723.6338-2-m.capdeville@no-log.org>
In-Reply-To: <20171225155723.6338-1-m.capdeville@no-log.org>
References: <20171225155723.6338-1-m.capdeville@no-log.org>
List-ID: <linux-iio@vger.kernel.org>

This is from rfc by Alan Cox : https://patchwork.ozlabs.org/patch/381773

The idea is as follows (extract from above rfc) :
- If an adapter knows about its ARA and smbus alerts then the adapter
  creates its own interrupt handler as before

- If a client knows it needs smbus alerts it calls
  i2c_require_smbus_alert(). This ensures that there is an ARA handler
  registered and tells the client whether the adapter is handling it
  anyway or not.

- When the client learns that an ARA event has occurred it calls
  i2c_smbus_alert_event() which uses the existing ARA mechanism to kick
  things off.

Suggested-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Marc CAPDEVILLE <m.capdeville@no-log.org>
---
 drivers/i2c/i2c-smbus.c   | 83 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c-smbus.h | 15 +++++++++
 2 files changed, 98 insertions(+)

diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index 5a1dd7f13bac..e97fbafd10ef 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -161,6 +161,9 @@ static int smbalert_probe(struct i2c_client *ara,
 	}
 
 	i2c_set_clientdata(ara, alert);
+
+	ara->adapter->smbus_ara = ara;
+
 	dev_info(&adapter->dev, "supports SMBALERT#\n");
 
 	return 0;
@@ -172,6 +175,9 @@ static int smbalert_remove(struct i2c_client *ara)
 	struct i2c_smbus_alert *alert = i2c_get_clientdata(ara);
 
 	cancel_work_sync(&alert->alert);
+
+	ara->adapter->smbus_ara = NULL;
+
 	return 0;
 }
 
@@ -210,6 +216,83 @@ int i2c_handle_smbus_alert(struct i2c_client *ara)
 }
 EXPORT_SYMBOL_GPL(i2c_handle_smbus_alert);
 
+/*
+ * i2c_require_smbus_alert - Client discovered SMBus alert
+ * @c: client requiring ARA
+ *
+ * When a client needs an ARA it calls this method. If the bus adapter
+ * supports ARA and already knows how to do so then it will already have
+ * configured for ARA and this is a no-op. If not then we set up an ARA
+ * on the adapter.
+ *
+ * We *cannot* simply register a new IRQ handler for this because we might
+ * have multiple GPIO interrupts to devices all of which trigger an ARA.
+ *
+ * Return:
+ *	0 if ara support already registered
+ *	1 if call register a new smbus_alert device
+ *	<0 on error
+ */
+int i2c_require_smbus_alert(struct i2c_client *client)
+{
+	struct i2c_adapter *adapter = client->adapter;
+	struct i2c_smbus_alert_setup setup;
+	struct i2c_client *ara;
+
+	/* ARA is already known and handled by the adapter (ideal case)
+	 * or another client has specified ARA is needed
+	 */
+	if (adapter->smbus_ara)
+		return 0;
+
+	/* Client driven, do not set up a new IRQ handler */
+	setup.irq = 0;
+
+	ara = i2c_setup_smbus_alert(adapter, &setup);
+	if (!ara)
+		return -ENODEV;
+
+	return 1;
+}
+EXPORT_SYMBOL_GPL(i2c_require_smbus_alert);
+
+/*
+ * i2c_smbus_alert_event
+ * @client: the client who known of a probable ara event
+ * Context: can't sleep
+ *
+ * Helper function to be called from an I2C device driver's interrupt
+ * handler. It will schedule the alert work, in turn calling the
+ * corresponding I2C device driver's alert function.
+ *
+ * It is assumed that client is an i2c client who previously call
+ * i2c_require_smbus_alert().
+ */
+int i2c_smbus_alert_event(struct i2c_client *client)
+{
+	struct i2c_adapter *adapter;
+	struct i2c_client *ara;
+	struct i2c_smbus_alert *alert;
+
+	if (!client)
+		return -EINVAL;
+
+	adapter = client->adapter;
+	if (!adapter)
+		return -EINVAL;
+
+	ara = adapter->smbus_ara;
+	if (!ara)
+		return -EINVAL;
+
+	alert = i2c_get_clientdata(ara);
+	if (!alert)
+		return -EINVAL;
+
+	return schedule_work(&alert->alert);
+}
+EXPORT_SYMBOL_GPL(i2c_smbus_alert_event);
+
 module_i2c_driver(smbalert_driver);
 
 MODULE_AUTHOR("Jean Delvare <jdelvare@suse.de>");
diff --git a/include/linux/i2c-smbus.h b/include/linux/i2c-smbus.h
index fb0e040b1abb..49f362fa6ac5 100644
--- a/include/linux/i2c-smbus.h
+++ b/include/linux/i2c-smbus.h
@@ -58,4 +58,19 @@ static inline int of_i2c_setup_smbus_alert(struct i2c_adapter *adap)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_I2C_SMBUS)
+int i2c_require_smbus_alert(struct i2c_client *client);
+int i2c_smbus_alert_event(struct i2c_client *client);
+#else
+static inline int i2c_require_smbus_alert(struct i2c_client *client)
+{
+	return NULL;
+}
+
+static inline int i2c_smbus_alert_event(struct i2c_client *client)
+{
+	return NULL;
+}
+#endif
+
 #endif /* _LINUX_I2C_SMBUS_H */
-- 
2.11.0
