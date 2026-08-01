Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13817380FE0;
	Sat,  1 Aug 2026 23:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785627514; cv=none; b=iWMM6DHivNNDqwLyC3FEvDp63CxQwIHv2szEw3vLFZu7mfMydpO+A+u/Yceio7GWct3VcR56pI6HD+8c9WmvG8zQMNHvKxr/mj7mdXVhsG+t3Kn6Xp4OxsaWNXuoiUfxhkN61NZC8DrW4dQCeegVQ/ODhtrhBVXui9ld/NN2scY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785627514; c=relaxed/simple;
	bh=blWx87TJu9FKa61OGVyqYuDZmb2k9o7krDvVQiD2CPc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8DEvHc9geojXTn2OQUIrXfSLmbwnGjqNDKKAxkHOYeLnZQNn9pj9iMuFSA41VQLAm38xoCdf7FGCHh18nv5fOEn09yq+qXj6kvcTQCDoNZU5ilcXZeNhkaCjGB6MPk83Yz2tJOYxiyVvZFsCVdGsmzmGC1QluikSyEK/TCMCZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjJaHU9G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjJaHU9G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13E61F00AC4;
	Sat,  1 Aug 2026 23:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785627512;
	bh=6HF0I+q/PkcSu7BT37SFJho/CTpYjRrsHW/fGyqcr0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YjJaHU9GeJV59DIOqGVyIyxPJ/K+XrjAwMph9tUJgHMD+8CTGkWzlDd6U0TgfME+9
	 YLS/vh7FspYZOM2gHIaJMM/bC1kR0ulnrILoMyVmW0YoMdL8OeU2Wakbbz/pYpbVLd
	 YuSif3mPJ/kK05LshfU0oItmCzYpPsXf3RvuGXXWC27fZmXtoed/jDzhR7KCiFjixH
	 7aQjD0Vl6TqTJwAqN/z+Ib3zrJ+ZP3PJUG7Jpmn4cYOI2G0sEAdYhihNirVjagtIaw
	 fyUWnGCUYKzbOkjqCcREK8MGPmqMHUtelM/3AJX0oKjkeofT8A4oVfPUVeDUbFMnfo
	 mWdBB3CHOgRUA==
Date: Sun, 2 Aug 2026 00:38:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: adc: add support for PAC1711
Message-ID: <20260802003827.1a1b8d3a@jic23-huawei>
In-Reply-To: <20260728-pac1711-v2-2-609bc026093c@microchip.com>
References: <20260728-pac1711-v2-0-609bc026093c@microchip.com>
	<20260728-pac1711-v2-2-609bc026093c@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 15:03:49 +0300
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> This is the iio driver for Microchip PAC1711, PAC1721, PAC1811 and
> PAC1821 single-channel power monitors with accumulator. The PAC1711 and
> PAC1721 devices use 12-bit resolution for voltage and current measurements
> and 24 bits for power calculations, while PAC1811 and PAC1821 have 16-bit
> resolution and use 32 bits for power calculations. The 56-bit accumulator
> register accumulates power (energy) or current (Coulomb counter).
> 
> PAC1711 and PAC1811 measure up to 42V Full-Scale Range, respectively 9V for
> PAC1721 and PAC1821.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>

A few trivial things from me that I don't think overlapped with existing review
comments.

>  obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
> diff --git a/drivers/iio/adc/pac1711.c b/drivers/iio/adc/pac1711.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..ee6adee31524e73371450d04bd501c545bd682b6
> --- /dev/null
> +++ b/drivers/iio/adc/pac1711.c
> @@ -0,0 +1,1274 @@



> +
> +static int pac1711_retrieve_data(struct pac1711_chip_info *info, u32 wait_time)
> +{
> +	int ret = 0;
> +
> +	/*
> +	 * Check if the minimal elapsed time has passed and if so,
> +	 * read again the chip, otherwise use the cached info.
> +	 */
> +	if (time_after(jiffies, info->chip_reg_data.jiffies_tstamp +
> +			msecs_to_jiffies(PAC1711_MIN_POLLING_TIME_MS))) {
> +		ret = pac1711_reg_snapshot(info, true, PAC1711_REFRESH_REG_ADDR,
> +					   wait_time);
> +
> +		/*
> +		 * Re-schedule the work for the read registers timeout
> +		 * (to prevent chip regs saturation)
> +		 */
> +		cancel_delayed_work_sync(&info->work_chip_rfsh);
> +		schedule_delayed_work(&info->work_chip_rfsh,
> +				      msecs_to_jiffies(PAC1711_MAX_RFSH_LIMIT_MS));
		return ret in here, possibly bring ret into narrow scope.
> +	}
> +
> +	return ret;

return 0 out here

> +}

> +
> +static ssize_t pac1711_in_enable_acc_store(struct device *dev, struct device_attribute *attr,
> +					   const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac1711_chip_info *info = iio_priv(indio_dev);
> +	bool val;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
> +	scoped_guard(mutex, &info->lock) {

Where it doesn't make any difference I'd generally use guard() rather
than scoped_guard()


> +		info->enable_acc = val;
> +		if (!val) {
> +			info->chip_reg_data.acc_val = 0;
> +			info->chip_reg_data.total_samples_nr = 0;
> +		}
> +	}
> +
> +	return count;
> +}

...

> +static struct attribute *pac1711_power_acc_attr[] = {
> +	PAC1711_DEV_ATTR(in_energy_raw),
> +	PAC1711_DEV_ATTR(in_energy_scale),
> +	PAC1711_DEV_ATTR(in_energy_en),
> +	NULL,
> +};
> +
> +static struct attribute *pac1711_coulomb_counter_attr[] = {
> +	PAC1711_DEV_ATTR(in_coulomb_counter_raw),
> +	PAC1711_DEV_ATTR(in_coulomb_counter_scale),
> +	PAC1711_DEV_ATTR(in_coulomb_counter_en),
> +	NULL,

No comma on final entries if they are intended to ensure nothing comes
after that point.

> +};



> +
> +static int pac1711_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct pac1711_chip_info *info = iio_priv(indio_dev);
> +	struct i2c_client *client = info->client;
> +	struct device *dev = &info->client->dev;
> +	s32 old_samp_rate;
> +	int new_idx, ret;
> +	__be16 tmp_be16;
> +	u16 tmp_u16;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		scoped_guard(mutex, &info->lock) {
> +			old_samp_rate = pac1711_samp_rate_map_tbl[info->sample_rate_idx];
> +			new_idx = pac1711_get_samp_rate_idx(val);
> +			if (new_idx < 0)
> +				return new_idx;
> +
> +			ret = i2c_smbus_read_i2c_block_data(client, PAC1711_CTRL_ACT_REG_ADDR,
> +							    sizeof(tmp_u16), (u8 *)&tmp_be16);
> +			if (ret < 0) {
> +				dev_err(&client->dev, "cannot read regs from 0x%02X\n",
> +					PAC1711_CTRL_ACT_REG_ADDR);
> +				return ret;
> +			}
> +
> +			tmp_u16 = be16_to_cpu(tmp_be16);
> +			tmp_u16 &= ~PAC1711_CTRL_SAMPLE_MODE_MASK;
> +			tmp_u16 |= FIELD_PREP(PAC1711_CTRL_SAMPLE_MODE_MASK, new_idx);

Use FIELD_MODIFY().

> +			tmp_be16 = cpu_to_be16(tmp_u16);
> +
> +			ret = i2c_smbus_write_word_data(client, PAC1711_CTRL_REG_ADDR, tmp_be16);
> +			if (ret < 0) {
> +				dev_err(&client->dev, "Failed to configure sampling mode\n");
> +				return ret;
> +			}
> +
> +			info->sample_rate_idx = new_idx;
> +			info->chip_reg_data.ctrl_act_reg = tmp_u16;
> +		}
> +
> +		/* Force register snapshot and timestamp update with a refresh. */
> +		info->chip_reg_data.jiffies_tstamp -= msecs_to_jiffies(PAC1711_MIN_POLLING_TIME_MS);
> +		ret = pac1711_retrieve_data(info, (1024 / old_samp_rate) * 1000);
> +		if (ret) {
> +			dev_err(dev, "%s - cannot snapshot ctrl and measurement regs\n", __func__);
> +			return ret;
> +		}
> +
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +static const struct i2c_device_id pac1711_id[] = {
> +	{ .name = "pac1711", .driver_data = (kernel_ulong_t)&pac1711_chip_features },
> +	{ .name = "pac1721", .driver_data = (kernel_ulong_t)&pac1721_chip_features },
> +	{ .name = "pac1811", .driver_data = (kernel_ulong_t)&pac1811_chip_features },
> +	{ .name = "pac1821", .driver_data = (kernel_ulong_t)&pac1821_chip_features },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, pac1711_id);
> +
> +static const struct of_device_id pac1711_of_match[] = {
> +	{
> +		.compatible = "microchip,pac1711",
> +		.data = &pac1711_chip_features

trailing comma should be there as we might add other things in future.
Also, why for the i2c_device_id table did you decided to keep them on one line
but in these entrees which are shorter, you have broken them out across multiple lines?
	{ .compatible = "microchip,pac1711", .compatible = "microchip,pac1711" },

I'm fine with both styles, but not inconsistency.

> +	},
> +	{
> +		.compatible = "microchip,pac1721",
> +		.data = &pac1721_chip_features
> +	},
> +	{
> +		.compatible = "microchip,pac1811",
> +		.data = &pac1811_chip_features
> +	},
> +	{
> +		.compatible = "microchip,pac1821",
> +		.data = &pac1821_chip_features
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, pac1711_of_match);

> 

