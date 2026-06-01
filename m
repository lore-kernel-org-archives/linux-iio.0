Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E905039A7F6;
	Mon,  1 Jun 2026 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307632; cv=none; b=ZnoZ6l/vwfZDrBmIOYr3QPz1GuLfOVGhm6lG+fNMBxH5qvcuoA+MyXYOBg5QXHzV/qNfZC3eWc2meL0Wk+goYmAMNEptIzVRMgNUhguwft+l0Hy/jHfIe0VG+JibutWn7DkSgbR/PJ1s1OQ1qSQ5weEmtRTWVlDXvQwd3pGBPnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307632; c=relaxed/simple;
	bh=z/WcXP9hkms60vcSW9Hmu6C+qDrYHQEnCfD0+woT+Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qD+wux0ETNuUIIWWjG/T9qKzEvsrtpDsEv1Wf3zGgSvpb1iJEt3145bilf0XBCvqd3wtCadHNtJD51nOpfpof9mHXBBpUfCod8r08VkElOafxN9LGbMCd9XUplLygT1ZCBz/DUgyQ0Wws9VowrBHYsqg9y3QtchLZlBSmnVWCmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6p/I3Jz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6p/I3Jz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA9F1F00893;
	Mon,  1 Jun 2026 09:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780307623;
	bh=JWl0lw+MoxNh959GGHol6HnrW1Sk6xuc5UpJG87M1Ms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=E6p/I3JzH3c+lFFCTSlxFieUaayOwwlWjoVveaOTfdt3oHB26w+IYlDMJpMOU8+5k
	 Dpzq0OlcfCEItDYF+45cdTWBG3GLoMz+7nJLi1Cqp/QmBAkzvIoobeNuL3XZeMWwG+
	 CrtzZItL6IVTjSprHQ8S1iQn9+J7+0mbmJ/Ddwshd1nOLaIFmCgtuexREJf+3pLzgP
	 MMncv1loekecFWTAAGsfoHZeGzpeBDeOAdKIzJo3uf6wKRcxwIZtJq/HVpAk2eohb5
	 PSqPCHaoMEUH3U0PxCTJxF10fQcYp8vVc+dlcFi4KnYiTC4VzImP3qWpKTwhdOf91f
	 1dKh7RLBncNSg==
Date: Mon, 1 Jun 2026 10:53:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Maxwell Doose <m32285159@gmail.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: flow: add Sensirion SLF3S liquid flow
 sensor driver
Message-ID: <20260601105334.3956c09d@jic23-huawei>
In-Reply-To: <20260530205435.37326-4-wafgo01@gmail.com>
References: <20260530205435.37326-1-wafgo01@gmail.com>
	<20260530205435.37326-4-wafgo01@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 May 2026 22:54:32 +0200
Wadim Mueller <wafgo01@gmail.com> wrote:

> Add a driver for the Sensirion SLF3S family of digital
> liquid-flow sensors on I2C.  Currently supported variants are
> SLF3S-0600F, SLF3S-1300F and SLF3S-4000B; they share the same
> register map and differ only in flow-scale factor and calibrated
> measurement range.  The variant (and therefore the scale) is
> auto-detected from the product-information register at probe time.
> 
> Each measurement frame returns a 16-bit signed flow value, a
> 16-bit signed temperature reading and a status word, each
> protected by a CRC-8 byte.  The driver exposes the flow rate as
> IIO_VOLUMEFLOW and the temperature as IIO_TEMP via the standard
> IIO read_raw / read_scale interface.
> 
> The active calibration medium can be switched at runtime between
> the factory-calibrated water and isopropyl-alcohol modes via the
> in_volumeflow_medium sysfs attribute; the sensor starts in water
> mode after probe.
> 
> This driver also creates the drivers/iio/flow/ subdirectory and
> the corresponding Kconfig/Makefile glue.
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
Hi Wadim

A few things inline.  Biggest one is don't use direct mode claims
to do serialization of things that lie entirely in your driver.
That there is a lock in that call is an implementation detail you
should not be relying on.

Jonathan

> diff --git a/drivers/iio/flow/slf3s.c b/drivers/iio/flow/slf3s.c
> new file mode 100644
> index 000000000..497a56f59
> --- /dev/null
> +++ b/drivers/iio/flow/slf3s.c

> +
> +/*
> + * Read the product-info block and pick the matching variant.  The
> + * sub-type byte returned by the sensor is the source of truth; a
> + * DT-supplied compatible only seeds an initial guess and is overridden
> + * on mismatch (with an informational message so misconfigured device
> + * trees are easy to spot).

Wrap to 80 chars.  Also if following suggestion to 'warn' on mismatch
make sure to update the comment as well.


> + *
> + * Bus / CRC failures are real errors and fail probe.  An unknown
> + * sub-type byte fails probe too: we cannot publish a meaningful scale
> + * without a matching entry in slf3s_variants[].
> + */
> +static int slf3s_detect_variant(struct slf3s_data *sf)
> +{


> +
> +static int slf3s_set_medium(struct iio_dev *indio_dev,
> +			    const struct iio_chan_spec *chan, unsigned int mode)
> +{
> +	struct slf3s_data *sf = iio_priv(indio_dev);
> +	const u8 *start_cmd;
> +	int ret;
> +
> +	if (!iio_device_claim_direct(indio_dev))

It makes no sense to claim direct mode in a driver that doesn't
do any other modes.  I think you are just using this to serialize
commands, all of which occur in direct mode.  Don't do that, use
your own local lock. 

> +		return -EBUSY;
> +
> +	ret = slf3s_send_cmd(sf->client, slf3s_cmd_stop_meas);
> +	if (ret)
> +		goto out;
> +
> +	start_cmd = (mode == SLF3S_MEDIUM_IPA) ? slf3s_cmd_start_ipa
> +					       : slf3s_cmd_start_water;
> +
> +	ret = slf3s_send_cmd(sf->client, start_cmd);
> +	if (ret)
> +		goto out;
> +
> +	fsleep(SLF3S_MEAS_START_DELAY_US);
> +	sf->medium = mode;
> +out:
> +	iio_device_release_direct(indio_dev);
> +
> +	return ret;
> +}


> +static const struct i2c_device_id slf3s_id[] = {
> +	{ .name = "slf3s-0600f",
> +	  .driver_data = (kernel_ulong_t)&slf3s_variants[0] },

	{
		.name = "slf3s-0600f",
		.driver_data = (kernel_ulong_t)&slf3s_variants[0],
	},

> +	{ .name = "slf3s-1300f",
> +	  .driver_data = (kernel_ulong_t)&slf3s_variants[1] },
> +	{ .name = "slf3s-4000b",
> +	  .driver_data = (kernel_ulong_t)&slf3s_variants[2] },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, slf3s_id);

