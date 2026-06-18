Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE73308F39
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781793865; cv=none; b=ik/aN2MsZ5e1EZhTCNM5M4nk52HhEvzrA2ftwKPnxkxYTGAMUyc+gYWSCaUp2D/vlwU03CjAaAn94mC+JOlcKKmhYUaFH71poUEUehij+YXLqzeOg7EDd4jubKnGLdlZCPm2AmLCX1tDDqTBjRR98BkOJo3PA81XIEIFxwCWFAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781793865; c=relaxed/simple;
	bh=Yu6YeUOnFWPrCqIB5YEhtWIJyvV2BtUwFJn4XL9Gr70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRpz5NQRvrwLG+LCUS0yIh28xtvREyM6FQMG6VIwqFq7MVwKsNelmkWvNGT60s9PcKvRbCNA2PUBBYORxfnW+C1vFa8GqJh+tY+jJlSw7yVelgq06u8zInyUslBDM4h5XZizpA5bf1mLeNF6FgyPKfcfRSlQHgq9iOiwo44eP0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeZm+h0M; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeZm+h0M"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4629d80fa08so1045123f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 07:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781793862; x=1782398662; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LemwOVSIrC22MjpNchRABfurYl4fHAx2ajxQmykJZ0A=;
        b=PeZm+h0MeG/A4/vv6gjIH0cRQLAoj4HR9JrACHWMuI476CY1k5gxpPl4O1f7KE/bra
         kaINdOfHenQopsMxCwSzvrhxH0snVHNZZNFYrArNkbfbFu9M4SLt5RP1/hI5UjYPSG+7
         uZ8sBJiEb18lP2gu4tl5zLgmgsVmREZ8uRatSMWukfDqGnp1CBKoyRSQjshkfFrFtz4u
         Sm53tA+s4coHz+RTU3+DyNUtjb2p2EDXnt1b0z3D26bgzWyX/i8N2s7y8a3EF0PVdhm+
         A8Hxy8ifIkZO6i889+NLb5uWt7u64mXks1uiFqczlrpmwYtrHsALfv4900rh4FmX5Nwn
         w1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781793862; x=1782398662;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LemwOVSIrC22MjpNchRABfurYl4fHAx2ajxQmykJZ0A=;
        b=mjERUPpaXbHSOkHtk1U5DmvWAX4XBA67jdFKMAaMsrbRsSt8Hl1sL+xqN8oVlvTiIe
         85y1IJ/t/0ST+GuvZedpBPJ9CpnCFeP0CZjNTCPpCsbJ59gHtW4WR8Ke1y02AAzG3z8b
         TQL74VfKVc2ShuQjyzuQf+brDaoJDtQl08HkY4hLo7QeHhUxcq4axaC2HTTUgPETkPH6
         jI+VAfgHWQmiG3G2kUJcjLMAWGTIGyFl1/f07KEVNxgkByHZiPzbX7H5yMTE7saav3RR
         iAqq3ecitIgwF7xDjfpfNYe3YigZpgQ+bPsbxvnloHyM239XP1I0pizjP2t0AqkTknwN
         +odg==
X-Gm-Message-State: AOJu0Yxx1H/ntXITUf3//c+NHJtgKOGW99dQ5Lp0wbZNhCFoHQQdHeQz
	XxwBZlc0Tv44/ns0mbDgi0KiveyGqbAO3E6VbbK5US8WPONhN55c+v+3
X-Gm-Gg: AfdE7ckY2qO/6GYYcV/DohOIIijMZIwpYdbo7jlHYK0DtcCqH4Nmk/kho8eDX38ot2I
	QHTAcu6dBIkBSvpiIBlU4ofaiwzPmK5kSToXbICv1y3gxsbS29br5p0E2ToELt+rxtzFTCGy6y8
	BWV9qFTiNt+1Ed4rKZsyshO1rENvgrRexsj/PbU8cUVgRPe3sjQrKgMyw5QCLj9yksR+T2/04iQ
	Gd3ZCDk5K+t+nR/Ozh3A1JX8/HiLNXk56Gjw9BcypermM9gOEfX4nWKgLQmKd5aJ8Diri8FRMV7
	Y4re4aKNfOvn3GlMMOmgFpk8BtJT94wuTVEnmdiQyZcjIwFF2jxT3iifdrY9MMm7MykEKhzyxUY
	LJLM19DZ2aEVKOgcCt3wYVVUkYB0K8hwS/N0O5X1/JGcGeSPo7CjjnwaAfHczhbZU/pqrdy4j0Q
	TloEOA
X-Received: by 2002:adf:e811:0:b0:460:1233:ecf2 with SMTP id ffacd0b85a97d-4623908e11dmr12410883f8f.30.1781793861659;
        Thu, 18 Jun 2026 07:44:21 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4620b1083e3sm20736217f8f.20.2026.06.18.07.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 07:44:21 -0700 (PDT)
Date: Thu, 18 Jun 2026 15:45:23 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v6 05/16] iio: core: support 64-bit register through
 debugfs
Message-ID: <ajQDsZWJQRKKM0dv@nsa>
References: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
 <20260618-ad9910-iio-driver-v6-5-79125ffbe430@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260618-ad9910-iio-driver-v6-5-79125ffbe430@analog.com>

On Thu, Jun 18, 2026 at 02:27:21PM +0100, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add debugfs_reg64_access function pointer field into iio_info and modify
> file operation callbacks to favor 64-bit variant when it is available.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/industrialio-core.c | 33 ++++++++++++++++++++++++---------
>  include/linux/iio/iio-opaque.h  |  2 +-
>  include/linux/iio/iio.h         |  4 ++++
>  3 files changed, 29 insertions(+), 10 deletions(-)
> 
> @@ -471,7 +485,8 @@ static void iio_device_register_debugfs(struct iio_dev *indio_dev)
>  {
>  	struct iio_dev_opaque *iio_dev_opaque;
>  
> -	if (indio_dev->info->debugfs_reg_access == NULL)
> +	if (!indio_dev->info->debugfs_reg_access &&
> +	    !indio_dev->info->debugfs_reg64_access)
>  		return;

Not really that important but should dev_warn() in case someone gives
both callbacks? Can't use both anyways.

(We now have agentic help reviewing the code so maybe even if someone
does it for some reason it won't pass review :))

- Nuno Sá
>  
>  	if (!iio_debugfs_dentry)
> diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> index b87841a355f8..98330385e08d 100644
> --- a/include/linux/iio/iio-opaque.h
> +++ b/include/linux/iio/iio-opaque.h
> @@ -73,7 +73,7 @@ struct iio_dev_opaque {
>  #if defined(CONFIG_DEBUG_FS)
>  	struct dentry			*debugfs_dentry;
>  	unsigned int			cached_reg_addr;
> -	char				read_buf[20];
> +	char				read_buf[24];
>  	unsigned int			read_buf_len;
>  #endif
>  };
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 711c00f67371..1c7d12af22da 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -484,6 +484,7 @@ struct iio_trigger; /* forward declaration */
>   * @update_scan_mode:	function to configure device and scan buffer when
>   *			channels have changed
>   * @debugfs_reg_access:	function to read or write register value of device
> + * @debugfs_reg64_access: function to read or write 64-bit register value of device
>   * @fwnode_xlate:	fwnode based function pointer to obtain channel specifier index.
>   * @hwfifo_set_watermark: function pointer to set the current hardware
>   *			fifo watermark level; see hwfifo_* entries in
> @@ -572,6 +573,9 @@ struct iio_info {
>  	int (*debugfs_reg_access)(struct iio_dev *indio_dev,
>  				  unsigned int reg, unsigned int writeval,
>  				  unsigned int *readval);
> +	int (*debugfs_reg64_access)(struct iio_dev *indio_dev,
> +				    unsigned int reg, u64 writeval,
> +				    u64 *readval);
>  	int (*fwnode_xlate)(struct iio_dev *indio_dev,
>  			    const struct fwnode_reference_args *iiospec);
>  	int (*hwfifo_set_watermark)(struct iio_dev *indio_dev, unsigned int val);
> 
> -- 
> 2.43.0
> 
> 
