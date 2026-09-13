Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BAA2E7379;
	Sun, 13 Sep 2026 03:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789270308; cv=none; b=hmn2o7cxgONkNKdXA6GM9gnk4O8oxpMYWJ+8lIFtM7M7F6jQzUSPDgecZykoGZ+Gf4gxmOxspCKPYkWzuJ6TkwfMpFHgf5tDBF7FXWzySi3QbEV+uaI8ceCMRi5WEEDPLP80DYfdcwpLGb6KjO+bFZow/UytSMIdyj6ScnPaza4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789270308; c=relaxed/simple;
	bh=eb5OX78e6j3lSciReGCxqqRheO7oA15G32dADSrzfHE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qv0/+4DaNFqz5BTYAkAt36Un8nn+VYHXCnuhsuST5X5MsCy7gpNKwG4lNmwzNvEyPs4MjI4eGogYEdij+9iiheAXpshvGe4Epk0epOWnlLTRyXpVZGbeUmVMpI7NZSRe8uJUtvZEUdH5CNMa5J9NfbD1i/Pw5YYTikA4atx9XGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/3phhsT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/3phhsT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC7C1F000FF;
	Sun, 13 Sep 2026 03:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789270306;
	bh=Kf0Pm/olxgNF7gFBWaGJ/CyqQmUYl0iacOBfb1wQ+F0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=m/3phhsTwdqhd9zh8LeoUdiOsDkKPetUv7BRMBAKNM6QKEXgqnv3z630uhLXnPYoT
	 h0kONnks3YWlgARVvo+Oj2Fw9QnUrd5ABsPP2IiVlcPOEjiPUu2LrBDuBHFXlywPjA
	 hmp6C6sV46u1JTgMJ8evlkMMef53O0Qfo2mIVtRyvgfN6IjFK0XBM6ssaBfFvzmlK3
	 2mfBXcTPtdJ8Uzr0XHT+5qc7tt04t8alS341Hgl6pALXX6DOpRi8/ReT1S+OKnn2eN
	 AVpvHVgNKB1pb3v33xB4fiHXpLOYyc3sxracPU7ZhFpWW893BmmRpsA9R+BZukEqeS
	 VxgSiZxFzbp0Q==
Date: Sun, 13 Sep 2026 04:31:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm
 <magnus.damm@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Chris
 Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH 3/5] iio: adc: rzg2l_adc: Add RZ/G3L ADC support for TSU
Message-ID: <20260913043141.1e50ae3b@jic23-hlaptop>
In-Reply-To: <20260911133653.115553-4-biju.das.jz@bp.renesas.com>
References: <20260911133653.115553-1-biju.das.jz@bp.renesas.com>
	<20260911133653.115553-4-biju.das.jz@bp.renesas.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 14:36:46 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Add renesas,r9a08g046-adc1 compatible string and its hardware
> parameters for the ADC1 IP on RZ/G3L, which is dedicated to
> the on-chip TSU (thermal sensor unit).
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

I'm in general fine with patches 1-3. If you respin, send
the whole series to everyone. It's not big enough to need messing around
with who gets what and the real DT example is patch 5.


> ---
>  drivers/iio/adc/rzg2l_adc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 408fbf8c29cc..35eaebfbdd77 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -500,8 +500,17 @@ static const struct rzg2l_adc_hw_params rzg3s_hw_params = {
>  	.adint_inten_mask = GENMASK(11, 0),
>  };
>  
> +static const struct rzg2l_adc_hw_params rzg3l_adc1_hw_params = {
> +	.num_channels = 9,
> +	.default_adcmp = 0x1d,
> +	.default_adsmp = { 0x7f, 0xff },
> +	.adsmp_mask = GENMASK(7, 0),
> +	.adint_inten_mask = BIT(8),
> +};
> +
>  static const struct of_device_id rzg2l_adc_match[] = {
>  	{ .compatible = "renesas,r9a08g045-adc", .data = &rzg3s_hw_params },
> +	{ .compatible = "renesas,r9a08g046-adc1", .data = &rzg3l_adc1_hw_params },
>  	{ .compatible = "renesas,rzg2l-adc", .data = &rzg2l_hw_params },
>  	{ }
>  };

