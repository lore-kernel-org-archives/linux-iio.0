Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7019E220687;
	Sun, 17 May 2026 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779030399; cv=none; b=XFPmAds/VhFcsBSujDBR816xCZ1uGK5N7EGbqygTarbDFWMZvW9JkOU4UbXIHqh5Px5XH6nRFde15hxkSrz/QNwt3JyONQdciu0lWVNPF66qeg7cpf0kFXxkA1mXzob/3E1Tf+QlQywoEpNd+EJI7MaN8R6LfsL1K6riYJi/Cg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779030399; c=relaxed/simple;
	bh=zLCZow48jchZHQs9kzqyqfpT/IAXJQ2Nouv/3GCwS5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U83y1QlfbzCePUEreU1RLbDHBSDYXrMI/i+ISJ8tCF2c9e/4NIb9+xRDw4egk0iwiqH89PVT0CrASJzW7gm59aFtrHL3rHc3OQ/Pv1xeUSgI86t6EIvfewj+u4oNDXbHUEA9K4jWpsIeUz2TeVEW2wPX5K7XmduVa7anBbo+WxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StWstgdi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StWstgdi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB97C2BCB0;
	Sun, 17 May 2026 15:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779030399;
	bh=zLCZow48jchZHQs9kzqyqfpT/IAXJQ2Nouv/3GCwS5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=StWstgdirUffeUmQgdUI+NqMobgu63H/Z74lq6OjDlzxCct/kwT1Rw/YhTsxiuNlp
	 PLA8O56kpJm4Ql3CKY1F8AVST9607V+f09fNaw2m5tDi3j6GmDodF2D2LNP+jgzA4s
	 XTx62k4mF7SwCyiP3gTccemTF9TR/GZgTWH08JrtTk2N9hIXWCjqDnQeVNjd1grqlX
	 g1efZe9rV85m30Ox3SgD+M9qAlaecUf/iiSOie8oEGOFeizcOTDy5tAzeQVddw7ORk
	 U7zwi7MrAyxPvTeNFNEWqUKq9BMLKBkKkd8d94B7WGKpupBdJl3i06Ioqi6eByFfHk
	 /qBcOv7syhG6Q==
Date: Sun, 17 May 2026 16:06:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH RFC v4 06/10] iio: frequency: ad9910: add RAM mode
 support
Message-ID: <20260517160627.5c98ec03@jic23-huawei>
In-Reply-To: <20260508-ad9910-iio-driver-v4-6-d26bfd20ee3d@analog.com>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
	<20260508-ad9910-iio-driver-v4-6-d26bfd20ee3d@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 08 May 2026 18:00:22 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add RAM control channel, which includes:
> - RAM data loading via firmware upload interface;
> - Per-profile configuration and DDS core parameter destination as firmware
>   metadata;
> - Profile switching relying on profile channels;
> - Sampling frequency control of the active profile;
> - ram-enable-aware read/write paths that redirect single tone
>   frequency/phase/amplitude access through reg_profile cache when RAM is
>   active;
> 
> When RAM is enabled, the DDS profile parameters (frequency, phase,
> amplitude) for the single tone mode are sourced from a shadow register
> cache (reg_profile[]) since the profile registers are repurposed for RAM
> control.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

Minor stuff inline.

> +
> +static enum fw_upload_err ad9910_ram_fwu_write(struct fw_upload *fw_upload,
> +					       const u8 *data, u32 offset,
> +					       u32 size, u32 *written)
> +{
> +	const struct ad9910_ram_fw *fw_data = (const struct ad9910_ram_fw *)data;
> +	struct ad9910_state *st = fw_upload->dd_handle;
> +	int ret, ret2, idx, wcount;
> +	u64 tmp64, backup;
> +
> +	if (offset != 0)
> +		return FW_UPLOAD_ERR_INVALID_SIZE;
> +
> +	guard(mutex)(&st->lock);
> +
> +	if (st->ram_fwu_cancel)
> +		return FW_UPLOAD_ERR_CANCELED;
> +
> +	if (AD9910_RAM_ENABLED(st))
> +		return FW_UPLOAD_ERR_HW_ERROR;
> +
> +	/* copy ram profiles */
> +	for (idx = 0; idx < AD9910_NUM_PROFILES; idx++)
> +		st->reg_profile[idx] = get_unaligned_be64(&fw_data->profiles[idx]) |
> +				       AD9910_PROFILE_RAM_OPEN_MSK;
> +
> +	/* update CFR1 */

Comment is kind of obvious.  Maybe say more or drop it.

> +	ret = ad9910_reg32_update(st, AD9910_REG_CFR1,
> +				  AD9910_CFR1_RAM_PLAYBACK_DEST_MSK |
> +				  AD9910_CFR1_INT_PROFILE_CTL_MSK,
> +				  get_unaligned_be32(&fw_data->cfr1), true);
> +	if (ret)
> +		return FW_UPLOAD_ERR_RW_ERROR;
> +
> +	wcount = get_unaligned_be32(&fw_data->wcount);
> +	if (!wcount) {
> +		*written = size;
> +		return FW_UPLOAD_ERR_NONE; /* nothing else to write */
> +	}
> +
> +	/* ensure profile is selected */

Comment is not adding value unless there is more to say.

> +	ret = ad9910_profile_set(st, st->profile);
> +	if (ret)
> +		return FW_UPLOAD_ERR_HW_ERROR;
> +
> +	/* backup profile register and update it with required address range */
> +	backup = st->reg[AD9910_REG_PROFILE(st->profile)].val64;
> +	tmp64 = AD9910_PROFILE_RAM_STEP_RATE_MSK |
> +		FIELD_PREP(AD9910_PROFILE_RAM_START_ADDR_MSK, 0) |
> +		FIELD_PREP(AD9910_PROFILE_RAM_END_ADDR_MSK, wcount - 1);
> +	ret = ad9910_reg64_write(st, AD9910_REG_PROFILE(st->profile), tmp64, true);
> +	if (ret)
> +		return FW_UPLOAD_ERR_RW_ERROR;
> +
> +	/* populate words into tx_buf[1:] */
Another comment that doesn't add value given the code is obviously doing that.
If nothing else to say remove it.
> +	memcpy(&st->tx_buf[1], fw_data->words, wcount * AD9910_RAM_WORD_SIZE);
> +
> +	/* write ram data and restore profile register */
> +	ret = ad9910_spi_write(st, AD9910_REG_RAM,
> +			       wcount * AD9910_RAM_WORD_SIZE, false);
> +	ret2 = ad9910_reg64_write(st, AD9910_REG_PROFILE(st->profile), backup, true);
> +	if (ret || ret2)
> +		return FW_UPLOAD_ERR_RW_ERROR;
> +
> +	*written = size;
> +	return FW_UPLOAD_ERR_NONE;
> +}

>  static int ad9910_probe(struct spi_device *spi)
>  {
>  	static const char * const supplies[] = {
> @@ -1688,7 +1991,21 @@ static int ad9910_probe(struct spi_device *spi)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "device setup failed\n");
>  
> -	return devm_iio_device_register(dev, indio_dev);
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	snprintf(st->ram_fwu_name, sizeof(st->ram_fwu_name), "%s:ram",
> +		 dev_name(&indio_dev->dev));
> +	st->ram_fwu = firmware_upload_register(THIS_MODULE, dev, st->ram_fwu_name,
> +					       &ad9910_ram_fwu_ops, st);
> +	if (IS_ERR(st->ram_fwu))
> +		return dev_err_probe(dev, PTR_ERR(st->ram_fwu),
> +				     "failed to register ram upload ops\n");
> +
> +	ad9910_debugfs_init(st, indio_dev);
> +
> +	return devm_add_action_or_reset(dev, ad9910_ram_fwu_unregister, st->ram_fwu);

Why is this only after we've registered the device?  At that point userspace
stuff is exposed, so any risk of a race with this bit not having finished yet?
Perhaps a comment would be useful.


>  }
>  
>  static const struct spi_device_id ad9910_id[] = {
> 

