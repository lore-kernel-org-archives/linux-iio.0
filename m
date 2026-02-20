Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD5E15ADB4
	for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771581982; cv=none; b=jYT3fx/9SARTkZM3vkl7HAtVD56h8CEr0g07gZpif7jZ2wWgtsEKQiu25P2bFGJnaf1zj8N832DVzuDVN429xYlfGAvXxjuxeLpfvuUeHCKxy1D5dH6kL2F5cUVG2trzYexeOiPldEaRFL4ohW8D+yUKmIwCxM+1VsNm8Thegio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771581982; c=relaxed/simple;
	bh=r/IRE/DqQUOzqIOET1LhWVvt7uKtLj2VQPom1twtyaI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbdQOZh9MJnAcPw55o0IhdJ+qEqBFQNwZHIB/D/HKfwlauhkhynY+natMeFb9D7j7+D6ixZo15nf/0Ps+fiCLYU0kkEZlBY1Y3XfAmDrk9qv3gR2MdIPkm/LafrFcHaOnenuoAVCHaXpNubvpZmKJuowTQbD/t8flUxchZQWF68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJ1GWGWk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJ1GWGWk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECEDC116C6;
	Fri, 20 Feb 2026 10:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771581982;
	bh=r/IRE/DqQUOzqIOET1LhWVvt7uKtLj2VQPom1twtyaI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mJ1GWGWkGVfi6JZtFTJUBbmgpQUl8tIxu99KOP3SixBek4tJtVpSxP8Jj4aw8dlFq
	 H+Y0cMy38qJ6bXs+PY1nChJzj3ZcQyfR6Bdsx/QU+tRsPr47Zu7EE4V6EO63ri5G6Y
	 viQ5H5Gr6a0cX/scwd/bvlwY2c5y6HfwjJHzDuG7Zjlib9Uo+UzPjhiiSSb7ciXZxs
	 GpTIJceOCkvL2zYu8s+AWOYaCDjWxLFbW/V0Ge2AW0Ck+qX9cBgJO0l14qiG3A3OdR
	 dLa6KR5g7WyuDwzSeylHT0YdM2I+5Ahxa0PIP8EqweiPb3UmW8I4xTdlBzwWxMKu1F
	 t7l51eZQ3Kf+g==
Date: Fri, 20 Feb 2026 10:06:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, bigeasy@linutronix.de, spasswolf@web.de
Subject: Re: [RFC PATCH] iio: hid-sensors: Use software trigger
Message-ID: <20260220100611.5ebc8ffa@jic23-huawei>
In-Reply-To: <80fb81d12db88a31ed6f30fc2268651458972abb.camel@linux.intel.com>
References: <20260209204227.1352304-1-srinivas.pandruvada@linux.intel.com>
	<20260214181612.20b37528@jic23-huawei>
	<0b2d8e0a73a7e57a37d9886374f2b3cb984b03d3.camel@linux.intel.com>
	<20260218191334.6da65747@jic23-huawei>
	<80fb81d12db88a31ed6f30fc2268651458972abb.camel@linux.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Feb 2026 15:47:09 -0800
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Wed, 2026-02-18 at 19:13 +0000, Jonathan Cameron wrote:
> > On Mon, 16 Feb 2026 14:49:38 -0800
> > srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> >  =20
> > > On Sat, 2026-02-14 at 18:16 +0000, Jonathan Cameron wrote: =20
> > > > On Mon,=C2=A0 9 Feb 2026 12:42:27 -0800
> > > > Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> > > > =C2=A0  =20
> > > > > Recent changes linux mainline resulted in warning:
> > > > > "genirq: Warn about using IRQF_ONESHOT without a threaded
> > > > > handler"
> > > > > when HID sensor hub is used.
> > > > >=20
> > > > > When INDIO_BUFFER_TRIGGERED is used, the core attaches a poll
> > > > > function
> > > > > when enabling the buffer. This poll function uses
> > > > > request_threaded_irq()
> > > > > with both bottom half and top half handlers. But when using HID
> > > > > sensor hub, bottom half (thread handler) is not registered.
> > > > >=20
> > > > > In HID sensors, once a sensor is powered on, the hub collects
> > > > > samples
> > > > > and pushes data to the host when programmed thresholds are met.
> > > > > When
> > > > > this data is received for a sensor, it is pushed using
> > > > > iio_push_to_buffers_with_ts().
> > > > >=20
> > > > > The sensor is powered ON or OFF based on the trigger callback
> > > > > set_trigger_state() when the poll function is attached. During
> > > > > the
> > > > > call
> > > > > to iio_triggered_buffer_setup_ext(), the HID sensor specifies
> > > > > only
> > > > > a
> > > > > handler function but provides no thread handler, as there is no
> > > > > data
> > > > > to read from the hub in thread context. Internally, this
> > > > > results in
> > > > > calling request_threaded_irq(). Recent kernel changes now warn
> > > > > when
> > > > > request_threaded_irq() is called without a thread handler.
> > > > >=20
> > > > > To address this issue, fundamental changes are required to
> > > > > avoid
> > > > > using
> > > > > iio_triggered_buffer_setup_ext(). HID sensors can use
> > > > > INDIO_BUFFER_SOFTWARE instead of INDIO_BUFFER_TRIGGERED, as
> > > > > this
> > > > > can
> > > > > work in trigger-less mode.
> > > > >=20
> > > > > In this approach, when user space opens the buffer, the sensor
> > > > > is
> > > > > powered
> > > > > on, and when the buffer is closed, the sensor is powered off
> > > > > using
> > > > > iio_buffer_setup_ops callbacks.
> > > > >=20
> > > > > Signed-off-by: Srinivas Pandruvada
> > > > > <srinivas.pandruvada@linux.intel.com>
> > > > > ---
> > > > > This is RFC, because
> > > > > The current user space in distro "iio-sensor-proxy" is not
> > > > > working
> > > > > in
> > > > > trigerless mode as it expects
> > > > > /sys/bus/iio/devices/iio:device0/trigger/current_trigger.
> > > > > So, change needs to be submitted to fix that.=C2=A0  =20
> > > >=20
> > > > Sorry I took a while to reply to the previous thread - been off
> > > > sick
> > > > and
> > > > just catching up again.=C2=A0  =20
> > >=20
> > > No problem. Hope you are feeling better.
> > >  =20
> > > >=20
> > > > I think we can't make this change on it's own because of the
> > > > backwards compatibility
> > > > problem.=C2=A0 Please can you try what you have here without removi=
ng
> > > > the
> > > > trigger adding
> > > > chunk (as we still need that to exist) +=20
> > > >=20
> > > > iio_dev->modes =3D INDIO_DIRECT | INDIO_HARDWARE_TRIGGERED;
> > > > =C2=A0  =20
> > > This is not enough as this will fail when buffer0 enable attribute
> > > is
> > > set to 1.
> > >=20
> > > https://elixir.bootlin.com/linux/v6.18.6/source/drivers/iio/industria=
lio-buffer.c#L951 =20
> >=20
> > =C2=A0 =20
> > > But=20
> > >=20
> > > iio_dev->modes |=3D INDIO_DIRECT | INDIO_HARDWARE_TRIGGERED;
> > >=20
> > > works. =20
> >=20
> > I'm lost.=C2=A0 Which other mode is set?=C2=A0=C2=A0 Maybe shift this u=
p before
> > whatever sets that would be clearer?
> >  =20
>=20
> Driver initialize this to
> iio_dev->modes =3D INDIO_DIRECT
>=20
> Call to=20
> https://elixir.bootlin.com/linux/v6.18.6/C/ident/devm_iio_kfifo_buffer_se=
tup_ext
> will set to=20
>=20
> indio_dev->modes |=3D INDIO_BUFFER_SOFTWARE;
>=20
> After if we do
> iio_dev->modes =3D INDIO_DIRECT | INDIO_HARDWARE_TRIGGERED;
>=20
> INDIO_BUFFER_SOFTWARE will be overwritten.
>=20
> I think we can set=20
> iio_dev->modes =3D INDIO_DIRECT | INDIO_HARDWARE_TRIGGERED;
>=20
> before calling
> devm_iio_kfifo_buffer_setup_ext(), then there is no need for "|".

Thanks. That makes sense.   At some point we should probably wrap
up seeing modes in a helper to ensure the ordering doesn't matter
for cases like this one.

That will be a big job for fairly small gain though so maybe not
worth the effort.

Jonathan

>=20
> Thanks,
> Srinivas
>=20
>=20
> > J =20
> > >=20
> > >  =20
> > > > It's been a while but I think that is there basically to hook up
> > > > current_trigger.
> > > > That was intended for cases where there are several to choose
> > > > between
> > > > but
> > > > I think it should do the job here of bringing back the
> > > > interface.=C2=A0=C2=A0
> > > > Add a comment
> > > > though on why it is there.
> > > >=20
> > > > I've tried to say roughly what to keep and drop inline.
> > > >=20
> > > > thanks,
> > > >=20
> > > > Jonathan
> > > >=20
> > > >=20
> > > > =C2=A0  =20
> > > > >=20
> > > > > =C2=A0.../common/hid-sensors/hid-sensor-trigger.c=C2=A0=C2=A0 | 6=
2 ++++++-----
> > > > > ----
> > > > > ----
> > > > > =C2=A01 file changed, 18 insertions(+), 44 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-
> > > > > trigger.c
> > > > > b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > > > index 5540e2d28f4a..113fd1361643 100644
> > > > > --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > > > +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > > > @@ -14,6 +14,7 @@
> > > > > =C2=A0#include <linux/iio/triggered_buffer.h>
> > > > > =C2=A0#include <linux/iio/trigger_consumer.h>
> > > > > =C2=A0#include <linux/iio/sysfs.h>
> > > > > +#include <linux/iio/kfifo_buf.h>
> > > > > =C2=A0#include "hid-sensor-trigger.h"
> > > > > =C2=A0
> > > > > =C2=A0static ssize_t _hid_sensor_set_report_latency(struct device
> > > > > *dev,
> > > > > @@ -202,12 +203,21 @@ static void
> > > > > hid_sensor_set_power_work(struct
> > > > > work_struct *work)
> > > > > =C2=A0		_hid_sensor_power_state(attrb, true);
> > > > > =C2=A0}
> > > > > =C2=A0
> > > > > -static int hid_sensor_data_rdy_trigger_set_state(struct
> > > > > iio_trigger *trig,
> > > > > -						bool state)
> > > > > +static int buffer_postenable(struct iio_dev *indio_dev)
> > > > > =C2=A0{
> > > > > -	return
> > > > > hid_sensor_power_state(iio_trigger_get_drvdata(trig), state);
> > > > > +	return
> > > > > hid_sensor_power_state(iio_device_get_drvdata(indio_dev), 1);
> > > > > =C2=A0}
> > > > > =C2=A0
> > > > > +static int buffer_predisable(struct iio_dev *indio_dev)
> > > > > +{
> > > > > +	return
> > > > > hid_sensor_power_state(iio_device_get_drvdata(indio_dev), 0);
> > > > > +}
> > > > > +
> > > > > +static const struct iio_buffer_setup_ops hid_sensor_buffer_ops
> > > > > =3D {
> > > > > +	.postenable =3D buffer_postenable,
> > > > > +	.predisable =3D buffer_predisable,
> > > > > +};=C2=A0  =20
> > > > I think these changes all help simplify things anyway so probably
> > > > good to have.=C2=A0 Maybe we could do them in a follow up rather th=
an
> > > > the
> > > > fix but I'll leave that up to you=C2=A0  =20
> > >=20
> > > This is required as the hid_sensor_trigger_ops.set_trigger_state()
> > > is
> > > not called once iio_triggered_buffer_setup_ext() is removed.
> > >  =20
> > > > =C2=A0  =20
> > > > > +
> > > > > =C2=A0void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
> > > > > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct hid_sensor_c=
ommon
> > > > > *attrb)
> > > > > =C2=A0{
> > > > > @@ -217,59 +227,30 @@ void hid_sensor_remove_trigger(struct
> > > > > iio_dev
> > > > > *indio_dev,
> > > > > =C2=A0	pm_runtime_set_suspended(&attrb->pdev->dev);
> > > > > =C2=A0
> > > > > =C2=A0	cancel_work_sync(&attrb->work);
> > > > > -	iio_trigger_unregister(attrb->trigger);
> > > > > -	iio_trigger_free(attrb->trigger);=C2=A0  =20
> > > > Keep the trigger parts here.
> > > > =C2=A0  =20
> > > > > -	iio_triggered_buffer_cleanup(indio_dev);
> > > > > =C2=A0}
> > > > > =C2=A0EXPORT_SYMBOL_NS(hid_sensor_remove_trigger, "IIO_HID");
> > > > > =C2=A0
> > > > > -static const struct iio_trigger_ops hid_sensor_trigger_ops =3D {
> > > > > -	.set_trigger_state =3D
> > > > > &hid_sensor_data_rdy_trigger_set_state,
> > > > > -};=C2=A0  =20
> > > > and this.=C2=A0  =20
> > > This callback is not called without
> > > iio_triggered_buffer_setup_ext().
> > >  =20
> > > > > -
> > > > > =C2=A0int hid_sensor_setup_trigger(struct iio_dev *indio_dev, con=
st
> > > > > char
> > > > > *name,
> > > > > =C2=A0				struct hid_sensor_common
> > > > > *attrb)
> > > > > =C2=A0{
> > > > > =C2=A0	const struct iio_dev_attr **fifo_attrs;
> > > > > =C2=A0	int ret;
> > > > > -	struct iio_trigger *trig;
> > > > > =C2=A0
> > > > > =C2=A0	if (hid_sensor_batch_mode_supported(attrb))
> > > > > =C2=A0		fifo_attrs =3D hid_sensor_fifo_attributes;
> > > > > =C2=A0	else
> > > > > =C2=A0		fifo_attrs =3D NULL;
> > > > > =C2=A0
> > > > > -	ret =3D iio_triggered_buffer_setup_ext(indio_dev,
> > > > > -					=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > &iio_pollfunc_store_time, NULL,
> > > > > -					=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > IIO_BUFFER_DIRECTION_IN,
> > > > > -					=C2=A0=C2=A0=C2=A0=C2=A0 NULL,
> > > > > fifo_attrs);
> > > > > +	ret =3D devm_iio_kfifo_buffer_setup_ext(&indio_dev->dev,
> > > > > indio_dev,
> > > > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > &hid_sensor_buffer_ops,
> > > > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fifo_attrs);
> > > > > =C2=A0	if (ret) {
> > > > > -		dev_err(&indio_dev->dev, "Triggered Buffer
> > > > > Setup
> > > > > Failed\n");
> > > > > +		dev_err(&indio_dev->dev, "Kfifo Buffer Setup
> > > > > Failed\n");
> > > > > =C2=A0		return ret;
> > > > > =C2=A0	}=C2=A0  =20
> > > > Down to here is good but keep the trigger setup.=C2=A0  =20
> > >=20
> > > I can keep with additional
> > >=20
> > > iio_dev->modes |=3D INDIO_DIRECT | INDIO_HARDWARE_TRIGGERED;
> > >=20
> > > I will send a patch with the changes.
> > >=20
> > > Thanks,
> > > Srinivas
> > >  =20
> > > > =C2=A0  =20
> > > > > -
> > > > > -	trig =3D iio_trigger_alloc(indio_dev->dev.parent,
> > > > > -				 "%s-dev%d", name,
> > > > > iio_device_id(indio_dev));
> > > > > -	if (trig =3D=3D NULL) {
> > > > > -		dev_err(&indio_dev->dev, "Trigger Allocate
> > > > > Failed\n");
> > > > > -		ret =3D -ENOMEM;
> > > > > -		goto error_triggered_buffer_cleanup;
> > > > > -	}
> > > > > -
> > > > > -	iio_trigger_set_drvdata(trig, attrb);
> > > > > -	trig->ops =3D &hid_sensor_trigger_ops;
> > > > > -	ret =3D iio_trigger_register(trig);
> > > > > -
> > > > > -	if (ret) {
> > > > > -		dev_err(&indio_dev->dev, "Trigger Register
> > > > > Failed\n");
> > > > > -		goto error_free_trig;
> > > > > -	}
> > > > > -	attrb->trigger =3D trig;
> > > > > -	indio_dev->trig =3D iio_trigger_get(trig);
> > > > > -
> > > > > =C2=A0	ret =3D pm_runtime_set_active(&indio_dev->dev);
> > > > > =C2=A0	if (ret)
> > > > > -		goto error_unreg_trigger;
> > > > > +		return ret;
> > > > > =C2=A0
> > > > > =C2=A0	iio_device_set_drvdata(indio_dev, attrb);
> > > > > =C2=A0
> > > > > @@ -280,13 +261,6 @@ int hid_sensor_setup_trigger(struct
> > > > > iio_dev
> > > > > *indio_dev, const char *name,
> > > > > =C2=A0	pm_runtime_set_autosuspend_delay(&attrb->pdev->dev,
> > > > > =C2=A0					 3000);
> > > > > =C2=A0	return ret;
> > > > > -error_unreg_trigger:
> > > > > -	iio_trigger_unregister(trig);
> > > > > -error_free_trig:
> > > > > -	iio_trigger_free(trig);
> > > > > -error_triggered_buffer_cleanup:
> > > > > -	iio_triggered_buffer_cleanup(indio_dev);
> > > > > -	return ret;
> > > > > =C2=A0}
> > > > > =C2=A0EXPORT_SYMBOL_NS(hid_sensor_setup_trigger, "IIO_HID");
> > > > > =C2=A0=C2=A0  =20
> > >  =20

