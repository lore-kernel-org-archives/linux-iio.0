Return-Path: <bfreed@google.com>
MIME-Version: 1.0
Sender: bfreed@google.com
In-Reply-To: <1330967759-18660-1-git-send-email-grundler@chromium.org>
References: <1330967759-18660-1-git-send-email-grundler@chromium.org>
Date: Mon, 5 Mar 2012 13:55:28 -0800
Message-ID: <CAEYUcX1rtQfzCSfhoxLtAJyCm2xE3cZgRG3cJ+HU3QBvVXKvXg@mail.gmail.com>
Subject: Re: [PATCH] staging:iio:tsl2563 rewrite probe error handling
From: Bryan Freed <bfreed@chromium.org>
To: Grant Grundler <grundler@chromium.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Benson Leung <bleung@chromium.org>, linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Looks good to me, too, but couldn't we get rid of one fail state
(fail3) by reversing the order of=A0schedule_delayed_work() and
iio_device_register()?

Reviewed-by: Bryan Freed <bfreed@chromium.org>

bryan.

On Mon, Mar 5, 2012 at 9:15 AM, Grant Grundler <grundler@chromium.org> wrot=
e:
>
> tsl2563 probe function has two minor issues with it's error handling path=
s:
> 1) it is silent (did not report errors to dmesg)
> 2) did not return failure code (mixed up use of ret and err)
>
> and two major issues:
> 3) goto fail2 would corrupt a free memory pool ("double free")
> 4) device registration failure did NOT cancel/flush delayed work.
> =A0 (and thus dereference a freed data structure later)
>
> The "double free" is subtle and was introduced with this change:
> =A0 =A0Author: Jonathan Cameron <jic23@cam.ac.uk>
> =A0 =A0Date: =A0 Mon Apr 18 12:58:55 2011 +0100
> =A0 =A0staging:iio:tsl2563 take advantage of new iio_device_allocate priv=
ate data.
>
> Originally, chip was allocated seperately. Now it's appended to the
> indio_dev by iio_allocate_device(sizeof(*chip)). So we only need one
> kfree call as well (in iio_free_device()).
>
> Signed-off-by: Grant Grundler <grundler@chromium.org>
> ---
> =A0Gory details of tracking this down are here:
> =A0 =A0http://crosbug.com/26819
>
> =A0Despite iio_device_registration failing, system can at least now boot.
> =A0Will follow up with a fix to "double register : in_intensity_both_raw"
> =A0error that is included in the bug report.
>
> =A0drivers/staging/iio/light/tsl2563.c | =A0 39 +++++++++++++++++++++++--=
---------
> =A01 files changed, 26 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/li=
ght/tsl2563.c
> index 7e984bc..bf6498b 100644
> --- a/drivers/staging/iio/light/tsl2563.c
> +++ b/drivers/staging/iio/light/tsl2563.c
> @@ -705,7 +705,6 @@ static int __devinit tsl2563_probe(struct i2c_client =
*client,
> =A0 =A0 =A0 =A0struct tsl2563_chip *chip;
> =A0 =A0 =A0 =A0struct tsl2563_platform_data *pdata =3D client->dev.platfo=
rm_data;
> =A0 =A0 =A0 =A0int err =3D 0;
> - =A0 =A0 =A0 int ret;
> =A0 =A0 =A0 =A0u8 id =3D 0;
>
> =A0 =A0 =A0 =A0indio_dev =3D iio_allocate_device(sizeof(*chip));
> @@ -719,13 +718,15 @@ static int __devinit tsl2563_probe(struct i2c_clien=
t *client,
>
> =A0 =A0 =A0 =A0err =3D tsl2563_detect(chip);
> =A0 =A0 =A0 =A0if (err) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "device not found, er=
ror %d\n", -err);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "detect error %d\n", =
-err);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail1;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0err =3D tsl2563_read_id(chip, &id);
> - =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "read id error %d\n",=
 -err);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail1;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0mutex_init(&chip->lock);
>
> @@ -748,40 +749,52 @@ static int __devinit tsl2563_probe(struct i2c_clien=
t *client,
> =A0 =A0 =A0 =A0indio_dev->num_channels =3D ARRAY_SIZE(tsl2563_channels);
> =A0 =A0 =A0 =A0indio_dev->dev.parent =3D &client->dev;
> =A0 =A0 =A0 =A0indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> =A0 =A0 =A0 =A0if (client->irq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0indio_dev->info =3D &tsl2563_info;
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0indio_dev->info =3D &tsl2563_info_no_irq;
> +
> =A0 =A0 =A0 =A0if (client->irq) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D request_threaded_irq(client->irq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D request_threaded_irq(client->irq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 NULL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 &tsl2563_event_handler,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 "tsl2563_event",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 indio_dev);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "irq =
request error %d\n", -err);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
> +
> =A0 =A0 =A0 =A0err =3D tsl2563_configure(chip);
> - =A0 =A0 =A0 if (err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail3;
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "configure error %d\n=
", -err);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail2;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0INIT_DELAYED_WORK(&chip->poweroff_work, tsl2563_poweroff_w=
ork);
> +
> =A0 =A0 =A0 =A0/* The interrupt cannot yet be enabled so this is fine wit=
hout lock */
> =A0 =A0 =A0 =A0schedule_delayed_work(&chip->poweroff_work, 5 * HZ);
>
> - =A0 =A0 =A0 ret =3D iio_device_register(indio_dev);
> - =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 err =3D iio_device_register(indio_dev);
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "iio registration err=
or %d\n", -err);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail3;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0return 0;
> +
> =A0fail3:
> + =A0 =A0 =A0 cancel_delayed_work(&chip->poweroff_work);
> + =A0 =A0 =A0 flush_scheduled_work();
> +fail2:
> =A0 =A0 =A0 =A0if (client->irq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_irq(client->irq, indio_dev);
> -fail2:
> - =A0 =A0 =A0 iio_free_device(indio_dev);
> =A0fail1:
> - =A0 =A0 =A0 kfree(chip);
> + =A0 =A0 =A0 iio_free_device(indio_dev);
> =A0 =A0 =A0 =A0return err;
> =A0}
>
> --
> 1.7.3.4
>
