Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2340921FF2A;
	Mon, 13 Jul 2026 02:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783909303; cv=none; b=WxM4bBfD+CaEtbt9WCEvhFTIWydgPg+7Btel8atDTnz6cfGBeDiAf2Moqna5qSlU62n1DdhyrUxlVphqzupRWJG0Bpsm6C8H8ft7wUduMoradfHl6hK7F6bvYt/i0cc3fhMMP8xh+QmuPls9pFT2k8LA110hJn+dUV6R7scFAiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783909303; c=relaxed/simple;
	bh=8UESDvAkrO514OqIn4izrogITvCCWdhzN/uXpG1HbkA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NP021oWLhnG0lexiFIsRxXoAmiC/HCutgLrySL3pwQqkLeAvTX5ZtyreEPdwyiVzvENKHwBHJTiWo25iMc4zp/qvqaPonoQnhBflHMzAoTDTLj2smRlakmKQM02vLuYJZxilmgSwh5Vomx90O3G0V9RP+A+mSgmjdjES2qxCvHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwyS8HT2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwyS8HT2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD091F000E9;
	Mon, 13 Jul 2026 02:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783909301;
	bh=nF38DvsKXqNNodzfkULGLA2jJ8dENmbEM56IGHlbNhg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jwyS8HT2GB3qyw2xBzKQZe9ytcX+LTSP3dxl2jNkwftjYosYR5EQfF5hy8HImRzFp
	 8dJmHKhnIjRXpuqjTEuoWcb74LjqWjnhpmZbjecoNBEozEsprfm8aU8BV1jeZj3JjE
	 sNjrwPNT/3nl7acqBsQ7UYYJ9Odqk7EQK29R7tYjbH1ybSa6vgy0HsJP9p38uHFb9s
	 g0jQ65wOpmEZ5zL6k6iX7qKgu7ljcE3lVU4I/WzVtWEUGnQVX1uL9Zc+MALdLFW5HK
	 qSfaUsQ8RIAQ9Q8TNNwUodswE09gQ2fA0CZxR70/2kmFNNrrXlVgFdmstIPmYqk7oH
	 KvV+Njf4Qk3EQ==
Date: Mon, 13 Jul 2026 03:21:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chris Hall
 <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, Kurt Borja
 <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/8] iio: adc: ti-ads112c14: implement gain on
 internal short SYS_MON channel
Message-ID: <20260713032135.09429678@jic23-huawei>
In-Reply-To: <20260710-iio-adc-ti-ads122c14-v3-7-746d52cbf1d0@baylibre.com>
References: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
	<20260710-iio-adc-ti-ads122c14-v3-7-746d52cbf1d0@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jul 2026 17:50:40 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Implement support for the programmable gain amplifier on the internal
> short SYS_MON channel. This channel is used for calibration, so it is
> useful to be able to set the PGA to the same gain as the external
> channels. The gain setting is implemented via the `_scale` attribute.
> 
> In the future, we may want to support different reference voltages for
> this channel, so the scale_available table is populated during probe
> rather than being a static table.
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> ---
> v3 changes:
> * Use IIO_VAL_DECIMAL64_PICO for scale.

Sashiko (I think rightly) raised endian concerns on the read_avail
side of things.  It think you need to do the decompose to fill that
that rather than relying on placement of bytes in the 64 bit int.


Jonathan

> ---
>  drivers/iio/adc/ti-ads112c14.c | 128 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 125 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
> index 4d2e7d37be82..2ce4411a0d86 100644
> --- a/drivers/iio/adc/ti-ads112c14.c
> +++ b/drivers/iio/adc/ti-ads112c14.c

>  
> +static int ads112c14_read_avail(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan, const int **vals,
> +				int *type, int *length, long mask)
> +{
> +	struct ads112c14_data *data = iio_priv(indio_dev);
> +
> +	if (chan->channel == ADS112C14_SYS_MON_CHANNEL_SHORT) {
> +		*vals = (const int *)data->sys_mon_chan_short_scale_available;

Sashiko is mean about this and it may have a point.. Definitely needs
a comment as you are forcing a u64 to be interpreted as an array of ints and
on big endian systems the top and bottom half will get swapped.

> +		*length = 2 * ARRAY_SIZE(data->sys_mon_chan_short_scale_available);
> +		*type = IIO_VAL_DECIMAL64_PICO;
> +		return IIO_AVAIL_LIST;
> +	}
> +
> +	return -EINVAL;
> +}
> +

>  
> +static void ads112c14_populate_scale_available(s64 *scale_avail, u32 full_scale,
> +					       u32 fsr_bits)
> +{
> +	for (u32 i = 0; i < ARRAY_SIZE(ads112c14_pga_gains_x10); i++) {
> +		u64 gain_x10 = ads112c14_pga_gains_x10[i];
> +
> +		scale_avail[i] = div64_u64((u64)PICO * 10U * full_scale,
> +					   gain_x10 * BIT(fsr_bits));

I think this needs to happen into a local variable that is then decomposed
into two int elements of scale_avail[]. I.e. type of that needs to change.

> +	}
> +}


