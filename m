Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8336825B0B9;
	Fri, 21 Aug 2026 00:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787273289; cv=none; b=JngYJE10vEcSlfjb7MjjV4YkySGFBid6iDo533G2KZg9fMGoN2CrBL7ZE4dh8bXDOjA1khQxPwJVdroZNYevfhSfA3lOFeWxOhfLZBr4H2RrCmiras37CYqlXwc5GAG9sVBUly8ge5+LJyPSIdb+OQkexuoy436DsrSoWlPzIDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787273289; c=relaxed/simple;
	bh=ooyqgoZXOA1WssuzWj8dfX8blKcCecxMAgs6kDu3QMg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poH1yFX8/axB9DOcu2JtjnNn10gdUviP41StX7OWFUe1cSGK7nEypKtxcSrodM2fqE6xZlc+HkHf/9aqFg4sOcZwvLHFbPlw9QqDw/sJefsZPBk5gNlTgcfD+OHNmi8Lv1nALhq7luK/7UkDg9UQLHn81DU0SDkA9B7hh8mlf0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkvuEgup; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkvuEgup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3901F000E9;
	Fri, 21 Aug 2026 00:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787273288;
	bh=0y8EkSgm4Lt8AmWoBepZ6M2LR3LZsjUfTgb/wmwIas0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UkvuEgup9qfdLbZd9+qBrcaqj4rALTK0YcP9o5e0UidOXR3meg90p7W/2IOdbXazX
	 zZOyAWbCYe9a+apI8kPC7WdQeI7AWAfw03UVdu3ad45AZlSTvnO8Gv7fQFcLUEa6v3
	 EeP7VPy63cVHtajlcSlrfddR7ckAFlDus/wVzeJzj30hFVDuqvWZ2DOVxvChui5yGj
	 zPxu7vYjsYLMx43hXOaPGOTNG5iBVkW8kAIvBDcAmGhILdXKQH0HwJE02FkkLdJzlS
	 /awfY6Gg8ScWBspurYkYcsrQUJSypm8UXv0ix3HIwJc7fkSVNbTav/WvU4Lekiahn7
	 9/NxdVMbGBnFw==
Date: Fri, 21 Aug 2026 01:48:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Louis Adamian <adamianlouis@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] iio: pressure: ms5637: Move device data struct
 to header
Message-ID: <20260821014806.1af99c71@jic23-huawei>
In-Reply-To: <20260820141224.23730-3-adamianlouis@gmail.com>
References: <20260820141224.23730-1-adamianlouis@gmail.com>
	<20260820141224.23730-3-adamianlouis@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 10:12:17 -0400
Louis Adamian <adamianlouis@gmail.com> wrote:

> ms_tp_dev duplicated the hw pointer already in ms_tp_data. This stores a
> pointer to ms_tp_data instead which requires moving the struct
> definition from ms5637.c to ms_sensors_i2c.h.

Why is this a good thing to do?  Pointing to only the data
we happen to need in the structure seems fine to me.  Is it
that you are going to add something else in there in a later patch?

If so, mention that because as it stands this patch doesn't have
a strong justification.

Jonathan


> 
> No functional change intended
> 
> Signed-off-by: Louis Adamian <adamianlouis@gmail.com>
> ---
>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c |  4 ++--
>  drivers/iio/common/ms_sensors/ms_sensors_i2c.h | 13 ++++++++++++-
>  drivers/iio/pressure/ms5637.c                  |  9 ++-------
>  3 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
> index 1960a2ce82a8..f9dc7c7468c1 100644
> --- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
> +++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
> @@ -579,7 +579,7 @@ int ms_sensors_tp_read_prom(struct ms_tp_dev *dev_data)
>  	int i, ret;
>  	bool valid;
>  
> -	for (i = 0; i < dev_data->hw->prom_len; i++) {
> +	for (i = 0; i < dev_data->data->hw->prom_len; i++) {
>  		ret = ms_sensors_read_prom_word(
>  			dev_data->client,
>  			MS_SENSORS_TP_PROM_READ + (i << 1),
> @@ -589,7 +589,7 @@ int ms_sensors_tp_read_prom(struct ms_tp_dev *dev_data)
>  			return ret;
>  	}
>  
> -	if (dev_data->hw->prom_len == 8)
> +	if (dev_data->data->hw->prom_len == 8)
>  		valid = ms_sensors_tp_crc_valid_128(dev_data->prom);
>  	else
>  		valid = ms_sensors_tp_crc_valid_112(dev_data->prom);
> diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.h b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
> index f15b973f27c6..d9898098c066 100644
> --- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
> +++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
> @@ -35,6 +35,16 @@ struct ms_tp_hw_data {
>  	u8 max_res_index;
>  };
>  
> +/**
> + * struct ms_tp_data - Temperature/Pressure sensor data
> + * @name: Device name
> + * @hw: Sensor hardware data
> + */
> +struct ms_tp_data {
> +	const char *name;
> +	const struct ms_tp_hw_data *hw;
> +};
> +
>  /**
>   * struct ms_tp_dev - Temperature/Pressure sensor device structure
>   * @client:	i2c client
> @@ -42,11 +52,12 @@ struct ms_tp_hw_data {
>   * @prom:	array of PROM coefficients used for conversion. Added element
>   *              for CRC computation
>   * @res_index:	index to selected sensor resolution
> + * @data:	Temperature/Pressure sensor data
>   */
>  struct ms_tp_dev {
>  	struct i2c_client *client;
>  	struct mutex lock;
> -	const struct ms_tp_hw_data *hw;
> +	const struct ms_tp_data *data;
>  	u16 prom[MS_SENSORS_TP_PROM_WORDS_NB];
>  	u8 res_index;
>  };
> diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
> index 4f9f556bd123..6009d87f3d4c 100644
> --- a/drivers/iio/pressure/ms5637.c
> +++ b/drivers/iio/pressure/ms5637.c
> @@ -29,11 +29,6 @@
>  
>  #include "../common/ms_sensors/ms_sensors_i2c.h"
>  
> -struct ms_tp_data {
> -	const char *name;
> -	const struct ms_tp_hw_data *hw;
> -};
> -
>  static const int ms5637_samp_freq[6] = { 960, 480, 240, 120, 60, 30 };
>  
>  static ssize_t ms5637_show_samp_freq(struct device *dev, struct device_attribute *attr, char *buf)
> @@ -42,7 +37,7 @@ static ssize_t ms5637_show_samp_freq(struct device *dev, struct device_attribute
>  	struct ms_tp_dev *dev_data = iio_priv(indio_dev);
>  	int i, len = 0;
>  
> -	for (i = 0; i <= dev_data->hw->max_res_index; i++)
> +	for (i = 0; i <= dev_data->data->hw->max_res_index; i++)
>  		len += sysfs_emit_at(buf, len, "%u ", ms5637_samp_freq[i]);
>  	sysfs_emit_at(buf, len - 1, "\n");
>  
> @@ -168,7 +163,7 @@ static int ms5637_probe(struct i2c_client *client)
>  	dev_data = iio_priv(indio_dev);
>  	dev_data->client = client;
>  	dev_data->res_index = data->hw->max_res_index;
> -	dev_data->hw = data->hw;
> +	dev_data->data = data;
>  	mutex_init(&dev_data->lock);
>  
>  	indio_dev->info = &ms5637_info;

