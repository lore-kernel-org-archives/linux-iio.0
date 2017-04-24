Return-Path: <SRS0=J3Le=4A=axentia.se=peda@kernel.org>
Subject: Re: [PATCH v14 00/11] mux controller abstraction and iio/i2c muxes
To: Philipp Zabel <p.zabel@pengutronix.de>
References: <1493022995-16917-1-git-send-email-peda@axentia.se>
 <1493031179.2446.9.camel@pengutronix.de>
 <2d978956-d247-917d-4150-a6723917a733@axentia.se>
 <1493043046.2446.37.camel@pengutronix.de>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-kernel@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Wolfram Sang <wsa@the-dreams.de>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>, Jonathan Corbet <corbet@lwn.net>,
	<linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Colin Ian King <colin.king@canonical.com>, Paul
 Gortmaker <paul.gortmaker@windriver.com>, <kernel@pengutronix.de>
From: Peter Rosin <peda@axentia.se>
Message-ID: <6fb34ea5-edc8-c7aa-1d49-f6ce1d33a2d4@axentia.se>
Date: Mon, 24 Apr 2017 16:36:50 +0200
MIME-Version: 1.0
In-Reply-To: <1493043046.2446.37.camel@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

On 2017-04-24 16:10, Philipp Zabel wrote:
> On Mon, 2017-04-24 at 13:37 +0200, Peter Rosin wrote:
>> On 2017-04-24 12:52, Philipp Zabel wrote:
>>> On Mon, 2017-04-24 at 10:36 +0200, Peter Rosin wrote:
>>>> Hi!
>>>>
>>>> The big change since v13 is that the mux state is now locked with a mutex
>>>> instead of an rwsem. Other that that, it is mostly restructuring and doc
>>>> changes. There are a few other "real" changes as well, but those changes
>>>> feel kind of minor. I guess what I'm trying to say is that although the
>>>> list of changes for v14 is longish, it's still basically the same as last
>>>> time.
>>>
>>> I have hooked this up to the video-multiplexer and now I trigger
>>> the lockdep debug_check_no_locks_held error message when selecting the
>>> mux input from userspace:
>>>
>>> $ media-ctl --links "'imx6-mipi-csi2':1->'ipu1_csi0_mux':0[1]"
>>> [   66.258368] 
>>> [   66.259919] =====================================
>>> [   66.265369] [ BUG: media-ctl/258 still has locks held! ]
>>> [   66.270810] 4.11.0-rc8-20170424-1+ #1305 Not tainted
>>> [   66.275863] -------------------------------------
>>> [   66.282158] 1 lock held by media-ctl/258:
>>> [   66.286464]  #0:  (&mux->lock){+.+.+.}, at: [<8074a6c0>] mux_control_select+0x24/0x50
>>> [   66.294424] 
>>> [   66.294424] stack backtrace:
>>> [   66.298980] CPU: 0 PID: 258 Comm: media-ctl Not tainted 4.11.0-rc8+ #1305
>>> [   66.306771] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
>>> [   66.313334] Backtrace: 
>>> [   66.315858] [<8010e5a4>] (dump_backtrace) from [<8010e8ac>] (show_stack+0x20/0x24)
>>> [   66.323473]  r7:80e518d0 r6:80e518d0 r5:600d0013 r4:00000000
>>> [   66.329190] [<8010e88c>] (show_stack) from [<80496cf4>] (dump_stack+0xb0/0xdc)
>>> [   66.336470] [<80496c44>] (dump_stack) from [<8017e404>] (debug_check_no_locks_held+0xb8/0xbc)
>>> [   66.345043]  r9:ae8566b8 r8:ad88dc84 r7:ad88df58 r6:ad88dc84 r5:ad88df58 r4:ae856400
>>> [   66.352837] [<8017e34c>] (debug_check_no_locks_held) from [<8012b258>] (do_exit+0x79c/0xcc8)
>>> [   66.361321] [<8012aabc>] (do_exit) from [<8012d25c>] (do_group_exit+0x4c/0xcc)
>>> [   66.368581]  r7:000000f8
>>> [   66.371161] [<8012d210>] (do_group_exit) from [<8012d2fc>] (__wake_up_parent+0x0/0x30)
>>> [   66.379120]  r7:000000f8 r6:76f71798 r5:00000000 r4:00000001
>>> [   66.384837] [<8012d2dc>] (SyS_exit_group) from [<80109380>] (ret_fast_syscall+0x0/0x1c)
>>>
>>> That correctly warns that the media-ctl process caused the mux->lock to
>>> be locked and still held when the process exited. Do we need a usage
>>> counter based mechanism for muxes that are (indirectly) controlled from
>>> userspace?
> [...]
>> The question then becomes how to best tell the mux core that you want
>> an exclusive mux. I see two options. Either you declare a mux controller
>> as exclusive up front somehow (in the device tree presumably), or you
>> add a mux_control_get_exclusive call that makes further calls to
>> mux_control_get{,_exclusive} fail with -EBUSY. I think I like the
>> latter better, if that can be made to work...
> 
> How about an atomic use_count on the mux_control, a bool shared that is
> only set by the first consumer, and controls whether selecting locks?

That has the drawback that it is hard to restore the mux-control in a safe
way so that exclusive consumers are allowed after the last shared consumer
puts the mux away. Agreed, it's a corner case, but I had this very similar
patch going through the compiler when I got this mail. Does it work as well
as what you suggested?

Cheers,
peda

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index e2343d9cbec7..5a7352a83124 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -342,7 +342,8 @@ MUX
   devm_mux_chip_free()
   devm_mux_chip_register()
   devm_mux_chip_unregister()
-  devm_mux_control_get()
+  devm_mux_control_get_shared()
+  devm_mux_control_get_exclusive()
   devm_mux_control_put()
 
 PER-CPU MEM
diff --git a/drivers/i2c/muxes/i2c-mux-gpmux.c b/drivers/i2c/muxes/i2c-mux-gpmux.c
index 92cf5f48afe6..135d6baaebe5 100644
--- a/drivers/i2c/muxes/i2c-mux-gpmux.c
+++ b/drivers/i2c/muxes/i2c-mux-gpmux.c
@@ -87,7 +87,7 @@ static int i2c_mux_probe(struct platform_device *pdev)
 	if (!mux)
 		return -ENOMEM;
 
-	mux->control = devm_mux_control_get(dev, NULL);
+	mux->control = devm_mux_control_get_shared(dev, NULL);
 	if (IS_ERR(mux->control)) {
 		if (PTR_ERR(mux->control) != -EPROBE_DEFER)
 			dev_err(dev, "failed to get control-mux\n");
diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
index 37ba007f8dca..fc41e9d10737 100644
--- a/drivers/iio/multiplexer/iio-mux.c
+++ b/drivers/iio/multiplexer/iio-mux.c
@@ -413,7 +413,7 @@ static int mux_probe(struct platform_device *pdev)
 		}
 	}
 
-	mux->control = devm_mux_control_get(dev, NULL);
+	mux->control = devm_mux_control_get_shared(dev, NULL);
 	if (IS_ERR(mux->control)) {
 		if (PTR_ERR(mux->control) != -EPROBE_DEFER)
 			dev_err(dev, "failed to get control-mux\n");
diff --git a/drivers/mux/mux-core.c b/drivers/mux/mux-core.c
index c02fa4dd2d09..6055e7c3ad1c 100644
--- a/drivers/mux/mux-core.c
+++ b/drivers/mux/mux-core.c
@@ -37,6 +37,7 @@ static struct class mux_class = {
 };
 
 static DEFINE_IDA(mux_ida);
+static DEFINE_MUTEX(mux_lock);
 
 static int __init mux_init(void)
 {
@@ -333,7 +334,8 @@ unsigned int mux_control_states(struct mux_control *mux)
 EXPORT_SYMBOL_GPL(mux_control_states);
 
 /*
- * The mux->lock must be held when calling this function.
+ * The mux->lock must be held when calling this function if the
+ * mux-control is shared.
  */
 static int __mux_control_select(struct mux_control *mux, int state)
 {
@@ -372,11 +374,12 @@ int mux_control_select(struct mux_control *mux, unsigned int state)
 {
 	int ret;
 
-	mutex_lock(&mux->lock);
+	if (mux->shared >= 0)
+		mutex_lock(&mux->lock);
 
 	ret = __mux_control_select(mux, state);
 
-	if (ret < 0)
+	if (ret < 0 && mux->shared >= 0)
 		mutex_unlock(&mux->lock);
 
 	return ret;
@@ -399,12 +402,12 @@ int mux_control_try_select(struct mux_control *mux, unsigned int state)
 {
 	int ret;
 
-	if (!mutex_trylock(&mux->lock))
+	if (mux->shared >= 0 && !mutex_trylock(&mux->lock))
 		return -EBUSY;
 
 	ret = __mux_control_select(mux, state);
 
-	if (ret < 0)
+	if (ret < 0 && mux->shared >= 0)
 		mutex_unlock(&mux->lock);
 
 	return ret;
@@ -427,7 +430,8 @@ int mux_control_deselect(struct mux_control *mux)
 	    mux->idle_state != mux->cached_state)
 		ret = mux_control_set(mux, mux->idle_state);
 
-	mutex_unlock(&mux->lock);
+	if (mux->shared >= 0)
+		mutex_unlock(&mux->lock);
 
 	return ret;
 }
@@ -447,18 +451,13 @@ static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
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
+struct mux_control *__mux_control_get(struct device *dev, const char *mux_name,
+	bool shared)
 {
 	struct device_node *np = dev->of_node;
 	struct of_phandle_args args;
 	struct mux_chip *mux_chip;
+	struct mux_control *mux;
 	unsigned int controller;
 	int index = 0;
 	int ret;
@@ -504,10 +503,20 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
 		return ERR_PTR(-EINVAL);
 	}
 
+	mux = &mux_chip->mux[controller];
+
+	mutex_lock(&mux_lock);
+	if (WARN_ON(mux->shared < 0 || (!shared && mux->shared))) {
+		mutex_unlock(&mux_lock);
+		return ERR_PTR(-EBUSY);
+	}
+	mux->shared = shared ? mux->shared + 1 : -1;
+	mutex_unlock(&mux_lock);
+
 	get_device(&mux_chip->dev);
-	return &mux_chip->mux[controller];
+	return mux;
 }
-EXPORT_SYMBOL_GPL(mux_control_get);
+EXPORT_SYMBOL_GPL(__mux_control_get);
 
 /**
  * mux_control_put() - Put away the mux-control for good.
@@ -517,6 +526,14 @@ EXPORT_SYMBOL_GPL(mux_control_get);
  */
 void mux_control_put(struct mux_control *mux)
 {
+	mutex_lock(&mux_lock);
+	WARN_ON(!mux->shared);
+	if (mux->shared > 0)
+		--mux->shared;
+	else
+		mux->shared = 0;
+	mutex_unlock(&mux_lock);
+
 	put_device(&mux->chip->dev);
 }
 EXPORT_SYMBOL_GPL(mux_control_put);
@@ -528,16 +545,9 @@ static void devm_mux_control_release(struct device *dev, void *res)
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
+struct mux_control *__devm_mux_control_get(struct device *dev,
+					   const char *mux_name,
+					   bool shared)
 {
 	struct mux_control **ptr, *mux;
 
@@ -545,7 +555,7 @@ struct mux_control *devm_mux_control_get(struct device *dev,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	mux = mux_control_get(dev, mux_name);
+	mux = __mux_control_get(dev, mux_name, shared);
 	if (IS_ERR(mux)) {
 		devres_free(ptr);
 		return mux;
@@ -556,7 +566,7 @@ struct mux_control *devm_mux_control_get(struct device *dev,
 
 	return mux;
 }
-EXPORT_SYMBOL_GPL(devm_mux_control_get);
+EXPORT_SYMBOL_GPL(__devm_mux_control_get);
 
 static int devm_mux_control_match(struct device *dev, void *res, void *data)
 {
diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
index a2a61834bd3a..611dcec7fa3a 100644
--- a/include/linux/mux/consumer.h
+++ b/include/linux/mux/consumer.h
@@ -23,11 +23,81 @@ int __must_check mux_control_try_select(struct mux_control *mux,
 					unsigned int state);
 int mux_control_deselect(struct mux_control *mux);
 
-struct mux_control *mux_control_get(struct device *dev, const char *mux_name);
+struct mux_control *__mux_control_get(struct device *dev,
+				      const char *mux_name, bool shared);
 void mux_control_put(struct mux_control *mux);
-
-struct mux_control *devm_mux_control_get(struct device *dev,
-					 const char *mux_name);
+struct mux_control *__devm_mux_control_get(struct device *dev,
+					   const char *mux_name, bool shared);
 void devm_mux_control_put(struct device *dev, struct mux_control *mux);
 
+/**
+ * mux_control_get_shared() - Get the mux-control for a device.
+ * @dev: The device that needs a mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * A shared mux-control can be operated by several independent consumers.
+ * The mux core will coordinate access by grabbing a lock when the mux-control
+ * is selected and releasing it when it is deselected.
+ *
+ * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
+ */
+static inline struct mux_control *mux_control_get_shared(
+					struct device *dev,
+					const char *mux_name)
+{
+	return __mux_control_get(dev, mux_name, true);
+}
+
+/**
+ * mux_control_get_exclusive() - Get the mux-control for a device.
+ * @dev: The device that needs a mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * An exclusive mux-control can only be operated by a single consumer. The
+ * mux core will return EBUSY for any further attempts to get a mux-control
+ * that already has an exclusive consumer. The mux core will also not lock
+ * the mux-control on mux_control_select, and the consumer is free to call
+ * repeatedly call select without calling mux_control_deselect. The consumer
+ * may however still call mux_control_deselect in order to activate the idle
+ * state.
+ *
+ * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
+ */
+static inline struct mux_control *mux_control_get_exclusive(
+					struct device *dev,
+					const char *mux_name)
+{
+	return __mux_control_get(dev, mux_name, false);
+}
+
+/**
+ * devm_mux_control_get_shared() - Get a shared mux-control for a device, with
+ *				   resource management.
+ * @dev: The device that needs a mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * Return: Pointer to the mux-control, or an ERR_PTR with a negative errno.
+ */
+static inline struct mux_control *devm_mux_control_get_shared(
+					struct device *dev,
+					const char *mux_name)
+{
+	return __devm_mux_control_get(dev, mux_name, true);
+}
+
+/**
+ * devm_mux_control_get_exclusive() - Get an exclusive mux-control for a
+ *				      device, with resource management.
+ * @dev: The device that needs a mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * Return: Pointer to the mux-control, or an ERR_PTR with a negative errno.
+ */
+static inline struct mux_control *devm_mux_control_get_exclusive(
+					struct device *dev,
+					const char *mux_name)
+{
+	return __devm_mux_control_get(dev, mux_name, false);
+}
+
 #endif /* _LINUX_MUX_CONSUMER_H */
diff --git a/include/linux/mux/driver.h b/include/linux/mux/driver.h
index 95269f40670a..882e9be3d185 100644
--- a/include/linux/mux/driver.h
+++ b/include/linux/mux/driver.h
@@ -33,6 +33,8 @@ struct mux_control_ops {
  * struct mux_control -	Represents a mux controller.
  * @lock:		Protects the mux controller state.
  * @chip:		The mux chip that is handling this mux controller.
+ * @shared:		The shared state, -1 if exclusive, 0 if no consumer
+ *			and if positive the number of sharing consumers.
  * @cached_state:	The current mux controller state, or -1 if none.
  * @states:		The number of mux controller states.
  * @idle_state:		The mux controller state to use when inactive, or one
@@ -40,13 +42,14 @@ struct mux_control_ops {
  *
  * Mux drivers may only change @states and @idle_state, and may only do so
  * between allocation and registration of the mux controller. Specifically,
- * @cached_state is internal to the mux core and should never be written by
- * mux drivers.
+ * @cached_state and @shared are internal to the mux core and should never be
+ * written by mux drivers.
  */
 struct mux_control {
 	struct mutex lock; /* protects the state of the mux */
 
 	struct mux_chip *chip;
+	int shared;
 	int cached_state;
 
 	unsigned int states;
