Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:58994
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751999Ab2BQMsR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 17 Feb 2012 07:48:17 -0500
From: <michael.hennerich@analog.com>
To: <jic23@kernel.org>, <grant.likely@secretlab.ca>
CC: <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 3/4] of_spi: New function spi_of_node_to_master
Date: Fri, 17 Feb 2012 13:46:11 +0100
Message-ID: <1329482772-18054-3-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1329482772-18054-1-git-send-email-michael.hennerich@analog.com>
References: <1329482772-18054-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

look up master associated with of_node

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/of/of_spi.c     |   28 ++++++++++++++++++++++++++++
 drivers/spi/spi.c       |    4 ++--
 include/linux/of_spi.h  |    1 +
 include/linux/spi/spi.h |    2 ++
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/of/of_spi.c b/drivers/of/of_spi.c
index 6dbc074..f3dee01 100644
--- a/drivers/of/of_spi.c
+++ b/drivers/of/of_spi.c
@@ -97,3 +97,31 @@ void of_register_spi_devices(struct spi_master *master)
 	}
 }
 EXPORT_SYMBOL(of_register_spi_devices);
+
+static int __spi_master_of_match(struct device *dev, void *data)
+{
+	struct device_node *of_node = data;
+	return dev->of_node == of_node;
+}
+
+/**
+ * spi_of_node_to_master - look up master associated with of_node
+ * @of_node: pointer to the device tree node.
+ * Context: can sleep
+ *
+ * Returns a pointer to the relevant spi_master, or NULL if there is
+ * no such master registered.
+ */
+struct spi_master *spi_of_node_to_master(struct device_node *of_node)
+{
+	struct device *dev;
+	struct spi_master *master = NULL;
+
+	dev = class_find_device(&spi_master_class, NULL, of_node,
+				__spi_master_of_match);
+	if (dev)
+		master = container_of(dev, struct spi_master, dev);
+
+	return master;
+}
+EXPORT_SYMBOL_GPL(spi_of_node_to_master);
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b2ccdea..6f63a8e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -515,12 +515,12 @@ static void spi_master_release(struct device *dev)
 	kfree(master);
 }
 
-static struct class spi_master_class = {
+struct class spi_master_class = {
 	.name		= "spi_master",
 	.owner		= THIS_MODULE,
 	.dev_release	= spi_master_release,
 };
-
+EXPORT_SYMBOL_GPL(spi_master_class);
 
 /**
  * spi_alloc_master - allocate SPI master controller
diff --git a/include/linux/of_spi.h b/include/linux/of_spi.h
index 9e3e70f..e1bafd2 100644
--- a/include/linux/of_spi.h
+++ b/include/linux/of_spi.h
@@ -13,6 +13,7 @@
 
 #if defined(CONFIG_OF_SPI) || defined(CONFIG_OF_SPI_MODULE)
 extern void of_register_spi_devices(struct spi_master *master);
+extern struct spi_master *spi_of_node_to_master(struct device_node *of_node);
 #else
 static inline void of_register_spi_devices(struct spi_master *master)
 {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 176fce9..62e566e 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -805,4 +805,6 @@ spi_unregister_device(struct spi_device *spi)
 extern const struct spi_device_id *
 spi_get_device_id(const struct spi_device *sdev);
 
+extern struct class spi_master_class;
+
 #endif /* __LINUX_SPI_H */
-- 
1.7.0.4


