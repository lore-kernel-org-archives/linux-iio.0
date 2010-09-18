Return-Path: <jic23@cam.ac.uk>
Message-ID: <4C94E38C.7040007@cam.ac.uk>
Date: Sat, 18 Sep 2010 17:06:36 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org, Michael.Hennerich@analog.com,
 Robin.Getz@analog.com, manuel.stahl@iis.fraunhofer.de
Subject: Re: [PATCH 5/6] staging:iio:adis16300 merge into adis16350 driver
References: <1284217100-2469-1-git-send-email-jic23@cam.ac.uk> <1284217100-2469-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284217100-2469-6-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

...
> +static struct attribute *adis16300_attributes[] = {
> +	&iio_dev_attr_gyro_x_calibbias.dev_attr.attr,
> +	&iio_dev_attr_accel_x_calibbias.dev_attr.attr,
> +	&iio_dev_attr_accel_y_calibbias.dev_attr.attr,
> +	&iio_dev_attr_accel_z_calibbias.dev_attr.attr,
> +	&iio_dev_attr_in_supply_raw.dev_attr.attr,
> +	&iio_const_attr_in_supply_scale.dev_attr.attr,
> +	&iio_dev_attr_gyro_z_raw.dev_attr.attr,
> +	&iio_dev_attr_gyro_scale.dev_attr.attr,
> +	&iio_dev_attr_accel_x_raw.dev_attr.attr,
> +	&iio_dev_attr_accel_y_raw.dev_attr.attr,
> +	&iio_dev_attr_accel_z_raw.dev_attr.attr,
> +	&iio_dev_attr_accel_scale.dev_attr.attr,
> +	&iio_dev_attr_incli_x_raw.dev_attr.attr,
> +	&iio_dev_attr_incli_y_raw.dev_attr.attr,
> +	&iio_const_attr_incli_scale.dev_attr.attr,
> +	&iio_dev_attr_temp_raw.dev_attr.attr,
> +	&iio_const_attr_temp_offset.dev_attr.attr,
> +	&iio_const_attr_temp_scale.dev_attr.attr,
> +	&iio_dev_attr_in0_raw.dev_attr.attr,
> +	&iio_const_attr_in0_scale.dev_attr.attr,
> +	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_reset.dev_attr.attr,
> +	&iio_dev_attr_name.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group adis16300_attribute_group = {
> +	.attrs = adis16300_attributes,
> +};
> +
> +static struct adis16350_chip_info adis16350_variants[] = {
> +	[adis16300] = {
> +		.attribute_group = &adis16300_attribute_group,


The complexity with building is here.  If we aren't building with 
CONFIG_IIO_RING_BUFFER then the right had side of this statement
does not exist.  Updated patch puts an ifdef around here.

It's not pretty but I can't work out any other way of doing it.

Jonathan
> +		.scan_el_group = &adis16300_scan_el_group,
> +		.burst_available = 1,
> +		.gyro_scale = "0.000872664",
> +		.accel_scale = "0.00588399",
> +		.burst_length = 18,
> +		.all_mask =
> +		BIT(ADIS16350_SCAN_IN_SUPPLY) |
> +		BIT(ADIS16350_SCAN_GYRO_Z) |
> +		BIT(ADIS16350_SCAN_ACCEL_X) |
> +		BIT(ADIS16350_SCAN_ACCEL_Y) |
> +		BIT(ADIS16350_SCAN_ACCEL_Z) |
> +		BIT(ADIS16300_SCAN_TEMP) |
> +		BIT(ADIS16300_SCAN_INCLI_X) |
> +		BIT(ADIS16300_SCAN_INCLI_Y) |
> +		BIT(ADIS16350_SCAN_IN0),
> +	},
> +	[adis16350] = {
> +		.attribute_group = &adis16350_attribute_group,
> +		.scan_el_group = &adis16350_scan_el_group,
> +		.burst_available = 0,
> +		.gyro_scale = "0.00127862821",
> +		.accel_scale = "0.0247323713",
> +		.all_mask =
> +		BIT(ADIS16350_SCAN_IN_SUPPLY) |
> +		BIT(ADIS16350_SCAN_GYRO_X) |
> +		BIT(ADIS16350_SCAN_GYRO_Y) |
> +		BIT(ADIS16350_SCAN_GYRO_Z) |
> +		BIT(ADIS16350_SCAN_ACCEL_X) |
> +		BIT(ADIS16350_SCAN_ACCEL_Y) |
> +		BIT(ADIS16350_SCAN_ACCEL_Z) |
> +		BIT(ADIS16350_SCAN_TEMP_X) |
> +		BIT(ADIS16350_SCAN_TEMP_Y) |
> +		BIT(ADIS16350_SCAN_TEMP_Z) |
> +		BIT(ADIS16350_SCAN_IN0),
> +	},
> +	[adis16360] = {
> +		.attribute_group = &adis16350_attribute_group,
> +		.scan_el_group = &adis16350_scan_el_group,
> +		.burst_available = 1,
> +		.gyro_scale = "0.00127862821",
> +		.accel_scale = "0.0247323713",
> +		.burst_length = 22,
> +		.all_mask =
> +		BIT(ADIS16350_SCAN_IN_SUPPLY) |
> +		BIT(ADIS16350_SCAN_GYRO_X) |
> +		BIT(ADIS16350_SCAN_GYRO_Y) |
> +		BIT(ADIS16350_SCAN_GYRO_Z) |
> +		BIT(ADIS16350_SCAN_ACCEL_X) |
> +		BIT(ADIS16350_SCAN_ACCEL_Y) |
> +		BIT(ADIS16350_SCAN_ACCEL_Z) |
> +		BIT(ADIS16350_SCAN_TEMP_X) |
> +		BIT(ADIS16350_SCAN_TEMP_Y) |
> +		BIT(ADIS16350_SCAN_TEMP_Z) |
> +		BIT(ADIS16350_SCAN_IN0),
> +	},
> +};
