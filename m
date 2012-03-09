Return-Path: <grundler@google.com>
MIME-Version: 1.0
Sender: grundler@google.com
In-Reply-To: <4F57465D.1000402@kernel.org>
References: <1330967759-18660-1-git-send-email-grundler@chromium.org>
	<4F57465D.1000402@kernel.org>
Date: Thu, 8 Mar 2012 19:51:07 -0800
Message-ID: <CANEJEGvWm83ucH8RH5HK_otTae2AxpUsvLV1XDA9=-JOL1kMGQ@mail.gmail.com>
Subject: Re: [PATCH] staging:iio:tsl2563 rewrite probe error handling
From: Grant Grundler <grundler@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Benson Leung <bleung@chromium.org>, Bryan Freed <bfreed@chromium.org>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan!

On Wed, Mar 7, 2012 at 3:28 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> Fundamentally an excellent patch fixing some real issues,

Thank you! :)

> but just
> because I'm in that sort of mood I'll be fussy about the fact it is
> one patch.
>
> To nitpick, I'd have prefered this to be two patches. First that fixes
> the issues and the second that adds the additional output. =C2=A0Actually
> should probably have even had a third making the white space changes.

Yup - I see/understand why. I need to improve my git foo and work
habits so it's not hard to play with a series of smaller patches
rather than one patch that does everything to one function.

> In particular 'device not found' and 'device detect error' are both
> valid explanations. =C2=A0Perhaps it's nice to have everything more
> consistent but that shouldn't have been in the same patch as some out
> and out fixes. =C2=A0Fixes will probably get back ported to stable trees,
> error messages won't.
>
> Still,getting the fix in place is the most important thing so if Greg
> is willing to pick this up then it has my Ack.

Thanks!

BTW, the bug(s) I fixed with this patch showed up because 3.2.7 (and
predecessors) didn't have this patch:
    Author: Jonathan Cameron <jic23@cam.ac.uk>
    Date:   Wed Oct 26 17:27:36 2011 +0100

    staging:iio:light:tsl2563 both intensity channels have same chan_spec.

    Bug has been fixed for some time in the outofstaging tree, but
    didn't propogate back to here.

please consider adding this to linux-stable series.

cheers,
grant

>
> On 03/05/2012 05:15 PM, Grant Grundler wrote:
>> tsl2563 probe function has two minor issues with it's error handling pat=
hs:
>> 1) it is silent (did not report errors to dmesg)
>> 2) did not return failure code (mixed up use of ret and err)
>>
>> and two major issues:
>> 3) goto fail2 would corrupt a free memory pool ("double free")
>> 4) device registration failure did NOT cancel/flush delayed work.
>> =C2=A0 =C2=A0(and thus dereference a freed data structure later)
>>
>> The "double free" is subtle and was introduced with this change:
>> =C2=A0 =C2=A0 Author: Jonathan Cameron <jic23@cam.ac.uk>
>> =C2=A0 =C2=A0 Date: =C2=A0 Mon Apr 18 12:58:55 2011 +0100
>> =C2=A0 =C2=A0 staging:iio:tsl2563 take advantage of new iio_device_alloc=
ate private data.
> oops. =C2=A0Thanks for picking up on this one.
>>
>> Originally, chip was allocated seperately. Now it's appended to the
>> indio_dev by iio_allocate_device(sizeof(*chip)). So we only need one
>> kfree call as well (in iio_free_device()).
>>
>> Signed-off-by: Grant Grundler <grundler@chromium.org>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
>> ---
>> =C2=A0Gory details of tracking this down are here:
>> =C2=A0 =C2=A0 http://crosbug.com/26819
>>
>> =C2=A0Despite iio_device_registration failing, system can at least now b=
oot.
>> =C2=A0Will follow up with a fix to "double register : in_intensity_both_=
raw"
>> =C2=A0error that is included in the bug report.
>>
>> =C2=A0drivers/staging/iio/light/tsl2563.c | =C2=A0 39 ++++++++++++++++++=
+++++-----------
>> =C2=A01 files changed, 26 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/l=
ight/tsl2563.c
>> index 7e984bc..bf6498b 100644
>> --- a/drivers/staging/iio/light/tsl2563.c
>> +++ b/drivers/staging/iio/light/tsl2563.c
>> @@ -705,7 +705,6 @@ static int __devinit tsl2563_probe(struct i2c_client=
 *client,
>> =C2=A0 =C2=A0 =C2=A0 struct tsl2563_chip *chip;
>> =C2=A0 =C2=A0 =C2=A0 struct tsl2563_platform_data *pdata =3D client->dev=
.platform_data;
>> =C2=A0 =C2=A0 =C2=A0 int err =3D 0;
>> - =C2=A0 =C2=A0 int ret;
>> =C2=A0 =C2=A0 =C2=A0 u8 id =3D 0;
>>
>> =C2=A0 =C2=A0 =C2=A0 indio_dev =3D iio_allocate_device(sizeof(*chip));
>> @@ -719,13 +718,15 @@ static int __devinit tsl2563_probe(struct i2c_clie=
nt *client,
>>
>> =C2=A0 =C2=A0 =C2=A0 err =3D tsl2563_detect(chip);
>> =C2=A0 =C2=A0 =C2=A0 if (err) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&client->dev, "devic=
e not found, error %d\n", -err);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&client->dev, "detec=
t error %d\n", -err);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail1;
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 err =3D tsl2563_read_id(chip, &id);
>> - =C2=A0 =C2=A0 if (err)
>> + =C2=A0 =C2=A0 if (err) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&client->dev, "read =
id error %d\n", -err);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail1;
>> + =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 mutex_init(&chip->lock);
>>
>> @@ -748,40 +749,52 @@ static int __devinit tsl2563_probe(struct i2c_clie=
nt *client,
>> =C2=A0 =C2=A0 =C2=A0 indio_dev->num_channels =3D ARRAY_SIZE(tsl2563_chan=
nels);
>> =C2=A0 =C2=A0 =C2=A0 indio_dev->dev.parent =3D &client->dev;
>> =C2=A0 =C2=A0 =C2=A0 indio_dev->modes =3D INDIO_DIRECT_MODE;
> Certainly no problem with white space here to make the sections of
> code more obvious, but it doesn't belong in a patch with bug fixes.
>> +
>> =C2=A0 =C2=A0 =C2=A0 if (client->irq)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev->info =3D &ts=
l2563_info;
>> =C2=A0 =C2=A0 =C2=A0 else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev->info =3D &ts=
l2563_info_no_irq;
>> +
>> =C2=A0 =C2=A0 =C2=A0 if (client->irq) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D request_threaded_irq=
(client->irq,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D request_threaded_irq=
(client->irq,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0NULL,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&tsl2563_event_handler,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0"tsl2563_event",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0indio_dev);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
goto fail2;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
dev_err(&client->dev, "irq request error %d\n", -err);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
goto fail1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 }
>> +
>> =C2=A0 =C2=A0 =C2=A0 err =3D tsl2563_configure(chip);
>> - =C2=A0 =C2=A0 if (err)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail3;
>> + =C2=A0 =C2=A0 if (err) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&client->dev, "confi=
gure error %d\n", -err);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail2;
>> + =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 INIT_DELAYED_WORK(&chip->poweroff_work, tsl2563_pow=
eroff_work);
>> +
>> =C2=A0 =C2=A0 =C2=A0 /* The interrupt cannot yet be enabled so this is f=
ine without lock */
>> =C2=A0 =C2=A0 =C2=A0 schedule_delayed_work(&chip->poweroff_work, 5 * HZ)=
;
>>
>> - =C2=A0 =C2=A0 ret =3D iio_device_register(indio_dev);
>> - =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 err =3D iio_device_register(indio_dev);
>> + =C2=A0 =C2=A0 if (err) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&client->dev, "iio r=
egistration error %d\n", -err);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail3;
>> + =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 return 0;
>> +
>> =C2=A0fail3:
>> + =C2=A0 =C2=A0 cancel_delayed_work(&chip->poweroff_work);
>> + =C2=A0 =C2=A0 flush_scheduled_work();
>> +fail2:
>> =C2=A0 =C2=A0 =C2=A0 if (client->irq)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free_irq(client->irq, i=
ndio_dev);
>> -fail2:
>> - =C2=A0 =C2=A0 iio_free_device(indio_dev);
>> =C2=A0fail1:
>> - =C2=A0 =C2=A0 kfree(chip);
>> + =C2=A0 =C2=A0 iio_free_device(indio_dev);
>> =C2=A0 =C2=A0 =C2=A0 return err;
>> =C2=A0}
>>
>
