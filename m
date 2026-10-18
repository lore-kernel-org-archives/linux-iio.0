Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305E53E4113;
	Sun, 18 Oct 2026 23:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792365719; cv=none; b=MOxWTDIj0NkTYkOeLzYFN27q3cAP5PAwPt2Y7kVpwClRXHc5EYZ0fpSRE1VDFQnX0itrj/Ky3E4ByNbJ/AqScmdrM0L3UasOcPpxWrJK6Y8HSAk9eF4XSXrnDpwzVFFhbXkKMctew95/X40dFTN6vzkl8emT+orSs3CmSeUMmPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792365719; c=relaxed/simple;
	bh=KQLRzRMUlrsXTRFRLW7P2CFU+Gm+rH1A3HUFJ17tiUI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLtwiiZJO5W3IRLBkHO0WpW5Zm7B2rQFVd7NbGQ733ersK2wO6ErH91s5RJwl1yXw37u0k+vnTclYO0PQLTbqFVuZAhHgFabMbtLCqZ4o5pT6Xjv124Pm9BbMjaVjpzV1eSt2wSQKtugTKzqQ5XHMsjReWuogzU6gyuHc1efL/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZwZo+0Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZwZo+0Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4F41F000C4;
	Sun, 18 Oct 2026 23:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792365716;
	bh=0fOW3qR5mV2aphpr3TLbv4HR1F98rR5DFuqzthisAJg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dZwZo+0ZaWDzoTbspNcnF0Dk7B6++xEgY77f4rFKh6GeWtfElNevwJKTrSZ2U1FIf
	 3wdvSVTOYQObazcGuxot7WtCly/2AjewaIMIJzIdFvgOTO6v5NuDURTKcJ52JtcZUq
	 rsVrejROIrN5+DGjwwver2uQRU066TXtJ+r4Sjl7InKFhxkzDIOo+i4q8DLbeQCEYl
	 FhO8Sh9Rp74t/fZh627jHpkij1YDqe0j2FiGsN1D8BA5CdHL9sFKlD720XpKZLua86
	 9xyEs8jVFEos4clwfqTL+dchdLpZX8ZIYlUfOpw7HXEFlxWwr6vCCEc2TifoftGtKb
	 cngs2eixToLvg==
Date: Mon, 19 Oct 2026 00:21:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michal Simek
 <michal.simek@amd.com>, Conall O'Griofa <conall.ogriofa@amd.com>,
 <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <git@amd.com>, Sai Krishna Potthuri
 <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH v4 12/15] iio: adc: xilinx-xadc: Add helper functions
 for the device setup
Message-ID: <20261019002149.7f90c78f@jic23-hlaptop>
In-Reply-To: <20261005094205.1045874-13-dileepkumar.nagavarapu@amd.com>
References: <20261005094205.1045874-1-dileepkumar.nagavarapu@amd.com>
	<20261005094205.1045874-13-dileepkumar.nagavarapu@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Oct 2026 15:12:02 +0530
Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com> wrote:

> Refactor the platform driver probe function by extracting device
> setup and configuration logic into reusable helper functions:
> xadc_device_setup(): handles IIO device allocation and basic setup
> xadc_device_configure(): handles device tree parsing and bipolar mask
> configuration
> 
> Move the bipolar channel mask calculation immediately after
> xadc_parse_dt(), as the channel information used to build
> the mask is populated there and remains unchanged before it is consumed.
> 
> This refactoring reduces code duplication and prepares for sharing the
> common setup logic between platform and I2C drivers.
> 
> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 105 +++++++++++++++++++----------
>  1 file changed, 71 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 92cd38cd1834..d95a84e7e561 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -933,6 +933,33 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int xadc_setup_buffer_and_triggers(struct iio_dev *indio_dev, int irq)
> +{
> +	struct device *dev = indio_dev->dev.parent;
> +	struct xadc *xadc = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!(xadc->ops->flags & XADC_FLAGS_BUFFERED))
> +		return 0;
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, &iio_pollfunc_store_time,
> +					      &xadc_trigger_handler, &xadc_buffer_ops);
> +	if (ret)
> +		return ret;
> +
> +	if (irq > 0) {
Unless it gets modified in later patches, flip this to reduce indent a bit + early exit
in the simple case of no irq.
	if (irq <= 0)
		return 0;

	xadc->convst_...

> +		xadc->convst_trigger = xadc_alloc_trigger(indio_dev, "convst");
> +		if (IS_ERR(xadc->convst_trigger))
> +			return PTR_ERR(xadc->convst_trigger);
> +
> +		xadc->samplerate_trigger = xadc_alloc_trigger(indio_dev, "samplerate");
> +		if (IS_ERR(xadc->samplerate_trigger))
> +			return PTR_ERR(xadc->samplerate_trigger);
> +	}
> +
> +	return 0;
> +}

> +static struct iio_dev *xadc_device_setup(struct device *dev, int size, const struct xadc_ops **ops)
> +{
> +	struct iio_dev *indio_dev;
> +
> +	*ops = device_get_match_data(dev);
> +	if (!*ops)
> +		return ERR_PTR(-ENODEV);
Having this in here seems more complex to me than moving it
to the caller and passing (*ops)->type in as a parameter
for this function.

Whilst I appreciate the aim of reducing repetition, I'm not
totally convinced this helper has the right balance of
saving code to readability.

> +
> +	indio_dev = devm_iio_device_alloc(dev, size);
> +	if (!indio_dev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	indio_dev->name = xadc_type_names[(*ops)->type];
> +	indio_dev->info = &xadc_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	return indio_dev;
> +}
>
