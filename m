Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57552E5B2A;
	Sat, 21 Mar 2026 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774113721; cv=none; b=Kz3yTOcBJAu37ADKtpAdy9NIKlXvLTQII5diwdEuVQTM9NwgGNstmTZTblf0f1LaEd5ArWJLDq/+wR0kheXNj9UwBC5gfpDVk/wcaJ21gNn+6Il+HiT2Q4frAuVxhCGwinBPT+GxtebUu8GcsL6sTOZJnCVuIN0B+qKZkUhSsDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774113721; c=relaxed/simple;
	bh=z4QV8eafgGTooV3KSX++SR4VGFYR5EHnFp8aEhIXg6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LTzXWrdS5YhtzZ7LSyGUpmn02LKnErPhu723fBxpyUyKM4HE/a3Gq712TN6aSpFTi+x66FZ1MQDZ0ja1WIn8gZYa5WAwDVggZ8hfCMzkUUK1Kz4BeJZhKr0ikrYZH/FWRN5/KkfiRiVqyVs+8zRFTBOc5Ev5HQPtB7tCUu3LH5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ov0B2ulB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ov0B2ulB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B901C19421;
	Sat, 21 Mar 2026 17:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774113720;
	bh=z4QV8eafgGTooV3KSX++SR4VGFYR5EHnFp8aEhIXg6k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ov0B2ulB+diIDnbmYc3AYl/1iqPuCyGwKAQafYPOyx5DrWePmIZSx2yUZWi0WL8rL
	 tYg5OaD8TvNkKWGg9u3ZIpR8dt625iVE/BNFXhXzVOdf6aJvpAwCu4JwMMClKo/JBI
	 Ft79ehHV2H4vup98AcxMag8yszB5oTcfeCbKqawomki6tGm7JNOxvGNpFtq+MV4Pe9
	 12t0Mqasasm6QkAdl90/29WElm7FWeJiJNePDGc6tyEYbSCGJ3qTieQ52q4psZQeLU
	 7VTs3LsDPY+748AZli4J/Ati0V/H6mQpwgHIjttbP90ATRuHMZNtCWkoXmhtIU3MX1
	 fFWCqv+GK/CdA==
Date: Sat, 21 Mar 2026 17:21:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Siratul Islam <email@sirat.me>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: proximity: add driver for ST VL53L1X ToF
 sensor
Message-ID: <20260321172151.1f434680@jic23-huawei>
In-Reply-To: <20260319190738.151614-3-email@sirat.me>
References: <20260319190738.151614-1-email@sirat.me>
	<20260319190738.151614-3-email@sirat.me>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Mar 2026 01:07:14 +0600
Siratul Islam <email@sirat.me> wrote:

> Add support for the STMicroelectronics VL53L1X Time-of-Flight
> ranging sensor with I2C interface.
> 
> Signed-off-by: Siratul Islam <email@sirat.me>
Hi Siratul

Just a few minor things seeing as you are going to v7 anyway.
If you weren't I'd have applied some or maybe all of these as tweaks
whilst picking the driver up.

thanks,

Jonathan

> diff --git a/drivers/iio/proximity/vl53l1x-i2c.c b/drivers/iio/proximity/vl53l1x-i2c.c
> new file mode 100644
> index 000000000000..771598b92e04
> --- /dev/null
> +++ b/drivers/iio/proximity/vl53l1x-i2c.c
> @@ -0,0 +1,820 @@


> +static irqreturn_t vl53l1x_trigger_handler(int irq, void *priv)
> +{
> +	struct iio_poll_func *pf = priv;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct vl53l1x_data *data = iio_priv(indio_dev);
> +	struct {
> +		u16 distance;
> +		aligned_s64 timestamp;
> +	} scan = {};
> +	unsigned int range_status;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, VL53L1X_RESULT__RANGE_STATUS,
> +			  &range_status);
> +	if (ret)
> +		goto notify_and_clear_irq;
> +	if (FIELD_GET(VL53L1X_RANGE_STATUS_MASK, range_status) !=
> +		      VL53L1X_RANGE_STATUS_VALID)
> +		goto notify_and_clear_irq;
> +
> +	ret = vl53l1x_read_u16(data,
> +			       VL53L1X_RESULT__FINAL_CROSSTALK_CORRECTED_RANGE_MM_SD0,
> +			       &scan.distance);
> +	if (ret)
> +		goto notify_and_clear_irq;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
> +					   iio_get_time_ns(indio_dev));

Use iio_push_to_buffers_with_ts() that also takes the size of the buffer
as a parameter.  That defends against mismatch in channel spec and the
buffer provided.  Can help catch some types of bugs.

> +
> +notify_and_clear_irq:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	vl53l1x_clear_irq(data);
> +
> +	return IRQ_HANDLED;
> +}


> +static int vl53l1x_configure_irq(struct device *dev, int irq,
> +				 struct iio_dev *indio_dev)
> +{
> +	struct vl53l1x_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = devm_request_irq(dev, irq, vl53l1x_irq_handler, IRQF_NO_THREAD,
> +			       indio_dev->name, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, VL53L1X_SYSTEM__INTERRUPT_CONFIG_GPIO,
> +			   VL53L1X_INT_NEW_SAMPLE_READY);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to configure IRQ\n");

Andy already pointed out that easily fits on oneline.


> +
> +	return 0;
> +}
> +
> +static int vl53l1x_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct vl53l1x_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_READ_I2C_BLOCK |
> +				     I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -EOPNOTSUPP;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->irq = client->irq;
> +
> +	data->regmap = devm_regmap_init_i2c(client, &vl53l1x_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +				     "regmap initialization failed\n");
> +
> +	/*
> +	 * vdd-supply is required in the DT binding but we
> +	 * continue if it is missing to support older DTs.

Given the driver does nothing different for an auto provided fake regulator
and one from DT, I'm not seeing the comment as particularly useful.

Drop it.

> +	 */
> +	data->vdd_supply = devm_regulator_get(dev, "vdd");
> +	if (IS_ERR(data->vdd_supply))
> +		return dev_err_probe(dev, PTR_ERR(data->vdd_supply),
> +				     "Unable to get VDD regulator\n");

