Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB95537C0E9;
	Sun, 12 Apr 2026 19:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776021135; cv=none; b=RJQUlw+p8dW26SEelVQkpan8ipUcqGopMy5Gp96Tw/hQSl/kPj//VhJUVg75dx8z/wqOyLZaDvzZPr1l3gbZqVe5eOytwyX73LYAOdYo+vFs51SG+ROx6fC5in88YvcxWJt3QSjFVR9WhgjHm7LwVuN8TXMPfTkiTtQiKgv4xdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776021135; c=relaxed/simple;
	bh=zrgdsIqgYwQijEsB5P3zq/xgVKcCnLHXGmU4Ln6eJHw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkQwbmF6Pt84cmyLb0dYXs8NL1DjCvX1288Fd+vLhATqexIjBZ/Xa8NxECR5fENs3jJhYLIof4TpZzyIwIywQDeRv8z7nZ7xztoO3HdPgMhsXWXWzpz2kxjoVpHer0ZS8V6kh3kYav5kSf8z9J17EGzmz5ofqqM48U3nEqr7mXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+i3mIe/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+i3mIe/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89B4C19424;
	Sun, 12 Apr 2026 19:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776021135;
	bh=zrgdsIqgYwQijEsB5P3zq/xgVKcCnLHXGmU4Ln6eJHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l+i3mIe/ptL1I58q1ie6vY44oK8NnQRJjFK8R1hkhm6wWDWp9mIVvcHiUACg6zfGA
	 T+Pqpd1PjdBU3BX4q1eurxhETCncSlZ9IIUhCM7bORYVBxzue88ucuds5agW+2rCYZ
	 hBJaU/wvRtN5e+mTOKqDlVxV1q14w+hWVlNt+PNA6GwnWSdByMAq77vmWYJJcbV3yN
	 rdAFqLNUaPlZTfBYxE/NC/StyG7JOnxSXhTbSjWhmNgMtrJbMp2sibYnPMRdp2yGKq
	 53Jds5v5mtQMS5n57awGrI9NPHj6hyW00NqtzrkyoSwjqRFErNZrP4iYA+XrdEZiS+
	 5TUw+yMFEzQnw==
Date: Sun, 12 Apr 2026 20:12:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3] iio: adc: ad4695: Fix call ordering in offload
 buffer postenable
Message-ID: <20260412201206.6f65e159@jic23-huawei>
In-Reply-To: <20260408-ad4696-fix-v3-1-37fe6e8d1d25@analog.com>
References: <20260408-ad4696-fix-v3-1-37fe6e8d1d25@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 08 Apr 2026 13:32:13 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
>=20
> ad4695_enter_advanced_sequencer_mode() was called after
> spi_offload_trigger_enable(). That is wrong because
> ad4695_enter_advanced_sequencer_mode() issues regular SPI transfers to
> put the ADC into advanced sequencer mode, and not all SPI offload capable
> controllers support regular SPI transfers while offloading is enabled.
>=20
> Fix this by calling ad4695_enter_advanced_sequencer_mode() before
> spi_offload_trigger_enable(), so the ADC is fully configured before the
> first CNV pulse can occur. This is consistent with the same constraint
> that already applies to the BUSY_GP_EN write above it.
>=20
> Update the error unwind labels accordingly: add err_exit_conversion_mode
> so that a failure of spi_offload_trigger_enable() correctly exits
> conversion mode before clearing BUSY_GP_EN.
>=20
> Fixes: f09f140e3ea8 ("iio: adc: ad4695: Add support for SPI offload")
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Note I'll almost certainly rebase that branch on rc1 once available
rather than doing a final fixes pull request this cycle.

Thanks,

Jonathan

> ---
> ad4695_enter_advanced_sequencer_mode() issues regular SPI transfers to
> configure the ADC. These must complete before spi_offload_trigger_enable()
> enables the PWM/CNV trigger, because once CNV pulses are live the offload
> engine owns the SPI bus.
>=20
> This fixes the call ordering and updates the error unwind path accordingl=
y.
> ---
> Changes in v3:
> - Reword commit message: "the offload engine owns the SPI bus; any
>   concurrent regular SPI transfer produces undefined behaviour" =E2=86=92
>   "not all SPI offload capable controllers support regular SPI
>   transfers while offloading is enabled".
> - Rename err_trigger_disable =E2=86=92 err_offload_trigger_disable to red=
uce
>   diff churn.
> - Link to v2: https://lore.kernel.org/r/20260401-ad4696-fix-v2-1-2480b9a3=
0749@analog.com
>=20
> Changes in v2:
> - Reword commit message to explain the correct bus-ownership
>   invariant directly, without reference to the HDL bug that
>   exposed it.
> - Remove unnecessary comment since the error path changed.
> - Link to v1: https://lore.kernel.org/r/20260330-ad4696-fix-v1-1-e841e964=
51b2@analog.com
> ---
>  drivers/iio/adc/ad4695.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
> index cda419638d9a..53642de7330d 100644
> --- a/drivers/iio/adc/ad4695.c
> +++ b/drivers/iio/adc/ad4695.c
> @@ -876,14 +876,14 @@ static int ad4695_offload_buffer_postenable(struct =
iio_dev *indio_dev)
>  	if (ret)
>  		goto err_unoptimize_message;
> =20
> -	ret =3D spi_offload_trigger_enable(st->offload, st->offload_trigger,
> -					 &config);
> +	ret =3D ad4695_enter_advanced_sequencer_mode(st, num_slots);
>  	if (ret)
>  		goto err_disable_busy_output;
> =20
> -	ret =3D ad4695_enter_advanced_sequencer_mode(st, num_slots);
> +	ret =3D spi_offload_trigger_enable(st->offload, st->offload_trigger,
> +					 &config);
>  	if (ret)
> -		goto err_offload_trigger_disable;
> +		goto err_exit_conversion_mode;
> =20
>  	mutex_lock(&st->cnv_pwm_lock);
>  	pwm_get_state(st->cnv_pwm, &state);
> @@ -895,23 +895,16 @@ static int ad4695_offload_buffer_postenable(struct =
iio_dev *indio_dev)
>  	ret =3D pwm_apply_might_sleep(st->cnv_pwm, &state);
>  	mutex_unlock(&st->cnv_pwm_lock);
>  	if (ret)
> -		goto err_offload_exit_conversion_mode;
> +		goto err_offload_trigger_disable;
> =20
>  	return 0;
> =20
> -err_offload_exit_conversion_mode:
> -	/*
> -	 * We have to unwind in a different order to avoid triggering offload.
> -	 * ad4695_exit_conversion_mode() triggers a conversion, so it has to be
> -	 * done after spi_offload_trigger_disable().
> -	 */
> -	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> -	ad4695_exit_conversion_mode(st);
> -	goto err_disable_busy_output;
> -
>  err_offload_trigger_disable:
>  	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> =20
> +err_exit_conversion_mode:
> +	ad4695_exit_conversion_mode(st);
> +
>  err_disable_busy_output:
>  	regmap_clear_bits(st->regmap, AD4695_REG_GP_MODE,
>  			  AD4695_REG_GP_MODE_BUSY_GP_EN);
>=20
> ---
> base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
> change-id: 20260330-ad4696-fix-186955a8c511
>=20
> Best regards,

