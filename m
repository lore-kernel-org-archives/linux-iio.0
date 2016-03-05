Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56156 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbcCEPgO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Mar 2016 10:36:14 -0500
Subject: Re: [PATCH v2 4/5] iio:magnetometer:ak8975: mounting matrix support
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1457001111.git.gregor.boirie@parrot.com>
 <022da3dfc0853c6f9820b24c2d9eaaf0c5ccf294.1457001111.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56DAFCEB.6080905@kernel.org>
Date: Sat, 5 Mar 2016 15:36:11 +0000
MIME-Version: 1.0
In-Reply-To: <022da3dfc0853c6f9820b24c2d9eaaf0c5ccf294.1457001111.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/03/16 10:44, Gregor Boirie wrote:
> Expose a rotation matrix to indicate userspace the chip placement with
> respect to the overall hardware system. This is needed to adjust
> coordinates sampled from a magnetometer chip when its position deviates
> from the main hardware system.
> 
> Final coordinates computation is delegated to userspace since:
> * computation may involve floating point arithmetics ;
> * it allows an application to combine adjustments with arbitrary
>   transformations.
> 
> This 3 dimentional space rotation matrix is expressed as 3x3 array of
> strings to support floating point numbers. It may be retrieved from a
> "in_magn_matrix" sysfs attribute file. It is declared into ak8975 DTS
> entry as a "matrix" property.
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
This one definitely wants to go to the device tree list. I'd also like a few
IIO related comments as well. I was sure we'd been through this before and
ended up with some sort of solution, but now I can't find it... Oh well.

Definitely needs ABI docs in Documentation/ABI/testing/sysfs-bus-iio
as well.  We need the reference directions to be well specified as
well - how do we define the main hardware orientation?  on yours presumably
the usual approach of using the screen is irrelevant so that definition
could be a little 'interesting' to write down?

I'm also unsure of whether the right thing to do in the 'not provided'
cases is to not export the setting, or to assume that the chip is at some
'standard' orientation and provide that?

Jonathan

> ---
>  .../bindings/iio/magnetometer/ak8975.txt           | 10 +++++
>  drivers/iio/magnetometer/ak8975.c                  | 46 +++++++++++++++++++++-
>  2 files changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
> index 34a3206..f936f86 100644
> --- a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
> @@ -9,6 +9,7 @@ Optional properties:
>  
>    - gpios : should be device tree identifier of the magnetometer DRDY pin
>    - vdd-supply: an optional regulator that needs to be on to provide VDD
> +  - matrix: an optional 3x3 mounting rotation matrix
>  
>  Example:
>  
> @@ -17,4 +18,13 @@ ak8975@0c {
>          reg = <0x0c>;
>          gpios = <&gpj0 7 0>;
>          vdd-supply = <&ldo_3v3_gnss>;
> +        matrix = "-0.984807753012208",  /* x0 */
> +                 "0",                   /* y0 */
> +                 "-0.173648177666930",  /* z0 */
> +                 "0",                   /* x1 */
> +                 "-1",                  /* y1 */
> +                 "0",                   /* z1 */
> +                 "-0.173648177666930",  /* x2 */
> +                 "0",                   /* y2 */
> +                 "0.984807753012208";   /* z2 */
>  };
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 72c03d9..95c68952 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -370,6 +370,7 @@ struct ak8975_data {
>  	wait_queue_head_t	data_ready_queue;
>  	unsigned long		flags;
>  	u8			cntl_cache;
> +	const char		*matrix[9];
>  };
>  
>  /*
> @@ -697,6 +698,28 @@ static int ak8975_read_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> +static ssize_t ak8975_show_matrix(struct device *dev,
> +				  struct device_attribute *attr,
> +				  char *buf)
> +{
> +	const struct ak8975_data *data = iio_priv(dev_to_iio_dev(dev));
> +	const char * const *m = data->matrix;
> +
> +	return sprintf(buf, "%s, %s, %s; %s, %s, %s; %s, %s, %s\n",
> +		       m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8]);
> +}
> +
> +static IIO_DEVICE_ATTR(in_magn_matrix, S_IRUGO, ak8975_show_matrix, NULL, -1);
> +
> +static struct attribute *ak8975_attrs[] = {
> +	&iio_dev_attr_in_magn_matrix.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group ak8975_attrs_group = {
> +	.attrs = ak8975_attrs
> +};
> +
>  #define AK8975_CHANNEL(axis, index)					\
>  	{								\
>  		.type = IIO_MAGN,					\
> @@ -716,6 +739,12 @@ static const struct iio_info ak8975_info = {
>  	.driver_module = THIS_MODULE,
>  };
>  
> +static const struct iio_info ak8975_matrix_info = {
> +	.read_raw = &ak8975_read_raw,
> +	.attrs = &ak8975_attrs_group,
> +	.driver_module = THIS_MODULE,
> +};
> +
>  static const struct acpi_device_id ak_acpi_match[] = {
>  	{"AK8975", AK8975},
>  	{"AK8963", AK8963},
> @@ -785,6 +814,22 @@ static int ak8975_probe(struct i2c_client *client,
>  	data->eoc_gpio = eoc_gpio;
>  	data->eoc_irq = 0;
>  
> +	/*
> +	 * Rotation matrix is expressed as an array of 3x3 strings to be able
> +	 * to represent floating point numbers.
> +	 */
> +	err = of_property_read_string_array(client->dev.of_node, "matrix",
> +					    data->matrix,
> +					    ARRAY_SIZE(data->matrix));
> +	if (err == ARRAY_SIZE(data->matrix))
> +		indio_dev->info = &ak8975_matrix_info;
> +	else if (err == -EINVAL)
> +		indio_dev->info = &ak8975_info;
> +	else if (err >= 0)
> +		return -EINVAL;
> +	else
> +		return err;
> +
>  	/* id will be NULL when enumerated via ACPI */
>  	if (id) {
>  		chipset = (enum asahi_compass_chipset)(id->driver_data);
> @@ -822,7 +867,6 @@ static int ak8975_probe(struct i2c_client *client,
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->channels = ak8975_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(ak8975_channels);
> -	indio_dev->info = &ak8975_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->name = name;
>  	return devm_iio_device_register(&client->dev, indio_dev);
> 

