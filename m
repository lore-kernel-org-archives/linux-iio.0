Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2627A381AFE;
	Thu, 23 Apr 2026 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776968844; cv=none; b=J8lkGYTS7vQWtFoNhGV+vKt/PuTNL59vdcSCbQTtheFwIzwLElKj7hWB03UGu9/9n7F49bLqOoG7hJCuyOhezGmXlBsEqNai1NUfmkYp52XG7FMtc5L2ixcnrpQClRksMzP25JPZWLV20+VjeN8gFpF1S1XjB2dpDfnZ26fGJSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776968844; c=relaxed/simple;
	bh=6Lcliz25qDxifqG4HztW80kgUV+p/ILmeWPLaUc58G0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/eeMAyMWjUVlfsgAsT+Yafdg+ta/Or/nf3GUvYoZUvrl4oQfE+b8xO1BdRCDSvxFbEHzayju3HeZAr5vtqT/mJ+IVr3tWrsTbtA4L2ufFM5Lt/Pd7y7dZOJBRO02EduP7N9ZHLo2atIA+F/mtYGnTutMUAFt/gQfA6crN57RNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILtbnQ7m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILtbnQ7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C75EC2BCAF;
	Thu, 23 Apr 2026 18:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776968843;
	bh=6Lcliz25qDxifqG4HztW80kgUV+p/ILmeWPLaUc58G0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ILtbnQ7mmDQL6AQIlZJTPvJtmgfDUkzC5qNRlooYUW6CdPbnf3ixdYa68GG11hDk7
	 amP18yS936VOlJTNnAI3WkbyZyzNC9W9/DRbE6DpERQFkrRlsUHGfg/hlngcR/59z6
	 LlP//QtS3E6wg+MhcDnsPv6sVxe8TAVIMwaJA6GL+lI0QIRNaL4djKG5dIW9iZZKA0
	 5M9dDQUThYWHRjuytqgefu6MSngxRie8RsDrJiOgHS6leI1JGsPwB2hJahsV+nuqq6
	 21m/Iia3PvImjKrDiLK5PeZL0tp1Ll6dd3lSoKc0K39UZZLHN08mtPpfhwwnpLmO40
	 OwLItBptS7urg==
Date: Thu, 23 Apr 2026 19:27:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Auchter
 <michael.auchter@ni.com>, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees
 Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 21/22] iio: dac: ad5686: add triggered buffer support
Message-ID: <20260423192714.04eaa55e@jic23-huawei>
In-Reply-To: <20260422-ad5313r-iio-support-v1-21-ed7dca001d1b@analog.com>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
	<20260422-ad5313r-iio-support-v1-21-ed7dca001d1b@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 15:45:55 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Trigger handler is implemented by leveraging the LDAC gpio when it is
> available. Multiple channel writes can be flushed at once with the sync()
> operation.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

A few comments inline.

> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index a065c614c874..bec951afe8d0 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c

> @@ -506,6 +512,55 @@ const struct ad5686_chip_info ad5679r_chip_info = {
>  };
>  EXPORT_SYMBOL_NS_GPL(ad5679r_chip_info, "IIO_AD5686");
>  
> +static irqreturn_t ad5686_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct iio_buffer *buffer = indio_dev->buffer;
> +	struct ad5686_state *st = iio_priv(indio_dev);
> +	const struct iio_chan_spec *chan;
> +	u16 val[AD5686_MAX_CHANNELS];

I may be wrong but I suspect the static analysers won't like the
fact that only part of this is initialised and they can't
tell how much of it is then used. We might need some sanity checks
to keep them happy even though we know they will always be fine
(branch predictors should quickly make them near cost free).

> +	int ret, ch, i = 0;
> +	bool async_update;
> +	u8 cmd;
> +
> +	ret = iio_pop_from_buffer(buffer, val);
At somepoint we should probably add a sanity check on buffer size to that.
> +	if (ret)
> +		goto out;
> +
> +	mutex_lock(&st->lock);
> +
> +	async_update = st->ldac_gpio && bitmap_weight(indio_dev->active_scan_mask,
> +						      iio_get_masklength(indio_dev)) > 1;
> +	if (async_update) {
> +		/* use ldac to update all channels simultaneously */
> +		cmd = AD5686_CMD_WRITE_INPUT_N;
> +		gpiod_set_value_cansleep(st->ldac_gpio, 0);
> +	} else {
> +		cmd = AD5686_CMD_WRITE_INPUT_N_UPDATE_N;
> +	}
> +
> +	iio_for_each_active_channel(indio_dev, ch) {
> +		chan = &indio_dev->channels[ch];
> +		ret = st->ops->write(st, cmd, chan->address,
> +				     val[i++] << chan->scan_type.shift);
> +		if (ret)
> +			break;
I'd use a goto for this.
> +	}
> +
> +	if (!ret && st->ops->sync)

Then this becomes only
	if (st->ops->sync(st))

> +		ret = st->ops->sync(st); /* flush all pending transfers */
> +

and label probably ends up here.

> +	if (async_update)
> +		gpiod_set_value_cansleep(st->ldac_gpio, 1);
> +
> +	mutex_unlock(&st->lock);
> +out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}


