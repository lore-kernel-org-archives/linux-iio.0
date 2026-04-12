Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027E47082D;
	Sun, 12 Apr 2026 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776001128; cv=none; b=a4kRB/mP8NJ8Arf8ZyK6jLbjJM6nTPO6rvu13qOD6s5ZTCuvPdCwOIyNo8A6Lxj2CtT1CHBMRv0FWS8/mplsHwgugRCxeY1SjhytgmvdwbxcOX4MY13DL6Rxs8AgIXbCv0Gq3tJFdrv/lHEzZZ83QT5asUjQdZiUirikczpKBNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776001128; c=relaxed/simple;
	bh=kN1BjnnR5BBFzLAIO7GXk/nK5WlLyGnzT8LezhN9/TY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVxG6F8LC/MqP2xnESCIezkvWuZZ/+SS/hfVh+eZXjwNJpUnBYH7NggEW2xnpsYoLCnuaDLRaoBLxHE1ozoVgP1BPpvodknEOBJws4MKTwXieNnNDPVL/QQolPPTUS1w6cNUO2c1u4R86iiKVKTFQuKKBQFTUEm6ejbmZckLtNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uI//slqr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uI//slqr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12964C19424;
	Sun, 12 Apr 2026 13:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776001127;
	bh=kN1BjnnR5BBFzLAIO7GXk/nK5WlLyGnzT8LezhN9/TY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uI//slqrR9RrbstUnQjLPF62fbgYwFWVptYW0YJ5FvyjsRmt/RxkkydCPqhocyKGu
	 bkTNxl9F7K+EvGOksCx9CbuK5AlEl9ZIdpXlFYAmdPmnJLc3e0KAFlwSD7hoydmqBG
	 e39mNUVqP4J6iUZFjgtnENoRKPiJF5UuUkZ3SszLF0LrUq7OdS9nYht89CRbrtuJ7y
	 jmmV9ihN9CjC4XgqJDfPOgcUQndv+R5i7tXqbJeUgNLeE94gHQMH2wv61wu4UxlhbY
	 wOrMMMJNFaKHX0+zPjhNiGpBiRWpG6LV05ycoax3YroXnKOr18p7ORsaEyzi7kKxXJ
	 4NT0AC85o0G9A==
Date: Sun, 12 Apr 2026 14:38:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hanne-Lotta =?UTF-8?B?TcOkZW5ww6TDpA==?= <hannelotta@gmail.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-iio@vger.kernel.org, bigeasy@linutronix.de, spasswolf@web.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: hid-sensors: Use software trigger
Message-ID: <20260412143840.349400ca@jic23-huawei>
In-Reply-To: <7ef87de7-9731-46fb-9608-34c07fcf03cd@gmail.com>
References: <20260220224514.471348-1-srinivas.pandruvada@linux.intel.com>
	<7ef87de7-9731-46fb-9608-34c07fcf03cd@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Mar 2026 17:10:58 +0200
Hanne-Lotta M=C3=A4enp=C3=A4=C3=A4 <hannelotta@gmail.com> wrote:

> On 2/21/26 12:45 AM, Srinivas Pandruvada wrote:
> > Recent changes linux mainline resulted in warning:
> > "genirq: Warn about using IRQF_ONESHOT without a threaded handler"
> > when HID sensor hub is used.
> >=20
> > When INDIO_BUFFER_TRIGGERED is used, the core attaches a poll function
> > when enabling the buffer. This poll function uses request_threaded_irq()
> > with both bottom half and top half handlers. But when using HID
> > sensor hub, bottom half (thread handler) is not registered.
> >=20
> > In HID sensors, once a sensor is powered on, the hub collects samples
> > and pushes data to the host when programmed thresholds are met. When
> > this data is received for a sensor, it is pushed using
> > iio_push_to_buffers_with_ts().
> >=20
> > The sensor is powered ON or OFF based on the trigger callback
> > set_trigger_state() when the poll function is attached. During the call
> > to iio_triggered_buffer_setup_ext(), the HID sensor specifies only a
> > handler function but provides no thread handler, as there is no data
> > to read from the hub in thread context. Internally, this results in
> > calling request_threaded_irq(). Recent kernel changes now warn when
> > request_threaded_irq() is called without a thread handler.
> >=20
> > To address this issue, fundamental changes are required to avoid using
> > iio_triggered_buffer_setup_ext(). HID sensors can use
> > INDIO_BUFFER_SOFTWARE instead of INDIO_BUFFER_TRIGGERED, as this can
> > work in trigger-less mode.
> >=20
> > In this approach, when user space opens the buffer, the sensor is power=
ed
> > on, and when the buffer is closed, the sensor is powered off using
> > iio_buffer_setup_ops callbacks.
> >=20
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > ---
> > Changes:
> > v2:
> > changed
> > indio_dev->modes |=3D INDIO_DIRECT_MODE | INDIO_HARDWARE_TRIGGERED;
> > to
> > indio_dev->modes =3D INDIO_DIRECT_MODE | INDIO_HARDWARE_TRIGGERED;
> >=20
> >  From RFC
> > - The trigger alloc and register is still kept as old code with
> > additional
> > indio_dev->modes |=3D INDIO_DIRECT_MODE | INDIO_HARDWARE_TRIGGERED;
> >=20
> >   .../common/hid-sensors/hid-sensor-trigger.c   | 48 ++++++++++++-------
> >   1 file changed, 30 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/driv=
ers/iio/common/hid-sensors/hid-sensor-trigger.c
> > index 5540e2d28f4a..417c4ab8c1b2 100644
> > --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > @@ -14,6 +14,7 @@
> >   #include <linux/iio/triggered_buffer.h>
> >   #include <linux/iio/trigger_consumer.h>
> >   #include <linux/iio/sysfs.h>
> > +#include <linux/iio/kfifo_buf.h>
> >   #include "hid-sensor-trigger.h"
> >  =20
> >   static ssize_t _hid_sensor_set_report_latency(struct device *dev,
> > @@ -202,12 +203,21 @@ static void hid_sensor_set_power_work(struct work=
_struct *work)
> >   		_hid_sensor_power_state(attrb, true);
> >   }
> >  =20
> > -static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *t=
rig,
> > -						bool state)
> > +static int buffer_postenable(struct iio_dev *indio_dev)
> >   {
> > -	return hid_sensor_power_state(iio_trigger_get_drvdata(trig), state);
> > +	return hid_sensor_power_state(iio_device_get_drvdata(indio_dev), 1);
> >   }
> >  =20
> > +static int buffer_predisable(struct iio_dev *indio_dev)
> > +{
> > +	return hid_sensor_power_state(iio_device_get_drvdata(indio_dev), 0);
> > +}
> > +
> > +static const struct iio_buffer_setup_ops hid_sensor_buffer_ops =3D {
> > +	.postenable =3D buffer_postenable,
> > +	.predisable =3D buffer_predisable,
> > +};
> > +
> >   void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
> >   			       struct hid_sensor_common *attrb)
> >   {
> > @@ -219,14 +229,9 @@ void hid_sensor_remove_trigger(struct iio_dev *ind=
io_dev,
> >   	cancel_work_sync(&attrb->work);
> >   	iio_trigger_unregister(attrb->trigger);
> >   	iio_trigger_free(attrb->trigger);
> > -	iio_triggered_buffer_cleanup(indio_dev);
> >   }
> >   EXPORT_SYMBOL_NS(hid_sensor_remove_trigger, "IIO_HID");
> >  =20
> > -static const struct iio_trigger_ops hid_sensor_trigger_ops =3D {
> > -	.set_trigger_state =3D &hid_sensor_data_rdy_trigger_set_state,
> > -};
> > -
> >   int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *n=
ame,
> >   				struct hid_sensor_common *attrb)
> >   {
> > @@ -239,25 +244,34 @@ int hid_sensor_setup_trigger(struct iio_dev *indi=
o_dev, const char *name,
> >   	else
> >   		fifo_attrs =3D NULL;
> >  =20
> > -	ret =3D iio_triggered_buffer_setup_ext(indio_dev,
> > -					     &iio_pollfunc_store_time, NULL,
> > -					     IIO_BUFFER_DIRECTION_IN,
> > -					     NULL, fifo_attrs);
> > +	indio_dev->modes =3D INDIO_DIRECT_MODE | INDIO_HARDWARE_TRIGGERED;
> > +
> > +	ret =3D devm_iio_kfifo_buffer_setup_ext(&indio_dev->dev, indio_dev,
> > +					      &hid_sensor_buffer_ops,
> > +					      fifo_attrs);
> >   	if (ret) {
> > -		dev_err(&indio_dev->dev, "Triggered Buffer Setup Failed\n");
> > +		dev_err(&indio_dev->dev, "Kfifo Buffer Setup Failed\n");
> >   		return ret;
> >   	}
> >  =20
> > +	/*
> > +	 * The current user space in distro "iio-sensor-proxy" is not working=
 in
> > +	 * trigerless mode and it expects
> > +	 * /sys/bus/iio/devices/iio:device0/trigger/current_trigger.
> > +	 * The change replacing iio_triggered_buffer_setup_ext() with
> > +	 * devm_iio_kfifo_buffer_setup_ext() will not create attribute without
> > +	 * registering a trigger with INDIO_HARDWARE_TRIGGERED.
> > +	 * So the below code fragment is still required.
> > +	 */
> > +
> >   	trig =3D iio_trigger_alloc(indio_dev->dev.parent,
> >   				 "%s-dev%d", name, iio_device_id(indio_dev));
> >   	if (trig =3D=3D NULL) {
> >   		dev_err(&indio_dev->dev, "Trigger Allocate Failed\n");
> > -		ret =3D -ENOMEM;
> > -		goto error_triggered_buffer_cleanup;
> > +		return -ENOMEM;
> >   	}
> >  =20
> >   	iio_trigger_set_drvdata(trig, attrb);
> > -	trig->ops =3D &hid_sensor_trigger_ops;
> >   	ret =3D iio_trigger_register(trig);
> >  =20
> >   	if (ret) {
> > @@ -284,8 +298,6 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_=
dev, const char *name,
> >   	iio_trigger_unregister(trig);
> >   error_free_trig:
> >   	iio_trigger_free(trig);
> > -error_triggered_buffer_cleanup:
> > -	iio_triggered_buffer_cleanup(indio_dev);
> >   	return ret;
> >   }
> >   EXPORT_SYMBOL_NS(hid_sensor_setup_trigger, "IIO_HID"); =20
>=20
>=20
> Hi,
>=20
> This patch clears the warning "WARNING: kernel/irq/manage.c:1502 at=20
> __setup_irq" on Debian forky.
>=20
> Tested-by: Hanne-Lotta M=C3=A4enp=C3=A4=C3=A4
>=20
> The referenced commit ID could be included in the commit message, like th=
is:
>=20
> Commit aef30c8d569c0f317154 ("genirq: Warn about using IRQF_ONESHOT=20
> without a threaded handler")
>=20
> With that included, this patch will be easier to find if someone bisects=
=20
> the issue.
>=20
> Also, a Closes tag could be added:
>=20
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221256
The patch was merged a while ago and in the discussions in the related
threads we decide it was too invasive to handle as a fix for what is a
warning print, not a failure.

The closes tag without a fixes would trigger various bot warnings.
It could have been there as a Link however. =20

Also, the small temporal issue of the fix predating the bugzilla
entry made it trickier!  I could have added it when merging but
we didn't have confirmation that the two were definitely the same
issue at that time and I chose not to connect up the dots.

Your reply may well help anyone looking to find the issue though
so thanks for that.

Jonathan

>=20
> Best regards,
>=20
> Hanne-Lotta M=C3=A4enp=C3=A4=C3=A4

