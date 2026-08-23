Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A836334C3D;
	Sun, 23 Aug 2026 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787508891; cv=none; b=KjqG3NtIVs6bXl1jG24lGSbLD2RSp5e6viyiQMufwYpwVIXIYLEYy+wsrvrgdTf1zl0Y5AJWZXYmrssIuPLMuzqyNU1FxGxMWtVA0Ew6c55Wkf/43zV0mSp9lkECEEnC7HvvFwHjcxaf6yFGArpVqjQmtkOKnI1uE2tL8s1/e/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787508891; c=relaxed/simple;
	bh=UBO9f8qBkgEVzXiS/xWTzSw8AGeJvPFvWF4qAJfJpVg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tn8LGQ20RDYQfTK9WWV16gu3ius/itVK4eKNWKsXL4o71pwXvFouL90mDPB02P2/RoYCCDd8NtxIZTpdpe3Q+45xsNxKbzdkojghNVsTpdg2TdWMD0tIKnyjfDkoaj8VFjeElZxIaGFQOEIYmkgyAOY2+sqkoTmH+ssNFBk8450=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWa0OLjl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWa0OLjl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43E71F000E9;
	Sun, 23 Aug 2026 18:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787508890;
	bh=3pnkSTu1H9wBPlf5n/Rj0RGrFpYYBXT3MfR46Y22NVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JWa0OLjlvWJBm5/Xn/qecQC0wsXSonnqAVN5tn5jZE+eyYMhSwrOthIi4qzzHw35n
	 XXuTvL/w1F5+NYxFPWjHB4XuZwSduYMBKr7n+Fji3/0+JVyh/sLgPOQo9UylB2mlbX
	 S6uNSmV7potQApR1Dp6U/APPh1lFC/hAGFK0Pw+Mil71CMHD4ahkQAL4Wz5zDV05JR
	 fsVZLy6XTA/2whOEvYDZ3ZPfv0YEsTu18GqkEgH7dyTK9axeVKKLju4k6vH7GzcQ19
	 s7qqwwtkExcEaVc/pP6YxJ+W4hwMv+doB2xeDSxR6W7lrZaasZWhBugm0ggsDDYImH
	 tVV9PevnowTpA==
Date: Sun, 23 Aug 2026 19:14:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, Puranjay Mohan
 <puranjay@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: temperature: tmp117: fix calibbias cache update
 on I2C write failure
Message-ID: <20260823191445.0d3bd9f9@jic23-huawei>
In-Reply-To: <20260823042300.24308-1-salah.triki@gmail.com>
References: <20260823042300.24308-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Aug 2026 05:23:00 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> The calibbias cache (data->calibbias) was updated before the I2C
> write to TMP117_REG_TEMP_OFFSET was known to succeed. If the write
> failed, the function correctly returned an error, but the driver's
> internal cache had already been updated to the new value.
> 
> This causes the cache and the actual hardware register to go out of
> sync: a subsequent write of the same value would be silently
> skipped by the early "if (off == data->calibbias) return 0;" check,
> since the cache matches even though the register was never
> successfully updated.
> 
> Update data->calibbias only after confirming the I2C write
> succeeded, so the cache always reflects the actual state of the
> device.
> 
> Found by code inspection.
> 
> Fixes: df041e737a38 ("iio: temperature: add driver support for ti tmp117")
> Signed-off-by: Salah Triki <salah.triki@gmail.com>

Unlike some of your other fixes this one to me is low urgency and not necessary
to backport. So applied to the testing branch of iio.git (material for next merge window)

Whilst here a bit more info on why I'm rapidly applying some of your fixes and
sitting on others.  I tend to take into account

1) Complexity of the fix - reluctant to rush on the hard ones!  This also applies more
   to core fixes where the blast radius is higher if we get it wrong,
2) Activity on the driver - if it is recent and the author is still around or others
   have been active (real changes to that driver, not tree wide stuff) then chances
   of getting additional specific review is good.
3) Manufacturer specific - generally if we have frequent contributions from a given
   manufacturer, they are also pretty good about reviewing fixes for other drivers
   supporting their hardware - even more so if someone working for them wrote the
   driver
4) Already had some review on earlier versions.
5) Phase of the moon.  I won't claim any great consistency on this ;)  Sometimes I work
   forwards in time through my backlog, sometimes backwards, sometimes based on size of
   patch etc.

Jonathan

> ---
> Changes since v2:
> - Fixed formatting around ret assignment and check (Joshua Crofts).
> - Mentioned in commit description that the issue was found by code inspection (David Lechner).
> 
>  drivers/iio/temperature/tmp117.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
> index 6bc18616ad15..a07028d560ba 100644
> --- a/drivers/iio/temperature/tmp117.c
> +++ b/drivers/iio/temperature/tmp117.c
> @@ -95,15 +95,20 @@ static int tmp117_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec
>  {
>  	struct tmp117_data *data = iio_priv(indio_dev);
>  	s16 off;
> +	int ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		off = clamp_t(int, val, S16_MIN, S16_MAX);
>  		if (off == data->calibbias)
>  			return 0;
> +
> +		ret = i2c_smbus_write_word_swapped(data->client, TMP117_REG_TEMP_OFFSET, off);
> +		if (ret)
> +			return ret;
> +
>  		data->calibbias = off;
> -		return i2c_smbus_write_word_swapped(data->client,
> -						TMP117_REG_TEMP_OFFSET, off);
> +		return 0;
>  
>  	default:
>  		return -EINVAL;

