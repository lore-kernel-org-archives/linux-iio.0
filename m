Return-Path: <manuel.stahl9ab33xy531iis.fraunhofer.de@bounce.antispameurope.com>
Message-ID: <4C84A297.2030207@iis.fraunhofer.de>
Date: Mon, 06 Sep 2010 10:13:11 +0200
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org, drivers@analog.com
Subject: Re: [PATCH 2/4] staging:iio:adis16350 move datardy trigger to straight
 interrupt.
References: <1283725218-15157-1-git-send-email-jic23@cam.ac.uk> <1283725218-15157-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1283725218-15157-3-git-send-email-jic23@cam.ac.uk>
Content-Type: multipart/mixed;
 boundary="------------090209080707020108000006"
List-ID: <linux-iio@vger.kernel.org>

This is a multi-part message in MIME format.
--------------090209080707020108000006
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by iis.fhg.de id KAA20203

Am 06.09.2010 00:20, schrieb Jonathan Cameron:
> The use of the interface for the trigger was lifted from the
> lis3l02dq.  There it is needed because the same physical line
> is used for data ready and event interrupts.  Her it isn't
> so we can simplify things.

I guess this patch has to be applied to all other adis devices as well.

>
> Signed-off-by: Jonathan Cameron<jic23@cam.ac.uk>
> ---
>   drivers/staging/iio/imu/adis16350_core.c    |   27 ++------------
>   drivers/staging/iio/imu/adis16350_trigger.c |   52 ++++++++----------=
---------
>   2 files changed, 18 insertions(+), 61 deletions(-)
>
> diff --git a/drivers/staging/iio/imu/adis16350_core.c b/drivers/staging=
/iio/imu/adis16350_core.c
> index d8181f9..e500a5c 100644
> --- a/drivers/staging/iio/imu/adis16350_core.c
> +++ b/drivers/staging/iio/imu/adis16350_core.c
> @@ -583,14 +583,6 @@ static const struct attribute_group adis16350_attr=
ibute_group =3D {
>   	.attrs =3D adis16350_attributes,
>   };
>
> -static struct attribute *adis16350_event_attributes[] =3D {
> -	NULL,
> -};
> -
> -static struct attribute_group adis16350_event_attribute_group =3D {
> -	.attrs =3D adis16350_event_attributes,
> -};
> -
>   static int __devinit adis16350_probe(struct spi_device *spi)
>   {
>   	int ret, regdone =3D 0;
> @@ -624,8 +616,6 @@ static int __devinit adis16350_probe(struct spi_dev=
ice *spi)
>   	}
>
>   	st->indio_dev->dev.parent =3D&spi->dev;
> -	st->indio_dev->num_interrupt_lines =3D 1;
> -	st->indio_dev->event_attrs =3D&adis16350_event_attribute_group;
>   	st->indio_dev->attrs =3D&adis16350_attribute_group;
>   	st->indio_dev->dev_data =3D (void *)(st);
>   	st->indio_dev->driver_module =3D THIS_MODULE;
> @@ -647,17 +637,9 @@ static int __devinit adis16350_probe(struct spi_de=
vice *spi)
>   	}
>
>   	if (spi->irq) {
> -		ret =3D iio_register_interrupt_line(spi->irq,
> -				st->indio_dev,
> -				0,
> -				IRQF_TRIGGER_RISING,
> -				"adis16350");
> -		if (ret)
> -			goto error_uninitialize_ring;
> -
>   		ret =3D adis16350_probe_trigger(st->indio_dev);
>   		if (ret)
> -			goto error_unregister_line;
> +			goto error_uninitialize_ring;
>   	}
>
>   	/* Get the device into a sane initial state */
> @@ -667,10 +649,8 @@ static int __devinit adis16350_probe(struct spi_de=
vice *spi)
>   	return 0;
>
>   error_remove_trigger:
> -	adis16350_remove_trigger(st->indio_dev);
> -error_unregister_line:
>   	if (spi->irq)
> -		iio_unregister_interrupt_line(st->indio_dev, 0);
> +		adis16350_remove_trigger(st->indio_dev);
>   error_uninitialize_ring:
>   	iio_ring_buffer_unregister(st->indio_dev->ring);
>   error_unreg_ring_funcs:
> @@ -702,9 +682,8 @@ static int adis16350_remove(struct spi_device *spi)
>
>   	flush_scheduled_work();
>
> -	adis16350_remove_trigger(indio_dev);
>   	if (spi->irq)
> -		iio_unregister_interrupt_line(indio_dev, 0);
> +		adis16350_remove_trigger(indio_dev);
>
>   	iio_ring_buffer_unregister(indio_dev->ring);
>   	iio_device_unregister(indio_dev);
> diff --git a/drivers/staging/iio/imu/adis16350_trigger.c b/drivers/stag=
ing/iio/imu/adis16350_trigger.c
> index 739b7ec..7f26de8 100644
> --- a/drivers/staging/iio/imu/adis16350_trigger.c
> +++ b/drivers/staging/iio/imu/adis16350_trigger.c
> @@ -13,23 +13,14 @@
>   #include "adis16350.h"
>
>   /**
> - * adis16350_data_rdy_trig_poll() the event handler for the data rdy t=
rig
> + * adis16350_data_rdy_trig_poll() the interrupt th for the data rdy tr=
ig
>    **/
> -static int adis16350_data_rdy_trig_poll(struct iio_dev *dev_info,
> -				       int index,
> -				       s64 timestamp,
> -				       int no_test)
> +static irqreturn_t adis16350_data_rdy_trig_poll(int irq, void *private=
)
>   {
> -	struct adis16350_state *st =3D iio_dev_get_devdata(dev_info);
> -	struct iio_trigger *trig =3D st->trig;
> -
> -	iio_trigger_poll(trig, timestamp);
> -
> +	iio_trigger_poll(private, iio_get_time_ns());
>   	return IRQ_HANDLED;
>   }
>
> -IIO_EVENT_SH(data_rdy_trig,&adis16350_data_rdy_trig_poll);
> -
>   static IIO_TRIGGER_NAME_ATTR;
>
>   static struct attribute *adis16350_trigger_attrs[] =3D {
> @@ -53,36 +44,16 @@ static int adis16350_data_rdy_trigger_set_state(str=
uct iio_trigger *trig,
>
>   	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
>   	ret =3D adis16350_set_irq(&st->indio_dev->dev, state);
> -	if (state =3D=3D false) {
> -		iio_remove_event_from_list(&iio_event_data_rdy_trig,
> -					&indio_dev->interrupts[0]
> -					   ->ev_list);
> -		/* possible quirk with handler currently worked around
> -		   by ensuring the work queue is empty */
> +	if (state =3D=3D false)
>   		flush_scheduled_work();
> -	} else {
> -		iio_add_event_to_list(&iio_event_data_rdy_trig,
> -				&indio_dev->interrupts[0]->ev_list);
> -	}
> -	return ret;
> -}
>
> -/**
> - * adis16350_trig_try_reen() try renabling irq for data rdy trigger
> - * @trig:	the datardy trigger
> - **/
> -static int adis16350_trig_try_reen(struct iio_trigger *trig)
> -{
> -	struct adis16350_state *st =3D trig->private_data;
> -	enable_irq(st->us->irq);
> -	/* irq reenabled so success! */
> -	return 0;
> +	return ret;
>   }
>
>   int adis16350_probe_trigger(struct iio_dev *indio_dev)
>   {
>   	int ret;
> -	struct adis16350_state *st =3D indio_dev->dev_data;
> +	struct adis16350_state *st =3D iio_dev_get_devdata(indio_dev);
>
>   	st->trig =3D iio_allocate_trigger();
>   	st->trig->name =3D kasprintf(GFP_KERNEL,
> @@ -96,7 +67,6 @@ int adis16350_probe_trigger(struct iio_dev *indio_dev=
)
>   	st->trig->owner =3D THIS_MODULE;
>   	st->trig->private_data =3D st;
>   	st->trig->set_trigger_state =3D&adis16350_data_rdy_trigger_set_state=
;
> -	st->trig->try_reenable =3D&adis16350_trig_try_reen;
>   	st->trig->control_attrs =3D&adis16350_trigger_attr_group;
>   	ret =3D iio_trigger_register(st->trig);
>
> @@ -105,8 +75,15 @@ int adis16350_probe_trigger(struct iio_dev *indio_d=
ev)
>   	if (ret)
>   		goto error_free_trig_name;
>
> +	ret =3D request_irq(st->us->irq, adis16350_data_rdy_trig_poll,
> +			IRQF_TRIGGER_RISING, st->trig->name, st->trig);
> +	if (ret)
> +		goto error_trigger_unregister;
> +
>   	return 0;
>
> +error_trigger_unregister:
> +	iio_trigger_unregister(st->trig);
>   error_free_trig_name:
>   	kfree(st->trig->name);
>   error_free_trig:
> @@ -117,8 +94,9 @@ error_free_trig:
>
>   void adis16350_remove_trigger(struct iio_dev *indio_dev)
>   {
> -	struct adis16350_state *state =3D indio_dev->dev_data;
> +	struct adis16350_state *state =3D iio_dev_get_devdata(indio_dev);
>
> +	free_irq(state->us->irq, state->trig);
>   	iio_trigger_unregister(state->trig);
>   	kfree(state->trig->name);
>   	iio_free_trigger(state->trig);


--=20
Dipl.-Inf. Manuel Stahl
Fraunhofer-Institut f=FCr Integrierte Schaltungen IIS
- Leistungsoptimierte Systeme -
Nordostpark 93                Telefon  +49 (0)911/58061-6419
90411 N=FCrnberg                Fax      +49 (0)911/58061-6398
http://www.iis.fraunhofer.de  manuel.stahl@iis.fraunhofer.de

--------------090209080707020108000006
Content-Type: text/x-vcard; charset=utf-8;
 name="manuel_stahl.vcf"
Content-Disposition: attachment;
 filename="manuel_stahl.vcf"
Content-Transfer-Encoding: 7bit

begin:vcard
fn:Manuel Stahl
n:Stahl;Manuel
email;internet:manuel.stahl@iis.fraunhofer.de
tel;work:+49 911 58061-6419
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------090209080707020108000006--
