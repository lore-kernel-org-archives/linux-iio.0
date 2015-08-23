Return-Path: <nicola@corna.info>
Mime-Version: 1.0
Date: Sun, 23 Aug 2015 20:58:08 +0000
Content-Type: text/plain; charset="utf-8"
Message-ID: <3c66d2f7c6de6deaf43fff7de8d348b6@rainloop.corna.info>
From: "Nicola Corna" <nicola@corna.info>
Subject: Re: [PATCH v3 1/2] iio: humidity: si7020: replaced bitmask on
 humidity values with range check
To: "Jonathan Cameron" <jic23@kernel.org>, "Hartmut Knaack"
 <knaack.h@gmx.de>, "Lars-Peter Clausen" <lars@metafoo.de>, "Peter
 Meerwald" <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
In-Reply-To: <55DA291F.40403@kernel.org>
References: <55DA291F.40403@kernel.org>
 <1440333248-3450-1-git-send-email-nicola@corna.info>
 <55D9EB58.50304@kernel.org> <55DA1A17.2020304@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

August 23 2015 10:12 PM, "Jonathan Cameron" <jic23@kernel.org> wrote:=0A>=
 On 23/08/15 20:08, Hartmut Knaack wrote:=0A> =0A>> Jonathan Cameron schr=
ieb am 23.08.2015 um 17:48:=0A>>> On 23/08/15 13:34, Nicola Corna wrote:=
=0A>>>> The maximum possible value for the relative humidity is 55575 (10=
0%RH).=0A>>>> This value, if shifted right by 2 bits, uses 14 bits and ma=
sking it with=0A>>>> a 12 bit mask removes 2 meaningful bits.=0A>>>> The =
masking has been replaced with a range check that sets the minimum=0A>>>>=
 value at 786 (0%RH) and the maximum at 13893 (99.998%RH).=0A>>>> =0A>>>>=
 Signed-off-by: Nicola Corna <nicola@corna.info>=0A>>>> Reviewed-by: Hart=
mut Knaack <knaack.h@gmx.de>=0A>>> =0A>>> Applied. I have taken the view =
that previously the driver=0A>>> was 'limited' by this rather than a nast=
y bug.=0A>>> Hence I've queued it up for the next merge window.=0A>>> App=
lied to the togreg branch of iio.git=0A>> =0A>> This doesn't work, clamp_=
val() returns a result, which has to be assigned=0A>> to a variable (*val=
) in this case. I thought I pointed that out in V2.=0A> =0A> backed out..=
.=0A> =0A> (hadn't pushed it out anywhere yet anyway ;)=0A> =0A> Thanks H=
armut.=0A> =0A=0AWell, I should have paid more attention. Sorry for the i=
nconvenience.=0A=0ANicola Corna=0A=0A>>> Thanks,=0A>>> =0A>>> Jonathan=0A=
>>>> ---=0A>>>> drivers/iio/humidity/si7020.c | 6 +++++-=0A>>>> 1 file ch=
anged, 5 insertions(+), 1 deletion(-)=0A>>>> =0A>>>> diff --git a/drivers=
/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c=0A>>>> index fa3b8=
09..06e6659 100644=0A>>>> --- a/drivers/iio/humidity/si7020.c=0A>>>> +++ =
b/drivers/iio/humidity/si7020.c=0A>>>> @@ -57,8 +57,12 @@ static int si70=
20_read_raw(struct iio_dev *indio_dev,=0A>>>> if (ret < 0)=0A>>>> return =
ret;=0A>>>> *val =3D ret >> 2;=0A>>>> + /*=0A>>>> + * Humidity values can=
 slightly exceed the 0-100%RH=0A>>>> + * range and should be corrected by=
 software=0A>>>> + */=0A>>>> if (chan->type =3D=3D IIO_HUMIDITYRELATIVE)=
=0A>>>> - *val &=3D GENMASK(11, 0);=0A>>>> + clamp_val(*val, 786, 13893);=
=0A>> =0A>> This needs to be: *val =3D clamp_val(...)=0A>> =0A>>>> return=
 IIO_VAL_INT;=0A>>>> case IIO_CHAN_INFO_SCALE:=0A>>>> if (chan->type =3D=
=3D IIO_TEMP)=0A>>> =0A>>> --=0A>>> To unsubscribe from this list: send t=
he line "unsubscribe linux-iio" in=0A>>> the body of a message to majordo=
mo@vger.kernel.org=0A>>> More majordomo info at http://vger.kernel.org/ma=
jordomo-info.html
