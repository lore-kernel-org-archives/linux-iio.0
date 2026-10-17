Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946C2443E2E;
	Sat, 17 Oct 2026 22:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792274832; cv=none; b=jUKw4tRaaLLNRy6jjOY3aLd/t1u5c5CH/FfXB/Hjl2jffmOH6dBZU5ch537NSjQ2D+kj1XUpScZsAGPrXhCg3hl20T3qD8y8yENAL01UmAN1HB8ctBHpSeMU26SHgU1NA4fEcAp014ltNO3IHRZ9pF9WTXjePHAvN9I92Pvxh1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792274832; c=relaxed/simple;
	bh=u7djDthNAKOvvZdx1yNvlpo3AnJ8zjkzRdaOJjaOfBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FYO7lpqvr5ZRGquCqbZt+y/invcbbH35DGAPPiSM6+2TNzwWRMivYzwjmOt4YIXw+7qCrYGkDy36MvyHugorYN+CdDiTG84dYSJT8MlBxtAbW+aAb8gmhGp3XAFMzZG31y8q4yC3yzKfluW277RqHWvIrD62qQLudtIWMKVqXWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNCgOcaY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNCgOcaY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372FE1F000C4;
	Sat, 17 Oct 2026 22:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792274828;
	bh=SGEswVneG/p7i3RIguNmAWLbaTgaj9KDGYhfjt2+nus=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RNCgOcaYQjF4hdtmH4X9RXSB04MwDtlvrDoMxgbEknnUEu4Mk+h76m9NJMgub5dTb
	 zPAixROBMjEygWcOZ2nlsEkdvce29NJ2l5jZ+FbG0m44JG/6recz7TVV5yGCpsefMx
	 /0Zzv60kYTeM0F5XwZr2b4rM9hbMYmPUBNh2UKE+CnVuEIYUFtJ0MkJ83qDawoZ4RM
	 4rroEPZKIztZdnWkB+F4QAk41EqPe7Ys7Vqbmu08pzmCJUllhLFdMEhI5zk5+EE+0x
	 7NPZmi++XBsnvKACnw+uQ+lwGKmme21xijp3DgWsvNbuUPMJp4i98gz6M/Zk79CszL
	 xtxTMPrDKz4zw==
Date: Sat, 17 Oct 2026 23:07:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <krzk+dt@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <Michael.Hennerich@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <conor+dt@kernel.org>
Subject: Re: [PATCH v4 2/2] iio: temperature: add support for Analog Devices
 MAX30210
Message-ID: <20261017230705.678a791c@jic23-hlaptop>
In-Reply-To: <20261015012159.44-3-johnerasmusmari.geronimo@analog.com>
References: <20261015012159.44-1-johnerasmusmari.geronimo@analog.com>
	<20261015012159.44-3-johnerasmusmari.geronimo@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Oct 2026 09:21:59 +0800
John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com> wrote:

> Add support for the Analog Devices MAX30210 I2C temperature
> sensor.
>=20
> The driver uses regmap for register access and integrates with
> the IIO framework. It supports:
>=20
> - Direct mode temperature conversion
> - Configurable sampling frequency
> - Threshold events
> - FIFO operation with IIO kfifo buffer support
> - Optional interrupt-driven data ready signaling
>=20
> The device provides 16-bit signed temperature data and a
> 64-sample FIFO.
>=20
> Signed-off-by: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analo=
g.com>

Josh already pointed out the sashiko feedback so I'll just
assume you'll either fix that or reply with why you disagree.

This is showing up just how bad our event handling infrastructure
is wrt to lifetimes.  Anyhow, I took a look at that and think
the right solution is to just not worry so much about a bit of
expansion in struct iio_dev_opaque and just always embed the
iio_event_interface.

That way we need much simpler ordering guarantee that interrupts
are disable before the iio_dev is freed.  That should always be
the case.

Jonathan

> diff --git a/drivers/iio/temperature/max30210.c b/drivers/iio/temperature=
/max30210.c
> new file mode 100644
> index 0000000000000..04123d51c6da4
> --- /dev/null
> +++ b/drivers/iio/temperature/max30210.c
> @@ -0,0 +1,788 @@

> +
> +/* Keeps the device sampling autonomously while buffer and/or events nee=
d it. */
> +static int max30210_autoconv_get(struct max30210_state *st)
> +{
> +	int ret =3D 0;
> +
> +	guard(mutex)(&st->lock);
> +
> +	if (st->autoconv_users =3D=3D 0)
> +		ret =3D regmap_write(st->regmap, MAX30210_TEMP_CONV_REG,
> +				   MAX30210_TEMPCONV_AUTO | MAX30210_TEMPCONV_CONV_T);
Errors out of line where ever possible.
	if (ret)
		return ret;

	st->autconv_users++;

	return 0;

Though note sashiko raised some concerns around this. I haven't looked
closely at whether it is right that you can increment this for ever.

> +	if (!ret)
> +		st->autoconv_users++;
> +
> +	return ret;
> +}

> +
> +static irqreturn_t max30210_irq_handler(int irq, void *dev_id)
> +{
> +	struct iio_dev *indio_dev =3D dev_id;
> +	struct max30210_state *st =3D iio_priv(indio_dev);
> +	unsigned int status;
> +	int ret;
> +
> +	ret =3D regmap_read(st->regmap, MAX30210_STATUS_REG, &status);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Status read failed\n");
> +		return IRQ_NONE;
> +	}
> +
> +	if (status & MAX30210_STATUS_A_FULL_MASK)
> +		max30210_fifo_read(indio_dev);
> +
> +	if (status & MAX30210_STATUS_TEMP_HI_MASK)
> +		iio_push_event(indio_dev,

So it's this call I assume is the root of the issue with events due
to interrupts in the tear down path.

I think we need to fix the core lifetime issue rather than making
it a driver problem to paper over it.  Note however that drivers
should still be doing what ever is necessary to disable interrupts
at source.  Sometimes that happens naturally due to power down. Other
times you have to register specific cleanup routines to do that.

I'm not sure which is true here.

> +			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_RISING),
> +			       iio_get_time_ns(indio_dev));
> +
> +	if (status & MAX30210_STATUS_TEMP_LO_MASK)
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_FALLING),
> +			       iio_get_time_ns(indio_dev));
> +
> +	return IRQ_HANDLED;
> +}
>

> +
> +static int max30210_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int *val,
> +			     int *val2, long mask)
> +{
> +	struct max30210_state *st =3D iio_priv(indio_dev);
> +	unsigned int uval;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D 5;
> +		*val2 =3D MILLI;
> +
> +		return IIO_VAL_FRACTIONAL;
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		unsigned int period;
> +
> +		ret =3D regmap_read(st->regmap, MAX30210_TEMP_CONF_2_REG, &uval);
> +		if (ret)
> +			return ret;
> +
> +		period =3D FIELD_GET(MAX30210_TEMPCONF2_TEMP_PERIOD_MASK, uval);
> +
> +		/*
> +		 * TEMP_PERIOD is an index into the sampling frequency lookup
> +		 * table. Clamp in case the register holds a reserved value.
> +		 */
> +		if (period >=3D ARRAY_SIZE(max30210_samp_freq_avail))
> +			period =3D ARRAY_SIZE(max30210_samp_freq_avail) - 1;

		period =3D min(period, ARRAY_SIZE(max30210_samp_freq_avail) - 1);

> +
> +		*val =3D max30210_samp_freq_avail[period][0];
> +		*val2 =3D max30210_samp_freq_avail[period][1];
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +	case IIO_CHAN_INFO_RAW: {
> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +
> +		guard(mutex)(&st->lock);
> +
> +		/*
> +		 * TEMP_DATA_REG is only refreshed by a single-shot
> +		 * conversion; the buffer/FIFO path is the only thing that
> +		 * gets updated during AUTO mode. If AUTO is already running
> +		 * for the buffer and/or events, triggering a one-off
> +		 * conversion here would stomp the AUTO bit out from under
> +		 * whoever enabled it, and there is no way to get a fresh
> +		 * single-shot value without doing so -- refuse instead of
> +		 * returning stale data.
> +		 */
> +		if (st->autoconv_users > 0)
> +			return -EBUSY;
> +
> +		ret =3D regmap_write(st->regmap, MAX30210_TEMP_CONV_REG,
> +				   MAX30210_TEMPCONV_CONV_T);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * Wait until CONVERT_T auto-clears.
> +		 * Datasheet:
> +		 *   tBIAS_WU =3D 260 =C2=B5s
> +		 *   tINT     =3D 8 ms
> +		 *
> +		 * Worst-case conversion =E2=89=88 8.26 ms.
> +		 * Use 10 ms timeout for margin.
> +		 */
> +		ret =3D regmap_read_poll_timeout(st->regmap, MAX30210_TEMP_CONV_REG, u=
val,
> +					       !(uval & MAX30210_TEMPCONV_CONV_T),
> +					       500, 10 * USEC_PER_MSEC);
> +		if (ret)
> +			return ret;
> +
> +		return max30210_read_temp(st->regmap, MAX30210_TEMP_DATA_REG, val);
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +static int max30210_probe(struct i2c_client *client)
> +{
> +	struct device *dev =3D &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct max30210_state *st;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +	mutex_init(&st->lock);
For a modern driver we pretty much always do
	ret =3D devm_mutex_init(dev, &st->lock);
	if (ret)
		return ret;

It only brings a bit of extra lock debug but it's simple so why not.

> +
> +	ret =3D devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable vdd regulator.\n");
> +
> +	st->regmap =3D devm_regmap_init_i2c(client, &max30210_regmap);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "Failed to allocate regmap.\n");
> +
> +	st->watermark =3D MAX30210_WATERMARK_DEFAULT;
> +
> +	ret =3D max30210_setup(st, dev);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->channels =3D &max30210_channel;
> +	indio_dev->num_channels =3D 1;
> +	indio_dev->name =3D "max30210";
> +	indio_dev->info =3D &max30210_info;
> +
> +	/* Without an interrupt there is no way to drain the FIFO into the buff=
er */

Maybe stick "currently" in that statement given you can just poll.

> +	if (client->irq) {
> +		ret =3D devm_iio_kfifo_buffer_setup_ext(dev, indio_dev, &max30210_buff=
er_ops,
> +						      max30210_fifo_attributes);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	if (!client->irq)
> +		return 0;
> +
> +	/*
> +	 * Request the IRQ after registering the IIO device so devm tears it
> +	 * down first on removal, before the event interface is freed.

Ok. I can see the logic in this, but I'm not particularly keen on the
position where we have a device up with exposed interfaces, some of which
would expect to generate interrupts, but we don't have interrupt support.

I think it is worth looking at whether we can solve this cleanly in the IIO
core.  As you observe, the issue is that event_interface is allocated
and freed as part of the device_register() on basis we don't need it
if there are no events. That smells to me like a design error (mine
long ago!).   Maybe we should just make it a part of the iio_dev_opaque?
Small amount of bloat as a result but it isn't huge.

That way, it's lifetime matches the device and it will
be around much longer.  Once that is true we can add a flag that indicates
the device is being torn down and short cut dropping events (as by
definition they aren't going anywhere) but not worry if we race
because it should be harmless to carry on using the event interface.

We can't use the info_exist_lock here as the events might be pushed
from an interrupt so fixing this up in similar fashion to the buffer
state management doesn't work.

Note drivers should still be disabling their interrupts at source
even if becomes safer to not do so.

I hacked something up to get an idea of how bad this would be to actually d=
o.
The header dependencies will require yet another header which is a bit anno=
ying
but such is life.  This is build tested only.  If you want to
give it a spin that would be great.  The new header naming needs some more
thought.  At somepoint I should also fix up that iio_opaque is currently
extremely ordering dependent as it doesn't include headers needed
for the stuff it defines.  That was kind of intentional but now perhaps
we need to rethink.

=46rom 6c3ac6b288db7d5840298649d34bf289be2a5a74 Mon Sep 17 00:00:00 2001
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 22:52:57 +0100
Subject: [PATCH] TEMP HACK

Stop allocating the event_interface independently of the device as
it makes for some annoying lifetime issues.

Note that until someone actually attaches to the kfifo no events
get stored anyway.

---
 drivers/iio/iio_core.h           |  8 ++---
 drivers/iio/industrialio-core.c  | 11 +++---
 drivers/iio/industrialio-event.c | 57 ++++++++------------------------
 drivers/iio/inkern.c             |  2 ++
 include/linux/iio/iio-opaque.h   | 28 +++++++++++++++-
 include/linux/iio/iio-types.h    | 14 ++++++++
 6 files changed, 65 insertions(+), 55 deletions(-)

diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 59fa1bd9924b..92fa47f74393 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -12,6 +12,8 @@
 #include <linux/kernel.h>
 #include <linux/device.h>
=20
+#include <linux/iio/iio-types.h>
+
 struct iio_buffer;
 struct iio_chan_spec;
 struct iio_dev;
@@ -24,11 +26,6 @@ struct iio_dev_buffer_pair {
 };
=20
 #define IIO_IOCTL_UNHANDLED	1
-struct iio_ioctl_handler {
-	struct list_head entry;
-	long (*ioctl)(struct iio_dev *indio_dev, struct file *filp,
-		      unsigned int cmd, unsigned long arg);
-};
=20
 void iio_device_ioctl_handler_register(struct iio_dev *indio_dev,
 				       struct iio_ioctl_handler *h);
@@ -61,6 +58,7 @@ ssize_t iio_format_value(char *buf, unsigned int type, in=
t size, int *vals);
=20
 /* Event interface flags */
 #define IIO_BUSY_BIT_POS 1
+#define IIO_EVENTS_PRESENT 2
=20
 #ifdef CONFIG_IIO_BUFFER
 struct poll_table_struct;
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-cor=
e.c
index d73f2541375f..e109bc190716 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -345,13 +345,12 @@ int iio_device_set_clock(struct iio_dev *indio_dev, c=
lockid_t clock_id)
 {
 	int ret;
 	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_dev);
-	const struct iio_event_interface *ev_int =3D iio_dev_opaque->event_interf=
ace;
+	const struct iio_event_interface *ev_int =3D &iio_dev_opaque->event_inter=
face;
=20
 	ret =3D mutex_lock_interruptible(&iio_dev_opaque->mlock);
 	if (ret)
 		return ret;
-	if ((ev_int && iio_event_enabled(ev_int)) ||
-	    iio_buffer_enabled(indio_dev)) {
+	if (iio_event_enabled(ev_int) || iio_buffer_enabled(indio_dev)) {
 		mutex_unlock(&iio_dev_opaque->mlock);
 		return -EBUSY;
 	}
@@ -1640,7 +1639,7 @@ static int iio_device_register_sysfs(struct iio_dev *=
indio_dev)
 			attrcount +=3D ret;
 		}
=20
-	if (iio_dev_opaque->event_interface)
+	if (test_bit(IIO_EVENTS_PRESENT, &iio_dev_opaque->event_interface.flags))
 		clk =3D &dev_attr_current_timestamp_clock.attr;
=20
 	if (indio_dev->name)
@@ -2165,10 +2164,10 @@ int __iio_device_register(struct iio_dev *indio_dev=
, struct module *this_mod)
=20
 	if (iio_dev_opaque->attached_buffers_cnt)
 		cdev_init(&iio_dev_opaque->chrdev, &iio_buffer_fileops);
-	else if (iio_dev_opaque->event_interface)
+	else if (test_bit(IIO_EVENTS_PRESENT, &iio_dev_opaque->event_interface.fl=
ags))
 		cdev_init(&iio_dev_opaque->chrdev, &iio_event_fileops);
=20
-	if (iio_dev_opaque->attached_buffers_cnt || iio_dev_opaque->event_interfa=
ce) {
+	if (iio_dev_opaque->attached_buffers_cnt || test_bit(IIO_EVENTS_PRESENT, =
&iio_dev_opaque->event_interface.flags)) {
 		indio_dev->dev.devt =3D MKDEV(MAJOR(iio_devt), iio_dev_opaque->id);
 		iio_dev_opaque->chrdev.owner =3D this_mod;
 	}
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-ev=
ent.c
index e6730f52262a..5e37af966002 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -23,27 +23,6 @@
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
=20
-/**
- * struct iio_event_interface - chrdev interface for an event line
- * @wait:		wait queue to allow blocking reads of events
- * @det_events:		list of detected events
- * @dev_attr_list:	list of event interface sysfs attribute
- * @flags:		file operations related flags including busy flag.
- * @group:		event interface sysfs attribute group
- * @read_lock:		lock to protect kfifo read operations
- * @ioctl_handler:	handler for event ioctl() calls
- */
-struct iio_event_interface {
-	wait_queue_head_t	wait;
-	DECLARE_KFIFO(det_events, struct iio_event_data, 16);
-
-	struct list_head	dev_attr_list;
-	unsigned long		flags;
-	struct attribute_group	group;
-	struct mutex		read_lock;
-	struct iio_ioctl_handler	ioctl_handler;
-};
-
 bool iio_event_enabled(const struct iio_event_interface *ev_int)
 {
 	return !!test_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
@@ -66,7 +45,7 @@ bool iio_event_enabled(const struct iio_event_interface *=
ev_int)
 int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp)
 {
 	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_dev);
-	struct iio_event_interface *ev_int =3D iio_dev_opaque->event_interface;
+	struct iio_event_interface *ev_int =3D &iio_dev_opaque->event_interface;
 	struct iio_event_data ev;
 	int copied;
=20
@@ -101,7 +80,7 @@ static __poll_t iio_event_poll(struct file *filep,
 {
 	struct iio_dev *indio_dev =3D filep->private_data;
 	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_dev);
-	struct iio_event_interface *ev_int =3D iio_dev_opaque->event_interface;
+	struct iio_event_interface *ev_int =3D &iio_dev_opaque->event_interface;
 	__poll_t events =3D 0;
=20
 	if (!indio_dev->info)
@@ -122,7 +101,7 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
 {
 	struct iio_dev *indio_dev =3D filep->private_data;
 	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_dev);
-	struct iio_event_interface *ev_int =3D iio_dev_opaque->event_interface;
+	struct iio_event_interface *ev_int =3D &iio_dev_opaque->event_interface;
 	unsigned int copied;
 	int ret;
=20
@@ -172,7 +151,7 @@ static int iio_event_chrdev_release(struct inode *inode=
, struct file *filep)
 {
 	struct iio_dev *indio_dev =3D filep->private_data;
 	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_dev);
-	struct iio_event_interface *ev_int =3D iio_dev_opaque->event_interface;
+	struct iio_event_interface *ev_int =3D &iio_dev_opaque->event_interface;
=20
 	clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
=20
@@ -192,7 +171,7 @@ static const struct file_operations iio_event_chrdev_fi=
leops =3D {
 static int iio_event_getfd(struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_dev);
-	struct iio_event_interface *ev_int =3D iio_dev_opaque->event_interface;
+	struct iio_event_interface *ev_int =3D &iio_dev_opaque->event_interface;
 	int fd;
=20
 	if (ev_int =3D=3D NULL)
@@ -422,7 +401,7 @@ static int iio_device_add_event(struct iio_dev *indio_d=
ev,
 		ret =3D __iio_add_chan_devattr(postfix, chan, show, store,
 			 (i << 16) | spec_index, shared_by, &indio_dev->dev,
 			 NULL,
-			&iio_dev_opaque->event_interface->dev_attr_list);
+			&iio_dev_opaque->event_interface.dev_attr_list);
 		kfree(postfix);
=20
 		if ((ret =3D=3D -EBUSY) && (shared_by !=3D IIO_SEPARATE))
@@ -462,7 +441,7 @@ static int iio_device_add_event_label(struct iio_dev *i=
ndio_dev,
=20
 	ret =3D __iio_add_chan_devattr(postfix, chan, &iio_ev_label_show, NULL,
 				spec_index, IIO_SEPARATE, &indio_dev->dev, NULL,
-				&iio_dev_opaque->event_interface->dev_attr_list);
+				&iio_dev_opaque->event_interface.dev_attr_list);
=20
 	kfree(postfix);
=20
@@ -574,7 +553,7 @@ static const char *iio_event_group_name =3D "events";
 int iio_device_register_eventset(struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_dev);
-	struct iio_event_interface *ev_int;
+	struct iio_event_interface *ev_int =3D &iio_dev_opaque->event_interface;
 	struct iio_dev_attr *p;
 	int ret =3D 0, attrcount_orig =3D 0, attrcount, attrn;
 	struct attribute **attr;
@@ -583,12 +562,6 @@ int iio_device_register_eventset(struct iio_dev *indio=
_dev)
 	      iio_check_for_dynamic_events(indio_dev)))
 		return 0;
=20
-	ev_int =3D kzalloc_obj(*ev_int);
-	if (!ev_int)
-		return -ENOMEM;
-
-	iio_dev_opaque->event_interface =3D ev_int;
-
 	INIT_LIST_HEAD(&ev_int->dev_attr_list);
=20
 	iio_setup_ev_int(ev_int);
@@ -625,6 +598,7 @@ int iio_device_register_eventset(struct iio_dev *indio_=
dev)
 	if (ret)
 		goto error_free_group_attrs;
=20
+	__set_bit(IIO_EVENTS_PRESENT, &ev_int->flags);
 	ev_int->ioctl_handler.ioctl =3D iio_event_ioctl;
 	iio_device_ioctl_handler_register(&iio_dev_opaque->indio_dev,
 					  &ev_int->ioctl_handler);
@@ -635,8 +609,6 @@ int iio_device_register_eventset(struct iio_dev *indio_=
dev)
 	kfree(ev_int->group.attrs);
 error_free_setup_event_lines:
 	iio_free_chan_devattr_list(&ev_int->dev_attr_list);
-	kfree(ev_int);
-	iio_dev_opaque->event_interface =3D NULL;
 	return ret;
 }
=20
@@ -650,23 +622,22 @@ int iio_device_register_eventset(struct iio_dev *indi=
o_dev)
 void iio_device_wakeup_eventset(struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_dev);
+	struct iio_event_interface *ev_int =3D &iio_dev_opaque->event_interface;
=20
-	if (iio_dev_opaque->event_interface =3D=3D NULL)
+	if (!test_bit(IIO_EVENTS_PRESENT, &ev_int->flags))
 		return;
-	wake_up(&iio_dev_opaque->event_interface->wait);
+	wake_up(&ev_int->wait);
 }
=20
 void iio_device_unregister_eventset(struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_dev);
-	struct iio_event_interface *ev_int =3D iio_dev_opaque->event_interface;
+	struct iio_event_interface *ev_int =3D &iio_dev_opaque->event_interface;
=20
-	if (ev_int =3D=3D NULL)
+	if (!test_bit(IIO_EVENTS_PRESENT, &ev_int->flags))
 		return;
=20
 	iio_device_ioctl_handler_unregister(&ev_int->ioctl_handler);
 	iio_free_chan_devattr_list(&ev_int->dev_attr_list);
 	kfree(ev_int->group.attrs);
-	kfree(ev_int);
-	iio_dev_opaque->event_interface =3D NULL;
 }
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 1f22275de55c..a97fb9aded8e 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -14,6 +14,8 @@
 #include <linux/units.h>
=20
 #include <linux/iio/iio.h>
+#include <linux/iio/events.h>
+/* ordering matters */
 #include <linux/iio/iio-opaque.h>
 #include "iio_core.h"
 #include <linux/iio/machine.h>
diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index 98330385e08d..91934621326b 100644
--- a/include/linux/iio/iio-opaque.h
+++ b/include/linux/iio/iio-opaque.h
@@ -3,6 +3,32 @@
 #ifndef _INDUSTRIAL_IO_OPAQUE_H_
 #define _INDUSTRIAL_IO_OPAQUE_H_
=20
+
+#include <linux/kfifo.h>
+#include <linux/iio/iio-types.h>
+#include <linux/iio/events.h>
+
+/**
+ * struct iio_event_interface - chrdev interface for an event line
+ * @wait:		wait queue to allow blocking reads of events
+ * @det_events:		list of detected events
+ * @dev_attr_list:	list of event interface sysfs attribute
+ * @flags:		file operations related flags including busy flag.
+ * @group:		event interface sysfs attribute group
+ * @read_lock:		lock to protect kfifo read operations
+ * @ioctl_handler:	handler for event ioctl() calls
+ */
+struct iio_event_interface {
+	wait_queue_head_t	wait;
+	DECLARE_KFIFO(det_events, struct iio_event_data, 16);
+
+	struct list_head	dev_attr_list;
+	unsigned long		flags;
+	struct attribute_group	group;
+	struct mutex		read_lock;
+	struct iio_ioctl_handler	ioctl_handler;
+};
+
 /**
  * struct iio_dev_opaque - industrial I/O device opaque information
  * @indio_dev:			public industrial I/O device information
@@ -42,6 +68,7 @@
  */
 struct iio_dev_opaque {
 	struct iio_dev			indio_dev;
+	struct iio_event_interface	event_interface;
 	int				currentmode;
 	int				id;
 	struct module			*driver_module;
@@ -50,7 +77,6 @@ struct iio_dev_opaque {
 	struct mutex			info_exist_lock;
 	struct lock_class_key		info_exist_key;
 	bool				trig_readonly;
-	struct iio_event_interface	*event_interface;
 	struct iio_buffer		**attached_buffers;
 	unsigned int			attached_buffers_cnt;
 	struct iio_ioctl_handler	*buffer_ioctl_handler;
diff --git a/include/linux/iio/iio-types.h b/include/linux/iio/iio-types.h
new file mode 100644
index 000000000000..b18a1f29a936
--- /dev/null
+++ b/include/linux/iio/iio-types.h
@@ -0,0 +1,14 @@
+#ifndef _IIO_INTERNAL_TYPES_H_
+#define  _IIO_INTERNAL_TYPES_H_
+#include <linux/list.h>
+
+struct iio_dev;
+struct file;
+
+struct iio_ioctl_handler {
+	struct list_head entry;
+	long (*ioctl)(struct iio_dev *indio_dev, struct file *filp,
+		      unsigned int cmd, unsigned long arg);
+};
+
+#endif /* _IIO_INTERNAL_TYPES_H_ */
--=20
2.56.0




> +	 */
> +	return devm_request_threaded_irq(dev, client->irq, NULL,
> +					 max30210_irq_handler, IRQF_ONESHOT,
> +					 indio_dev->name, indio_dev);
> +}

