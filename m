Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5C93BFE5D;
	Wed,  1 Jul 2026 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782937228; cv=none; b=MbLYX77JJnnMJAbi2H5DeluEp/hYfYWKmOAKo6K7NTZTfGSuYRNOqSg2hMB+20rL+tCfSJOhQY+lw8xEjioT1oZhbJYXl15yDpl1U3W9OFB+hDNfVOWtguSe//7Sr8ytBYwqcZhY5zpfkt/H/l6Zub+Q64D/ID2xpnNbskal3Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782937228; c=relaxed/simple;
	bh=DiKIlPGvyyuukL3yl9Y9R/M5k27mHv1+TmNglbBBx0I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WVG6p3MhumI068Rf8AlmDhWUBxEbGEpf1CgfpunBmuGhNiQMaX2DzOIk+87iylzMWUzaaqKd0LxbSgG45j/vX4VG6i35OAhfsceQ5Ff7pgzffRiwPhbzGAI33+J/uNTKsECgFd5GfimJHGvoccvd5pQk2NIZrpDLSMnPZDE/qoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+eeiUGs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+eeiUGs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BC11F00A3A;
	Wed,  1 Jul 2026 20:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782937224;
	bh=LlTvymr1qhCFHx3BYrEX0/HjBikOlYZzTRkbM68s6tk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=c+eeiUGsb7bGw8ZzN2+vO8cYJypmiiFR0RNs86/25FU2Ahaq1OEKj3PsX4n4jCWED
	 FZMmFa2TYNuntY9JwIna7fVSJKjBlixkjRxUZPiou8JuJHjJzS93bJxFp4WwuBRILp
	 u3c2rBOlWl8r6gcoRtIELO2XGflyFJdJ5S6GnxNE1qMoYio1+Xw/2hMh9cPwsz1Wfe
	 i3jm0tsP635fBQbPicXjUz/wmYScjVdXE2gpC3d+vwj1t4NgDlP5+NniiL8CtRkS+N
	 uUFEGxfQQKz5M4sQsr1q+r+wuKpOA++smDYyHA88eReVy1+JZOsmPJ/0wn+nyJinqT
	 mgf4E2UaMlMGg==
Date: Wed, 1 Jul 2026 21:20:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chris Hall
 <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, Kurt Borja
 <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] iio: adc: ti-ads112c14: add measurement channel
 support
Message-ID: <20260701212019.12757df3@jic23-huawei>
In-Reply-To: <20260625-iio-adc-ti-ads122c14-v2-8-ceb9b0b561cb@baylibre.com>
References: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
	<20260625-iio-adc-ti-ads122c14-v2-8-ceb9b0b561cb@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 16:55:10 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Add support for parsing devicetree properties for measurement channels
> and doing direct reads on these.
> 
> There are quite a lot of conditions that have to be met for each
> measurement to be made, so quite a bit of state and algorithms are
> required to handle it.
> 
> Channels are created dynamically since the number of possibilities is
> unreasonably large.
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>

Just a few minor things inline.

Thanks,

Jonathan
> 
> diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
> index 0e775dbc8d50..05d9670c72a4 100644
> --- a/drivers/iio/adc/ti-ads112c14.c
> +++ b/drivers/iio/adc/ti-ads112c14.c

> @@ -441,6 +594,16 @@ static int ads112c14_read_avail(struct iio_dev *indio_dev,
>  {
>  	struct ads112c14_data *data = iio_priv(indio_dev);
>  
> +	if (chan->channel < 100) {

Perhaps we need a define for that magic channel number.

> +
> +static int ads112c14_parse_channels(struct iio_dev *indio_dev,
> +				    bool *need_avdd_ref, bool *need_ext_ref)
> +{
> +	struct ads112c14_data *data = iio_priv(indio_dev);
> +	struct device *dev = indio_dev->dev.parent;
> +	struct iio_chan_spec *channels;
> +	u32 num_child_nodes, i, pair[2];
> +	int ret;
> +
> +	*need_avdd_ref = false;
> +	*need_ext_ref = false;
> +
> +	num_child_nodes = device_get_named_child_node_count(dev, "channel");
> +
> +	data->measurements = devm_kcalloc(dev, num_child_nodes,
> +					  sizeof(*data->measurements), GFP_KERNEL);
> +	if (!data->measurements)
> +		return -ENOMEM;
> +
> +	channels = devm_kcalloc(dev, num_child_nodes +
> +				ARRAY_SIZE(ads112c14_sys_mon_channels),
> +				sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	i = 0;
> +	device_for_each_named_child_node_scoped(dev, child, "channel") {
> +		struct ads112c14_measurement *measurement = &data->measurements[i];
> +		struct iio_chan_spec *spec = &channels[i];
> +
> +		if (!fwnode_device_is_available(child))
> +			continue;
> +
> +		spec->indexed = 1;
> +		spec->scan_index = i;
> +		measurement->gain_val = 1;
> +
> +		fwnode_property_read_string(child, "label", &measurement->label);

Hmm.  Should check if this exists and then error out on an a parsing error
when it is there but not valid?  Seems like that would be more consistent
with other properties.

> +
> +		if (fwnode_property_present(child, "single-channel")) {
> +			ret = fwnode_property_read_u32(child, "single-channel",
> +						       &pair[0]);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "failed to read single-channel property\n");
> +
> +			if (pair[0] >= 8)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "single-channel value must be between 0 and 7\n");
> +
> +			spec->channel = pair[0];
> +			/* NB: channel2 is unused by iio core code in this case. */

True, but maybe should also say why you are stuffing something in it.
What makes that only useful for single channel cases?

> +			spec->channel2 = ADS112C14_MUX_CFG_AIN_GND;
> +		} else if (fwnode_property_present(child, "diff-channels")) {
> +			ret = fwnode_property_read_u32_array(child, "diff-channels",
> +							     pair, ARRAY_SIZE(pair));
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "failed to read diff-channels property\n");
> +
> +			if (pair[0] >= 8 || pair[1] >= 8)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "diff-channels values must be between 0 and 7\n");
> +
> +			spec->differential = 1;
> +			spec->channel = pair[0];
> +			spec->channel2 = pair[1];
> +		} else {
> +			return dev_err_probe(dev, -EINVAL,
> +					     "channel node missing channel type property\n");
> +		}
> +
> +
...
