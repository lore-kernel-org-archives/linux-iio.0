Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9191DED4C;
	Tue, 30 Jun 2026 00:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782780451; cv=none; b=BQddAnVscgLgItYK+uI0dDHrF+b8miEdLk/OLK2dMeKuRt4WZVv5KC9S/PPlfj+qbfJtmWzPewcGJ2CydEId9os8DcjLl+8VjGUW2BEzcTGReZJexBmslpKwXog9mVxuiUkES/LjHlNsk3EVzNSsK4DD8UEdU49qpaDXk5jBwAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782780451; c=relaxed/simple;
	bh=dtPjW2kRmkITo1Gb8iZuddJUydk7HNIJ942CLjHTgIc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNEzbCHdTi6jzZ/VK4JYaiSsVrMHbFHGIBReLyyuMFSOLJkLLna5fpXmv6wZC3btmJ7tpxeu83lXiRPBCwpNYwC4Mqn8KKNL7KGfwLe8rr+xlDDq6ccO95D7IFfpWIE0Nw1n3et20PN0bk3yv4MuF5KUm5vtlivE50+nUiJNP6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKwPJBfS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKwPJBfS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB171F000E9;
	Tue, 30 Jun 2026 00:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782780449;
	bh=DWh7VafDY+WJPltLWLrvuXmtNnDtFnW39PWRh90AYtU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fKwPJBfS6UjfvBbPuXd15EJxXcUcAtGtsi8Ttkob1KkaRRQZ0IX6jUnqqpLPF4vIn
	 q2KsZyW7K5MYevrMbU4Fi48bofwjLy7q2ImZ+306+5C5dSocSgfz202N1i2arxZgDF
	 BgGNcN9Lmi+rnLjvKCZPbTj++aNa3qscqyUzomjGnn8lJrtLeIMrI0iEByMCGVZbIF
	 tkFstY+BBU92/EXeqTLw32cMhr+ExSQ8RwtqToTUCG2fmqIwxoFuvoN7M43NnXY71a
	 BzhH8hYe1lKPjOXBgHw1z9P6FCBQrT53fTMtRyCf2fV0Nl3j7ntkZ6/96ghpG+RHLO
	 dqDcxbevcExDg==
Date: Tue, 30 Jun 2026 01:47:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] iio: adc: ti-ads1262: Add excitation current
 support
Message-ID: <20260630014723.786a8885@jic23-huawei>
In-Reply-To: <20260628-ads126x-v2-4-4b1b231325ba@gmail.com>
References: <20260628-ads126x-v2-0-4b1b231325ba@gmail.com>
	<20260628-ads126x-v2-4-4b1b231325ba@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jun 2026 00:36:05 -0500
Kurt Borja <kuurtb@gmail.com> wrote:

> Support the two IDAC excitation current sources. Each channel can route
> its IDAC1/IDAC2 outputs to a pin via the "excitation-channels" property
> and select a magnitude via "excitation-current-nanoamp".
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/iio/adc/ti-ads1262.c | 78 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 76 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
> index ece97a0c2b1304ad..8921eaae537f6b0a 100644
> --- a/drivers/iio/adc/ti-ads1262.c
> +++ b/drivers/iio/adc/ti-ads1262.c
> @@ -193,6 +193,22 @@ enum {
>  	ADS1262_INPMUX_LAST
>  };
>  
> +enum {
> +	ADS1262_IDACMUX_AIN0,
> +	ADS1262_IDACMUX_AIN1,
> +	ADS1262_IDACMUX_AIN2,
> +	ADS1262_IDACMUX_AIN3,
> +	ADS1262_IDACMUX_AIN4,
> +	ADS1262_IDACMUX_AIN5,
> +	ADS1262_IDACMUX_AIN6,
> +	ADS1262_IDACMUX_AIN7,
> +	ADS1262_IDACMUX_AIN8,
> +	ADS1262_IDACMUX_AIN9,
> +	ADS1262_IDACMUX_AINCOM,
> +	ADS1262_IDACMUX_NO_CONN,
> +	ADS1262_IDACMUX_LAST

_LAST usually means inclusive. So probably call this NUM or something like that
to show that it should be one more than last value.

> +};

> @@ -450,7 +468,7 @@ static int ads1262_dev_read_by_cmd(struct ads1262 *st, u8 cmd, __be32 *val)
>  static int ads1262_channel_enable(struct ads1262 *st,
>  				  struct ads1262_channel *chan)
>  {
> -	u8 mode0, mode1, mode2, inpmux, refmux;
> +	u8 mode0, mode1, mode2, inpmux, idacmux, idacmag, refmux;
>  	int ret;
>  
>  	/* Avoid using guard() here to mitigate AB/BA deadlock warning */
> @@ -464,6 +482,10 @@ static int ads1262_channel_enable(struct ads1262 *st,
>  		FIELD_PREP(ADS1262_MODE2_BYPASS_MASK, chan->pga_bypass);
>  	inpmux = FIELD_PREP(ADS1262_INPMUX_MUXN_MASK, chan->input[1]) |
>  		 FIELD_PREP(ADS1262_INPMUX_MUXP_MASK, chan->input[0]);
> +	idacmux = FIELD_PREP(ADS1262_IDACMUX_MUX1_MASK, chan->idac_mux[0]) |
> +		  FIELD_PREP(ADS1262_IDACMUX_MUX2_MASK, chan->idac_mux[1]);
> +	idacmag = FIELD_PREP(ADS1262_IDACMAG_MAG1_MASK, chan->idac_mag[0]) |
> +		  FIELD_PREP(ADS1262_IDACMAG_MAG2_MASK, chan->idac_mag[1]);

This presumably feeds into the discussion of locking that you were having
with David, but I'd find this a lot easier to read if these were just
above where the values are used. Then we can clearly see the match between
masks and fields.  If you have to do it like this, then add variables up
here for the masks as well.


>  	refmux = FIELD_PREP(ADS1262_REFMUX_RMUXN_MASK, chan->reference[1]) |
>  		 FIELD_PREP(ADS1262_REFMUX_RMUXP_MASK, chan->reference[0]);
>  	mutex_unlock(&st->chan_lock);
