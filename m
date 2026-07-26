Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED8F189F43;
	Sun, 26 Jul 2026 19:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785093394; cv=none; b=kroOlBCcTGW8KvbV312lONiHUPJUDlp0zxBxFAdhnq5Um0bcUbZOmL9xRY/32gQ/girFDRYJ6YDtRAtUKeW1fHjwSNCmNvr70uWHbKLbJ/fZ0x2N7q5d1g2aOfIAuFPirPvzC0mBm0UTXdf4D2NN6buLjBV5oOM8soB7tG9u8wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785093394; c=relaxed/simple;
	bh=CmVsxHc/RzoGucDG1EFHNBjviirnRulscJnkcWiydxk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sf9B5ZOphpNBaQwP0KwFxlF1sIh7cCAy9WfRuHWgXB2JCRHMaH0S0wsIOkxJ8fhERCuoMq1GQecM6a4xMeLltDeeOwLklSfg1fmLUddQtIBrbbUs1YROR0z1uHicfX2de6N+U/uUItDp7o/bFsk+c0feE6hcokxq1+/Oecam6Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zphf/47e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zphf/47e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C08E1F000E9;
	Sun, 26 Jul 2026 19:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785093393;
	bh=Oy9sPc/YDcLNAEYkFAd0wWANma0xaTVJGPDyRenOnHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Zphf/47eyOEsStXf4Efj2pd1lVc/mf6JBbjfm+gCqtaFe49t5sGUpEDgVCqKVaB+8
	 AJr8ioXsW3xWnB95BDu0+ImlxYdxcFTgci3Y3qBBIRB5WYCn01CnHaFz6m7fiz6jh/
	 z/Las8aVGB1ziWnXpU6c173fwLmLvVmA0bVAGY+skZQxUIZnViBwICnWiGSEr04D6/
	 H2A9YRpTCtLCtxLmu7dfCp/LloAIYBaPYJyuAiuML/Yy65/Z2INL4KdXJLJ2vB1iHJ
	 A9fH5Av92709gjX15pGTWsTpohdf1Yei1M5+Vg0jPuaVNNwezjZkjih/oPugs4usPo
	 S2/dT3BCEoouw==
Date: Sun, 26 Jul 2026 20:16:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: veml3328: remove extra blank line
Message-ID: <20260726201628.11fb4375@jic23-huawei>
In-Reply-To: <20260724-veml3328-cleanup-v1-2-240ecf3e5097@gmail.com>
References: <20260724-veml3328-cleanup-v1-0-240ecf3e5097@gmail.com>
	<20260724-veml3328-cleanup-v1-2-240ecf3e5097@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 00:07:09 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> Remove an extra blank line in the iio_chan_spec[] assignment.
> 
> No functional change.

I don't mind this at one end of a series doing something more substantial
but patch 1 is going away anyway and this on it's own is too much
churn / noise.

Jonathan

> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/iio/light/veml3328.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/light/veml3328.c b/drivers/iio/light/veml3328.c
> index a65748466116..7884c8250590 100644
> --- a/drivers/iio/light/veml3328.c
> +++ b/drivers/iio/light/veml3328.c
> @@ -70,7 +70,6 @@ static const struct regmap_config veml3328_regmap_config = {
>  static const struct iio_chan_spec veml3328_channels[] = {
>  	{
>  		.type = IIO_LIGHT,
> -
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>  		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),
> 

