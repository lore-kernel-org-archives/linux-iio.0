Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BAD2DCF74
	for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 23:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771458432; cv=none; b=N3U3y1/pXdh8QqsH95ac3E5TVNL4ArWDDGQA32qlw3VI4FckyAr1MLT5iHm7wcMFyjT0Ru7hHsqezWHX8yN++w1N07DpHb58R68v9Y3BtSFDYyV0d0w+UFyWNR1mtGbM0uuZYjVrtEYne0M6ubE8UABUgTfT9Q3MXRcZZv3egEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771458432; c=relaxed/simple;
	bh=dO3on2ZnfuKK8htkixD37a5j4YZiYYgEO2poTjt53wY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a9t59NXQow/VsNJcLlcc6O53qxz8C0C+qDtoQa5QWJxjVjMl0Zju5Xha7VG0lJBKDLRauQzLB8nBTzbvRsi36bh3RujDseuTuz6q1foAmtcqD8KtVcP3tABgH6ly5pefu0OQgHCekD4cR7N4NJeaBy5VyQ+pkAkI51Oyos0lPH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CWG/7RKE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CWG/7RKE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771458430; x=1802994430;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=dO3on2ZnfuKK8htkixD37a5j4YZiYYgEO2poTjt53wY=;
  b=CWG/7RKEH+yGptzM2WmJlwQFST7FsELEsRBuOrYmLS2GZ5La9kq+dkZY
   lPF2bdtR6/6Ge/jNPvWLNQqFniwB3AgwyV68Y0xG2dqADIikKSju401FF
   qNoovcJJ57hLbVWpQCQ6x7euYL820EF1MVttTqFFVdnyyrfTNbMwpPGre
   rq2On8Btnw9T07luXDLsAy7XlrvAkxZ8x7sm/FxL4R5Aid1qs6rzM3O+8
   xIuRIX7+UCkGVtitGUGpz3i4j1+nweGH23K27ZUDlbAignyK3nQrRG8dF
   oSnasDTXlUHFtlbrnL2ZF+DTorcpyeWpbBW8+Z5+tXE1Y69dBTYfOX6jt
   w==;
X-CSE-ConnectionGUID: VXXL5LdwRSC6zyumPcYnFA==
X-CSE-MsgGUID: Luzsxo7WSPu/RUdNCoyZdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="75154128"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="75154128"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 15:47:09 -0800
X-CSE-ConnectionGUID: +M50Txg2QWS3F8VJKCXDtA==
X-CSE-MsgGUID: kwbC1pLZTkWbAvP7HJoJpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="214355353"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 15:47:09 -0800
Message-ID: <80fb81d12db88a31ed6f30fc2268651458972abb.camel@linux.intel.com>
Subject: Re: [RFC PATCH] iio: hid-sensors: Use software trigger
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, bigeasy@linutronix.de, spasswolf@web.de
Date: Wed, 18 Feb 2026 15:47:09 -0800
In-Reply-To: <20260218191334.6da65747@jic23-huawei>
References: <20260209204227.1352304-1-srinivas.pandruvada@linux.intel.com>
		<20260214181612.20b37528@jic23-huawei>
		<0b2d8e0a73a7e57a37d9886374f2b3cb984b03d3.camel@linux.intel.com>
	 <20260218191334.6da65747@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-18 at 19:13 +0000, Jonathan Cameron wrote:
> On Mon, 16 Feb 2026 14:49:38 -0800
> srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>=20
> > On Sat, 2026-02-14 at 18:16 +0000, Jonathan Cameron wrote:
> > > On Mon,=C2=A0 9 Feb 2026 12:42:27 -0800
> > > Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> > > =C2=A0=20
> > > > Recent changes linux mainline resulted in warning:
> > > > "genirq: Warn about using IRQF_ONESHOT without a threaded
> > > > handler"
> > > > when HID sensor hub is used.
> > > >=20
> > > > When INDIO_BUFFER_TRIGGERED is used, the core attaches a poll
> > > > function
> > > > when enabling the buffer. This poll function uses
> > > > request_threaded_irq()
> > > > with both bottom half and top half handlers. But when using HID
> > > > sensor hub, bottom half (thread handler) is not registered.
> > > >=20
> > > > In HID sensors, once a sensor is powered on, the hub collects
> > > > samples
> > > > and pushes data to the host when programmed thresholds are met.
> > > > When
> > > > this data is received for a sensor, it is pushed using
> > > > iio_push_to_buffers_with_ts().
> > > >=20
> > > > The sensor is powered ON or OFF based on the trigger callback
> > > > set_trigger_state() when the poll function is attached. During
> > > > the
> > > > call
> > > > to iio_triggered_buffer_setup_ext(), the HID sensor specifies
> > > > only
> > > > a
> > > > handler function but provides no thread handler, as there is no
> > > > data
> > > > to read from the hub in thread context. Internally, this
> > > > results in
> > > > calling request_threaded_irq(). Recent kernel changes now warn
> > > > when
> > > > request_threaded_irq() is called without a thread handler.
> > > >=20
> > > > To address this issue, fundamental changes are required to
> > > > avoid
> > > > using
> > > > iio_triggered_buffer_setup_ext(). HID sensors can use
> > > > INDIO_BUFFER_SOFTWARE instead of INDIO_BUFFER_TRIGGERED, as
> > > > this
> > > > can
> > > > work in trigger-less mode.
> > > >=20
> > > > In this approach, when user space opens the buffer, the sensor
> > > > is
> > > > powered
> > > > on, and when the buffer is closed, the sensor is powered off
> > > > using
> > > > iio_buffer_setup_ops callbacks.
> > > >=20
> > > > Signed-off-by: Srinivas Pandruvada
> > > > <srinivas.pandruvada@linux.intel.com>
> > > > ---
> > > > This is RFC, because
> > > > The current user space in distro "iio-sensor-proxy" is not
> > > > working
> > > > in
> > > > trigerless mode as it expects
> > > > /sys/bus/iio/devices/iio:device0/trigger/current_trigger.
> > > > So, change needs to be submitted to fix that.=C2=A0=20
> > >=20
> > > Sorry I took a while to reply to the previous thread - been off
> > > sick
> > > and
> > > just catching up again.=C2=A0=20
> >=20
> > No problem. Hope you are feeling better.
> >=20
> > >=20
> > > I think we can't make this change on it's own because of the
> > > backwards compatibility
> > > problem.=C2=A0 Please can you try what you have here without removing
> > > the
> > > trigger adding
> > > chunk (as we still need that to exist) +=20
> > >=20
> > > iio_dev->modes =3D INDIO_DIRECT | INDIO_HARDWARE_TRIGGERED;
> > > =C2=A0=20
> > This is not enough as this will fail when buffer0 enable attribute
> > is
> > set to 1.
> >=20
> > https://elixir.bootlin.com/linux/v6.18.6/source/drivers/iio/industriali=
o-buffer.c#L951
>=20
> =C2=A0
> > But=20
> >=20
> > iio_dev->modes |=3D INDIO_DIRECT | INDIO_HARDWARE_TRIGGERED;
> >=20
> > works.
>=20
> I'm lost.=C2=A0 Which other mode is set?=C2=A0=C2=A0 Maybe shift this up =
before
> whatever sets that would be clearer?
>=20

Driver initialize this to
iio_dev->modes =3D INDIO_DIRECT

Call to=20
https://elixir.bootlin.com/linux/v6.18.6/C/ident/devm_iio_kfifo_buffer_setu=
p_ext
will set to=20

indio_dev->modes |=3D INDIO_BUFFER_SOFTWARE;

After if we do
iio_dev->modes =3D INDIO_DIRECT | INDIO_HARDWARE_TRIGGERED;

INDIO_BUFFER_SOFTWARE will be overwritten.

I think we can set=20
iio_dev->modes =3D INDIO_DIRECT | INDIO_HARDWARE_TRIGGERED;

before calling
devm_iio_kfifo_buffer_setup_ext(), then there is no need for "|".

Thanks,
Srinivas


> J
> >=20
> >=20
> > > It's been a while but I think that is there basically to hook up
> > > current_trigger.
> > > That was intended for cases where there are several to choose
> > > between
> > > but
> > > I think it should do the job here of bringing back the
> > > interface.=C2=A0=C2=A0
> > > Add a comment
> > > though on why it is there.
> > >=20
> > > I've tried to say roughly what to keep and drop inline.
> > >=20
> > > thanks,
> > >=20
> > > Jonathan
> > >=20
> > >=20
> > > =C2=A0=20
> > > >=20
> > > > =C2=A0.../common/hid-sensors/hid-sensor-trigger.c=C2=A0=C2=A0 | 62 =
++++++-----
> > > > ----
> > > > ----
> > > > =C2=A01 file changed, 18 insertions(+), 44 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-
> > > > trigger.c
> > > > b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > > index 5540e2d28f4a..113fd1361643 100644
> > > > --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > > +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > > @@ -14,6 +14,7 @@
> > > > =C2=A0#include <linux/iio/triggered_buffer.h>
> > > > =C2=A0#include <linux/iio/trigger_consumer.h>
> > > > =C2=A0#include <linux/iio/sysfs.h>
> > > > +#include <linux/iio/kfifo_buf.h>
> > > > =C2=A0#include "hid-sensor-trigger.h"
> > > > =C2=A0
> > > > =C2=A0static ssize_t _hid_sensor_set_report_latency(struct device
> > > > *dev,
> > > > @@ -202,12 +203,21 @@ static void
> > > > hid_sensor_set_power_work(struct
> > > > work_struct *work)
> > > > =C2=A0		_hid_sensor_power_state(attrb, true);
> > > > =C2=A0}
> > > > =C2=A0
> > > > -static int hid_sensor_data_rdy_trigger_set_state(struct
> > > > iio_trigger *trig,
> > > > -						bool state)
> > > > +static int buffer_postenable(struct iio_dev *indio_dev)
> > > > =C2=A0{
> > > > -	return
> > > > hid_sensor_power_state(iio_trigger_get_drvdata(trig), state);
> > > > +	return
> > > > hid_sensor_power_state(iio_device_get_drvdata(indio_dev), 1);
> > > > =C2=A0}
> > > > =C2=A0
> > > > +static int buffer_predisable(struct iio_dev *indio_dev)
> > > > +{
> > > > +	return
> > > > hid_sensor_power_state(iio_device_get_drvdata(indio_dev), 0);
> > > > +}
> > > > +
> > > > +static const struct iio_buffer_setup_ops hid_sensor_buffer_ops
> > > > =3D {
> > > > +	.postenable =3D buffer_postenable,
> > > > +	.predisable =3D buffer_predisable,
> > > > +};=C2=A0=20
> > > I think these changes all help simplify things anyway so probably
> > > good to have.=C2=A0 Maybe we could do them in a follow up rather than
> > > the
> > > fix but I'll leave that up to you=C2=A0=20
> >=20
> > This is required as the hid_sensor_trigger_ops.set_trigger_state()
> > is
> > not called once iio_triggered_buffer_setup_ext() is removed.
> >=20
> > > =C2=A0=20
> > > > +
> > > > =C2=A0void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
> > > > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct hid_sensor_com=
mon
> > > > *attrb)
> > > > =C2=A0{
> > > > @@ -217,59 +227,30 @@ void hid_sensor_remove_trigger(struct
> > > > iio_dev
> > > > *indio_dev,
> > > > =C2=A0	pm_runtime_set_suspended(&attrb->pdev->dev);
> > > > =C2=A0
> > > > =C2=A0	cancel_work_sync(&attrb->work);
> > > > -	iio_trigger_unregister(attrb->trigger);
> > > > -	iio_trigger_free(attrb->trigger);=C2=A0=20
> > > Keep the trigger parts here.
> > > =C2=A0=20
> > > > -	iio_triggered_buffer_cleanup(indio_dev);
> > > > =C2=A0}
> > > > =C2=A0EXPORT_SYMBOL_NS(hid_sensor_remove_trigger, "IIO_HID");
> > > > =C2=A0
> > > > -static const struct iio_trigger_ops hid_sensor_trigger_ops =3D {
> > > > -	.set_trigger_state =3D
> > > > &hid_sensor_data_rdy_trigger_set_state,
> > > > -};=C2=A0=20
> > > and this.=C2=A0=20
> > This callback is not called without
> > iio_triggered_buffer_setup_ext().
> >=20
> > > > -
> > > > =C2=A0int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const
> > > > char
> > > > *name,
> > > > =C2=A0				struct hid_sensor_common
> > > > *attrb)
> > > > =C2=A0{
> > > > =C2=A0	const struct iio_dev_attr **fifo_attrs;
> > > > =C2=A0	int ret;
> > > > -	struct iio_trigger *trig;
> > > > =C2=A0
> > > > =C2=A0	if (hid_sensor_batch_mode_supported(attrb))
> > > > =C2=A0		fifo_attrs =3D hid_sensor_fifo_attributes;
> > > > =C2=A0	else
> > > > =C2=A0		fifo_attrs =3D NULL;
> > > > =C2=A0
> > > > -	ret =3D iio_triggered_buffer_setup_ext(indio_dev,
> > > > -					=C2=A0=C2=A0=C2=A0=C2=A0
> > > > &iio_pollfunc_store_time, NULL,
> > > > -					=C2=A0=C2=A0=C2=A0=C2=A0
> > > > IIO_BUFFER_DIRECTION_IN,
> > > > -					=C2=A0=C2=A0=C2=A0=C2=A0 NULL,
> > > > fifo_attrs);
> > > > +	ret =3D devm_iio_kfifo_buffer_setup_ext(&indio_dev->dev,
> > > > indio_dev,
> > > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > &hid_sensor_buffer_ops,
> > > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fifo_attrs);
> > > > =C2=A0	if (ret) {
> > > > -		dev_err(&indio_dev->dev, "Triggered Buffer
> > > > Setup
> > > > Failed\n");
> > > > +		dev_err(&indio_dev->dev, "Kfifo Buffer Setup
> > > > Failed\n");
> > > > =C2=A0		return ret;
> > > > =C2=A0	}=C2=A0=20
> > > Down to here is good but keep the trigger setup.=C2=A0=20
> >=20
> > I can keep with additional
> >=20
> > iio_dev->modes |=3D INDIO_DIRECT | INDIO_HARDWARE_TRIGGERED;
> >=20
> > I will send a patch with the changes.
> >=20
> > Thanks,
> > Srinivas
> >=20
> > > =C2=A0=20
> > > > -
> > > > -	trig =3D iio_trigger_alloc(indio_dev->dev.parent,
> > > > -				 "%s-dev%d", name,
> > > > iio_device_id(indio_dev));
> > > > -	if (trig =3D=3D NULL) {
> > > > -		dev_err(&indio_dev->dev, "Trigger Allocate
> > > > Failed\n");
> > > > -		ret =3D -ENOMEM;
> > > > -		goto error_triggered_buffer_cleanup;
> > > > -	}
> > > > -
> > > > -	iio_trigger_set_drvdata(trig, attrb);
> > > > -	trig->ops =3D &hid_sensor_trigger_ops;
> > > > -	ret =3D iio_trigger_register(trig);
> > > > -
> > > > -	if (ret) {
> > > > -		dev_err(&indio_dev->dev, "Trigger Register
> > > > Failed\n");
> > > > -		goto error_free_trig;
> > > > -	}
> > > > -	attrb->trigger =3D trig;
> > > > -	indio_dev->trig =3D iio_trigger_get(trig);
> > > > -
> > > > =C2=A0	ret =3D pm_runtime_set_active(&indio_dev->dev);
> > > > =C2=A0	if (ret)
> > > > -		goto error_unreg_trigger;
> > > > +		return ret;
> > > > =C2=A0
> > > > =C2=A0	iio_device_set_drvdata(indio_dev, attrb);
> > > > =C2=A0
> > > > @@ -280,13 +261,6 @@ int hid_sensor_setup_trigger(struct
> > > > iio_dev
> > > > *indio_dev, const char *name,
> > > > =C2=A0	pm_runtime_set_autosuspend_delay(&attrb->pdev->dev,
> > > > =C2=A0					 3000);
> > > > =C2=A0	return ret;
> > > > -error_unreg_trigger:
> > > > -	iio_trigger_unregister(trig);
> > > > -error_free_trig:
> > > > -	iio_trigger_free(trig);
> > > > -error_triggered_buffer_cleanup:
> > > > -	iio_triggered_buffer_cleanup(indio_dev);
> > > > -	return ret;
> > > > =C2=A0}
> > > > =C2=A0EXPORT_SYMBOL_NS(hid_sensor_setup_trigger, "IIO_HID");
> > > > =C2=A0=C2=A0=20
> >=20
