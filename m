Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:36360 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898Ab2KHRAD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 8 Nov 2012 12:00:03 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-iio@m.gmane.org>)
	id 1TWVSV-0007Kx-Q0
	for linux-iio@vger.kernel.org; Thu, 08 Nov 2012 18:00:03 +0100
Received: from p5b3c0cad.dip0.t-ipconnect.de ([91.60.12.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Thu, 08 Nov 2012 18:00:03 +0100
Received: from alban.bedel by p5b3c0cad.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Thu, 08 Nov 2012 18:00:03 +0100
To: linux-iio@vger.kernel.org
From: Alban Bedel <alban.bedel@avionic-design.de>
Subject: Re: Querry on IIO/ADC DT based consumer device probe
Date: Thu, 8 Nov 2012 17:53:18 +0100
Message-ID: <20121108175318.1b79884f@avionic-0020.adnet.avionic-design.de>
References: <CAHfPSqCnBw1ed97greGdMz-qexWbB2b5_NrbT6FFUeawvygWWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 5 Oct 2012 14:37:01 +0530
Naveen Krishna Ch
<naveenkrishna.ch@gmail.com> wrote:

> Hello All,
> 
> I'm trying to add an ADC driver under IIO/ADC.
> Machine is DT based so, passing the ADC device as tree node and
> consumer devices (thermistors) as child nodes via DT.
> 
> I don't find a frame work to parse the child nodes and probe them like
> I2C does using of/of_i2c.c

Here is my take at DT support in IIO, I wanted to submit that later on
after some more test and cleanup but you can see if it help you.

Alban

>From 15decde13239f09101673b08aa0bd7e67e970b3c Mon Sep 17 00:00:00 2001
From: Alban Bedel <alban.bedel@avionic-design.de>
Date: Thu, 18 Oct 2012 17:07:29 +0200
Subject: [PATCH] IIO: Add basic DT/devm support for in kernel users

Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>
---
 .../devicetree/bindings/iio/iio-channel.txt        |   27 ++++
 drivers/iio/inkern.c                               |  154 ++++++++++++++++++++
 include/linux/iio/consumer.h                       |   63 ++++++++
 3 files changed, 244 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/iio-channel.txt

diff --git a/Documentation/devicetree/bindings/iio/iio-channel.txt b/Documentation/devicetree/bindings/iio/iio-channel.txt
new file mode 100644
index 0000000..dc894f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/iio-channel.txt
@@ -0,0 +1,27 @@
+Specifying IIO channels for devices
+===================================
+
+1) iio-channels property
+------------------------
+
+Nodes that makes use of IIO channels should specify them using one or more
+properties, each containing a iio-channels-list':
+
+	iio-channel-list ::= <single-iio-channel> [iio-channel-list]
+	single-iio-channel ::= <iio-channel-phandle> <iio-channel-specifier>
+	iio-channel-phandle : phandle to iio-channel controller node
+	iio-channel-specifier : Array of #iio-channel-cells specifying
+	                        specific IIO channel (controller specific)
+
+GPIO properties should be named "[<name>-]iio-channels".  Exact
+meaning of each gpios property must be documented in the device tree
+binding for each device.
+
+2) iio device nodes
+------------------------
+
+Every IIO device must have #iio-channel-cells contain the size of the
+iio-channel-specifier.
+
+Currently #iio-channel-cells will always be 1 but this will most
+propably change in the future.
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 6d5194f..5986ef5 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -10,6 +10,7 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 
 #include <linux/iio/iio.h>
 #include "iio_core.h"
@@ -404,3 +405,156 @@ err_unlock:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iio_get_channel_type);
+
+#ifdef CONFIG_OF
+static int of_dev_node_match(struct device *dev, void *data)
+{
+        return dev->parent ? dev->parent->of_node == data : 0;
+}
+
+int __of_get_named_iio_channel(struct iio_channel* channel,
+			       struct device_node *np,
+			       const char *propname,
+			       int index)
+{
+	struct device *dev;
+	struct of_phandle_args ph;
+	struct iio_dev *indio_dev;
+	int ret, channel_id = -1;
+
+	ret = of_parse_phandle_with_args(np, propname, "#iio-channel-cells",
+					 index, &ph);
+	if (ret)
+		return ret;
+
+	dev = bus_find_device(&iio_bus_type, NULL, ph.np,
+			      of_dev_node_match);
+	if (!dev)
+		return -EPROBE_DEFER;
+
+	if (ph.args_count > 0)
+		channel_id = ph.args[0];
+
+	indio_dev = dev_to_iio_dev(dev);
+	if (channel_id < 0 || channel_id >= indio_dev->num_channels)
+		return -EINVAL;
+
+	iio_device_get(indio_dev);
+	channel->indio_dev = indio_dev;
+	channel->channel = &indio_dev->channels[channel_id];
+
+	return 0;
+}
+
+/**
+ * of_get_iio_channel() - get a iio channel from a device tree property
+ * @np:           Device node to get the channel from
+ * @propname:     The property to read
+ * @index:        Index of the channel
+ */
+struct iio_channel* of_get_named_iio_channel(struct device_node *np,
+                                             const char *propname,
+                                             int index)
+{
+	struct iio_channel* channel;
+	int ret;
+
+	channel = kzalloc(sizeof(*channel), GFP_KERNEL);
+	if (!channel)
+		return ERR_PTR(-ENOMEM);
+
+	ret = __of_get_named_iio_channel(channel, np, propname, index);
+	if (ret) {
+		kfree(channel);
+		return ERR_PTR(ret);
+	}
+	return channel;
+}
+
+EXPORT_SYMBOL_GPL(of_get_named_iio_channel);
+
+struct iio_channel* of_get_named_all_iio_channels(struct device_node *np,
+						  const char *propname)
+{
+	int ret, i, cnt;
+	struct iio_channel* channels;
+
+	cnt = of_iio_channel_named_count(np, propname);
+	if (cnt == 0)
+		return NULL;
+
+	channels = kzalloc((cnt+1) * sizeof(*channels), GFP_KERNEL);
+	if (!channels)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0 ; i < cnt ; i += 1) {
+		ret = __of_get_named_iio_channel(&channels[i],
+						 np, propname, i);
+		if (ret)
+			break;
+	}
+
+	if (ret) {
+		for ( ; i >= 0 ; i -= 1)
+			iio_device_put(channels[i].indio_dev);
+		kfree(channels);
+		return ERR_PTR(ret);
+	}
+
+	return channels;
+
+}
+EXPORT_SYMBOL_GPL(of_get_named_all_iio_channels);
+
+unsigned int of_iio_channel_named_count(struct device_node *np,
+					const char *propname)
+{
+        unsigned int cnt = 0;
+
+        do {
+                int ret;
+
+                ret = of_parse_phandle_with_args(np, propname, "#iio-channel-cells",
+                                                 cnt, NULL);
+                /* A hole in the gpios = <> counts anyway. */
+                if (ret < 0 && ret != -EEXIST)
+                        break;
+        } while (++cnt);
+
+        return cnt;
+
+}
+EXPORT_SYMBOL_GPL(of_iio_channel_named_count);
+
+struct iio_channel_devres {
+	struct iio_channel*	channel;
+};
+
+static void devm_iio_channel_release(struct device *dev, void *res)
+{
+	struct iio_channel_devres *dr = res;
+	iio_channel_release(dr->channel);
+}
+
+struct iio_channel* devm_iio_channel_get(struct device* dev, int index)
+{
+	struct iio_channel_devres *dr;
+	struct iio_channel *channel;
+
+	channel = of_get_iio_channel(dev->of_node, index);
+	if (IS_ERR(channel))
+		return channel;
+
+	dr = devres_alloc(devm_iio_channel_release, sizeof(*dr), GFP_KERNEL);
+	if (!dr) {
+		iio_channel_release(channel);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	dr->channel = channel;
+	devres_add(dev, dr);
+	return dr->channel;
+}
+EXPORT_SYMBOL_GPL(devm_iio_channel_get);
+
+#endif
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index e4ff665..e2f958a 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -131,4 +131,67 @@ int iio_read_channel_scale(struct iio_channel *chan, int *val,
 int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
 	int *processed, unsigned int scale);
 
+#ifdef CONFIG_OF
+struct iio_channel* of_get_named_iio_channel(struct device_node *np,
+                                             const char *propname,
+                                             int index);
+
+struct iio_channel* of_get_named_all_iio_channels(struct device_node *np,
+						  const char *propname);
+
+unsigned int of_iio_channel_named_count(struct device_node *np,
+					const char *propname);
+
+#else
+struct iio_channel* of_get_named_iio_channel(struct device_node *np,
+                                             const char *propname,
+                                             int index)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+struct iio_channel* of_get_named_all_iio_channels(struct device_node *np,
+						  const char *propname)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+unsigned int of_iio_channel_named_count(struct device_node *np,
+					const char *propname)
+{
+	return 0;
+}
+#endif
+
+/**
+ * of_get_iio_channel() - get a iio channel from the device tree
+ * @np:           Device node to get the channel from
+ * @index:        Index of the channel
+ */
+static inline struct iio_channel* of_get_iio_channel(struct device_node *np,
+						     int index)
+{
+	return of_get_named_iio_channel(np, "iio-channels", index);
+}
+
+/**
+ * of_get_all_iio_channels() - get a iio channel from the device tree
+ * @np:           Device node to get the channel from
+ */
+static inline struct iio_channel* of_get_all_iio_channels(struct device_node *np)
+{
+	return of_get_named_all_iio_channels(np, "iio-channels");
+}
+
+/**
+ * of_get_iio_channel() - get the number of iio channel from the device tree
+ * @np:           Device node to get the number of channel from
+ */
+static inline unsigned int of_iio_channel_count(struct device_node *np)
+{
+	return of_iio_channel_named_count(np, "iio-channels");
+}
+
+struct iio_channel* devm_iio_channel_get(struct device* dev, int index);
+
 #endif
-- 
1.7.0.4



