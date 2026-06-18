Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6181534C981
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 21:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781816769; cv=none; b=sfg9iB3f+C4eszTFIvPXG4gcWscLCRd1mroir452lKuPloQ8RtnK1Rjv7Ao7peI+vzLTjoP3h3U3PKnCLLtBNBA7tttY7IspqWe48Av+mKdnPnoCPvQGohV3Z2EMZEm73RifEpIJQhYE5xtRP6dGMLtXDr7pJpUFArTl7OJ7hxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781816769; c=relaxed/simple;
	bh=PASeUgTzjTM7iFLKonqwXnIJVP0A7XOsMyymbKG3Yf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N45RF9196urX2Nmg7YkJQ1NyeY2/ld3W742g3D2Qi+l/evQhwDsHaOxHZltHzPiR8s6oU1c6yIpXqIibkXV2zCDQmwMkUAokf6DOFi3iwuN2JcPZPoQJtLo2M7KfTfmI3Qlj0cdQxugx+uA2EEoywfnIxLHdQRBr6ZwYNEWx5ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIzPEiJg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIzPEiJg"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso10255745ad.0
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 14:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781816766; x=1782421566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=35+a94hKocLI/+h7GmBih/atY1Im2rSTFj/Q4uqACbI=;
        b=hIzPEiJgvqfOFpdkNzozPrsy5BohROwsMKoY1u66y+pIi5AM87qKBNsod90YAcVos9
         0uIVXbd5Cx3qArhjj+4kF57dz29lBjzrjMY4wphpNBrrUaJ1Y2qx2anXvXiPM7bYcP6Q
         LrFGssOqY801bJF63hCUhP57x6QH6OGoPIYz9/W7C0U00HKgSF7PpsvTxlbcgPsIKY19
         np5S4DOtTMpUD5PPKqFtpL9UeOqlCNw1P0NmTkjYxpcwBmqluKAPipFnpIHWB9kVpVBn
         MSoL1EJ9FRDpJoF+au9evQ/ujBV1Y8LINlQDlZdxxnaGywTDliJFSp/3Mlh5YuZXhGyv
         K8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781816766; x=1782421566;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=35+a94hKocLI/+h7GmBih/atY1Im2rSTFj/Q4uqACbI=;
        b=iUkOz6P8oi/sYpZ8AGJd31WmewlVH119y0FnzA4iSWngPVjeVX5h4uoMmN/qALgUKR
         k44ORXpexlxOCTtm0m2YlJMGRQVdkkPO33PJ4uERMtOJf2dcUQ9DRgphFIT5k4AjHLFP
         x3+QEglrZJ7rXT40kpUFIENbX+Vl5ZOa+gPOpgzgzjebr3ZFoMLBnU0476rz+LyZIvYq
         yYY5GlLJn+LPaAp5Y/39zEYavpOYLWKtnovY4CddtfutarWDlQPb8QJ0d/O+o75h3VqA
         ASZ54YwuwYRKEkjGNpyKR8YJz67vD8CEgF92G3r4hRTW5XrZeO/83wsS/jgXvchyac0K
         h96Q==
X-Gm-Message-State: AOJu0YwZBtM5FejDzNiHLF0fIa8eXDs+OYz1yCxQF+z4Fv3c/kFL1/iZ
	VAl7NAGU3vPeOHF/D+SIqo1pkFtbdsav467ssF4ZlSYkMcdLNStgUrU=
X-Gm-Gg: AfdE7clCxTr5nj92QiISAF7Nl7Y0IGBr+IB2OhWoHYWZbKTfbdsPVkXtXTudQ9HmVFq
	8D/cgoWcqmKUvt3qxwxh2UNSY4S/W6WOoyyZ5QBFc61NBlvxcty2ccS7htRonJF7ja3WnjnFXx6
	EIirxbRnuPphwRwqqC751YIPVVjETX8vvgbdIQfF+F2yfXL0Nh3hNWgYj2aZGnOCvTcazq5PExa
	r0rPY/FZvH61ScSg3+AUXTjqCKZaax1Y73DE1bosyDciACBO4zpQ9A83xIyUrS3dSN5XgRsPg6E
	MJ60qI0Sv4C64KKMtp77ArK0SD/WEnGvQL42PAoALuxoXF/jTXNLgNNfGqweuYYzdZIdTXgH5tg
	gSiThEOlj46OoLekMXI0yELDss3AFLjjgvdJ2YYe8Y3NOHVQdfGgbAwK1jh4DiVwExwrCLkHnBC
	7CaEzvUbPaImB5m/NwNd30LV7ez2aE9Zv1YjymkcC93XsLcD8GLaSEweElEw==
X-Received: by 2002:a17:903:1746:b0:2c1:20fe:9d5a with SMTP id d9443c01a7336-2c719052e29mr8901845ad.35.1781816765508;
        Thu, 18 Jun 2026 14:06:05 -0700 (PDT)
Received: from [192.168.1.45] ([101.0.62.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7209bc754sm523365ad.42.2026.06.18.14.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 14:06:04 -0700 (PDT)
Message-ID: <98a08d17-5b70-4f4d-bf52-fe1073fde2b6@gmail.com>
Date: Fri, 19 Jun 2026 02:36:00 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: magnetometer: add support for Melexis
 MLX90393
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260618160141.11409-1-nikhilgtr@gmail.com>
 <20260618160141.11409-3-nikhilgtr@gmail.com>
 <ajRGf0YT-fCZA1ih@ashevche-desk.local>
Content-Language: en-US
From: Nikhil Gautam <nikhilgtr@gmail.com>
In-Reply-To: <ajRGf0YT-fCZA1ih@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19-06-2026 12:56 am, Andy Shevchenko wrote:
> On Thu, Jun 18, 2026 at 09:31:41PM +0530, Nikhil Gautam wrote:
Hi Andy,

Thank you very much for taking the time to do such a thorough review of 
this patch series.

Your detailed comments and suggestions are very helpful.
I'll address the issues you've pointed out, update the cover letter to 
better explain the design decisions,
and incorporate the requested coding style and API changes in the next 
revision.

I appreciate your review and feedback.
>> +config MLX90393
>> +	tristate "MELEXIS MLX90393 3-axis magnetometer sensor"
>> +	depends on I2C
> Why not a regmap?
The MLX90393 uses both register-based and command-based transactions.
Since regmap does not naturally model the command-based interface,
using it would require workarounds such as virtual registers or bypass 
paths.
A custom transport abstraction is therefore simpler and better suited 
for this device.

I already discussed this on thread, Link : 
https://lore.kernel.org/linux-iio/20260423121834.4244-1-nikhilgtr@gmail.com/ 

>> +#ifndef MLX90393_H
>> +#define MLX90393_H
>>
>> +#include <linux/bitops.h>
>> +#include <linux/bits.h>
> Not required, it's covered by bitops.h.
Noted. Thanks

>> +#include <linux/types.h>
> ...
>
>> +#define MLX90393_MEASURE_ALL \
>> +	(MLX90393_MEASURE_TEMP | MLX90393_MEASURE_X | \
>> +	MLX90393_MEASURE_Y | MLX90393_MEASURE_Z)
> Split logically.
>
> #define MLX90393_MEASURE_ALL \
> 	(MLX90393_MEASURE_TEMP | \
> 	 MLX90393_MEASURE_X | MLX90393_MEASURE_Y | MLX90393_MEASURE_Z)
>
> Or just a (long) single line.
Agreed. Thanks

>> +	int (*xfer)(void *context, const u8 *tx, int tx_len,
>> +		    u8 *rx, int rx_len);
> One line, it's only 81 characters.
Agreed Thanks

>> +};
>> +
>> +int mlx90393_core_probe(struct device *dev,
> You want forward declaration for struct device.
Agreed, Thanks

> + array_size.h
> + bitfield.h // FIELD_GET()
>
>> +#include <linux/delay.h>
> + errno.h // -Exxx
>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
> + types.h // uXX
>
>> +#include <linux/unaligned.h>
>> +#include <linux/units.h>
> IWYU, please (just pointed out a few missing above, there are more).
Sure, will do it.

>> +/* Datasheet: Table no.17 */
>> +static const int mlx90393_scale_table[MLX90393_AXIS_MAX]
>> +				[MLX90393_GAIN_MAX]
>> +				[MLX90393_RES_MAX] = {
> This is broken indentation.
Noted, Thanks

>> +/*
>> + * Calculate total conversion time in microseconds.
>> + *
>> + * Formula derived from datasheet timing equations.
> Which formula? Where is datasheet? What if I have no access to it?
> Always repeat the important details in the comment in the code.
Got it, will add all details from datasheet

>> + */
>> +
> Unneeded blank line.
Noted, Thanks

>> +static int mlx90393_get_tconv_us(struct mlx90393_data *data)
>> +{
>> +	const int osr = data->osr;
>> +	const int osr2 = data->osr2;
>> +	const int df = data->dig_filt;
>> +
>> +	int tconvm;
>> +	int tconvt;
>> +
>> +	int m = 3; /* X,Y,Z */
>> +
>> +	/*
>> +	 * Datasheet:
> What chapter/section/table name? Page number?
Sure will add.

>> +	 * TCONVM = 67 + 64 * 2^OSR * (2 + 2^DIG_FILT)
> What does this cryptic message mean? Please, accompany this with more English
> plain text.
Agreed, Thanks

>> +static int mlx90393_xfer(struct mlx90393_data *data,
>> +			 const u8 *tx, int tx_len,
>> +			 u8 *rx, int rx_len)
>> +{
>> +	return data->ops->xfer(data->bus_context,
>> +			tx, tx_len,
>> +			rx, rx_len);
> It's perfectly one line.
>
> Also you might want to have
>
> 	if (!...->xfer)
> 		return -E...;
>
>> +}
Noted, Thanks

>> +static int mlx90393_check_status(u8 cmd, u8 status)
>> +{
>> +	/* Always validate error bit */
>> +	if (status & MLX90393_STATUS_ERROR)
>> +		return -EIO;
>> +
>> +	switch (cmd & MLX90393_CMD_MASK) {
>> +	case MLX90393_CMD_RM:
>> +		/*
>> +		 * D1:D0 indicates response availability
>> +		 * 00 means invalid/no measurement
>> +		 */
>> +		if ((status & MLX90393_STATUS_RESP) == 0)
>> +			return -EIO;
>> +		return 0;
>> +	case MLX90393_CMD_RT:
>> +		/* Reset acknowledge */
>> +		if (!(status & MLX90393_STATUS_RT))
> For sake of consistency you might want to also compare to 0 here.
Thanks, I'll make that change.

>> +static int mlx90393_write_reg(struct mlx90393_data *data, u8 reg, u16 val)
> Here the variable is named 'reg' there is 'reg_addr'. As I can see the code is
> full of inconsistencies (like 2+ people with different style guidelines wrote
> it). Please. take your time and check the code and make it consistent.
Got it, will make it consistent across whole file.

>> +{
>> +	u8 tx[4];
>> +	u8 status;
>> +	int ret;
>> +
>> +	tx[0] = MLX90393_CMD_WR;
>> +	put_unaligned_be16(val, &tx[1]);
>> +	/* Register address is encoded in bits [7:2] */
>> +	tx[3] = reg << 2;
>> +
>> +	ret = mlx90393_xfer(data, tx, sizeof(tx), &status, 1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return mlx90393_check_status(tx[0], status);
>> +}
>> +
>> +static int mlx90393_update_bits(struct mlx90393_data *data, u8 reg_addr,
>> +				u16 mask, u16 val)
>> +{
>> +	u16 reg;
>> +	int ret;
>> +
>> +	ret = mlx90393_read_reg(data, reg_addr, &reg);
>> +	if (ret)
>> +		return ret;
>>
>> +	reg &= ~mask;
>> +	reg |= (val << __ffs(mask)) & mask;
> bitfield.h has macros for this.
Noted, Thanks
>> +static int mlx90393_find_osr(int val, int *osr)
>> +{
>> +	for (unsigned int i = 0; i < MLX90393_OSR_MAX;  i++)
>> +		if (mlx90393_osr_avail[i] == val) {
>> +			*osr = i;
>> +			return 0;
>> +		}
> Missing {}.
Agreed, removed intentionally as single statement, will add as per 
guidelines all the places
where needed

>> +static int mlx90393_get_temp_osr2(struct mlx90393_data *data, int *val)
>> +{
>> +	*val = mlx90393_osr2_avail[data->osr2];
> Missing blank line.
Noted, Thanks

>> int mlx90393_write_raw(struct iio_dev *indio_dev,
>> +			      const struct iio_chan_spec *chan,
>> +			      int val, int val2,
>> +			      long mask)
>> +{
>> +	struct mlx90393_data *data = iio_priv(indio_dev);
>> +	int ret;
> Not needed, return directly.
Agreed.

>> +			/* Datasheet: 22124 millidegC/LSB */
>> +		/* Datasheet: temperature offset */
> Again, at least put a page, better to have Section/Table/et cetera title.
Sure, will do it

> +			*vals = mlx90393_osr_avail;
> +			*type = IIO_VAL_INT;
> +			*length = MLX90393_OSR_MAX;
> +		}
> +		return IIO_AVAIL_LIST;
> +
> +	default:
> +		return -EINVAL;
> +	}
>> +	return -EINVAL;
> Besides missing blank line, this is actually a dead code.
Correct, this will never be called. will fix

>> +static int mlx90393_init(struct mlx90393_data *data)
>> +{
>> +	int ret;
>> +	u16 reg;
>> +
>> +	/* Exit mode */
>> +	ret = mlx90393_write_cmd(data, MLX90393_CMD_EX);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Wait for device comes out of reset */
> Datasheet? Empirical?
Agreed, Thanks

>> +	fsleep(1000);
> 1 * USEC_PER_MSEC
> (will require time.h to be included).
Noted, Thanks

>> +	/* Reset device */
>> +	ret = mlx90393_write_cmd(data, MLX90393_CMD_RT);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Wait for device to reset */
>> +	fsleep(6000);
> As per above.
This delay is not 6000ms it is 1500ms as per datasheet, forgot to update 
in code
Thanks for pointing out, will update all places delay requirement with 
datasheet reference.

>> +int mlx90393_core_probe(struct device *dev,
>> +			const struct mlx90393_transfer_ops *ops,
>> +			void *context)
>> +{
>> +	struct iio_dev *indio_dev;
>> +	struct mlx90393_data *data;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	data = iio_priv(indio_dev);
>> +	devm_mutex_init(dev, &data->lock);
> Nonsense. If we don't check the return code of devm_*(), there is a little
> reason to use it in the first place. But then one should not use devm further.
> Easy fix: check for returned errors.
Agreed, I'll fix this in the next revision.

>> +	data->dev = dev;
>> +	data->ops = ops;
>> +	data->bus_context = context;
>> +
>> +	indio_dev->name = "mlx90393";
>> +	indio_dev->info = &mlx90393_info;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->channels = mlx90393_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(mlx90393_channels);
>> +
>> +	ret = mlx90393_init(data);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to initialize device\n");
>> +
>> +	return devm_iio_device_register(dev, indio_dev);
>> +}
>> +EXPORT_SYMBOL_GPL(mlx90393_core_probe);
> Make it namespaces.
Okay, will do it
> + array_size.h
> + errno.h
>
>> +#include <linux/module.h>
>> +#include <linux/i2c.h>
>> +#include <linux/mod_devicetable.h>
> ...and so on.
>
> Same, follow the IWYU principle.
Got it, will take care
>> +/*
>> + * MLX90393 commands use repeated-start transfers where
>> + * every command is followed by a status/data response.
>> + */
>> +static int mlx90393_i2c_xfer(void *context,
>> +			     const u8 *tx, int tx_len,
>> +			     u8 *rx, int rx_len)
>> +{
>> +	struct i2c_client *client = context;
>> +	int ret;
>> +	struct i2c_msg msgs[2] = {
>> +		[0] = {
>> +			.addr = client->addr,
>> +			.len = tx_len,
>> +			.buf = (u8 *)tx,
>> +		},
>> +		[1] = {
>> +			.addr = client->addr,
>> +			.flags = I2C_M_RD,
>> +			.len = rx_len,
>> +			.buf = rx,
>> +		},
>> +	};
>> +
>> +	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
>> +	if (ret != ARRAY_SIZE(msgs))
>> +		return ret < 0 ? ret : -EIO;
> Please, make this to be the regular pattern
>
> 	if (ret < 0)
> 		return ret;
> 	if (ret != ARRAY_SIZE(msgs))
> 		return -EIO;
>
>> +	return 0;
>> +}
Thanks, I'll make that change.
>> +static struct i2c_driver mlx90393_i2c_driver = {
>> +	.driver = {
>> +		.name = "mlx90393",
>> +		.of_match_table = mlx90393_of_match,
>> +	},
>> +	.probe = mlx90393_i2c_probe,
>> +};
> Remove this blank line.
Noted
>> +module_i2c_driver(mlx90393_i2c_driver);
>>

Thanks & Regards,
Nikhil
