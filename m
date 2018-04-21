Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35048 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753138AbeDUSPj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Apr 2018 14:15:39 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH 3/3] stagging:iio:meter: Add ade7854_write_raw function
From: John Syne <john3909@gmail.com>
In-Reply-To: <20180421182608.3371a50b@archlinux>
Date: Sat, 21 Apr 2018 11:15:32 -0700
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Message-Id: <8A7DB0CD-8DB0-40C2-A4F0-9B365E2F78D5@gmail.com>
References: <cover.1524311298.git.rodrigosiqueiramelo@gmail.com>
 <82a36a0f4ee84d8ff53be2055bad22be4b75634a.1524311298.git.rodrigosiqueiramelo@gmail.com>
 <20180421182608.3371a50b@archlinux>
To: Jonathan Cameron <jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



> On Apr 21, 2018, at 10:26 AM, Jonathan Cameron <jic23@kernel.org> =
wrote:
>=20
> On Sat, 21 Apr 2018 08:56:19 -0300
> Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
>=20
>> This patch adds the ade7854_write_raw() function which is responsible
>> for handling the write operation for registers: AIGAIN, BIGAIN, =
CIGAIN,
>> NIGAIN, AVGAIN, BVGAIN, and CVGAIN. Finally, this patch completely
>> removes the old ABI used for handling the registers mentioned above.
>>=20
>> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> The baby steps approach here is good, but with all 3 patches as one it
> would have been a lot easier to follow.
>=20
> This is almost fine except for the issue I had with how the channels
> were defined in the first place.
>=20
> Also a question about scales inline...
>=20
>> ---
>> drivers/staging/iio/meter/ade7854.c | 60 =
++++++++++++-----------------
>> 1 file changed, 25 insertions(+), 35 deletions(-)
>>=20
>> diff --git a/drivers/staging/iio/meter/ade7854.c =
b/drivers/staging/iio/meter/ade7854.c
>> index 242ecde75900..df19c8b4b5d7 100644
>> --- a/drivers/staging/iio/meter/ade7854.c
>> +++ b/drivers/staging/iio/meter/ade7854.c
>> @@ -228,34 +228,6 @@ static int ade7854_reset(struct device *dev)
>> 	return st->write_reg(dev, ADE7854_CONFIG, val, 16);
>> }
>>=20
>> -static IIO_DEV_ATTR_AIGAIN(0644,
>> -		NULL,
>> -		ade7854_write_24bit,
>> -		ADE7854_AIGAIN);
>> -static IIO_DEV_ATTR_BIGAIN(0644,
>> -		NULL,
>> -		ade7854_write_24bit,
>> -		ADE7854_BIGAIN);
>> -static IIO_DEV_ATTR_CIGAIN(0644,
>> -		NULL,
>> -		ade7854_write_24bit,
>> -		ADE7854_CIGAIN);
>> -static IIO_DEV_ATTR_NIGAIN(0644,
>> -		NULL,
>> -		ade7854_write_24bit,
>> -		ADE7854_NIGAIN);
>> -static IIO_DEV_ATTR_AVGAIN(0644,
>> -		NULL,
>> -		ade7854_write_24bit,
>> -		ADE7854_AVGAIN);
>> -static IIO_DEV_ATTR_BVGAIN(0644,
>> -		NULL,
>> -		ade7854_write_24bit,
>> -		ADE7854_BVGAIN);
>> -static IIO_DEV_ATTR_CVGAIN(0644,
>> -		NULL,
>> -		ade7854_write_24bit,
>> -		ADE7854_CVGAIN);
>> static IIO_DEV_ATTR_APPARENT_POWER_A_GAIN(0644,
>> 		ade7854_read_24bit,
>> 		ade7854_write_24bit,
>> @@ -497,6 +469,30 @@ static int ade7854_read_raw(struct iio_dev =
*indio_dev,
>> 	return -EINVAL;
>> }
>>=20
>> +static int ade7854_write_raw(struct iio_dev *indio_dev,
>> +			     struct iio_chan_spec const *chan,
>> +			     int val, int val2, long mask)
>> +{
>> +	struct ade7854_state *st =3D iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	if (mask !=3D IIO_CHAN_INFO_SCALE)
>> +		return -EINVAL;
>> +
>> +	switch (chan->type) {
>> +	case IIO_CURRENT:
>> +	case IIO_VOLTAGE:
> Probably need some range checking to make sure we have a sane value.
>=20
> Also, I'm curious about units here.
>=20
> you are using CHAN_INFO_SCALE which would mean this is linked to
> the _RAW value (the actual reading of the channel) by _RAW*_SCALE =3D =
value in
> defined base units for the channel type.  So I'd expect to see some
> code here doing a conversion to the internal format for the device.
These should be IIO_CHAN_INFO_HARDWAREGAIN as they are used to correct=20=

any imperfections of the sensors. A user space application calculates =
the error and
based on a formula determines the correct register value.=20

Meter values such as Voltage, Current, Power, Energy use a value/LSB =
method,=20
which is determined while applying a known voltage and current. After =
that, any
parameter is multiplied by the respective value/LSB to get a real world =
value.=20

Regards,
John
>=20
> I wouldn't expect to see a value from userspace written unconverted
> into the register.
>=20
> (I missed this in the previous patch - sorry).
>=20
> Jonathan
>=20
>> +		ret =3D st->write_reg(&indio_dev->dev, chan->address, =
val, 24);
>> +		if (ret < 0)
>> +			return ret;
>> +		return 0;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> static int ade7854_initial_setup(struct iio_dev *indio_dev)
>> {
>> 	int ret;
>> @@ -521,13 +517,6 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("8000");
>> static IIO_CONST_ATTR(name, "ade7854");
>>=20
>> static struct attribute *ade7854_attributes[] =3D {
>> -	&iio_dev_attr_aigain.dev_attr.attr,
>> -	&iio_dev_attr_bigain.dev_attr.attr,
>> -	&iio_dev_attr_cigain.dev_attr.attr,
>> -	&iio_dev_attr_nigain.dev_attr.attr,
>> -	&iio_dev_attr_avgain.dev_attr.attr,
>> -	&iio_dev_attr_bvgain.dev_attr.attr,
>> -	&iio_dev_attr_cvgain.dev_attr.attr,
>> 	&iio_dev_attr_linecyc.dev_attr.attr,
>> 	&iio_dev_attr_sagcyc.dev_attr.attr,
>> 	&iio_dev_attr_cfcyc.dev_attr.attr,
>> @@ -599,6 +588,7 @@ static const struct attribute_group =
ade7854_attribute_group =3D {
>> static const struct iio_info ade7854_info =3D {
>> 	.attrs =3D &ade7854_attribute_group,
>> 	.read_raw =3D &ade7854_read_raw,
>> +	.write_raw =3D &ade7854_write_raw,
>> };
>>=20
>> int ade7854_probe(struct iio_dev *indio_dev, struct device *dev)
