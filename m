Return-Path: <grundler@google.com>
MIME-Version: 1.0
Sender: grundler@google.com
In-Reply-To: <CAEYUcX0ofOgv+G2aUaqcpEZhJU7UmBpxTZ0ye1FkcWdkHLR0MA@mail.gmail.com>
References: <1330967759-18660-1-git-send-email-grundler@chromium.org>
	<CAEYUcX0ofOgv+G2aUaqcpEZhJU7UmBpxTZ0ye1FkcWdkHLR0MA@mail.gmail.com>
Date: Mon, 5 Mar 2012 14:12:04 -0800
Message-ID: <CANEJEGs-BG4Dv6m0f0r+bue=hg+JWJSw4fxQKFYivkxf6qOA2Q@mail.gmail.com>
Subject: Re: [PATCH] staging:iio:tsl2563 rewrite probe error handling
From: Grant Grundler <grundler@chromium.org>
To: Bryan Freed <bfreed@chromium.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Benson Leung <bleung@chromium.org>, linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Mar 5, 2012 at 1:53 PM, Bryan Freed <bfreed@chromium.org> wrote:
> Looks good to me, too,

Thanks for reviewing!

> but couldn't we get rid of one fail state (fail3) by
> reversing the order of=C2=A0schedule_delayed_work() and=C2=A0iio_device_r=
egister()?

My focus on this patch was to get a driver to load/unload properly and
avoid restructuring bits that can be deferred to later patches.

I had the same thought and considered this. The problem is I don't
understand or have time to investigate the locking that is hinted at
in the comment preceding the call to schedule_delayed_work(). I don't
understand what locking they are referring to since interrupts are in
fact enabled by the time the delayed work function is invoked.

I have to wonder if the comment is left over from when the function
was directly called instead of "delayed work".  ie race condition
exists regardless of when we call schedule_delayed_work().

> Reviewed-by: Bryan Freed <bfreed@chromium.org>

Thanks! :)

cheers,
grant

>
> bryan.
>
> On Mon, Mar 5, 2012 at 9:15 AM, Grant Grundler <grundler@chromium.org>
> wrote:
>>
>> tsl2563 probe function has two minor issues with it's error handling
>> paths:
>> 1) it is silent (did not report errors to dmesg)
>> 2) did not return failure code (mixed up use of ret and err)
>>
>> and two major issues:
>> 3) goto fail2 would corrupt a free memory pool ("double free")
>> 4) device registration failure did NOT cancel/flush delayed work.
>> =C2=A0 (and thus dereference a freed data structure later)
>>
>> The "double free" is subtle and was introduced with this change:
>> =C2=A0 =C2=A0Author: Jonathan Cameron <jic23@cam.ac.uk>
>> =C2=A0 =C2=A0Date: =C2=A0 Mon Apr 18 12:58:55 2011 +0100
>> =C2=A0 =C2=A0staging:iio:tsl2563 take advantage of new iio_device_alloca=
te private
>> data.
>>
>> Originally, chip was allocated seperately. Now it's appended to the
>> indio_dev by iio_allocate_device(sizeof(*chip)). So we only need one
>> kfree call as well (in iio_free_device()).
>>
>> Signed-off-by: Grant Grundler <grundler@chromium.org>
>> ---
>> =C2=A0Gory details of tracking this down are here:
>> =C2=A0 =C2=A0http://crosbug.com/26819
>>
>> =C2=A0Despite iio_device_registration failing, system can at least now b=
oot.
>> =C2=A0Will follow up with a fix to "double register : in_intensity_both_=
raw"
>> =C2=A0error that is included in the bug report.
>>
>> =C2=A0drivers/staging/iio/light/tsl2563.c | =C2=A0 39
>> +++++++++++++++++++++++-----------
>> =C2=A01 files changed, 26 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/staging/iio/light/tsl2563.c
>> b/drivers/staging/iio/light/tsl2563.c
>> index 7e984bc..bf6498b 100644
>> --- a/drivers/staging/iio/light/tsl2563.c
>> +++ b/drivers/staging/iio/light/tsl2563.c
>> @@ -705,7 +705,6 @@ static int __devinit tsl2563_probe(struct i2c_client
>> *client,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct tsl2563_chip *chip;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct tsl2563_platform_data *pdata =3D clien=
t->dev.platform_data;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int err =3D 0;
>> - =C2=A0 =C2=A0 =C2=A0 int ret;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 id =3D 0;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev =3D iio_allocate_device(sizeof(*chi=
p));
>> @@ -719,13 +718,15 @@ static int __devinit tsl2563_probe(struct i2c_clie=
nt
>> *client,
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D tsl2563_detect(chip);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&client->dev,=
 "device not found, error %d\n",
>> -err);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&client->dev,=
 "detect error %d\n", -err);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail1;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D tsl2563_read_id(chip, &id);
>> - =C2=A0 =C2=A0 =C2=A0 if (err)
>> + =C2=A0 =C2=A0 =C2=A0 if (err) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&client->dev,=
 "read id error %d\n", -err);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail1;
>> + =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_init(&chip->lock);
>>
>> @@ -748,40 +749,52 @@ static int __devinit tsl2563_probe(struct i2c_clie=
nt
>> *client,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev->num_channels =3D ARRAY_SIZE(tsl256=
3_channels);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev->dev.parent =3D &client->dev;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev->modes =3D INDIO_DIRECT_MODE;
>> +
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (client->irq)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev->info =
=3D &tsl2563_info;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev->info =
=3D &tsl2563_info_no_irq;
>> +
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (client->irq) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D request_threa=
ded_irq(client->irq,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D request_threa=
ded_irq(client->irq,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 NULL,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &tsl2563_event_handler,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 IRQF_TRIGGER_RISING |
>> IRQF_ONESHOT,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 "tsl2563_event",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 indio_dev);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 goto fail2;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 dev_err(&client->dev, "irq request error %d\n",
>> -err);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 goto fail1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> +
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D tsl2563_configure(chip);
>> - =C2=A0 =C2=A0 =C2=A0 if (err)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail3;
>> + =C2=A0 =C2=A0 =C2=A0 if (err) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&client->dev,=
 "configure error %d\n", -err);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail2;
>> + =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0INIT_DELAYED_WORK(&chip->poweroff_work, tsl25=
63_poweroff_work);
>> +
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* The interrupt cannot yet be enabled so thi=
s is fine without lock
>> */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0schedule_delayed_work(&chip->poweroff_work, 5=
 * HZ);
>>
>> - =C2=A0 =C2=A0 =C2=A0 ret =3D iio_device_register(indio_dev);
>> - =C2=A0 =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 err =3D iio_device_register(indio_dev);
>> + =C2=A0 =C2=A0 =C2=A0 if (err) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&client->dev,=
 "iio registration error %d\n",
>> -err);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail3;
>> + =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>> +
>> =C2=A0fail3:
>> + =C2=A0 =C2=A0 =C2=A0 cancel_delayed_work(&chip->poweroff_work);
>> + =C2=A0 =C2=A0 =C2=A0 flush_scheduled_work();
>> +fail2:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (client->irq)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_irq(client->=
irq, indio_dev);
>> -fail2:
>> - =C2=A0 =C2=A0 =C2=A0 iio_free_device(indio_dev);
>> =C2=A0fail1:
>> - =C2=A0 =C2=A0 =C2=A0 kfree(chip);
>> + =C2=A0 =C2=A0 =C2=A0 iio_free_device(indio_dev);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;
>> =C2=A0}
>>
>> --
>> 1.7.3.4
>>
>
