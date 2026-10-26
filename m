Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792974556;
	b=3FAfC0JstS5TpHOSObEqNRAHRIA+b5V7VwDWxyVXpRKSUpUftVDVPjCNnPqN9HzSTuUs
	 /Zt5uWVZ0XzMyTi4bmrzYGOdBL0ydWSG/CRHmAPxvW7s3++ylCTgzRfipSHUuugQD8GNf
	 SdoIibql1+P+35dyKE+0EGEj0ZioldqBRFxUrtwF3XNDWEhPzK33lUZXOucUgTZ9pW7F5
	 ojmvrjNarGaJf424t3D5RgVqxctAxBVgDvv0SofbQPIkw0FrsXXk0yRLTqEHxNG226z9S
	 ARteh689rOsro8tijv4nZy3MReJchcvBzP2tOjFEVukOOwzF9eEI+FY+lOjD8S+55LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792974556;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=RsRol0iWX2LXNeTBSh9N+khn4xoIQfDoB/Tmxi/SoUE=;
	b=sSsD+uLPTEbb03hoHeZkNdn25OR7jhCb5uoivhUNZcOipJVAPyYfOP03sFOndXVRpARp
	 ePo3uoOsdXPzzOuzxvH6QyTuKvX0SB1Q2uU+OOGRi7BMaD10uMvn3czgWOcYqr3pwbHMx
	 hcIWN5+erEmz/n352w2YGJM/eFVZ3N5s0ZCKJkp3OKL+7nz3pXbI8ThSgigBhGO6LTaaf
	 p5w0kkHFaic81TwmqcOq8S01x1Qxt+LMV3HeMLM3MCOnEnh6sawWfjDufPe4JiTIDh65W
	 pagr9DfeYWAgPlrgvrGJK8sPxsmUJ8v4y3/Wr/8gTDh0Fk9GdWcWb8qfDLhGSkhQg9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l1x2k5l3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98916606A31E;
	Mon, 26 Oct 2026 00:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l1x2k5l3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897A91F01825;
	Mon, 26 Oct 2026 00:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792974555;
	bh=RsRol0iWX2LXNeTBSh9N+khn4xoIQfDoB/Tmxi/SoUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=l1x2k5l3o/vFjceSvPTGFp7SAXfiBSXZMvhaiyik25oOrSQlziDD6wuEkiZLLeCvh
	 fr3WEKQ+/UoFUCag3zIVbJU9wkF6df7p8NWNdC4/V7Jd7QY+XyvT+YlptIWG5PZ0Uh
	 vkYU5mZONB0NBqUym2fPUtvKrPMSGY89UqU/Ii/X88+5Pd9zyOHna4zJFw+tKDYeTs
	 Z/tXp7L5/Yr0X2D5AuG9ES9NsHgJdXy5GxCW5NUfWpF1Ac6IX7psGHLheOKRvcnnPB
	 0XmAsHGb0W/sesmA7RbEXNHy4ROvjrnPqv19tgqO0VYuwdUVhpwgH77jj0MRceTmA/
	 euZip5289amVA==
Date: Mon, 26 Oct 2026 00:29:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@analog.com, devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org, Olivier Moysan
 <olivier.moysan@foss.st.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 06/10] iio: frequency: ad9910: add axi backend driver
Message-ID: <20261026002906.2f9dd2a6@jic23-hlaptop>
In-Reply-To: <20261022-ad9910-backend-support-v2-6-0ff7f0bff326@analog.com>
References: <20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com>
	<20261022-ad9910-backend-support-v2-6-0ff7f0bff326@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2026 12:19:04 -0300
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add the driver for the AD9910 AXI backend IP core, which interfaces with
> the data and control pins of the AD9910 DDS. It registers as an IIO
> backend that provides:
> 
> - a DMA output buffer that streams data into the parallel data port;
> - the parallel data destination (F[1:0] pins) and data rate, derived
>   from the PDCLK frequency;
> - the PROFILE[2:0] pins control, through profile channel enables.
> 
> It also registers a PWM chip with a single output driving the DRCTL
> pin, which the AD9910 driver uses to control the digital ramp generator
> direction. The PWM implements the waveform callbacks, with period, duty
> length and duty offset programmed in SYNC_CLK cycles. The duty offset
> is realized by a delay applied once, before DRCTL starts toggling. The
> waveform is reprogrammed when the SYNC_CLK rate changes, so that the PWM
> output keeps its timing.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

A few small things inline. In general I'll be looking for a
tag from Nuno on this like most IIO backends.

Jonathan

> diff --git a/drivers/iio/frequency/ad9910-axi-backend.c b/drivers/iio/frequency/ad9910-axi-backend.c
> new file mode 100644
> index 000000000000..f5374aeb2afe
> --- /dev/null
> +++ b/drivers/iio/frequency/ad9910-axi-backend.c

> +static int ad9910_axi_drctl_write(struct ad9910_axi_state *st,
> +				  const struct ad9910_axi_drctl_wfhw *wfhw)
> +{
> +	int ret;
> +
> +	/*
> +	 * DRCTL toggling restarts, applying the delay, when enabled or when
> +	 * its period or width changes. Changing the delay alone does not
> +	 * restart it, so disable toggling while updating the waveform.
> +	 */
> +	ret = regmap_clear_bits(st->regmap, AD9910_AXI_REG_DRG,
> +				AD9910_AXI_REG_DRG_TOGGLE_EN_MSK);
> +	if (ret || !wfhw->period)

Split conditions as one returns success and that's not obvious coded
like this.  Add a comment there on why it is a success.

> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD9910_AXI_REG_DRCTL_DELAY, wfhw->delay);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD9910_AXI_REG_DRCTL_WIDTH, wfhw->width);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD9910_AXI_REG_DRCTL_PERIOD, wfhw->period);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Register values reach the SYNC_CLK domain in snapshots, taken every
> +	 * 64 AXI clock cycles. Make sure toggling being disabled is captured
> +	 * by one of them before enabling it again.
> +	 */
> +	fsleep(2);
> +
> +	return regmap_set_bits(st->regmap, AD9910_AXI_REG_DRG,
> +			       AD9910_AXI_REG_DRG_TOGGLE_EN_MSK);
> +}
> +
> +static int ad9910_axi_chan_enable(struct iio_backend *back, unsigned int chan)
> +{
> +	struct ad9910_axi_state *st = iio_backend_get_priv(back);
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (chan) {
> +	/*
> +	 * Profiles are mutually exclusive, as the PROFILE[2:0] pins always
> +	 * select one of them. Enabling a profile channel selects it, which
> +	 * implicitly disables the previously selected one, hence there is
> +	 * nothing to do when disabling a profile channel.
> +	 */
> +	case AD9910_CHAN_IDX_PROFILE_0 ... AD9910_CHAN_IDX_PROFILE_7:
> +		chan -= AD9910_CHAN_IDX_PROFILE_0;
> +		return regmap_update_bits(st->regmap, AD9910_AXI_REG_PROFILE,
> +					  AD9910_AXI_REG_PROFILE_MSK,
> +					  FIELD_PREP(AD9910_AXI_REG_PROFILE_MSK, chan));
> +	case AD9910_CHAN_IDX_PARALLEL_AMP ... AD9910_CHAN_IDX_PARALLEL_POLAR_PHASE:
> +		/*
> +		 * F[1:0] destination follows the parallel channel order:
> +		 * amplitude, phase, frequency and polar.
> +		 */
> +		chan = min(chan - AD9910_CHAN_IDX_PARALLEL_AMP,
> +			   FIELD_MAX(AD9910_AXI_REG_F_CFG_MSK));

Why min() rather than a FIELD_FIT() and reject if it doesn't?
Or just use FIELD_PREP below and paper over it as you are doing
here.

> +		ret = regmap_update_bits(st->regmap, AD9910_AXI_REG_F_CFG,
> +					 AD9910_AXI_REG_F_CFG_MSK, chan);
Not immediately obvious that the field starts at bit zero so even though it
does I'd use a FIELD_PREP().


> +		if (ret)
> +			return ret;
> +
> +		return regmap_set_bits(st->regmap, AD9910_AXI_REG_UPDATE_CTRL,
> +				       AD9910_AXI_REG_UPDATE_PAR_IF_EN_MSK);
> +	default:
> +		return -EINVAL;
> +	}
> +}

