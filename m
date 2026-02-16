Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA3B46BF
	for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771282226; cv=none; b=LQKfli3Ic7+xsuibPFl5O3pb60Hpiy1qZd0t7EYtXBnoOnQfqBqr3iQAtCfugMyrA8KrKiezDwWqoCviqxbqIpJ77fEXDxOawHKOqDXEo7c+A3uBN5MJ5yYmWiNhzx+BXb9D3J44af+m1Goclb7xUvIU4JcPHJcApYQ36inQ9n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771282226; c=relaxed/simple;
	bh=bmKCyf+eFT91eUNLngZ3lCiV0n2wkFBiJcer0R3wG94=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 MIME-Version:Date; b=aCknspkecd42Os/VaSOb+Ae9GWs80yyjd4SBUgbNDUy4goPWi8kJcChD91aYCJMQEJck9/4H1zWuyDC0BO0zlxrLQPFHI7S9d8Hsmm6rrHbXIpTBPy/We2vlLp5reqbZqfSbYx4ltG2NpOhZur2DK3nG7PnyMN7pFIJRvBZ6IYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UIxAG2Cz; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UIxAG2Cz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771282224; x=1802818224;
  h=message-id:subject:from:to:cc:in-reply-to:references:
   content-transfer-encoding:mime-version:date;
  bh=bmKCyf+eFT91eUNLngZ3lCiV0n2wkFBiJcer0R3wG94=;
  b=UIxAG2Cz+VkQcEXeo9a73bsDwNl0UOGZhz6L2dKeSfZx+EHmgNGwTY1E
   BhS8abn29he3fc0Ns31vN5FTQdlJALppSh0vW95TZrCR68y5k06PFqWvq
   Jf1WCaL56c0eCFS1WzpNI//dRuM/3zpBBvTmBqgK/P3W9aUs8GE1hFpT/
   zhQTucfuQLBe2GOuh1gqiwpdH8kWthh7OJ58+Zqd0/WT2q4dpV/ghASpw
   7SqDaLSSgWCDJZjqNWMCTCiHpC6i8r0DKBB+UoR+fSR7IP2jXmsldtWb1
   DGywmpCKdk8qV9nAHvvLsPN/pHdAetGUxXHRitnpFM5glIAl3f4ErIqMw
   A==;
X-CSE-ConnectionGUID: xhM56SKYQ6eY01r9ARRoPw==
X-CSE-MsgGUID: QXxLPHkDTGON+4c9VxS2tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="76199198"
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="76199198"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 14:50:23 -0800
X-CSE-ConnectionGUID: +INn/ZvmQhCo1776oNmA9w==
X-CSE-MsgGUID: j6keLey6S7qFfwI5FmX3jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="236736339"
Received: from spandruv-mobl5.amr.corp.intel.com (HELO [10.125.109.119]) ([10.125.109.119])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 14:50:22 -0800
Message-ID: <0b2d8e0a73a7e57a37d9886374f2b3cb984b03d3.camel@linux.intel.com>
Subject: Re: [RFC PATCH] iio: hid-sensors: Use software trigger
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, bigeasy@linutronix.de, spasswolf@web.de
In-Reply-To: <20260214181612.20b37528@jic23-huawei>
References: <20260209204227.1352304-1-srinivas.pandruvada@linux.intel.com>
	 <20260214181612.20b37528@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Feb 2026 14:49:38 -0800
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 

On Sat, 2026-02-14 at 18:16 +0000, Jonathan Cameron wrote:
> On Mon,=C2=A0 9 Feb 2026 12:42:27 -0800
> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>=20
> > Recent changes linux mainline resulted in warning:
> > "genirq: Warn about using IRQF_ONESHOT without a threaded handler"
> > when HID sensor hub is used.
> >=20
> > When INDIO_BUFFER_TRIGGERED is used, the core attaches a poll
> > function
> > when enabling the buffer. This poll function uses
> > request_threaded_irq()
> > with both bottom half and top half handlers. But when using HID
> > sensor hub, bottom half (thread handler) is not registered.
> >=20
> > In HID sensors, once a sensor is powered on, the hub collects
> > samples
> > and pushes data to the host when programmed thresholds are met.
> > When
> > this data is received for a sensor, it is pushed using
> > iio_push_to_buffers_with_ts().
> >=20
> > The sensor is powered ON or OFF based on the trigger callback
> > set_trigger_state() when the poll function is attached. During the
> > call
> > to iio_triggered_buffer_setup_ext(), the HID sensor specifies only
> > a
> > handler function but provides no thread handler, as there is no
> > data
> > to read from the hub in thread context. Internally, this results in
> > calling request_threaded_irq(). Recent kernel changes now warn when
> > request_threaded_irq() is called without a thread handler.
> >=20
> > To address this issue, fundamental changes are required to avoid
> > using
> > iio_triggered_buffer_setup_ext(). HID sensors can use
> > INDIO_BUFFER_SOFTWARE instead of INDIO_BUFFER_TRIGGERED, as this
> > can
> > work in trigger-less mode.
> >=20
> > In this approach, when user space opens the buffer, the sensor is
> > powered
> > on, and when the buffer is closed, the sensor is powered off using
> > iio_buffer_setup_ops callbacks.
> >=20
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > ---
> > This is RFC, because
> > The current user space in distro "iio-sensor-proxy" is not working
> > in
> > trigerless mode as it expects
> > /sys/bus/iio/devices/iio:device0/trigger/current_trigger.
> > So, change needs to be submitted to fix that.
>=20
> Sorry I took a while to reply to the previous thread - been off sick
> and
> just catching up again.

No problem. Hope you are feeling better.

>=20
> I think we can't make this change on it's own because of the
> backwards compatibility
> problem.=C2=A0 Please can you try what you have here without removing the
> trigger adding
> chunk (as we still need that to exist) +=20
>=20
> iio_dev->modes =3D INDIO_DIRECT | INDIO_HARDWARE_TRIGGERED;
>=20
This is not enough as this will fail when buffer0 enable attribute is
set to 1.

https://elixir.bootlin.com/linux/v6.18.6/source/drivers/iio/industrialio-bu=
ffer.c#L951

But=20

iio_dev->modes |=3D INDIO_DIRECT | INDIO_HARDWARE_TRIGGERED;

works.


> It's been a while but I think that is there basically to hook up
> current_trigger.
> That was intended for cases where there are several to choose between
> but
> I think it should do the job here of bringing back the interface.=C2=A0=
=C2=A0
> Add a comment
> though on why it is there.
>=20
> I've tried to say roughly what to keep and drop inline.
>=20
> thanks,
>=20
> Jonathan
>=20
>=20
>=20
> >=20
> > =C2=A0.../common/hid-sensors/hid-sensor-trigger.c=C2=A0=C2=A0 | 62 ++++=
++---------
> > ----
> > =C2=A01 file changed, 18 insertions(+), 44 deletions(-)
> >=20
> > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > index 5540e2d28f4a..113fd1361643 100644
> > --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > @@ -14,6 +14,7 @@
> > =C2=A0#include <linux/iio/triggered_buffer.h>
> > =C2=A0#include <linux/iio/trigger_consumer.h>
> > =C2=A0#include <linux/iio/sysfs.h>
> > +#include <linux/iio/kfifo_buf.h>
> > =C2=A0#include "hid-sensor-trigger.h"
> > =C2=A0
> > =C2=A0static ssize_t _hid_sensor_set_report_latency(struct device *dev,
> > @@ -202,12 +203,21 @@ static void hid_sensor_set_power_work(struct
> > work_struct *work)
> > =C2=A0		_hid_sensor_power_state(attrb, true);
> > =C2=A0}
> > =C2=A0
> > -static int hid_sensor_data_rdy_trigger_set_state(struct
> > iio_trigger *trig,
> > -						bool state)
> > +static int buffer_postenable(struct iio_dev *indio_dev)
> > =C2=A0{
> > -	return
> > hid_sensor_power_state(iio_trigger_get_drvdata(trig), state);
> > +	return
> > hid_sensor_power_state(iio_device_get_drvdata(indio_dev), 1);
> > =C2=A0}
> > =C2=A0
> > +static int buffer_predisable(struct iio_dev *indio_dev)
> > +{
> > +	return
> > hid_sensor_power_state(iio_device_get_drvdata(indio_dev), 0);
> > +}
> > +
> > +static const struct iio_buffer_setup_ops hid_sensor_buffer_ops =3D {
> > +	.postenable =3D buffer_postenable,
> > +	.predisable =3D buffer_predisable,
> > +};
> I think these changes all help simplify things anyway so probably
> good to have.=C2=A0 Maybe we could do them in a follow up rather than the
> fix but I'll leave that up to you

This is required as the hid_sensor_trigger_ops.set_trigger_state() is
not called once iio_triggered_buffer_setup_ext() is removed.

>=20
> > +
> > =C2=A0void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct hid_sensor_common =
*attrb)
> > =C2=A0{
> > @@ -217,59 +227,30 @@ void hid_sensor_remove_trigger(struct iio_dev
> > *indio_dev,
> > =C2=A0	pm_runtime_set_suspended(&attrb->pdev->dev);
> > =C2=A0
> > =C2=A0	cancel_work_sync(&attrb->work);
> > -	iio_trigger_unregister(attrb->trigger);
> > -	iio_trigger_free(attrb->trigger);
> Keep the trigger parts here.
>=20
> > -	iio_triggered_buffer_cleanup(indio_dev);
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_NS(hid_sensor_remove_trigger, "IIO_HID");
> > =C2=A0
> > -static const struct iio_trigger_ops hid_sensor_trigger_ops =3D {
> > -	.set_trigger_state =3D
> > &hid_sensor_data_rdy_trigger_set_state,
> > -};
> and this.
This callback is not called without iio_triggered_buffer_setup_ext().

> > -
> > =C2=A0int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const cha=
r
> > *name,
> > =C2=A0				struct hid_sensor_common *attrb)
> > =C2=A0{
> > =C2=A0	const struct iio_dev_attr **fifo_attrs;
> > =C2=A0	int ret;
> > -	struct iio_trigger *trig;
> > =C2=A0
> > =C2=A0	if (hid_sensor_batch_mode_supported(attrb))
> > =C2=A0		fifo_attrs =3D hid_sensor_fifo_attributes;
> > =C2=A0	else
> > =C2=A0		fifo_attrs =3D NULL;
> > =C2=A0
> > -	ret =3D iio_triggered_buffer_setup_ext(indio_dev,
> > -					=C2=A0=C2=A0=C2=A0=C2=A0
> > &iio_pollfunc_store_time, NULL,
> > -					=C2=A0=C2=A0=C2=A0=C2=A0
> > IIO_BUFFER_DIRECTION_IN,
> > -					=C2=A0=C2=A0=C2=A0=C2=A0 NULL, fifo_attrs);
> > +	ret =3D devm_iio_kfifo_buffer_setup_ext(&indio_dev->dev,
> > indio_dev,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > &hid_sensor_buffer_ops,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fifo_attrs);
> > =C2=A0	if (ret) {
> > -		dev_err(&indio_dev->dev, "Triggered Buffer Setup
> > Failed\n");
> > +		dev_err(&indio_dev->dev, "Kfifo Buffer Setup
> > Failed\n");
> > =C2=A0		return ret;
> > =C2=A0	}
> Down to here is good but keep the trigger setup.

I can keep with additional

iio_dev->modes |=3D INDIO_DIRECT | INDIO_HARDWARE_TRIGGERED;

I will send a patch with the changes.

Thanks,
Srinivas

>=20
> > -
> > -	trig =3D iio_trigger_alloc(indio_dev->dev.parent,
> > -				 "%s-dev%d", name,
> > iio_device_id(indio_dev));
> > -	if (trig =3D=3D NULL) {
> > -		dev_err(&indio_dev->dev, "Trigger Allocate
> > Failed\n");
> > -		ret =3D -ENOMEM;
> > -		goto error_triggered_buffer_cleanup;
> > -	}
> > -
> > -	iio_trigger_set_drvdata(trig, attrb);
> > -	trig->ops =3D &hid_sensor_trigger_ops;
> > -	ret =3D iio_trigger_register(trig);
> > -
> > -	if (ret) {
> > -		dev_err(&indio_dev->dev, "Trigger Register
> > Failed\n");
> > -		goto error_free_trig;
> > -	}
> > -	attrb->trigger =3D trig;
> > -	indio_dev->trig =3D iio_trigger_get(trig);
> > -
> > =C2=A0	ret =3D pm_runtime_set_active(&indio_dev->dev);
> > =C2=A0	if (ret)
> > -		goto error_unreg_trigger;
> > +		return ret;
> > =C2=A0
> > =C2=A0	iio_device_set_drvdata(indio_dev, attrb);
> > =C2=A0
> > @@ -280,13 +261,6 @@ int hid_sensor_setup_trigger(struct iio_dev
> > *indio_dev, const char *name,
> > =C2=A0	pm_runtime_set_autosuspend_delay(&attrb->pdev->dev,
> > =C2=A0					 3000);
> > =C2=A0	return ret;
> > -error_unreg_trigger:
> > -	iio_trigger_unregister(trig);
> > -error_free_trig:
> > -	iio_trigger_free(trig);
> > -error_triggered_buffer_cleanup:
> > -	iio_triggered_buffer_cleanup(indio_dev);
> > -	return ret;
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_NS(hid_sensor_setup_trigger, "IIO_HID");
> > =C2=A0
