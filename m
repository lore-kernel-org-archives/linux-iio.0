Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795838022;
	b=Et4gxxuoITvMdh36lSxsImMOOiEtipif4zSsnkWuQ5sBiQXVAI4/kM7v9wxDZrC6HJPI
	 N+QvHWCHzs9WmO0h7fARu13DcFLQizKE8sFF45vmt/wQtR1vp+CABRaIMSQOTXOLNWHHA
	 dQ71dYmOreaQDYjqUIXRObn7ech/5kDLhnKNNKN/BU/URWH4xI9YzD6cX/pkOuBuUwdav
	 68+Ru0IQ/GdZJ7+S2ACoc6u3DskAZe2y37334Ck39/hQaC6r5kpr+IQvW3qNEa3KsmLQE
	 oHcCXvsf0wspHTrhihQZmfeQg/Z4mkQ3wtq59X+a+rvacAULBqc652RZANsGk33hx/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795838022;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=laKjdSbBUY16fk60LqBJUmqlrfTN3PGZi0SWIeo0fCQ=;
	b=Eh440XFZfuZgb5pCIsPzCqGFfKfBevGtS8lo/r2co8jMciG6bap1M7Cal2rOJznA4y1I
	 ujPKim2WLxxqAbsq5nxQunjknAdj6Z2PKWUX7LuzmkDy7yEyybxP+ardgfIDilsJBQFtD
	 CsrZQbdgLtgYXC0EwURhFDnWAIdxbZsNwQX08gzc40UQtdzxDHCov1I5hpY9SQRMkHQD4
	 jBxxKSNKkNfsDySX+uHAp3gBTK3ZUTdr6c9Qn0+tN4TBMRTcqGlAkpJLJ3zKvARU7rSF4
	 XTrwuzt06yQNJ4Ldgu0V6W8xgPnQNC5GfyoBgX8hdS0X0H6lYgba4H9/tt4FVmrY6Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NtZqsSIo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9589A606A31C;
	Sat, 28 Nov 2026 03:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NtZqsSIo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B4C1F00893;
	Sat, 28 Nov 2026 03:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795838022;
	bh=laKjdSbBUY16fk60LqBJUmqlrfTN3PGZi0SWIeo0fCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NtZqsSIo69P88IjmceqXWS8E1/GhH0v1kXjR2ujgPidXtEhzDtfv44C+Ii860DeaY
	 bDFNOO44Ue+YX4iprTI4mig99DqEgUzdnnVJNlnQk3+ABYobHrOy/DUZvfOB3bpqRg
	 HJhnbmhYqma0V8Dl9BuhD8q/RJQZWqgW8BfdzuImztIEsJjTPIUsNmaZLkxAjTIdlu
	 NqHK3DBtmzhzOgL2knm+PdsTxBo2a2/7gwOVubtyJfWye1IEMQZJgqQU6WbN7Gu1iU
	 6RFQ6Atr9Q4nHjgqoGZzbFIcKxa2qLXm/z3o4eNGeslNq/aOkWv9CFmWVuWHmWQSQN
	 tZ0hIBgjUkk4A==
Date: Sat, 28 Nov 2026 03:53:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: rohm-bd79703: Fix full-scale voltages
Message-ID: <20261128035336.0ad3ba76@jic23-hlaptop>
In-Reply-To: <0723d51fa973f0204e1c436c08a784b7b1cca795.1795699121.git.mazziesaccount@gmail.com>
References: <0723d51fa973f0204e1c436c08a784b7b1cca795.1795699121.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Nov 2026 15:23:10 +0200
Matti Vaittinen <matti.vaittinen@linux.dev> wrote:

> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> The BD79702 and BD79703 have a VFS pin which can be used to supply a
> full-scale voltage to be output with maximum DAC word. The driver
> assumes this voltage is the full-scale voltage for all of the DAC
> channels. This, however, is not true.
> 
> The VFS-pin voltage is only used for the first half of the channels. Eg.
> on BD79703, channels AO1 and AO2 use VFS, AO3 and, AO4 use the VCC.
> Similarly, the BD79703 channels AO1, AO2, and, AO3 use VFS, AO4, AO5, and
> AO6 use the VCC.
> 
> Fix the driver to use correct full-scale voltages (VCC instead of VFS) on
> the last channels of the BD79702 and BD79703. The BD79700 and BD79701
> logic should not be changed.
> 
> NOTE: This change is visible to the user-space, it makes the scale a
> per-channel property so the sysFS file out_voltage_scale gets replaced
> by per-channel variants out_voltageN_scale
> 
> Fixes: af6aca656a85 ("iio: dac: Support ROHM BD79703 DAC")
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Enjoy the side discussion. I'm going to take the expedient path and
just merge this. Applied to the fixes-togreg branch of iio.git.

This wins one of those awards for generally odd things to build
in hardware.

Thanks
Jonathan

> ---
>  drivers/iio/dac/rohm-bd79703.c | 77 ++++++++++++++++++++++------------
>  1 file changed, 51 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/dac/rohm-bd79703.c b/drivers/iio/dac/rohm-bd79703.c
> index 127ccc2c4a22..1d58bc1544a1 100644
> --- a/drivers/iio/dac/rohm-bd79703.c
> +++ b/drivers/iio/dac/rohm-bd79703.c
> @@ -41,7 +41,9 @@ static const struct regmap_config bd79703_regmap_config = {
>  /* Dynamic driver private data */
>  struct bd79703_data {
>  	struct regmap *regmap;
> -	int vfs;
> +	int vcc_mv;
> +	int vfs_mv;
> +	unsigned int num_vfs_chan;
>  };
>  
>  /* Static, IC type specific data for different variants */
> @@ -49,7 +51,11 @@ struct bd7970x_chip_data {
>  	const char *name;
>  	const struct iio_chan_spec *channels;
>  	int num_channels;
> -	bool has_vfs;
> +	/*
> +	 * Some ICs use VFS-pin for full-scale voltage for first N channels.
> +	 * We need to know these channels to get correct scale
> +	 */
> +	unsigned int num_vfs_chan;
>  };
>  
>  static int bd79703_read_raw(struct iio_dev *idev,
> @@ -61,7 +67,11 @@ static int bd79703_read_raw(struct iio_dev *idev,
>  	if (mask != IIO_CHAN_INFO_SCALE)
>  		return -EINVAL;
>  
> -	*val = data->vfs / 1000;
> +	if (data->num_vfs_chan > chan->channel)
> +		*val = data->vfs_mv;
> +	else
> +		*val = data->vcc_mv;
> +
>  	*val2 = BD79703_DAC_BITS;
>  
>  	return IIO_VAL_FRACTIONAL_LOG2;
> @@ -88,16 +98,26 @@ static const struct iio_info bd79703_info = {
>  };
>  
>  #define BD79703_CHAN_ADDR(_chan, _addr) {			\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.output = 1,						\
> +	.channel = (_chan),					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +			      BIT(IIO_CHAN_INFO_SCALE),		\
> +	.address = (_addr),					\
> +}
> +
> +#define BD79703_CHAN(_chan) {					\
>  	.type = IIO_VOLTAGE,					\
>  	.indexed = 1,						\
>  	.output = 1,						\
>  	.channel = (_chan),					\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> -	.address = (_addr),					\
> +	.address = (_chan) + 1,					\
>  }
>  
> -#define BD79703_CHAN(_chan) BD79703_CHAN_ADDR((_chan), (_chan) + 1)
> +#define BD79703_CHAN_VFS(_chan) BD79703_CHAN_ADDR((_chan), (_chan) + 1)
>  
>  static const struct iio_chan_spec bd79700_channels[] = {
>  	BD79703_CHAN(0),
> @@ -115,6 +135,8 @@ static const struct iio_chan_spec bd79701_channels[] = {
>   * and 3, but to the channels 0, 1, 4, 5. So the addressing used with SPI
>   * accesses is 1, 2, 5 and 6 for them. Thus, they're not constant offset to
>   * the channel number as with other IC variants.
> + *
> + * Furthermore, the BD79702 and BD79703 can have different scale for channels.
>   */
>  static const struct iio_chan_spec bd79702_channels[] = {
>  	BD79703_CHAN_ADDR(0, 1),
> @@ -124,40 +146,40 @@ static const struct iio_chan_spec bd79702_channels[] = {
>  };
>  
>  static const struct iio_chan_spec bd79703_channels[] = {
> -	BD79703_CHAN(0),
> -	BD79703_CHAN(1),
> -	BD79703_CHAN(2),
> -	BD79703_CHAN(3),
> -	BD79703_CHAN(4),
> -	BD79703_CHAN(5),
> +	BD79703_CHAN_VFS(0),
> +	BD79703_CHAN_VFS(1),
> +	BD79703_CHAN_VFS(2),
> +	BD79703_CHAN_VFS(3),
> +	BD79703_CHAN_VFS(4),
> +	BD79703_CHAN_VFS(5),
>  };
>  
>  static const struct bd7970x_chip_data bd79700_chip_data = {
>  	.name = "bd79700",
>  	.channels = bd79700_channels,
>  	.num_channels = ARRAY_SIZE(bd79700_channels),
> -	.has_vfs = false,
> +	.num_vfs_chan = 0,
>  };
>  
>  static const struct bd7970x_chip_data bd79701_chip_data = {
>  	.name = "bd79701",
>  	.channels = bd79701_channels,
>  	.num_channels = ARRAY_SIZE(bd79701_channels),
> -	.has_vfs = false,
> +	.num_vfs_chan = 0,
>  };
>  
>  static const struct bd7970x_chip_data bd79702_chip_data = {
>  	.name = "bd79702",
>  	.channels = bd79702_channels,
>  	.num_channels = ARRAY_SIZE(bd79702_channels),
> -	.has_vfs = true,
> +	.num_vfs_chan = 2,
>  };
>  
>  static const struct bd7970x_chip_data bd79703_chip_data = {
>  	.name = "bd79703",
>  	.channels = bd79703_channels,
>  	.num_channels = ARRAY_SIZE(bd79703_channels),
> -	.has_vfs = true,
> +	.num_vfs_chan = 3,
>  };
>  
>  static int bd79703_probe(struct spi_device *spi)
> @@ -184,23 +206,26 @@ static int bd79703_probe(struct spi_device *spi)
>  				     "Failed to initialize Regmap\n");
>  
>  	/*
> -	 * BD79703 has a separate VFS pin, whereas the BD79700 and BD79701 use
> -	 * VCC for their full-scale output voltage.
> +	 * BD79702 and BD79703 have a separate VFS pin. On these ICs, the VFS
> +	 * pin provides the full-scale output voltage for half of the channels,
> +	 * and use VCC for the rest.
> +	 * The BD79700 and BD79701 use VCC for their full-scale output voltage
> +	 * for all of the channels.
>  	 */
> -	if (cd->has_vfs) {
> -		ret = devm_regulator_get_enable(dev, "vcc");
> -		if (ret)
> -			return dev_err_probe(dev, ret, "Failed to enable VCC\n");
> +	ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to enable VCC\n");
> +
> +	data->vcc_mv = ret / 1000;
>  
> +	if (cd->num_vfs_chan > 0) {
>  		ret = devm_regulator_get_enable_read_voltage(dev, "vfs");
>  		if (ret < 0)
>  			return dev_err_probe(dev, ret, "Failed to get Vfs\n");
> -	} else {
> -		ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
> -		if (ret < 0)
> -			return dev_err_probe(dev, ret, "Failed to get VCC\n");
> +
> +		data->vfs_mv = ret / 1000;
> +		data->num_vfs_chan = cd->num_vfs_chan;
>  	}
> -	data->vfs = ret;
>  
>  	idev->channels = cd->channels;
>  	idev->num_channels = cd->num_channels;
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

