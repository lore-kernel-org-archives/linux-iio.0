Return-Path: <nicola@corna.info>
Mime-Version: 1.0
Date: Sat, 22 Aug 2015 17:50:50 +0000
Content-Type: text/plain; charset="utf-8"
Message-ID: <a6d1e7ad0dde50fc05f69c99efed9cd7@rainloop.corna.info>
From: "Nicola Corna" <nicola@corna.info>
Subject: Re: [PATCH 3/3] iio:humidity:si7020: added processed data
To: "Jonathan Cameron" <jic23@kernel.org>, "Hartmut Knaack"
 <knaack.h@gmx.de>, "Lars-Peter Clausen" <lars@metafoo.de>, "Peter
 Meerwald" <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
In-Reply-To: <55D8AFB3.6010603@kernel.org>
References: <55D8AFB3.6010603@kernel.org>
 <1440079909-1337-1-git-send-email-nicola@corna.info>
 <1440079909-1337-3-git-send-email-nicola@corna.info>
List-ID: <linux-iio@vger.kernel.org>

August 22 2015 7:21 PM, "Jonathan Cameron" <jic23@kernel.org> wrote:=0A> =
On 20/08/15 15:11, Nicola Corna wrote:=0A> =0A>> The value given by the S=
i7013/20/21 modules needs a conversion using a=0A>> small expression in o=
rder to obtain the measurement in =C2=B0C or %RH. This=0A>> patch adds th=
e computation inside the si7020 module, allowing the user to=0A>> obtain =
the measurement in m=C2=B0C and 10E-3%RH without any additional=0A>> calc=
ulation.=0A>> =0A>> Signed-off-by: Nicola Corna <nicola@corna.info>=0A> =
=0A> What is the benefit in doing this? Userspace already has all the num=
bers=0A> to calculate the value? The calculation is trivial to do in user=
space.=0A> The basic principle of IIO is to do as little as possible in t=
he driver=0A> and to leave such calculations to userspace which has the b=
enefit of=0A> easy access to floating point calculations if desired.=0A> =
=0A> So sorry, not taking this one.=0A> =0A> Jonathan=0A> =0A=0AOk, thank=
s anyway.=0A=0A>> ---=0A>> drivers/iio/humidity/si7020.c | 18 +++++++++++=
+++++--=0A>> 1 file changed, 16 insertions(+), 2 deletions(-)=0A>> =0A>> =
diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.=
c=0A>> index a8bad04..c534706 100644=0A>> --- a/drivers/iio/humidity/si70=
20.c=0A>> +++ b/drivers/iio/humidity/si7020.c=0A>> @@ -70,6 +70,7 @@ stat=
ic int si7020_read_raw(struct iio_dev *indio_dev,=0A>> =0A>> switch (mask=
) {=0A>> case IIO_CHAN_INFO_RAW:=0A>> + case IIO_CHAN_INFO_PROCESSED:=0A>=
> if (holdmode) {=0A>> ret =3D i2c_smbus_read_word_data(*client,=0A>> cha=
n->type =3D=3D IIO_TEMP ?=0A>> @@ -108,6 +109,17 @@ static int si7020_rea=
d_raw(struct iio_dev *indio_dev,=0A>> else if (*val > 55575) /* 100%RH */=
=0A>> *val =3D 55575;=0A>> }=0A>> + if (mask =3D=3D IIO_CHAN_INFO_PROCESS=
ED) {=0A>> + /*=0A>> + * To avoid overflows the fractions can be simplifi=
ed:=0A>> + * temperature --> 175720 / (65536 >> 2) =3D 21965 / 2048=0A>> =
+ * humidity --> 125000 / (65536 >> 2) =3D 15625 / 2048=0A>> + */=0A>> + =
if (chan->type =3D=3D IIO_TEMP)=0A>> + *val =3D (*val - 4368) * 21965 / 2=
048;=0A>> + else=0A>> + *val =3D (*val - 768) * 15625 / 2048;=0A>> + }=0A=
>> return IIO_VAL_INT;=0A>> case IIO_CHAN_INFO_SCALE:=0A>> if (chan->type=
 =3D=3D IIO_TEMP)=0A>> @@ -142,12 +154,14 @@ static const struct iio_chan=
_spec si7020_channels[] =3D {=0A>> {=0A>> .type =3D IIO_HUMIDITYRELATIVE,=
=0A>> .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |=0A>> - BIT(IIO_CHA=
N_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),=0A>> + BIT(IIO_CHAN_INFO_SCALE=
) | BIT(IIO_CHAN_INFO_OFFSET) |=0A>> + BIT(IIO_CHAN_INFO_PROCESSED),=0A>>=
 },=0A>> {=0A>> .type =3D IIO_TEMP,=0A>> .info_mask_separate =3D BIT(IIO_=
CHAN_INFO_RAW) |=0A>> - BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFS=
ET),=0A>> + BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET) |=0A>> +=
 BIT(IIO_CHAN_INFO_PROCESSED),=0A>> }=0A>> };
