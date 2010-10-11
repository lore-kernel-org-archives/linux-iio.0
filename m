Return-Path: <rklein@nvidia.com>
From: Rhyland Klein <rklein@nvidia.com>
To: Jonathan Cameron <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Date: Mon, 11 Oct 2010 09:43:08 -0700
Subject: RE: [PATCH] staging:iio:isl29018 sparse and build warning fixes +
 trivial cleanup
Message-ID: <E88A1D35AF5437468E5B14C7C4BA61C702D37CA10B@HQMAIL01.nvidia.com>
References: <1286807229-22102-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1286807229-22102-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

LGTM, feel free to add
Acked-by: Rhyland Klein <rklein@nvidia.com>

> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
> Sent: Monday, October 11, 2010 7:27 AM
> To: Rhyland Klein; linux-iio@vger.kernel.org
> Cc: Jonathan Cameron
> Subject: [PATCH] staging:iio:isl29018 sparse and build warning fixes +
> trivial cleanup
>=20
> gcc gives a couple of false positives on unassigned variables so lets
> set them to 0.
>=20
> As the values passed into set_range and set_resolution have already bee=
n
> narrowed down we can do the conversion to unsigned int at passing into
> the function slightly simplifying the matching code.
>=20
> 3rd change fixes warning about a signed parameter being passed
> in when unsigned is expected.
>=20
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
>=20
> ---
>  drivers/staging/iio/light/isl29018.c |   26 ++++++++++++--------------=

>  1 files changed, 12 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/staging/iio/light/isl29018.c
> b/drivers/staging/iio/light/isl29018.c
> index f919cc1..ec02a85 100644
> --- a/drivers/staging/iio/light/isl29018.c
> +++ b/drivers/staging/iio/light/isl29018.c
> @@ -84,18 +84,17 @@ static int isl29018_write_data(struct i2c_client
> *client, u8 reg,
>  	return 0;
>  }
>=20
> -static int isl29018_set_range(struct i2c_client *client, unsigned long=

> range,
> +static int isl29018_set_range(struct i2c_client *client, unsigned int
> range,
>  		unsigned int *new_range)
>  {
> -	static const unsigned long supp_ranges[] =3D {1000, 4000, 16000,
> 64000};
> +	static const unsigned int supp_ranges[] =3D {1000, 4000, 16000, 64000=
};
>  	int i;
>=20
> -	for (i =3D 0; i < ARRAY_SIZE(supp_ranges); ++i) {
> +	for (i =3D 0; i < ARRAY_SIZE(supp_ranges); ++i)
>  		if (range <=3D supp_ranges[i]) {
> -			*new_range =3D (unsigned int)supp_ranges[i];
> +			*new_range =3D supp_ranges[i];
>  			break;
>  		}
> -	}
>=20
>  	if (i >=3D ARRAY_SIZE(supp_ranges))
>  		return -EINVAL;
> @@ -105,17 +104,16 @@ static int isl29018_set_range(struct i2c_client
> *client, unsigned long range,
>  }
>=20
>  static int isl29018_set_resolution(struct i2c_client *client,
> -			unsigned long adcbit, unsigned int *conf_adc_bit)
> +			unsigned int adcbit, unsigned int *conf_adc_bit)
>  {
> -	static const unsigned long supp_adcbit[] =3D {16, 12, 8, 4};
> +	static const unsigned int supp_adcbit[] =3D {16, 12, 8, 4};
>  	int i;
>=20
> -	for (i =3D 0; i < ARRAY_SIZE(supp_adcbit); ++i) {
> +	for (i =3D 0; i < ARRAY_SIZE(supp_adcbit); ++i)
>  		if (adcbit >=3D supp_adcbit[i]) {
> -			*conf_adc_bit =3D (unsigned int)supp_adcbit[i];
> +			*conf_adc_bit =3D supp_adcbit[i];
>  			break;
>  		}
> -	}
>=20
>  	if (i >=3D ARRAY_SIZE(supp_adcbit))
>  		return -EINVAL;
> @@ -282,7 +280,7 @@ static ssize_t store_range(struct device *dev,
>  	struct i2c_client *client =3D chip->client;
>  	int status;
>  	unsigned long lval;
> -	unsigned int new_range;
> +	unsigned int new_range =3D 0;
>=20
>  	if (strict_strtoul(buf, 10, &lval))
>  		return -EINVAL;
> @@ -324,7 +322,7 @@ static ssize_t store_resolution(struct device *dev,=

>  	struct i2c_client *client =3D chip->client;
>  	int status;
>  	unsigned long lval;
> -	unsigned int new_adc_bit;
> +	unsigned int new_adc_bit =3D 0;
>=20
>  	if (strict_strtoul(buf, 10, &lval))
>  		return -EINVAL;
> @@ -449,8 +447,8 @@ static int isl29018_chip_init(struct i2c_client
> *client)
>  {
>  	struct isl29018_chip *chip =3D i2c_get_clientdata(client);
>  	int status;
> -	int new_adc_bit;
> -	unsigned int new_range;
> +	unsigned int new_adc_bit;
> +	unsigned int new_range =3D 0;
>=20
>  	memset(chip->reg_cache, 0, sizeof(chip->reg_cache));
>=20
> --
> 1.7.2.2

-------------------------------------------------------------------------=
----------
This email message is for the sole use of the intended recipient(s) and m=
ay contain
confidential information.  Any unauthorized review, use, disclosure or di=
stribution
is prohibited.  If you are not the intended recipient, please contact the=
=20sender by
reply email and destroy all copies of the original message.
-------------------------------------------------------------------------=
----------
