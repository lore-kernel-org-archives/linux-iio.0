Return-Path: <jic23@kernel.org>
Message-ID: <4FFF23DD.8050100@kernel.org>
Date: Thu, 12 Jul 2012 20:22:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
 Randy Dunlap <rdunlap@xenotime.net>,
 linux-next@vger.kernel.org
Subject: Re: [PATCH] iio: ad5064: Move bus write callbacks to #if protected
 sections
References: <4FFD1458.6000404@xenotime.net> <1341993690-19125-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1341993690-19125-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 07/11/2012 09:01 AM, Lars-Peter Clausen wrote:
> Move the SPI and I2C specific write callbacks to the respective
> "#if IS_ENABLED(CONFIG_SPI_MASTER)" and "#if IS_ENABLED(CONFIG_I2C)"
> protected sections of the code.
>=20
> This fixes the following warning which occurs if CONFIG_I2C is not set:
> 	drivers/iio/dac/ad5064.c: In function =E2=80=98ad5064_i2c_write=E2=80=99=
:
> 	drivers/iio/dac/ad5064.c:132: error: implicit declaration of function =
=E2=80=98i2c_master_send=E2=80=99
>=20
> And the follwing warning which occurs when CONFIG_SPI_MASTER is not set=
:
> 	drivers/iio/dac/ad5064.c:137: warning: =E2=80=98ad5064_spi_write=E2=80=
=99 defined but not used
>=20
> Reported-by: Randy Dunlap <rdunlap@xenotime.net>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
merged to fixes-togreg and pull request sent.
> ---
>  drivers/iio/dac/ad5064.c |   38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
> index aa739c4..de2c368 100644
> --- a/drivers/iio/dac/ad5064.c
> +++ b/drivers/iio/dac/ad5064.c
> @@ -122,25 +122,6 @@ enum ad5064_type {
>  	ID_AD5668_2,
>  };
> =20
> -static int ad5064_i2c_write(struct ad5064_state *st, unsigned int cmd,
> -	unsigned int addr, unsigned int val)
> -{
> -	struct i2c_client *i2c =3D to_i2c_client(st->dev);
> -
> -	st->data.i2c[0] =3D (cmd << 4) | addr;
> -	put_unaligned_be16(val, &st->data.i2c[1]);
> -	return i2c_master_send(i2c, st->data.i2c, 3);
> -}
> -
> -static int ad5064_spi_write(struct ad5064_state *st, unsigned int cmd,
> -	unsigned int addr, unsigned int val)
> -{
> -	struct spi_device *spi =3D to_spi_device(st->dev);
> -
> -	st->data.spi =3D cpu_to_be32(AD5064_CMD(cmd) | AD5064_ADDR(addr) | va=
l);
> -	return spi_write(spi, &st->data.spi, sizeof(st->data.spi));
> -}
> -
>  static int ad5064_write(struct ad5064_state *st, unsigned int cmd,
>  	unsigned int addr, unsigned int val, unsigned int shift)
>  {
> @@ -533,6 +514,15 @@ static int __devexit ad5064_remove(struct device *=
dev)
> =20
>  #if IS_ENABLED(CONFIG_SPI_MASTER)
> =20
> +static int ad5064_spi_write(struct ad5064_state *st, unsigned int cmd,
> +	unsigned int addr, unsigned int val)
> +{
> +	struct spi_device *spi =3D to_spi_device(st->dev);
> +
> +	st->data.spi =3D cpu_to_be32(AD5064_CMD(cmd) | AD5064_ADDR(addr) | va=
l);
> +	return spi_write(spi, &st->data.spi, sizeof(st->data.spi));
> +}
> +
>  static int __devinit ad5064_spi_probe(struct spi_device *spi)
>  {
>  	const struct spi_device_id *id =3D spi_get_device_id(spi);
> @@ -596,6 +586,16 @@ static inline void ad5064_spi_unregister_driver(vo=
id) { }
> =20
>  #if IS_ENABLED(CONFIG_I2C)
> =20
> +static int ad5064_i2c_write(struct ad5064_state *st, unsigned int cmd,
> +	unsigned int addr, unsigned int val)
> +{
> +	struct i2c_client *i2c =3D to_i2c_client(st->dev);
> +
> +	st->data.i2c[0] =3D (cmd << 4) | addr;
> +	put_unaligned_be16(val, &st->data.i2c[1]);
> +	return i2c_master_send(i2c, st->data.i2c, 3);
> +}
> +
>  static int __devinit ad5064_i2c_probe(struct i2c_client *i2c,
>  	const struct i2c_device_id *id)
>  {
>=20
