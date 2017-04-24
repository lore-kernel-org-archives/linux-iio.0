Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37163 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1172164AbdDXOLM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Apr 2017 10:11:12 -0400
Message-ID: <1493043046.2446.37.camel@pengutronix.de>
Subject: Re: [PATCH v14 00/11] mux controller abstraction and iio/i2c muxes
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Peter Rosin <peda@axentia.se>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        kernel@pengutronix.de
Date: Mon, 24 Apr 2017 16:10:46 +0200
In-Reply-To: <2d978956-d247-917d-4150-a6723917a733@axentia.se>
References: <1493022995-16917-1-git-send-email-peda@axentia.se>
         <1493031179.2446.9.camel@pengutronix.de>
         <2d978956-d247-917d-4150-a6723917a733@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 2017-04-24 at 13:37 +0200, Peter Rosin wrote:
> On 2017-04-24 12:52, Philipp Zabel wrote:
> > On Mon, 2017-04-24 at 10:36 +0200, Peter Rosin wrote:
> >> Hi!
> >>
> >> The big change since v13 is that the mux state is now locked with a mutex
> >> instead of an rwsem. Other that that, it is mostly restructuring and doc
> >> changes. There are a few other "real" changes as well, but those changes
> >> feel kind of minor. I guess what I'm trying to say is that although the
> >> list of changes for v14 is longish, it's still basically the same as last
> >> time.
> > 
> > I have hooked this up to the video-multiplexer and now I trigger
> > the lockdep debug_check_no_locks_held error message when selecting the
> > mux input from userspace:
> > 
> > $ media-ctl --links "'imx6-mipi-csi2':1->'ipu1_csi0_mux':0[1]"
> > [   66.258368] 
> > [   66.259919] =====================================
> > [   66.265369] [ BUG: media-ctl/258 still has locks held! ]
> > [   66.270810] 4.11.0-rc8-20170424-1+ #1305 Not tainted
> > [   66.275863] -------------------------------------
> > [   66.282158] 1 lock held by media-ctl/258:
> > [   66.286464]  #0:  (&mux->lock){+.+.+.}, at: [<8074a6c0>] mux_control_select+0x24/0x50
> > [   66.294424] 
> > [   66.294424] stack backtrace:
> > [   66.298980] CPU: 0 PID: 258 Comm: media-ctl Not tainted 4.11.0-rc8+ #1305
> > [   66.306771] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> > [   66.313334] Backtrace: 
> > [   66.315858] [<8010e5a4>] (dump_backtrace) from [<8010e8ac>] (show_stack+0x20/0x24)
> > [   66.323473]  r7:80e518d0 r6:80e518d0 r5:600d0013 r4:00000000
> > [   66.329190] [<8010e88c>] (show_stack) from [<80496cf4>] (dump_stack+0xb0/0xdc)
> > [   66.336470] [<80496c44>] (dump_stack) from [<8017e404>] (debug_check_no_locks_held+0xb8/0xbc)
> > [   66.345043]  r9:ae8566b8 r8:ad88dc84 r7:ad88df58 r6:ad88dc84 r5:ad88df58 r4:ae856400
> > [   66.352837] [<8017e34c>] (debug_check_no_locks_held) from [<8012b258>] (do_exit+0x79c/0xcc8)
> > [   66.361321] [<8012aabc>] (do_exit) from [<8012d25c>] (do_group_exit+0x4c/0xcc)
> > [   66.368581]  r7:000000f8
> > [   66.371161] [<8012d210>] (do_group_exit) from [<8012d2fc>] (__wake_up_parent+0x0/0x30)
> > [   66.379120]  r7:000000f8 r6:76f71798 r5:00000000 r4:00000001
> > [   66.384837] [<8012d2dc>] (SyS_exit_group) from [<80109380>] (ret_fast_syscall+0x0/0x1c)
> > 
> > That correctly warns that the media-ctl process caused the mux->lock to
> > be locked and still held when the process exited. Do we need a usage
> > counter based mechanism for muxes that are (indirectly) controlled from
> > userspace?
[...]
> The question then becomes how to best tell the mux core that you want
> an exclusive mux. I see two options. Either you declare a mux controller
> as exclusive up front somehow (in the device tree presumably), or you
> add a mux_control_get_exclusive call that makes further calls to
> mux_control_get{,_exclusive} fail with -EBUSY. I think I like the
> latter better, if that can be made to work...

How about an atomic use_count on the mux_control, a bool shared that is
only set by the first consumer, and controls whether selecting locks?

----------8<----------
diff --git a/drivers/mux/mux-core.c b/drivers/mux/mux-core.c
index c02fa4dd2d099..1d18bb7f15e07 100644
--- a/drivers/mux/mux-core.c
+++ b/drivers/mux/mux-core.c
@@ -372,11 +372,12 @@ int mux_control_select(struct mux_control *mux, unsigned int state)
 {
 	int ret;
 
-	mutex_lock(&mux->lock);
+	if (mux->shared)
+		mutex_lock(&mux->lock);
 
 	ret = __mux_control_select(mux, state);
 
-	if (ret < 0)
+	if (ret < 0 && mux->shared)
 		mutex_unlock(&mux->lock);
 
 	return ret;
@@ -399,12 +400,12 @@ int mux_control_try_select(struct mux_control *mux, unsigned int state)
 {
 	int ret;
 
-	if (!mutex_trylock(&mux->lock))
+	if (mux->shared && !mutex_trylock(&mux->lock))
 		return -EBUSY;
 
 	ret = __mux_control_select(mux, state);
 
-	if (ret < 0)
+	if (ret < 0 && mux->shared)
 		mutex_unlock(&mux->lock);
 
 	return ret;
@@ -427,7 +428,8 @@ int mux_control_deselect(struct mux_control *mux)
 	    mux->idle_state != mux->cached_state)
 		ret = mux_control_set(mux, mux->idle_state);
 
-	mutex_unlock(&mux->lock);
+	if (mux->shared)
+		mutex_unlock(&mux->lock);
 
 	return ret;
 }
@@ -447,18 +449,13 @@ static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
 	return dev ? to_mux_chip(dev) : NULL;
 }
 
-/**
- * mux_control_get() - Get the mux-control for a device.
- * @dev: The device that needs a mux-control.
- * @mux_name: The name identifying the mux-control.
- *
- * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
- */
-struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
+static struct mux_control *__mux_control_get(struct device *dev,
+					     const char *mux_name, bool shared)
 {
 	struct device_node *np = dev->of_node;
 	struct of_phandle_args args;
 	struct mux_chip *mux_chip;
+	struct mux_control *mux;
 	unsigned int controller;
 	int index = 0;
 	int ret;
@@ -505,9 +502,56 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
 	}
 
 	get_device(&mux_chip->dev);
-	return &mux_chip->mux[controller];
+
+	mux = &mux_chip->mux[controller];
+
+	ret = atomic_inc_return(&mux->use_count);
+	if (ret == 1 && shared)
+		mux->shared = true;
+	if (ret > 1 && (!shared || !mux->shared)) {
+		atomic_dec(&mux->use_count);
+		put_device(&mux_chip->dev);
+		return ERR_PTR(-EBUSY);
+	}
+
+	return mux;
+}
+
+/**
+ * mux_control_get_shared() - Get the mux-control for a device.
+ * @dev: The device that needs a mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * The returned mux control is in shared mode and can not be controlled from
+ * userspace. The mux control lock is taken when the mux is selected and
+ * released when the mux is deselected.
+ *
+ * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
+ */
+struct mux_control *mux_control_get_shared(struct device *dev,
+					   const char *mux_name)
+{
+	return __mux_control_get(dev, mux_name, true);
+}
+EXPORT_SYMBOL_GPL(mux_control_get_shared);
+
+/**
+ * mux_control_get_exclusive() - Get the mux-control for a device.
+ * @dev: The device that needs a mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * The returned mux control is in exclusive mode and does not lock the mux
+ * control lock when the mux is selected. The exclusive consumer has to take
+ * care of locking, if necessary.
+ *
+ * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
+ */
+struct mux_control *mux_control_get_exclusive(struct device *dev,
+					      const char *mux_name)
+{
+	return __mux_control_get(dev, mux_name, false);
 }
-EXPORT_SYMBOL_GPL(mux_control_get);
+EXPORT_SYMBOL_GPL(mux_control_get_exclusive);
 
 /**
  * mux_control_put() - Put away the mux-control for good.
@@ -517,6 +561,7 @@ EXPORT_SYMBOL_GPL(mux_control_get);
  */
 void mux_control_put(struct mux_control *mux)
 {
+	atomic_dec(&mux->use_count);
 	put_device(&mux->chip->dev);
 }
 EXPORT_SYMBOL_GPL(mux_control_put);
@@ -528,16 +573,9 @@ static void devm_mux_control_release(struct device *dev, void *res)
 	mux_control_put(mux);
 }
 
-/**
- * devm_mux_control_get() - Get the mux-control for a device, with resource
- *			    management.
- * @dev: The device that needs a mux-control.
- * @mux_name: The name identifying the mux-control.
- *
- * Return: Pointer to the mux-control, or an ERR_PTR with a negative errno.
- */
-struct mux_control *devm_mux_control_get(struct device *dev,
-					 const char *mux_name)
+static struct mux_control *__devm_mux_control_get(struct device *dev,
+						  const char *mux_name,
+						  bool shared)
 {
 	struct mux_control **ptr, *mux;
 
@@ -545,7 +583,7 @@ struct mux_control *devm_mux_control_get(struct device *dev,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	mux = mux_control_get(dev, mux_name);
+	mux = __mux_control_get(dev, mux_name, shared);
 	if (IS_ERR(mux)) {
 		devres_free(ptr);
 		return mux;
@@ -556,7 +594,36 @@ struct mux_control *devm_mux_control_get(struct device *dev,
 
 	return mux;
 }
-EXPORT_SYMBOL_GPL(devm_mux_control_get);
+
+/**
+ * devm_mux_control_get_shared() - Get the mux-control for a device, with
+ *				   resource management.
+ * @dev: The device that needs a mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * Return: Pointer to the mux-control, or an ERR_PTR with a negative errno.
+ */
+struct mux_control *devm_mux_control_get_shared(struct device *dev,
+						const char *mux_name)
+{
+	return __devm_mux_control_get(dev, mux_name, true);
+}
+EXPORT_SYMBOL_GPL(devm_mux_control_get_shared);
+
+/**
+ * devm_mux_control_get_exclusive() - Get the mux-control for a device, with
+ *				      resource management.
+ * @dev: The device that needs a mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * Return: Pointer to the mux-control, or an ERR_PTR with a negative errno.
+ */
+struct mux_control *devm_mux_control_get_exclusive(struct device *dev,
+						   const char *mux_name)
+{
+	return __devm_mux_control_get(dev, mux_name, false);
+}
+EXPORT_SYMBOL_GPL(devm_mux_control_get_exclusive);
 
 static int devm_mux_control_match(struct device *dev, void *res, void *data)
 {
diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
index a2a61834bd3ae..26634c3dda124 100644
--- a/include/linux/mux/consumer.h
+++ b/include/linux/mux/consumer.h
@@ -23,11 +23,16 @@ int __must_check mux_control_try_select(struct mux_control *mux,
 					unsigned int state);
 int mux_control_deselect(struct mux_control *mux);
 
-struct mux_control *mux_control_get(struct device *dev, const char *mux_name);
+struct mux_control *mux_control_get_exclusive(struct device *dev,
+					      const char *mux_name);
+struct mux_control *mux_control_get_shared(struct device *dev,
+					   const char *mux_name);
 void mux_control_put(struct mux_control *mux);
 
-struct mux_control *devm_mux_control_get(struct device *dev,
-					 const char *mux_name);
+struct mux_control *devm_mux_control_get_exclusive(struct device *dev,
+						   const char *mux_name);
+struct mux_control *devm_mux_control_get_shared(struct device *dev,
+						const char *mux_name);
 void devm_mux_control_put(struct device *dev, struct mux_control *mux);
 
 #endif /* _LINUX_MUX_CONSUMER_H */
diff --git a/include/linux/mux/driver.h b/include/linux/mux/driver.h
index 95269f40670a7..0ac5d3db9cd3e 100644
--- a/include/linux/mux/driver.h
+++ b/include/linux/mux/driver.h
@@ -31,17 +31,20 @@ struct mux_control_ops {
 
 /**
  * struct mux_control -	Represents a mux controller.
- * @lock:		Protects the mux controller state.
+ * @lock:		Protects the mux controller state, if shared.
  * @chip:		The mux chip that is handling this mux controller.
  * @cached_state:	The current mux controller state, or -1 if none.
  * @states:		The number of mux controller states.
  * @idle_state:		The mux controller state to use when inactive, or one
  *			of MUX_IDLE_AS_IS and MUX_IDLE_DISCONNECT.
+ * @use_count:		Number of consumers that have requested this mux.
+ * @shared:		True if the mux control was requested as shared and
+ *			must therefore be locked.
  *
  * Mux drivers may only change @states and @idle_state, and may only do so
  * between allocation and registration of the mux controller. Specifically,
- * @cached_state is internal to the mux core and should never be written by
- * mux drivers.
+ * @cached_state, @use_count, and @shared are internal to the mux core and
+ * should never be written by mux drivers.
  */
 struct mux_control {
 	struct mutex lock; /* protects the state of the mux */
@@ -51,6 +54,9 @@ struct mux_control {
 
 	unsigned int states;
 	int idle_state;
+
+	atomic_t use_count;
+	bool shared;
 };
 
 /**
---------->8----------

regards
Philipp

