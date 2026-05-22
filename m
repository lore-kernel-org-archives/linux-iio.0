Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F5C3D45EA;
	Fri, 22 May 2026 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779457922; cv=none; b=W3TgyeYZJsVCfAVtJ0tveVINw0rfFhHLyWyg50KzCJ2IDbnN+WhAFiHN1qtjygmk9P4IevgkbCdFFakD+veIUR85ByllcgTzxKZLyJ1aM+8apojm625ovXoAF+RpYpSfgteDcn5Vbgxs55VOSKTgdvxIQtmp8bJ4c1PejJQZQ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779457922; c=relaxed/simple;
	bh=0lU2q4HUF+V+3/xape5kbwRjuxtQP3pyZQY7oeJ6Suc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4UmdBLmcgRFSb32rG4mVgW/sGb9R2czKTELV+p0wVmpsHBO7uW9bnLIiRubwxa17y9AVKvNcZYywn2JLN+A+nJIxAAdfhV6VnPhkAITSh1cKH5yaO2+qUkkczNFSAbunZAzya+PolTDiy9wL58CjVfkNFvjAmj2L/IYzjpHYyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhFZiTR5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhFZiTR5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7282B1F000E9;
	Fri, 22 May 2026 13:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779457912;
	bh=XF3NIYP11UdOCrfOes/zoYPQBdawQPSXvEPNb9lLPGo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WhFZiTR5sXjUQTdvZNcGAoV5myYXRwPnPPtXw8DOd5flHxNn2cB5YWa1vi/RJVzgo
	 RiLcSwj/2DBDoVi8WCsUtlw7b46S+Jxm42O/OretdeuaF/46wmkoi6ErVEhaP9+8wx
	 Wu4OE0cMlzh1C7wlmq7kNlqoYWb2/9XA32OEmfS62KclrmG9Ha0rDLRl6BeMl5cBQt
	 rPgjsPafJHq/X489JVJh/3/mklriWghdUloHe/wyktmch2iN35T4/UrDghPBP9ZN77
	 D1Qj5J+5JVHUupbojxx4yQEfmXl6z5F4NdEkEwuXu34ogoAmoZyggSDL8XmSvMT7bX
	 xdg83PEnl0EZQ==
Date: Fri, 22 May 2026 14:51:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: ad_sigma_delta: fix
 clear_pending_event for registerless devices
Message-ID: <20260522145143.1e651c12@jic23-huawei>
In-Reply-To: <20260521-ad_sigma_delta-fix-v4-2-bfb3df3e36da@analog.com>
References: <20260521-ad_sigma_delta-fix-v4-0-bfb3df3e36da@analog.com>
	<20260521-ad_sigma_delta-fix-v4-2-bfb3df3e36da@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 21 May 2026 13:30:49 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
>=20
> ad_sigma_delta_clear_pending_event() falls through to the status register
> read path for devices with has_registers =3D false and no rdy_gpiod. For
> such devices, ad_sd_read_reg() skips the address byte entirely and clocks
> raw MISO bytes with no address phase =E2=80=94 making it byte-for-byte id=
entical
> to reading conversion data. If a pending conversion result is present,
> this partially consumes it and corrupts the data stream for the subsequent
> ad_sd_read_reg() call in ad_sigma_delta_single_conversion().
>=20
> Furthermore, with num_resetclks =3D 0 on these devices, data_read_len
> evaluates to 0. If the clocked byte has bit 7 clear, pending_event is set
> and the code attempts memset(data + 2, 0xff, 0 - 1), overflowing to
> SIZE_MAX and corrupting the heap.
>=20
> Fix by returning 0 immediately when neither rdy_gpiod nor has_registers
> is set. This is safe because the IRQ is requested with IRQF_NO_AUTOEN and
> IRQ_DISABLE_UNLAZY, which keeps the hardware IRQ line unmasked even while
> software-disabled. Any falling edge from a completed conversion is latched
> by the IRQ controller.

David raised this on v2.

This sounds suspiciously like we are in implementation defined territory.
IIRC if an irq is disabled, whether the interrupt is latched is down
to whether the irq controller happens to do so. There is no hard rule on th=
is
or way to detect whether it will or not.

https://lore.kernel.org/all/io53lznz3qp3jd5rohqsjhosnmdzd6d44sdbwu5jcfrs3rz=
2a2@orquwgflrtyc/
Was I think the most recent detailed thread on this.

Uwe - you were driving that discussion can you sanity check what we have
here if you have a moment?  Thanks!




> When ad_sd_enable_irq() is subsequently called the
> latched edge fires immediately, and the existing ad_sd_read_reg() call in
> ad_sigma_delta_single_conversion() reads the complete stale result from
> the beginning with no prior partial clock corruption.
>=20
> The same heap corruption is reachable on any device with rdy_gpiod set
> but num_resetclks =3D 0: if the GPIO indicates a pending event, the drain
> path executes memset(data + 2, 0xff, 0 - 1) regardless of has_registers.
> Add an explicit data_read_len =3D=3D 0 guard after the pending event chec=
k to
> cover this path.
>=20
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
>  drivers/iio/adc/ad_sigma_delta.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_=
delta.c
> index 651ade67ad2e..d4ded8d6b211 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -262,11 +262,16 @@ static int ad_sigma_delta_clear_pending_event(struc=
t ad_sigma_delta *sigma_delta
> =20
>  	/*
>  	 * Read R=CC=85D=CC=85Y=CC=85 pin (if possible) or status register to c=
heck if there is an
> -	 * old event.
> +	 * old event. For devices with neither an RDY GPIO nor registers,
> +	 * ad_sd_read_reg() transmits no address byte and clocks raw MISO bytes,
> +	 * which is indistinguishable from reading conversion data and would
> +	 * partially consume a pending result. Skip the check for such devices;
> +	 * IRQ_DISABLE_UNLAZY ensures any pending falling edge is latched and
> +	 * fires naturally on the next ad_sd_enable_irq() call.
>  	 */
>  	if (sigma_delta->rdy_gpiod) {
>  		pending_event =3D gpiod_get_value(sigma_delta->rdy_gpiod);
> -	} else {
> +	} else if (sigma_delta->info->has_registers) {
>  		unsigned int status_reg;
> =20
>  		ret =3D ad_sd_read_reg(sigma_delta, AD_SD_REG_STATUS, 1, &status_reg);
> @@ -274,11 +279,23 @@ static int ad_sigma_delta_clear_pending_event(struc=
t ad_sigma_delta *sigma_delta
>  			return ret;
> =20
>  		pending_event =3D !(status_reg & AD_SD_REG_STATUS_RDY);
> +	} else {
> +		return 0;
>  	}
> =20
>  	if (!pending_event)
>  		return 0;
> =20
> +	/*
> +	 * With num_resetclks =3D 0, data_read_len is 0 and the drain sequence
> +	 * below would compute memset(data + 2, 0xff, 0 - 1), underflowing to
> +	 * SIZE_MAX and corrupting the heap. There is no safe way to drain the
> +	 * stale result without knowing the data register size, so return 0 and
> +	 * let the latched IRQ edge fire on the next ad_sd_enable_irq() call.
> +	 */
> +	if (!data_read_len)
> +		return 0;
> +
>  	/*
>  	 * In general the size of the data register is unknown. It varies from
>  	 * device to device, might be one byte longer if CONTROL.DATA_STATUS is
>=20

