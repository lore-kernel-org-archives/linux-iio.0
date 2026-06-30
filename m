Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD96331A44;
	Tue, 30 Jun 2026 23:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782863368; cv=none; b=nGm68bOtYDq+tV3dHY8LxD/iKUsyX3ghDDnM3uruigaLKWT9xFaYLqTVrj/psFP26PlDJgX0d89KKFPvTtpql6oGDGGwHMTtbLpEvUJxj6yz4KAHa4RnaHQbsRwztKhdPVX6iekzdQYb4JTuPVcwV1yo/PjWOyce8IyxUDUKp+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782863368; c=relaxed/simple;
	bh=uCxc1DKXcHuYQO2dInCBlK3aa8uHzLSZF+6OAiLXDrA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2AoxCuh9g0Eh1KILYe/GV90WA9RTyTM6KNai7jgWYaZwwHgUKJFzqPDTvMyzITFWWvdTq+s75lQaLo5JCZ1JfYiJXhM61AzQPayv/PIlZhEOu58v7GJB4iuj7ArEFyPBZD/HPklV956rp3xajtqnkFs3Gqo2+28iWQmIBHJLGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMdPXLIg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMdPXLIg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF57A1F000E9;
	Tue, 30 Jun 2026 23:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782863367;
	bh=n9xIVbosf1jApgOmRwC3zrz/SlFmK4cYqX7Bcsrj9+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JMdPXLIgiAiYDr3pL2l39PgCePdIreehKyUdtQn/eFztXnlQ1cVwoaXLY9CJtvQEW
	 d4UsZr7wDyxd8+KRTYs5A8rfZpomi6zzC+GvoGSffB+sk3YDFTGUw8xN69kkgKEtD8
	 t8ShLmfpz43ipyUwYMHBsKDlqzK7ms5B40qKwGfRuu4QSoD1tS8P7OaOYsOHIfLjRz
	 x6q8uhivFYHO/iVYyhbkctklucEcTS6Sv3H0jty2pRSsCYmUVasLmD2cM3Ms38SOyZ
	 EsgL0Mj1FweA5zPlo9iy7B/I26dl0p6FEZW+QhdWJCaYwdGVtHr4UHxjjoVFW0wOvq
	 mpCbqSneD/UKQ==
Date: Wed, 1 Jul 2026 00:49:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: <ehristev@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
 <srini@kernel.org>, <marcelo.schmitt@analog.com>,
 <jorge.marques@analog.com>, <mazziesaccount@gmail.com>,
 <Jonathan.Santos@analog.com>, <jishnu.prakash@oss.qualcomm.com>,
 <antoniu.miclaus@analog.com>, <duje@dujemihanovic.xyz>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/13] nvmem: microchip-otpc: add tag-based packet
 lookup
Message-ID: <20260701004920.2f084a3c@jic23-huawei>
In-Reply-To: <20260630093603.38663-7-varshini.rajendran@microchip.com>
References: <20260630093603.38663-1-varshini.rajendran@microchip.com>
	<20260630093603.38663-7-varshini.rajendran@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 15:05:56 +0530
Varshini Rajendran <varshini.rajendran@microchip.com> wrote:

> Add support for accessing OTP packets by their 4-byte ASCII tag while
> preserving backward compatibility with the existing ID-based lookup.
> 
> The OTP memory layout can vary across devices and may change over time,
> making the packet ID approach unreliable when the memory map is not
> known in advance. The packet tag provides a reliable way to identify
> and access packets without prior knowledge of the OTP memory layout.
> 
> Two offset encoding are now supported:
>   1. Legacy ID-based: offset = OTP_PKT(id) = id * 4
>      Used in DT as: reg = <OTP_PKT(1) 76>;
>   2. TAG-based: offset = 4-byte ASCII packet tag
>      Used in DT as: reg = <0x41435354 0x4c>; (tag "ACST")
> 
> The driver resolves offsets matching valid legacy selectors (multiples
> of 4 within the packet count) through ID lookup, falling back to tag
> lookup for other values. This ensures existing device trees continue
> to work while enabling new tag-based access.
> 
> During probe, packet meta data including the tag is read and cached.
> The driver also validates OTP memory accessibility and emulation mode
> status. When the boot packet is not configured, emulation mode allows
> access to the other packets. When both are not available an
> informational message is logged.
> 
> The stride of the nvmem memory is set to 1 in order to support tag based
> offsets, comment in the header file is updated accordingly.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
A couple of trivial things inline

Thanks,

Jonathan

>  static int mchp_otpc_prepare_read(struct mchp_otpc *otpc,
>  				  unsigned int offset)
>  {
> @@ -140,8 +198,29 @@ static int mchp_otpc_prepare_read(struct mchp_otpc *otpc,
>   * offset returned by hardware.
>   *
>   * For this, the read function will return the first requested bytes in the
> - * packet. The user will have to be aware of the memory footprint before doing
> - * the read request.
> + * packet.
> + *
> + * Two offset encoding are supported:

"encodings" as there are two of them.

> + *
> + * 1. Legacy ID-based: offset = OTP_PKT(id) = id * 4
> + *    Used in DT as: reg = <OTP_PKT(1) 76>;
> + * 2. TAG-based: offset = 4-byte ASCII packet tag
> + *    Used in DT as: reg = <0x41435354 0x4c>; (tag "ACST")
> + *
> + * To use the legacy ID based packet lookup the user will have to be aware of
> + * the memory footprint before doing the read request.
> + *
> + * But by using the TAG based packet lookup, the user won't have to be aware
> + * of the memory footprint before doing the read request since this driver has
> + * it abstracted and taken care of.
> + *
> + * Practically, there is no way of knowing the mapping of the OTP memory table
> + * in advance for every device. But by using the packet tag - the identifier
> + * ASCII value, the packets can be recognized without being aware of the
> + * flashed OTP memory map table and the payload can be acquired reliably.
> + *
> + * While the legacy ID based lookup is still supported, TAG based approach is
> + * recommended.
>   */
  
> @@ -244,7 +356,8 @@ static int mchp_otpc_probe(struct platform_device *pdev)
>  {
>  	struct nvmem_device *nvmem;
>  	struct mchp_otpc *otpc;
> -	u32 size;
> +	bool emul_enable;
> +	u32 size, tmp;

If possible give tmp a more meaningful name.  reg_val or better yet
something about which register.

>  	int ret;
>  
>  	otpc = devm_kzalloc(&pdev->dev, sizeof(*otpc), GFP_KERNEL);
> @@ -256,10 +369,22 @@ static int mchp_otpc_probe(struct platform_device *pdev)
>  		return PTR_ERR(otpc->base);
>  
>  	otpc->dev = &pdev->dev;
> +
> +	tmp = readl_relaxed(otpc->base + MCHP_OTPC_MR);
> +	emul_enable = tmp & MCHP_OTPC_MR_EMUL;
> +	if (emul_enable)
> +		dev_info(otpc->dev, "Emulation mode enabled\n");
> +
>  	ret = mchp_otpc_init_packets_list(otpc, &size);
>  	if (ret)
>  		return ret;
>  
> +	if (!size) {
> +		dev_warn(otpc->dev, "Cannot access OTP memory\n");
> +		if (!emul_enable)
> +			dev_info(otpc->dev, "Boot packet not programmed and emulation mode disabled\n");
> +	}
> +

