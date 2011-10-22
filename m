Return-Path: <maxin.john@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4E60B63C.1030101@cam.ac.uk>
References: <20110902094107.GA2846@maxin>
	<4E60B63C.1030101@cam.ac.uk>
Date: Sat, 22 Oct 2011 08:15:27 +0300
Message-ID: <CAMhs6Yzw3-CARTULhy4s-Re4Q82Ek9gZGUQtABLLs0PSArHCuw@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: light: Fix compiler warning in tsl2563.c
From: Maxin B John <maxin.john@gmail.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Dan Carpenter <error27@gmail.com>, Bryan Freed <bfreed@chromium.org>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-iio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	devel@driverdev.osuosl.org, Amit Kucheria <amit.kucheria@verdurent.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi,

On Fri, Sep 2, 2011 at 1:55 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> On 09/02/11 10:41, Maxin B. John wrote:
>>> Don't overwrite the error code. =A0For example, the lower layers can
>>> return -EAGAIN and that's more useful than just returning -EIO every
>>> time.
>> Ahh.. Thanks a lot for explaining this.
>>
>>> Your fix works, but it's not very clean. =A0Just add a "*id =3D ret;"
>>> line before the "return 0;" and that's it. =A0(It doesn't make sense
>>> to pass a pointer to "id" and not use it).
>> Dan, yes, I agree with you. This fix is much much better than what I
>> had in my mind.
>>
>>> Yikes - I wonder why my various compilers don't throw that up.
>> I guess, in "iio-blue.git" tree, the 'id =3D 0' suppresses this warning.
> That'd do it. oops.
>
> Ideally keep the white space but doesn't really matter. Either send on
> to Greg directly or I'll add it to iio-blue and send on with the next fix=
es
> series - probably this afternoon.
>>
>> Signed-off-by: Maxin B. John <maxin.john@gmail.com>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>

Sorry for the delay in replying to this mail. I am curious about the
status of this patch. I couldn't locate this patch at  iio-blue.git as
it is not present in kernel.org now
(http://git.kernel.org/?p=3Dlinux/kernel/git/jic23/iio-blue.git;a=3Dsummary=
)
Please ignore this mail if you have already added this patch to your tree.

>> ---
>> diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/l=
ight/tsl2563.c
>> index f25243b..55012ff 100644
>> --- a/drivers/staging/iio/light/tsl2563.c
>> +++ b/drivers/staging/iio/light/tsl2563.c
>> @@ -226,7 +226,7 @@ static int tsl2563_read_id(struct tsl2563_chip *chip=
, u8 *id)
>> =A0 =A0 =A0 ret =3D i2c_smbus_read_byte_data(client, TSL2563_CMD | TSL25=
63_REG_ID);
>> =A0 =A0 =A0 if (ret < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> -
>> + =A0 =A0 *id =3D ret;
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>>
>
>

Warm Regards,
Maxin B. John
