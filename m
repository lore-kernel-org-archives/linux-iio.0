Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4BD7706F.70003@cam.ac.uk>
References: <4BD5F4A8.7020309@cam.ac.uk> <0F1B54C89D5F954D8535DB252AF412FA048553F4@chinexm1.ad.analog.com>
	<4BD7706F.70003@cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 28 Apr 2010 10:46:28 +0800
Message-ID: <t2x3c17e3571004271946o293cbc89hd40b5207ef10bb94@mail.gmail.com>
Subject: Re: adis16300 to new abi
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "Song, Barry" <Barry.Song@analog.com>, linux-iio@vger.kernel.org,
	"Zhang, Sonic" <Sonic.Zhang@analog.com>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Apr 28, 2010 at 7:17 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> On 04/27/10 04:20, Song, Barry wrote:
>> Drivers that passed debugging and testing on hardware can be pushed to m=
ainline. By now, ADIS16300 and ADIS16400 drivers are on the list.
>> But the problem is they are based on old abi, will you change codes to m=
atch new abi? If no, we can update codes after you merge the new abi into m=
ainline.
>>
>
> Hi Barry,
>
> I've just taken a quick look at the adis16300 driver. =C2=A0The following
> patch is all that is needed to get it to build against the abi patch set.
> (and touch wood it should still work, be it with an odd mix of abis)
>
> There are other changes to meet the abi, but they can be done via
> incremental patches after this one. =C2=A0They are all name changes (such=
 as
> addition of _raw to the inclination parameters) or additional parameters
> that would be needed by a general userspace interpreter (my
> drivers are missing some of these as well at the moment!). =C2=A0Also the=
re
> are a couple of additions to make to the abi documentation. =C2=A0All of =
these
> could be sorted by a nice clean patch set after the driver patch itself.
>
> Whilst we are here. =C2=A0Under what circumstances does userspace want to=
 reset
> the device manually? =C2=A0Unless there is a clear and common use for thi=
s, I'd
> be inclined to move that particular attribute definition into individual
> drivers.
>
> How do you want to do the actual patch? I could apply the following as
> a 'merge' fix to a clean patch from you, or I can put together a suitable
> hybrid of the two (from you of course). Obviously this would need you
> to take a quick glance and sign-off on it.
Thanks! I prefer you make a hybrid of the two since this patch will be
applied after your new abi is merged.
-barry
>
> Thanks,
>
> Jonathan
> ---
> diff --git a/drivers/staging/iio/imu/adis16300_core.c b/drivers/staging/i=
io/imu/adis16300_core.c
> index 8f84175..94ea2d1 100644
> --- a/drivers/staging/iio/imu/adis16300_core.c
> +++ b/drivers/staging/iio/imu/adis16300_core.c
> @@ -646,9 +646,9 @@ static struct attribute *adis16300_attributes[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0&iio_const_attr_volt_supply_scale.dev_attr.att=
r,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0&iio_dev_attr_gyro_x.dev_attr.attr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0&iio_const_attr_gyro_scale.dev_attr.attr,
> - =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_accel_x.dev_attr.attr,
> - =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_accel_y.dev_attr.attr,
> - =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_accel_z.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_accel_x_raw.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_accel_y_raw.dev_attr.attr,
> + =C2=A0 =C2=A0 =C2=A0 &iio_dev_attr_accel_z_raw.dev_attr.attr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0&iio_const_attr_accel_scale.dev_attr.attr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0&iio_dev_attr_incli_x.dev_attr.attr,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0&iio_dev_attr_incli_y.dev_attr.attr,
> diff --git a/drivers/staging/iio/imu/adis16300_ring.c b/drivers/staging/i=
io/imu/adis16300_ring.c
> index 79298b3..76cf8a6 100644
> --- a/drivers/staging/iio/imu/adis16300_ring.c
> +++ b/drivers/staging/iio/imu/adis16300_ring.c
> @@ -49,7 +49,7 @@ static IIO_SCAN_EL_C(incli_x, ADIS16300_SCAN_INCLI_X, I=
IO_SIGNED(12),
> =C2=A0static IIO_SCAN_EL_C(incli_y, ADIS16300_SCAN_INCLI_Y, IIO_SIGNED(12=
),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ADI=
S16300_YINCLI_OUT, NULL);
>
> -static IIO_SCAN_EL_TIMESTAMP;
> +static IIO_SCAN_EL_TIMESTAMP(9);
>
> =C2=A0static struct attribute *adis16300_scan_el_attrs[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0&iio_scan_el_supply.dev_attr.attr,
> @@ -224,7 +224,7 @@ error_iio_sw_rb_free:
>
> =C2=A0int adis16300_initialize_ring(struct iio_ring_buffer *ring)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 return iio_ring_buffer_register(ring);
> + =C2=A0 =C2=A0 =C2=A0 return iio_ring_buffer_register(ring, 0);
> =C2=A0}
>
> =C2=A0void adis16300_uninitialize_ring(struct iio_ring_buffer *ring)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>
