Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD69367B6A;
	Mon,  8 Jun 2026 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780941054; cv=none; b=HCsND0+N0acWFvW239H+vzDBCaiisT3+nzl+TSRFd+RSuEMhr6uco9sCLJA2XBZflHSZmgpVNGTZY8TSKlcOZUIsCOprbbLSxHXoDyvVfxeKJ8vVL7l8EuSRVCkf3MhbxeifDxzsu8Sh0U4bgp2h5SmorBuPTo9JYzJPh/KtVao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780941054; c=relaxed/simple;
	bh=Z9gPHvsofZjC1fk1q8gdCdZYAWsOZ83raXd86qLymyI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0eVG5CaC1cpGgb+s6y3dSp3dHd1R+g3tBdldX9nboD3LdlmrREo6pK88ic3uHbaictS7G0y0BS7f5BMO6q4EErygtMnhl8DVilPWa+bYLJGITv4kd3Zm0B3HXQ7Ja1AhcEk8noxWVvAThMzqKcfXeMtOPSs9ycdvvagtc++uf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdUPIVH5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdUPIVH5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A4D1F00898;
	Mon,  8 Jun 2026 17:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780941053;
	bh=Pw/pr7aE6600XxkfmkzfjJkQxPHFotN48cNxqgnQmK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TdUPIVH5F1Tg31L4RUP/ivOhfIL6bOU1ACHRpoGgRUaawq2+NzB+0Er9jQd1Non+d
	 lwgRycDiKcJl/IIkIv9h8uU6wRD+3MS/UzAJwK2arCDjONHkn/ue8RG47j0k9y4J2V
	 AiV7OgO80AJ+TXrCnLo+N1GiWaXRQAN9xNyhKKo6F4UWrQGAVghAZauSJ4aV6xvXpo
	 mcnBdc3uVRnLcxABZJpZPrW373Mcq7xyPOxSPpfX8viIc9yiwDpUt2l38orQ1XYBtj
	 CJap+jk79pFAuqLYREj6Y+Nl8idnLLEXhL3YD53fK+x55x95lv+6VgV20n9S+cOxfU
	 TtUnJFma6RgrQ==
Date: Mon, 8 Jun 2026 18:50:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: magnetometer: bmc150: simplify member access
 formatting
Message-ID: <20260608185046.14f326ea@jic23-huawei>
In-Reply-To: <20260607142120.60621-1-dennylin0707@gmail.com>
References: <20260607142120.60621-1-dennylin0707@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  7 Jun 2026 14:21:20 +0000
Hungyu Lin <dennylin0707@gmail.com> wrote:

> Keep the structure member dereference on a single line to
> improve readability.
> 
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  drivers/iio/magnetometer/bmc150_magn.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index bf2551988008..d2075a18e6a7 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -311,8 +311,7 @@ static int bmc150_magn_set_odr(struct bmc150_magn_data *data, int val)
>  			ret = regmap_update_bits(data->regmap,
>  						 BMC150_MAGN_REG_OPMODE_ODR,
>  						 BMC150_MAGN_MASK_ODR,
> -						 bmc150_magn_samp_freq_table[i].
> -						 reg_val <<
> +						 bmc150_magn_samp_freq_table[i].reg_val <<
>  						 BMC150_MAGN_SHIFT_ODR);
That is indeed ugly!

However, preferred route if we are touching the code is to use field prep for these rather
than explicit shifts (allowing the shift declaration to be dropped!) If you want
to make that change though it needs to be driver wide rather than just for this
one case.

						FIELD_PREP(BMC150_MAGN_MASK_ODR,
							   bmc150_magn_samp_freq_table[i].reg_val),

Given that whole block is very long line, it may be worth looking to see if a broader
refactor can be done to make the whole thing more readable.
For this type of code there is a standard trick - invert the check in the loop
After a bit more tidying up (which is fine in one patch I think given this
is all about improving this function)

static int bmc150_magn_set_odr(struct bmc150_magn_data *data, int val)
{
	for (unsigned int i = 0; i < ARRAY_SIZE(bmc150_magn_samp_freq_table); i++) {
		if (bmc150_magn_samp_freq_table[i].freq != val)
			continue;

		return regmap_update_bits(data->regmap,
					  BMC150_MAGN_REG_OPMODE_ODR,
					  BMC150_MAGN_MASK_ODR,
					  FIELD_PREP(BMC150_MAGN_MASK_ODR,
						     bmc150_magn_samp_freq_table[i].reg_val));
	}

	return -EINVAL;
}

I don't really like the line going that near the absolute limit of 100 but
it seems to me that introducing a local variable would result in slightly
less readable code.

Anyhow, tidy it up along the lies of that code but also apply FIELD_PREP()
FIELD_GET() for all appropriate fields (and check for the relevant includes)

Thanks,

Jonathan



>  			if (ret < 0)
>  				return ret;

