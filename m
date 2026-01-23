Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C298364025;
	Fri, 23 Jan 2026 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769161094; cv=none; b=qCS+VTrDSx+ETwT2m/rIpbThWixMol/zknb2kDV5BMf6lj1N7ilq1uPA4l0FgXvpH+6NujyoC/0g9wTxu8cljeXrO+WxEuuJQGCnc22MBc5HEO6IsNkaxNlOX3nZorLFCNf8Rs+/7KoHvuYZjdab3cDJqE4IpCFpuw/s23FZuks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769161094; c=relaxed/simple;
	bh=LfipcSOqdAFv0IVQ+sn6QVivzYsh6QNdOssfK/qpBTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvBxrxc5Ty3/mUWxWuBme6wT+b5qkZcAwXMFfxDE36MGPG+5qJFzJuw8OUXLulZBK7dZFyl8Ou//t313lbSbpTvC69Q171IfI3132UjiMuqjqHh+pf6aLsYeOq+t5V3SIc8lO+hEOfb+JWyF8Zf6sy4rI+KRGP0buzIeTHEOgmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AV/hK1Gt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AV/hK1Gt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D16C4CEF1;
	Fri, 23 Jan 2026 09:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769161093;
	bh=LfipcSOqdAFv0IVQ+sn6QVivzYsh6QNdOssfK/qpBTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AV/hK1GtHkKYoj+6Ja82nUdIyRwDp3wDifzvuTytCFL7yP/u0M+0nGLJzfGYB6/XY
	 fZ9+oaZ4bEYS5RMv95Mu+c//ZAoNw42KFutOZ82yrjvYhl6Tstw4X+QYaH7LYxT4dz
	 S5pFDzyaYSsFWeWUCHOOoKVhI2bD+KtuLJgZoYWmpAI2htvexR421Isbu4+3r3Ewcx
	 hG94LF/nUnOkL1ALQkBJqKyp1taeboBt+l2mdYExad3MDiO+EnyYqZ91TZ3bCwV3A8
	 wxDQRkELzOSw3EurSl9dFVdf+g5fF0DG8Fwnag/dL/k0c8el3tbdqEdbC+cb6J4fm8
	 4OZUUmelKnW+Q==
Date: Fri, 23 Jan 2026 09:38:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, David Jander <david@protonic.nl>
Subject: Re: [PATCH v1 6/8] iio: dac: ds4424: clear outputs on probe
Message-ID: <20260123093804.139f0409@jic23-huawei>
In-Reply-To: <20260119182424.1660601-7-o.rempel@pengutronix.de>
References: <20260119182424.1660601-1-o.rempel@pengutronix.de>
	<20260119182424.1660601-7-o.rempel@pengutronix.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 19:24:22 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> The DS44xx devices have no reset pin or reset bit, so output registers
> may retain preconfigured values across reboot or warm reset.
> 
> Also, the driver suspend/resume path restores from data->raw. When the
> device is first probed, data->raw is zero-initialized and may not match
> the actual hardware state. A later suspend/resume can therefore change an
> output from a preconfigured non-zero value to 0 mA.

For DACs we often want to retain settings from before kernel load (or
on exit of the driver).  Can we just read them back from the device to
fill in the cached versions?  If we can I think that would be preferred
option.

Jonathan


> 
> Initialize all channels to 0 output current during probe to ensure a
> deterministic baseline and consistent suspend/resume behavior.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/iio/dac/ds4424.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
> index a0c60eb89717..2d299a52cede 100644
> --- a/drivers/iio/dac/ds4424.c
> +++ b/drivers/iio/dac/ds4424.c
> @@ -220,6 +220,20 @@ static int ds4424_verify_chip(struct iio_dev *indio_dev)
>  	return ret;
>  }
>  
> +static int ds4424_init(struct iio_dev *indio_dev)
> +{
> +	int i, ret;
> +
> +	/* Set all channels to 0 current. */
> +	for (i = 0; i < indio_dev->num_channels; i++) {
> +		ret = ds4424_set_value(indio_dev, 0, &indio_dev->channels[i]);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int ds4424_setup_channels(struct i2c_client *client,
>  				 struct ds4424_data *data,
>  				 struct iio_dev *indio_dev)
> @@ -397,6 +411,11 @@ static int ds4424_probe(struct i2c_client *client)
>  	if (ret)
>  		goto fail;
>  
> +	/* No reset pin/bit: clear any preconfigured output on probe. */
> +	ret = ds4424_init(indio_dev);
> +	if (ret)
> +		goto fail;
> +
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &ds4424_iio_info;
>  

