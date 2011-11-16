Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1321434819-23678-6-git-send-email-lars@metafoo.de>
References: <1321434819-23678-1-git-send-email-lars@metafoo.de> <1321434819-23678-6-git-send-email-lars@metafoo.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 16 Nov 2011 10:15:04 -0700
Message-ID: <CACxGe6su+18Ct6E7z8VfbXcOwftxMm49A9Q49Eat8+StT17F4g@mail.gmail.com>
Subject: Re: [PATCH 5/5] staging:iio: Use module_spi_driver to register SPI driver
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jean Delvare <khali@linux-fr.org>,
	Jonathan Cameron <jic23@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org, spi-devel-general@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On Wed, Nov 16, 2011 at 2:13 AM, Lars-Peter Clausen <lars@metafoo.de> wrote=
:
> Use the newly introduced module_spi_driver macro for registering SPI driv=
ers.
> This allows us to remove a few lines of boilerplate code.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

g.

> ---
> =A0drivers/staging/iio/accel/adis16201_core.c | =A0 13 +------------
> =A0drivers/staging/iio/accel/adis16203_core.c | =A0 13 +------------
> =A0drivers/staging/iio/accel/adis16204_core.c | =A0 13 +------------
> =A0drivers/staging/iio/accel/adis16209_core.c | =A0 13 +------------
> =A0drivers/staging/iio/accel/adis16220_core.c | =A0 13 +------------
> =A0drivers/staging/iio/accel/adis16240_core.c | =A0 13 +------------
> =A0drivers/staging/iio/accel/kxsd9.c =A0 =A0 =A0 =A0 =A0| =A0 13 +-------=
-----
> =A0drivers/staging/iio/accel/lis3l02dq_core.c | =A0 13 +------------
> =A0drivers/staging/iio/accel/sca3000_core.c =A0 | =A0 13 +------------
> =A0drivers/staging/iio/adc/ad7192.c =A0 =A0 =A0 =A0 =A0 | =A0 13 +-------=
-----
> =A0drivers/staging/iio/adc/ad7280a.c =A0 =A0 =A0 =A0 =A0| =A0 13 +-------=
-----
> =A0drivers/staging/iio/adc/ad7298_core.c =A0 =A0 =A0| =A0 13 +-----------=
-
> =A0drivers/staging/iio/adc/ad7476_core.c =A0 =A0 =A0| =A0 13 +-----------=
-
> =A0drivers/staging/iio/adc/ad7606_spi.c =A0 =A0 =A0 | =A0 13 +-----------=
-
> =A0drivers/staging/iio/adc/ad7780.c =A0 =A0 =A0 =A0 =A0 | =A0 13 +-------=
-----
> =A0drivers/staging/iio/adc/ad7793.c =A0 =A0 =A0 =A0 =A0 | =A0 13 +-------=
-----
> =A0drivers/staging/iio/adc/ad7816.c =A0 =A0 =A0 =A0 =A0 | =A0 14 +-------=
------
> =A0drivers/staging/iio/adc/ad7887_core.c =A0 =A0 =A0| =A0 13 +-----------=
-
> =A0drivers/staging/iio/adc/adt7310.c =A0 =A0 =A0 =A0 =A0| =A0 14 +-------=
------
> =A0drivers/staging/iio/addac/adt7316-spi.c =A0 =A0| =A0 14 +-------------
> =A0drivers/staging/iio/dac/ad5064.c =A0 =A0 =A0 =A0 =A0 | =A0 13 +-------=
-----
> =A0drivers/staging/iio/dac/ad5360.c =A0 =A0 =A0 =A0 =A0 | =A0 13 +-------=
-----
> =A0drivers/staging/iio/dac/ad5446.c =A0 =A0 =A0 =A0 =A0 | =A0 13 +-------=
-----
> =A0drivers/staging/iio/dac/ad5504.c =A0 =A0 =A0 =A0 =A0 | =A0 13 +-------=
-----
> =A0drivers/staging/iio/dac/ad5624r_spi.c =A0 =A0 =A0| =A0 13 +-----------=
-
> =A0drivers/staging/iio/dac/ad5686.c =A0 =A0 =A0 =A0 =A0 | =A0 13 +-------=
-----
> =A0drivers/staging/iio/dac/ad5791.c =A0 =A0 =A0 =A0 =A0 | =A0 13 +-------=
-----
> =A0drivers/staging/iio/dds/ad5930.c =A0 =A0 =A0 =A0 =A0 | =A0 13 +-------=
-----
> =A0drivers/staging/iio/dds/ad9832.c =A0 =A0 =A0 =A0 =A0 | =A0 13 +-------=
-----
> =A0drivers/staging/iio/dds/ad9834.c =A0 =A0 =A0 =A0 =A0 | =A0 13 +-------=
-----
> =A0drivers/staging/iio/dds/ad9850.c =A0 =A0 =A0 =A0 =A0 | =A0 13 +-------=
-----
> =A0drivers/staging/iio/dds/ad9852.c =A0 =A0 =A0 =A0 =A0 | =A0 13 +-------=
-----
> =A0drivers/staging/iio/dds/ad9910.c =A0 =A0 =A0 =A0 =A0 | =A0 13 +-------=
-----
> =A0drivers/staging/iio/dds/ad9951.c =A0 =A0 =A0 =A0 =A0 | =A0 13 +-------=
-----
> =A0drivers/staging/iio/gyro/adis16080_core.c =A0| =A0 13 +------------
> =A0drivers/staging/iio/gyro/adis16130_core.c =A0| =A0 13 +------------
> =A0drivers/staging/iio/gyro/adis16260_core.c =A0| =A0 13 +------------
> =A0drivers/staging/iio/gyro/adxrs450_core.c =A0 | =A0 13 +------------
> =A0drivers/staging/iio/imu/adis16400_core.c =A0 | =A0 13 +------------
> =A0drivers/staging/iio/meter/ade7753.c =A0 =A0 =A0 =A0| =A0 13 +---------=
---
> =A0drivers/staging/iio/meter/ade7754.c =A0 =A0 =A0 =A0| =A0 13 +---------=
---
> =A0drivers/staging/iio/meter/ade7758_core.c =A0 | =A0 13 +------------
> =A0drivers/staging/iio/meter/ade7759.c =A0 =A0 =A0 =A0| =A0 13 +---------=
---
> =A0drivers/staging/iio/meter/ade7854-spi.c =A0 =A0| =A0 13 +------------
> =A0drivers/staging/iio/resolver/ad2s1200.c =A0 =A0| =A0 13 +------------
> =A0drivers/staging/iio/resolver/ad2s1210.c =A0 =A0| =A0 13 +------------
> =A0drivers/staging/iio/resolver/ad2s90.c =A0 =A0 =A0| =A0 13 +-----------=
-
> =A047 files changed, 47 insertions(+), 567 deletions(-)
>
> diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging=
/iio/accel/adis16201_core.c
> index 1c5dad5..97f747e 100644
> --- a/drivers/staging/iio/accel/adis16201_core.c
> +++ b/drivers/staging/iio/accel/adis16201_core.c
> @@ -549,18 +549,7 @@ static struct spi_driver adis16201_driver =3D {
> =A0 =A0 =A0 =A0.probe =3D adis16201_probe,
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(adis16201_remove),
> =A0};
> -
> -static __init int adis16201_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&adis16201_driver);
> -}
> -module_init(adis16201_init);
> -
> -static __exit void adis16201_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&adis16201_driver);
> -}
> -module_exit(adis16201_exit);
> +module_spi_driver(adis16201_driver);
>
> =A0MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> =A0MODULE_DESCRIPTION("Analog Devices ADIS16201 Programmable Digital Vibr=
ation Sensor driver");
> diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging=
/iio/accel/adis16203_core.c
> index 8a33374..a6d6d27 100644
> --- a/drivers/staging/iio/accel/adis16203_core.c
> +++ b/drivers/staging/iio/accel/adis16203_core.c
> @@ -504,18 +504,7 @@ static struct spi_driver adis16203_driver =3D {
> =A0 =A0 =A0 =A0.probe =3D adis16203_probe,
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(adis16203_remove),
> =A0};
> -
> -static __init int adis16203_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&adis16203_driver);
> -}
> -module_init(adis16203_init);
> -
> -static __exit void adis16203_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&adis16203_driver);
> -}
> -module_exit(adis16203_exit);
> +module_spi_driver(adis16203_driver);
>
> =A0MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> =A0MODULE_DESCRIPTION("Analog Devices ADIS16203 Programmable Digital Vibr=
ation Sensor driver");
> diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging=
/iio/accel/adis16204_core.c
> index 644ac8e..7ac5b4c 100644
> --- a/drivers/staging/iio/accel/adis16204_core.c
> +++ b/drivers/staging/iio/accel/adis16204_core.c
> @@ -577,18 +577,7 @@ static struct spi_driver adis16204_driver =3D {
> =A0 =A0 =A0 =A0.probe =3D adis16204_probe,
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(adis16204_remove),
> =A0};
> -
> -static __init int adis16204_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&adis16204_driver);
> -}
> -module_init(adis16204_init);
> -
> -static __exit void adis16204_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&adis16204_driver);
> -}
> -module_exit(adis16204_exit);
> +module_spi_driver(adis16204_driver);
>
> =A0MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> =A0MODULE_DESCRIPTION("ADIS16204 High-g Digital Impact Sensor and Recorde=
r");
> diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging=
/iio/accel/adis16209_core.c
> index 0a8571b..c03afbf 100644
> --- a/drivers/staging/iio/accel/adis16209_core.c
> +++ b/drivers/staging/iio/accel/adis16209_core.c
> @@ -553,18 +553,7 @@ static struct spi_driver adis16209_driver =3D {
> =A0 =A0 =A0 =A0.probe =3D adis16209_probe,
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(adis16209_remove),
> =A0};
> -
> -static __init int adis16209_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&adis16209_driver);
> -}
> -module_init(adis16209_init);
> -
> -static __exit void adis16209_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&adis16209_driver);
> -}
> -module_exit(adis16209_exit);
> +module_spi_driver(adis16209_driver);
>
> =A0MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> =A0MODULE_DESCRIPTION("Analog Devices ADIS16209 Digital Vibration Sensor =
driver");
> diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging=
/iio/accel/adis16220_core.c
> index 6d4503d..73298e7 100644
> --- a/drivers/staging/iio/accel/adis16220_core.c
> +++ b/drivers/staging/iio/accel/adis16220_core.c
> @@ -708,18 +708,7 @@ static struct spi_driver adis16220_driver =3D {
> =A0 =A0 =A0 =A0.probe =3D adis16220_probe,
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(adis16220_remove),
> =A0};
> -
> -static __init int adis16220_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&adis16220_driver);
> -}
> -module_init(adis16220_init);
> -
> -static __exit void adis16220_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&adis16220_driver);
> -}
> -module_exit(adis16220_exit);
> +module_spi_driver(adis16220_driver);
>
> =A0MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> =A0MODULE_DESCRIPTION("Analog Devices ADIS16220 Digital Vibration Sensor"=
);
> diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging=
/iio/accel/adis16240_core.c
> index b8be292..88881b9 100644
> --- a/drivers/staging/iio/accel/adis16240_core.c
> +++ b/drivers/staging/iio/accel/adis16240_core.c
> @@ -606,18 +606,7 @@ static struct spi_driver adis16240_driver =3D {
> =A0 =A0 =A0 =A0.probe =3D adis16240_probe,
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(adis16240_remove),
> =A0};
> -
> -static __init int adis16240_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&adis16240_driver);
> -}
> -module_init(adis16240_init);
> -
> -static __exit void adis16240_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&adis16240_driver);
> -}
> -module_exit(adis16240_exit);
> +module_spi_driver(adis16240_driver);
>
> =A0MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> =A0MODULE_DESCRIPTION("Analog Devices Programmable Impact Sensor and Reco=
rder");
> diff --git a/drivers/staging/iio/accel/kxsd9.c b/drivers/staging/iio/acce=
l/kxsd9.c
> index 5238503..cfce21c 100644
> --- a/drivers/staging/iio/accel/kxsd9.c
> +++ b/drivers/staging/iio/accel/kxsd9.c
> @@ -280,18 +280,7 @@ static struct spi_driver kxsd9_driver =3D {
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(kxsd9_remove),
> =A0 =A0 =A0 =A0.id_table =3D kxsd9_id,
> =A0};
> -
> -static __init int kxsd9_spi_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&kxsd9_driver);
> -}
> -module_init(kxsd9_spi_init);
> -
> -static __exit void kxsd9_spi_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&kxsd9_driver);
> -}
> -module_exit(kxsd9_spi_exit);
> +module_spi_driver(kxsd9_driver);
>
> =A0MODULE_AUTHOR("Jonathan Cameron <jic23@cam.ac.uk>");
> =A0MODULE_DESCRIPTION("Kionix KXSD9 SPI driver");
> diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging=
/iio/accel/lis3l02dq_core.c
> index 559545a..6877521 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_core.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_core.c
> @@ -804,18 +804,7 @@ static struct spi_driver lis3l02dq_driver =3D {
> =A0 =A0 =A0 =A0.probe =3D lis3l02dq_probe,
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(lis3l02dq_remove),
> =A0};
> -
> -static __init int lis3l02dq_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&lis3l02dq_driver);
> -}
> -module_init(lis3l02dq_init);
> -
> -static __exit void lis3l02dq_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&lis3l02dq_driver);
> -}
> -module_exit(lis3l02dq_exit);
> +module_spi_driver(lis3l02dq_driver);
>
> =A0MODULE_AUTHOR("Jonathan Cameron <jic23@cam.ac.uk>");
> =A0MODULE_DESCRIPTION("ST LIS3L02DQ Accelerometer SPI driver");
> diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/i=
io/accel/sca3000_core.c
> index a44a705..6c35907 100644
> --- a/drivers/staging/iio/accel/sca3000_core.c
> +++ b/drivers/staging/iio/accel/sca3000_core.c
> @@ -1250,18 +1250,7 @@ static struct spi_driver sca3000_driver =3D {
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(sca3000_remove),
> =A0 =A0 =A0 =A0.id_table =3D sca3000_id,
> =A0};
> -
> -static __init int sca3000_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&sca3000_driver);
> -}
> -module_init(sca3000_init);
> -
> -static __exit void sca3000_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&sca3000_driver);
> -}
> -module_exit(sca3000_exit);
> +module_spi_driver(sca3000_driver);
>
> =A0MODULE_AUTHOR("Jonathan Cameron <jic23@cam.ac.uk>");
> =A0MODULE_DESCRIPTION("VTI SCA3000 Series Accelerometers SPI driver");
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/a=
d7192.c
> index 31c376b..a6a4a4e 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -1161,18 +1161,7 @@ static struct spi_driver ad7192_driver =3D {
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D __devexit_p(ad7192_remove),
> =A0 =A0 =A0 =A0.id_table =A0 =A0 =A0 =3D ad7192_id,
> =A0};
> -
> -static int __init ad7192_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ad7192_driver);
> -}
> -module_init(ad7192_init);
> -
> -static void __exit ad7192_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ad7192_driver);
> -}
> -module_exit(ad7192_exit);
> +module_spi_driver(ad7192_driver);
>
> =A0MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> =A0MODULE_DESCRIPTION("Analog Devices AD7190, AD7192, AD7195 ADC");
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/=
ad7280a.c
> index 372d059..dbaeae8 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -979,18 +979,7 @@ static struct spi_driver ad7280_driver =3D {
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D __devexit_p(ad7280_remove),
> =A0 =A0 =A0 =A0.id_table =A0 =A0 =A0 =3D ad7280_id,
> =A0};
> -
> -static int __init ad7280_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ad7280_driver);
> -}
> -module_init(ad7280_init);
> -
> -static void __exit ad7280_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ad7280_driver);
> -}
> -module_exit(ad7280_exit);
> +module_spi_driver(ad7280_driver);
>
> =A0MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> =A0MODULE_DESCRIPTION("Analog Devices AD7280A");
> diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/=
adc/ad7298_core.c
> index c1de73a..a799bd1 100644
> --- a/drivers/staging/iio/adc/ad7298_core.c
> +++ b/drivers/staging/iio/adc/ad7298_core.c
> @@ -276,18 +276,7 @@ static struct spi_driver ad7298_driver =3D {
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D __devexit_p(ad7298_remove),
> =A0 =A0 =A0 =A0.id_table =A0 =A0 =A0 =3D ad7298_id,
> =A0};
> -
> -static int __init ad7298_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ad7298_driver);
> -}
> -module_init(ad7298_init);
> -
> -static void __exit ad7298_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ad7298_driver);
> -}
> -module_exit(ad7298_exit);
> +module_spi_driver(ad7298_driver);
>
> =A0MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> =A0MODULE_DESCRIPTION("Analog Devices AD7298 ADC");
> diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/=
adc/ad7476_core.c
> index fd79fac..0b58520 100644
> --- a/drivers/staging/iio/adc/ad7476_core.c
> +++ b/drivers/staging/iio/adc/ad7476_core.c
> @@ -248,18 +248,7 @@ static struct spi_driver ad7476_driver =3D {
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D __devexit_p(ad7476_remove),
> =A0 =A0 =A0 =A0.id_table =A0 =A0 =A0 =3D ad7476_id,
> =A0};
> -
> -static int __init ad7476_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ad7476_driver);
> -}
> -module_init(ad7476_init);
> -
> -static void __exit ad7476_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ad7476_driver);
> -}
> -module_exit(ad7476_exit);
> +module_spi_driver(ad7476_driver);
>
> =A0MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> =A0MODULE_DESCRIPTION("Analog Devices AD7475/6/7/8(A) AD7466/7/8 ADC");
> diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/a=
dc/ad7606_spi.c
> index aede1ba..b984bd2 100644
> --- a/drivers/staging/iio/adc/ad7606_spi.c
> +++ b/drivers/staging/iio/adc/ad7606_spi.c
> @@ -109,18 +109,7 @@ static struct spi_driver ad7606_driver =3D {
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(ad7606_spi_remove),
> =A0 =A0 =A0 =A0.id_table =3D ad7606_id,
> =A0};
> -
> -static int __init ad7606_spi_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ad7606_driver);
> -}
> -module_init(ad7606_spi_init);
> -
> -static void __exit ad7606_spi_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ad7606_driver);
> -}
> -module_exit(ad7606_spi_exit);
> +module_spi_driver(ad7606_driver);
>
> =A0MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> =A0MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/a=
d7780.c
> index 7a579a1..ec90261 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -283,18 +283,7 @@ static struct spi_driver ad7780_driver =3D {
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D __devexit_p(ad7780_remove),
> =A0 =A0 =A0 =A0.id_table =A0 =A0 =A0 =3D ad7780_id,
> =A0};
> -
> -static int __init ad7780_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ad7780_driver);
> -}
> -module_init(ad7780_init);
> -
> -static void __exit ad7780_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ad7780_driver);
> -}
> -module_exit(ad7780_exit);
> +module_spi_driver(ad7780_driver);
>
> =A0MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> =A0MODULE_DESCRIPTION("Analog Devices AD7780/1 ADC");
> diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/a=
d7793.c
> index 999f8f7..1c5588e 100644
> --- a/drivers/staging/iio/adc/ad7793.c
> +++ b/drivers/staging/iio/adc/ad7793.c
> @@ -1045,18 +1045,7 @@ static struct spi_driver ad7793_driver =3D {
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D __devexit_p(ad7793_remove),
> =A0 =A0 =A0 =A0.id_table =A0 =A0 =A0 =3D ad7793_id,
> =A0};
> -
> -static int __init ad7793_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ad7793_driver);
> -}
> -module_init(ad7793_init);
> -
> -static void __exit ad7793_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ad7793_driver);
> -}
> -module_exit(ad7793_exit);
> +module_spi_driver(ad7793_driver);
>
> =A0MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> =A0MODULE_DESCRIPTION("Analog Devices AD7792/3 ADC");
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/a=
d7816.c
> index bdb9049..acbf936 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -466,21 +466,9 @@ static struct spi_driver ad7816_driver =3D {
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(ad7816_remove),
> =A0 =A0 =A0 =A0.id_table =3D ad7816_id,
> =A0};
> -
> -static __init int ad7816_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ad7816_driver);
> -}
> -
> -static __exit void ad7816_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ad7816_driver);
> -}
> +module_spi_driver(ad7816_driver);
>
> =A0MODULE_AUTHOR("Sonic Zhang <sonic.zhang@analog.com>");
> =A0MODULE_DESCRIPTION("Analog Devices AD7816/7/8 digital"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" temperature sensor drive=
r");
> =A0MODULE_LICENSE("GPL v2");
> -
> -module_init(ad7816_init);
> -module_exit(ad7816_exit);
> diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/=
adc/ad7887_core.c
> index 609dcd5..91b8fb0 100644
> --- a/drivers/staging/iio/adc/ad7887_core.c
> +++ b/drivers/staging/iio/adc/ad7887_core.c
> @@ -257,18 +257,7 @@ static struct spi_driver ad7887_driver =3D {
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D __devexit_p(ad7887_remove),
> =A0 =A0 =A0 =A0.id_table =A0 =A0 =A0 =3D ad7887_id,
> =A0};
> -
> -static int __init ad7887_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ad7887_driver);
> -}
> -module_init(ad7887_init);
> -
> -static void __exit ad7887_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ad7887_driver);
> -}
> -module_exit(ad7887_exit);
> +module_spi_driver(ad7887_driver);
>
> =A0MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> =A0MODULE_DESCRIPTION("Analog Devices AD7887 ADC");
> diff --git a/drivers/staging/iio/adc/adt7310.c b/drivers/staging/iio/adc/=
adt7310.c
> index c9e0be3..bc307f3 100644
> --- a/drivers/staging/iio/adc/adt7310.c
> +++ b/drivers/staging/iio/adc/adt7310.c
> @@ -884,21 +884,9 @@ static struct spi_driver adt7310_driver =3D {
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(adt7310_remove),
> =A0 =A0 =A0 =A0.id_table =3D adt7310_id,
> =A0};
> -
> -static __init int adt7310_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&adt7310_driver);
> -}
> -
> -static __exit void adt7310_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&adt7310_driver);
> -}
> +module_spi_driver(adt7310_driver);
>
> =A0MODULE_AUTHOR("Sonic Zhang <sonic.zhang@analog.com>");
> =A0MODULE_DESCRIPTION("Analog Devices ADT7310 digital"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" temperature sensor drive=
r");
> =A0MODULE_LICENSE("GPL v2");
> -
> -module_init(adt7310_init);
> -module_exit(adt7310_exit);
> diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/ii=
o/addac/adt7316-spi.c
> index 369d4d0..1e93c7b 100644
> --- a/drivers/staging/iio/addac/adt7316-spi.c
> +++ b/drivers/staging/iio/addac/adt7316-spi.c
> @@ -160,21 +160,9 @@ static struct spi_driver adt7316_driver =3D {
> =A0 =A0 =A0 =A0.resume =3D adt7316_spi_resume,
> =A0 =A0 =A0 =A0.id_table =3D adt7316_spi_id,
> =A0};
> -
> -static __init int adt7316_spi_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&adt7316_driver);
> -}
> -
> -static __exit void adt7316_spi_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&adt7316_driver);
> -}
> +module_spi_driver(adt7316_driver);
>
> =A0MODULE_AUTHOR("Sonic Zhang <sonic.zhang@analog.com>");
> =A0MODULE_DESCRIPTION("SPI bus driver for Analog Devices ADT7316/7/8 and"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"ADT7516/7/9 digital tempe=
rature sensor, ADC and DAC");
> =A0MODULE_LICENSE("GPL v2");
> -
> -module_init(adt7316_spi_init);
> -module_exit(adt7316_spi_exit);
> diff --git a/drivers/staging/iio/dac/ad5064.c b/drivers/staging/iio/dac/a=
d5064.c
> index 24279f2..39cfe6c 100644
> --- a/drivers/staging/iio/dac/ad5064.c
> +++ b/drivers/staging/iio/dac/ad5064.c
> @@ -445,18 +445,7 @@ static struct spi_driver ad5064_driver =3D {
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(ad5064_remove),
> =A0 =A0 =A0 =A0.id_table =3D ad5064_id,
> =A0};
> -
> -static __init int ad5064_spi_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ad5064_driver);
> -}
> -module_init(ad5064_spi_init);
> -
> -static __exit void ad5064_spi_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ad5064_driver);
> -}
> -module_exit(ad5064_spi_exit);
> +module_spi_driver(ad5064_driver);
>
> =A0MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
> =A0MODULE_DESCRIPTION("Analog Devices AD5064/64-1/44/24 DAC");
> diff --git a/drivers/staging/iio/dac/ad5360.c b/drivers/staging/iio/dac/a=
d5360.c
> index 72d0f3f0..bc0459e 100644
> --- a/drivers/staging/iio/dac/ad5360.c
> +++ b/drivers/staging/iio/dac/ad5360.c
> @@ -563,18 +563,7 @@ static struct spi_driver ad5360_driver =3D {
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(ad5360_remove),
> =A0 =A0 =A0 =A0.id_table =3D ad5360_ids,
> =A0};
> -
> -static __init int ad5360_spi_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ad5360_driver);
> -}
> -module_init(ad5360_spi_init);
> -
> -static __exit void ad5360_spi_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ad5360_driver);
> -}
> -module_exit(ad5360_spi_exit);
> +module_spi_driver(ad5360_driver);
>
> =A0MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
> =A0MODULE_DESCRIPTION("Analog Devices AD5360/61/62/63/70/71/72/73 DAC");
> diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/a=
d5446.c
> index e1c204d..ac3bc5f 100644
> --- a/drivers/staging/iio/dac/ad5446.c
> +++ b/drivers/staging/iio/dac/ad5446.c
> @@ -465,18 +465,7 @@ static struct spi_driver ad5446_driver =3D {
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D __devexit_p(ad5446_remove),
> =A0 =A0 =A0 =A0.id_table =A0 =A0 =A0 =3D ad5446_id,
> =A0};
> -
> -static int __init ad5446_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ad5446_driver);
> -}
> -module_init(ad5446_init);
> -
> -static void __exit ad5446_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ad5446_driver);
> -}
> -module_exit(ad5446_exit);
> +module_spi_driver(ad5446_driver);
>
> =A0MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> =A0MODULE_DESCRIPTION("Analog Devices AD5444/AD5446 DAC");
> diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/a=
d5504.c
> index 60dd640..57539ce 100644
> --- a/drivers/staging/iio/dac/ad5504.c
> +++ b/drivers/staging/iio/dac/ad5504.c
> @@ -377,18 +377,7 @@ static struct spi_driver ad5504_driver =3D {
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(ad5504_remove),
> =A0 =A0 =A0 =A0.id_table =3D ad5504_id,
> =A0};
> -
> -static __init int ad5504_spi_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ad5504_driver);
> -}
> -module_init(ad5504_spi_init);
> -
> -static __exit void ad5504_spi_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ad5504_driver);
> -}
> -module_exit(ad5504_spi_exit);
> +module_spi_driver(ad5504_driver);
>
> =A0MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> =A0MODULE_DESCRIPTION("Analog Devices AD5501/AD5501 DAC");
> diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/=
dac/ad5624r_spi.c
> index 284d879..6e05f0d 100644
> --- a/drivers/staging/iio/dac/ad5624r_spi.c
> +++ b/drivers/staging/iio/dac/ad5624r_spi.c
> @@ -317,18 +317,7 @@ static struct spi_driver ad5624r_driver =3D {
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(ad5624r_remove),
> =A0 =A0 =A0 =A0.id_table =3D ad5624r_id,
> =A0};
> -
> -static __init int ad5624r_spi_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ad5624r_driver);
> -}
> -module_init(ad5624r_spi_init);
> -
> -static __exit void ad5624r_spi_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ad5624r_driver);
> -}
> -module_exit(ad5624r_spi_exit);
> +module_spi_driver(ad5624r_driver);
>
> =A0MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> =A0MODULE_DESCRIPTION("Analog Devices AD5624/44/64R DAC spi driver");
> diff --git a/drivers/staging/iio/dac/ad5686.c b/drivers/staging/iio/dac/a=
d5686.c
> index 974c6f5..e72db2f 100644
> --- a/drivers/staging/iio/dac/ad5686.c
> +++ b/drivers/staging/iio/dac/ad5686.c
> @@ -447,18 +447,7 @@ static struct spi_driver ad5686_driver =3D {
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(ad5686_remove),
> =A0 =A0 =A0 =A0.id_table =3D ad5686_id,
> =A0};
> -
> -static __init int ad5686_spi_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ad5686_driver);
> -}
> -module_init(ad5686_spi_init);
> -
> -static __exit void ad5686_spi_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ad5686_driver);
> -}
> -module_exit(ad5686_spi_exit);
> +module_spi_driver(ad5686_driver);
>
> =A0MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> =A0MODULE_DESCRIPTION("Analog Devices AD5686/85/84 DAC");
> diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/a=
d5791.c
> index 6fbca8d..4a80fd8 100644
> --- a/drivers/staging/iio/dac/ad5791.c
> +++ b/drivers/staging/iio/dac/ad5791.c
> @@ -410,18 +410,7 @@ static struct spi_driver ad5791_driver =3D {
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(ad5791_remove),
> =A0 =A0 =A0 =A0.id_table =3D ad5791_id,
> =A0};
> -
> -static __init int ad5791_spi_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ad5791_driver);
> -}
> -module_init(ad5791_spi_init);
> -
> -static __exit void ad5791_spi_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ad5791_driver);
> -}
> -module_exit(ad5791_spi_exit);
> +module_spi_driver(ad5791_driver);
>
> =A0MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> =A0MODULE_DESCRIPTION("Analog Devices AD5760/AD5780/AD5781/AD5791 DAC");
> diff --git a/drivers/staging/iio/dds/ad5930.c b/drivers/staging/iio/dds/a=
d5930.c
> index f5e368b..4a360d0 100644
> --- a/drivers/staging/iio/dds/ad5930.c
> +++ b/drivers/staging/iio/dds/ad5930.c
> @@ -143,18 +143,7 @@ static struct spi_driver ad5930_driver =3D {
> =A0 =A0 =A0 =A0.probe =3D ad5930_probe,
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(ad5930_remove),
> =A0};
> -
> -static __init int ad5930_spi_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ad5930_driver);
> -}
> -module_init(ad5930_spi_init);
> -
> -static __exit void ad5930_spi_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ad5930_driver);
> -}
> -module_exit(ad5930_spi_exit);
> +module_spi_driver(ad5930_driver);
>
> =A0MODULE_AUTHOR("Cliff Cai");
> =A0MODULE_DESCRIPTION("Analog Devices ad5930 driver");
> diff --git a/drivers/staging/iio/dds/ad9832.c b/drivers/staging/iio/dds/a=
d9832.c
> index 9b4ff60..cc32fd6 100644
> --- a/drivers/staging/iio/dds/ad9832.c
> +++ b/drivers/staging/iio/dds/ad9832.c
> @@ -355,18 +355,7 @@ static struct spi_driver ad9832_driver =3D {
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D __devexit_p(ad9832_remove),
> =A0 =A0 =A0 =A0.id_table =A0 =A0 =A0 =3D ad9832_id,
> =A0};
> -
> -static int __init ad9832_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ad9832_driver);
> -}
> -module_init(ad9832_init);
> -
> -static void __exit ad9832_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ad9832_driver);
> -}
> -module_exit(ad9832_exit);
> +module_spi_driver(ad9832_driver);
>
> =A0MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> =A0MODULE_DESCRIPTION("Analog Devices AD9832/AD9835 DDS");
> diff --git a/drivers/staging/iio/dds/ad9834.c b/drivers/staging/iio/dds/a=
d9834.c
> index c468f69..2b31e35 100644
> --- a/drivers/staging/iio/dds/ad9834.c
> +++ b/drivers/staging/iio/dds/ad9834.c
> @@ -446,18 +446,7 @@ static struct spi_driver ad9834_driver =3D {
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D __devexit_p(ad9834_remove),
> =A0 =A0 =A0 =A0.id_table =A0 =A0 =A0 =3D ad9834_id,
> =A0};
> -
> -static int __init ad9834_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ad9834_driver);
> -}
> -module_init(ad9834_init);
> -
> -static void __exit ad9834_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ad9834_driver);
> -}
> -module_exit(ad9834_exit);
> +module_spi_driver(ad9834_driver);
>
> =A0MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> =A0MODULE_DESCRIPTION("Analog Devices AD9833/AD9834/AD9837/AD9838 DDS");
> diff --git a/drivers/staging/iio/dds/ad9850.c b/drivers/staging/iio/dds/a=
d9850.c
> index a14771b..f9c96af 100644
> --- a/drivers/staging/iio/dds/ad9850.c
> +++ b/drivers/staging/iio/dds/ad9850.c
> @@ -129,18 +129,7 @@ static struct spi_driver ad9850_driver =3D {
> =A0 =A0 =A0 =A0.probe =3D ad9850_probe,
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(ad9850_remove),
> =A0};
> -
> -static __init int ad9850_spi_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ad9850_driver);
> -}
> -module_init(ad9850_spi_init);
> -
> -static __exit void ad9850_spi_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ad9850_driver);
> -}
> -module_exit(ad9850_spi_exit);
> +module_spi_driver(ad9850_driver);
>
> =A0MODULE_AUTHOR("Cliff Cai");
> =A0MODULE_DESCRIPTION("Analog Devices ad9850 driver");
> diff --git a/drivers/staging/iio/dds/ad9852.c b/drivers/staging/iio/dds/a=
d9852.c
> index cfceaa6..9fc73fd 100644
> --- a/drivers/staging/iio/dds/ad9852.c
> +++ b/drivers/staging/iio/dds/ad9852.c
> @@ -280,18 +280,7 @@ static struct spi_driver ad9852_driver =3D {
> =A0 =A0 =A0 =A0.probe =3D ad9852_probe,
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(ad9852_remove),
> =A0};
> -
> -static __init int ad9852_spi_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ad9852_driver);
> -}
> -module_init(ad9852_spi_init);
> -
> -static __exit void ad9852_spi_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ad9852_driver);
> -}
> -module_exit(ad9852_spi_exit);
> +module_spi_driver(ad9852_driver);
>
> =A0MODULE_AUTHOR("Cliff Cai");
> =A0MODULE_DESCRIPTION("Analog Devices ad9852 driver");
> diff --git a/drivers/staging/iio/dds/ad9910.c b/drivers/staging/iio/dds/a=
d9910.c
> index da83d2b..57046b0 100644
> --- a/drivers/staging/iio/dds/ad9910.c
> +++ b/drivers/staging/iio/dds/ad9910.c
> @@ -413,18 +413,7 @@ static struct spi_driver ad9910_driver =3D {
> =A0 =A0 =A0 =A0.probe =3D ad9910_probe,
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(ad9910_remove),
> =A0};
> -
> -static __init int ad9910_spi_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ad9910_driver);
> -}
> -module_init(ad9910_spi_init);
> -
> -static __exit void ad9910_spi_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ad9910_driver);
> -}
> -module_exit(ad9910_spi_exit);
> +module_spi_driver(ad9910_driver);
>
> =A0MODULE_AUTHOR("Cliff Cai");
> =A0MODULE_DESCRIPTION("Analog Devices ad9910 driver");
> diff --git a/drivers/staging/iio/dds/ad9951.c b/drivers/staging/iio/dds/a=
d9951.c
> index 20c1825..d29130e 100644
> --- a/drivers/staging/iio/dds/ad9951.c
> +++ b/drivers/staging/iio/dds/ad9951.c
> @@ -224,18 +224,7 @@ static struct spi_driver ad9951_driver =3D {
> =A0 =A0 =A0 =A0.probe =3D ad9951_probe,
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(ad9951_remove),
> =A0};
> -
> -static __init int ad9951_spi_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ad9951_driver);
> -}
> -module_init(ad9951_spi_init);
> -
> -static __exit void ad9951_spi_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ad9951_driver);
> -}
> -module_exit(ad9951_spi_exit);
> +module_spi_driver(ad9951_driver);
>
> =A0MODULE_AUTHOR("Cliff Cai");
> =A0MODULE_DESCRIPTION("Analog Devices ad9951 driver");
> diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/=
iio/gyro/adis16080_core.c
> index 5d7a906..9405f2d 100644
> --- a/drivers/staging/iio/gyro/adis16080_core.c
> +++ b/drivers/staging/iio/gyro/adis16080_core.c
> @@ -189,18 +189,7 @@ static struct spi_driver adis16080_driver =3D {
> =A0 =A0 =A0 =A0.probe =3D adis16080_probe,
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(adis16080_remove),
> =A0};
> -
> -static __init int adis16080_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&adis16080_driver);
> -}
> -module_init(adis16080_init);
> -
> -static __exit void adis16080_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&adis16080_driver);
> -}
> -module_exit(adis16080_exit);
> +module_spi_driver(adis16080_driver);
>
> =A0MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> =A0MODULE_DESCRIPTION("Analog Devices ADIS16080/100 Yaw Rate Gyroscope Dr=
iver");
> diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/=
iio/gyro/adis16130_core.c
> index 749240d..c9aaca9 100644
> --- a/drivers/staging/iio/gyro/adis16130_core.c
> +++ b/drivers/staging/iio/gyro/adis16130_core.c
> @@ -168,18 +168,7 @@ static struct spi_driver adis16130_driver =3D {
> =A0 =A0 =A0 =A0.probe =3D adis16130_probe,
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(adis16130_remove),
> =A0};
> -
> -static __init int adis16130_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&adis16130_driver);
> -}
> -module_init(adis16130_init);
> -
> -static __exit void adis16130_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&adis16130_driver);
> -}
> -module_exit(adis16130_exit);
> +module_spi_driver(adis16130_driver);
>
> =A0MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> =A0MODULE_DESCRIPTION("Analog Devices ADIS16130 High Precision Angular Ra=
te");
> diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/=
iio/gyro/adis16260_core.c
> index aaa3967..886dddf 100644
> --- a/drivers/staging/iio/gyro/adis16260_core.c
> +++ b/drivers/staging/iio/gyro/adis16260_core.c
> @@ -711,18 +711,7 @@ static struct spi_driver adis16260_driver =3D {
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(adis16260_remove),
> =A0 =A0 =A0 =A0.id_table =3D adis16260_id,
> =A0};
> -
> -static __init int adis16260_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&adis16260_driver);
> -}
> -module_init(adis16260_init);
> -
> -static __exit void adis16260_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&adis16260_driver);
> -}
> -module_exit(adis16260_exit);
> +module_spi_driver(adis16260_driver);
>
> =A0MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> =A0MODULE_DESCRIPTION("Analog Devices ADIS16260/5 Digital Gyroscope Senso=
r");
> diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/i=
io/gyro/adxrs450_core.c
> index 3c3ef79..70fd468 100644
> --- a/drivers/staging/iio/gyro/adxrs450_core.c
> +++ b/drivers/staging/iio/gyro/adxrs450_core.c
> @@ -381,18 +381,7 @@ static struct spi_driver adxrs450_driver =3D {
> =A0 =A0 =A0 =A0.probe =3D adxrs450_probe,
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(adxrs450_remove),
> =A0};
> -
> -static __init int adxrs450_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&adxrs450_driver);
> -}
> -module_init(adxrs450_init);
> -
> -static __exit void adxrs450_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&adxrs450_driver);
> -}
> -module_exit(adxrs450_exit);
> +module_spi_driver(adxrs450_driver);
>
> =A0MODULE_AUTHOR("Cliff Cai <cliff.cai@xxxxxxxxxx>");
> =A0MODULE_DESCRIPTION("Analog Devices ADXRS450 Gyroscope SPI driver");
> diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/i=
io/imu/adis16400_core.c
> index d082a37..efc0f65 100644
> --- a/drivers/staging/iio/imu/adis16400_core.c
> +++ b/drivers/staging/iio/imu/adis16400_core.c
> @@ -1128,18 +1128,7 @@ static struct spi_driver adis16400_driver =3D {
> =A0 =A0 =A0 =A0.probe =3D adis16400_probe,
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(adis16400_remove),
> =A0};
> -
> -static __init int adis16400_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&adis16400_driver);
> -}
> -module_init(adis16400_init);
> -
> -static __exit void adis16400_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&adis16400_driver);
> -}
> -module_exit(adis16400_exit);
> +module_spi_driver(adis16400_driver);
>
> =A0MODULE_AUTHOR("Manuel Stahl <manuel.stahl@iis.fraunhofer.de>");
> =A0MODULE_DESCRIPTION("Analog Devices ADIS16400/5 IMU SPI driver");
> diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/me=
ter/ade7753.c
> index 940fef6..4c7b0cb 100644
> --- a/drivers/staging/iio/meter/ade7753.c
> +++ b/drivers/staging/iio/meter/ade7753.c
> @@ -577,18 +577,7 @@ static struct spi_driver ade7753_driver =3D {
> =A0 =A0 =A0 =A0.probe =3D ade7753_probe,
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(ade7753_remove),
> =A0};
> -
> -static __init int ade7753_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ade7753_driver);
> -}
> -module_init(ade7753_init);
> -
> -static __exit void ade7753_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ade7753_driver);
> -}
> -module_exit(ade7753_exit);
> +module_spi_driver(ade7753_driver);
>
> =A0MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> =A0MODULE_DESCRIPTION("Analog Devices ADE7753/6 Single-Phase Multifunctio=
n Meter");
> diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/me=
ter/ade7754.c
> index 33f0d32..15c98cd 100644
> --- a/drivers/staging/iio/meter/ade7754.c
> +++ b/drivers/staging/iio/meter/ade7754.c
> @@ -600,18 +600,7 @@ static struct spi_driver ade7754_driver =3D {
> =A0 =A0 =A0 =A0.probe =3D ade7754_probe,
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(ade7754_remove),
> =A0};
> -
> -static __init int ade7754_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ade7754_driver);
> -}
> -module_init(ade7754_init);
> -
> -static __exit void ade7754_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ade7754_driver);
> -}
> -module_exit(ade7754_exit);
> +module_spi_driver(ade7754_driver);
>
> =A0MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> =A0MODULE_DESCRIPTION("Analog Devices ADE7754 Polyphase Multifunction Ene=
rgy Metering IC Driver");
> diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/i=
io/meter/ade7758_core.c
> index c5dafbd..39338bc 100644
> --- a/drivers/staging/iio/meter/ade7758_core.c
> +++ b/drivers/staging/iio/meter/ade7758_core.c
> @@ -853,18 +853,7 @@ static struct spi_driver ade7758_driver =3D {
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(ade7758_remove),
> =A0 =A0 =A0 =A0.id_table =3D ade7758_id,
> =A0};
> -
> -static __init int ade7758_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ade7758_driver);
> -}
> -module_init(ade7758_init);
> -
> -static __exit void ade7758_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ade7758_driver);
> -}
> -module_exit(ade7758_exit);
> +module_spi_driver(ade7758_driver);
>
> =A0MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> =A0MODULE_DESCRIPTION("Analog Devices ADE7758 Polyphase Multifunction Ene=
rgy Metering IC Driver");
> diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/me=
ter/ade7759.c
> index b691f10..cfa2a5e 100644
> --- a/drivers/staging/iio/meter/ade7759.c
> +++ b/drivers/staging/iio/meter/ade7759.c
> @@ -521,18 +521,7 @@ static struct spi_driver ade7759_driver =3D {
> =A0 =A0 =A0 =A0.probe =3D ade7759_probe,
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(ade7759_remove),
> =A0};
> -
> -static __init int ade7759_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ade7759_driver);
> -}
> -module_init(ade7759_init);
> -
> -static __exit void ade7759_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ade7759_driver);
> -}
> -module_exit(ade7759_exit);
> +module_spi_driver(ade7759_driver);
>
> =A0MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> =A0MODULE_DESCRIPTION("Analog Devices ADE7759 Active Energy Metering IC D=
river");
> diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/ii=
o/meter/ade7854-spi.c
> index cfa23ba..c485a79 100644
> --- a/drivers/staging/iio/meter/ade7854-spi.c
> +++ b/drivers/staging/iio/meter/ade7854-spi.c
> @@ -353,18 +353,7 @@ static struct spi_driver ade7854_driver =3D {
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(ade7854_spi_remove),
> =A0 =A0 =A0 =A0.id_table =3D ade7854_id,
> =A0};
> -
> -static __init int ade7854_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ade7854_driver);
> -}
> -module_init(ade7854_init);
> -
> -static __exit void ade7854_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ade7854_driver);
> -}
> -module_exit(ade7854_exit);
> +module_spi_driver(ade7854_driver);
>
> =A0MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> =A0MODULE_DESCRIPTION("Analog Devices ADE7854/58/68/78 SPI Driver");
> diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/ii=
o/resolver/ad2s1200.c
> index d7ad46a..1c6a02b 100644
> --- a/drivers/staging/iio/resolver/ad2s1200.c
> +++ b/drivers/staging/iio/resolver/ad2s1200.c
> @@ -170,18 +170,7 @@ static struct spi_driver ad2s1200_driver =3D {
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(ad2s1200_remove),
> =A0 =A0 =A0 =A0.id_table =3D ad2s1200_id,
> =A0};
> -
> -static __init int ad2s1200_spi_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ad2s1200_driver);
> -}
> -module_init(ad2s1200_spi_init);
> -
> -static __exit void ad2s1200_spi_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ad2s1200_driver);
> -}
> -module_exit(ad2s1200_spi_exit);
> +module_spi_driver(ad2s1200_driver);
>
> =A0MODULE_AUTHOR("Graff Yang <graff.yang@gmail.com>");
> =A0MODULE_DESCRIPTION("Analog Devices AD2S1200/1205 Resolver to Digital S=
PI driver");
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/ii=
o/resolver/ad2s1210.c
> index 6401a62..ff1b331 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -759,18 +759,7 @@ static struct spi_driver ad2s1210_driver =3D {
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(ad2s1210_remove),
> =A0 =A0 =A0 =A0.id_table =3D ad2s1210_id,
> =A0};
> -
> -static __init int ad2s1210_spi_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ad2s1210_driver);
> -}
> -module_init(ad2s1210_spi_init);
> -
> -static __exit void ad2s1210_spi_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ad2s1210_driver);
> -}
> -module_exit(ad2s1210_spi_exit);
> +module_spi_driver(ad2s1210_driver);
>
> =A0MODULE_AUTHOR("Graff Yang <graff.yang@gmail.com>");
> =A0MODULE_DESCRIPTION("Analog Devices AD2S1210 Resolver to Digital SPI dr=
iver");
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/=
resolver/ad2s90.c
> index a9200d9..6d07943 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -119,18 +119,7 @@ static struct spi_driver ad2s90_driver =3D {
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(ad2s90_remove),
> =A0 =A0 =A0 =A0.id_table =3D ad2s90_id,
> =A0};
> -
> -static __init int ad2s90_spi_init(void)
> -{
> - =A0 =A0 =A0 return spi_register_driver(&ad2s90_driver);
> -}
> -module_init(ad2s90_spi_init);
> -
> -static __exit void ad2s90_spi_exit(void)
> -{
> - =A0 =A0 =A0 spi_unregister_driver(&ad2s90_driver);
> -}
> -module_exit(ad2s90_spi_exit);
> +module_spi_driver(ad2s90_driver);
>
> =A0MODULE_AUTHOR("Graff Yang <graff.yang@gmail.com>");
> =A0MODULE_DESCRIPTION("Analog Devices AD2S90 Resolver to Digital SPI driv=
er");
> --
> 1.7.7.1
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
