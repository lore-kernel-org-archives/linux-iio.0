Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08985233937;
	Fri,  3 Jul 2026 03:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783047953; cv=none; b=FqTGvFfgpuuD5tGoLu1k7zzcCIKMRaFwgkphFe1LcvPszwgvP38xJXk6TfORZ0wy5JHtawlco2KDFKnT3nbYiSxkIYh5Ixt86EzX0LStIXusQSDI92bzRMaNzLaW7YbPdBXI/D/8UjQj0I5WNWyVqgleyNqmTX3Eb0yu/N5nhUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783047953; c=relaxed/simple;
	bh=wrwyfSkstvRpjeapMRua3jAzdkzZSmAwOsWVrU/3oSE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgcuSuXQHN5q8fi3h8bl3V7b3TcXZBVa6rTHgDqD3qmdKkyoyeLDDsA57MpjcL0SSmj7sNOHeKUZdt4cgJuRBhUeX6V6qx+bfWALL+1kAFXT4tUzvtUN9Q5VC6wprH94fbmKcnOWECx9ybQ4tFta5XoajyM3lzUvQ7FL6Tkg+qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/SfhvY3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/SfhvY3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34061F000E9;
	Fri,  3 Jul 2026 03:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783047951;
	bh=KT3RWN0m765R/uG56b0LfonMWfYG3QMmuHXhV5vNFpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N/SfhvY3xc4O29uYnEFYi/jTvseic3pyMZRRhlsJIiOQfI3ZZw8Pdb6kbwwmMiQmK
	 ylO1xmxtmDCfioTLFKtz5aVlQM7/8ibKxpqm5pxGlqFnfmSQ8GX56xbXV7Jtmb7jLw
	 1Nkx7kbsw9n9qAQo2Ih5fBWkiIQwVvFoCIEMZnHZMlA+Pd7q3KvAfZw2BmpJ8OhaT2
	 DmqaNMTpMXOQyNdE1dsJihqwO6IfCWQQ5dI8btX9MfjqUXsDX4MieXusJpy2w0leyy
	 RIys2ktIBCk9ZG9tEaVIG7bTocIbL8WUyUExyxipzV/R4lKTuDBtWotjRo8fBX3coM
	 itM26HoC26WfQ==
Date: Fri, 3 Jul 2026 04:05:44 +0100
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
Subject: Re: [PATCH v6 12/16] iio: frequency: ad9910: add RAM mode support
Message-ID: <20260703040544.08a8ea5e@jic23-huawei>
In-Reply-To: <20260618-ad9910-iio-driver-v6-12-79125ffbe430@analog.com>
References: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
	<20260618-ad9910-iio-driver-v6-12-79125ffbe430@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jun 2026 14:27:28 +0100
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

> diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
> index 3fe97aa887c3..c4e179dda715 100644
> --- a/drivers/iio/frequency/ad9910.c
> +++ b/drivers/iio/frequency/ad9910.c

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
> +	for (idx = 0; idx < AD9910_NUM_PROFILES; idx++)
> +		st->reg_profile[idx] = get_unaligned_be64(&fw_data->profiles[idx]) |
> +				       AD9910_PROFILE_RAM_OPEN_MSK;
> +
> +	ret = ad9910_reg32_update(st, AD9910_REG_CFR1,
> +				  AD9910_CFR1_RAM_PLAYBACK_DEST_MSK |
> +				  AD9910_CFR1_INT_PROFILE_CTL_MSK,
> +				  get_unaligned_be32(&fw_data->cfr1), true);
> +	if (ret)
> +		return FW_UPLOAD_ERR_RW_ERROR;
> +
> +	wcount = get_unaligned_be16(&fw_data->wcount);
> +	if (!wcount) {
> +		*written = size;
> +		return FW_UPLOAD_ERR_NONE; /* nothing else to write */
> +	}
> +
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

I'd like a blank line here. Mostly to make that 'good' return more obvious.

> +	return FW_UPLOAD_ERR_NONE;
> +}

>  
> +static inline void ad9910_debugfs_init(struct ad9910_state *st,
> +				       struct iio_dev *indio_dev)
> +{
> +	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
> +	char buf[64];
> +
> +	/*
> +	 * symlinks are created here so iio userspace tools can refer to them
> +	 * as debug attributes.

Maybe worth a reference to appropriate ABI doc here (even if it is introduced
in a later patch)

> +	 */
> +	snprintf(buf, sizeof(buf), "/sys/class/firmware/%s/loading", st->ram_fwu_name);
> +	debugfs_create_symlink("ram_loading", d, buf);
> +
> +	snprintf(buf, sizeof(buf), "/sys/class/firmware/%s/data", st->ram_fwu_name);
> +	debugfs_create_symlink("ram_data", d, buf);
> +}
> +
>  static int ad9910_probe(struct spi_device *spi)
>  {
>  	static const char * const supplies[] = {
> @@ -1561,7 +1876,25 @@ static int ad9910_probe(struct spi_device *spi)
...

> +	ad9910_debugfs_init(st, indio_dev);

Blank line preferred before a simple return like this one.

> +	return 0;
>  }
>  
>  static const struct spi_device_id ad9910_id[] = {
> 

