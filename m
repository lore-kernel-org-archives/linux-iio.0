Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41D439A067;
	Mon,  1 Jun 2026 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309605; cv=none; b=jrxDnpn37xs5e0+Vzjc0WLcpx+S7SteFmDBzgwe7OJp79jV3jgCCc2pYVebkoc1v/RbgBf94x5ikT/u4YoDd9vxKUrPt7nYKnpto5iIG06pksRDyVrGMP6ky6CBVdEwmjsOzCxmNsZkXMdqOTl8sdGBoCY8wNUP9lZjX1v/4iAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309605; c=relaxed/simple;
	bh=O7f/4lTAd/U8Ko4Tq0Hr/YImEuMybXm5CzIBDbcmMEs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n04vExffaaoV+9IFpRJ29t3bteDsIJ7WVp0Qma4YUFpvfZOkZNiBCL0XVB+l54g87snzGNwCYWaFDo4jZFwIPj/oeSBa7yE4dcF8LBXruDnhjiOhz8y1S4Ha3XSNQ9/gW8kabv2yGZYIrDLo7GsZcAZVKQvdsIboBQesxNnveq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwkofFEw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwkofFEw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4471F00898;
	Mon,  1 Jun 2026 10:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780309604;
	bh=bxtbxokAuvcIfXllOXzgKns6vnrwpu4LLCFqIjbKZS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XwkofFEwUofHTFfWjeN+VD3x+WHJbrzD5CiJPkRgye54XfByuKQ61nlyiMyx8O+25
	 8UKUiVOcNQwUsjgpIA3rdfACrzmg6zLICBdSB8TW509TSWZJHQcICLlUdNqtcruWxY
	 GdArc2gAM9Kv5SgiA3rknR6ca/1rK7d4KObKv8njslWLFo3rdvArVJw0fU2cdk2tkl
	 KrS8ha3NyjxO0BvVU4m+ZZq4H4rtq7AzdHzG7SrWOa5jWmZ50brGlbPMGxxDtE2SAs
	 xugQWMEygInMaUL6r5RShxZgtWxSrQMnk1Pc53aqtr+rB7ocgeW3GEOtsB0tpV6bki
	 iS3e2jl3ZfE+w==
Date: Mon, 1 Jun 2026 11:26:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] iio: light: veml6031x00: add support for
 triggered buffers
Message-ID: <20260601112634.62d1b733@jic23-huawei>
In-Reply-To: <20260531-veml6031x00-v4-3-e64f7fdce38d@gmail.com>
References: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
	<20260531-veml6031x00-v4-3-e64f7fdce38d@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 May 2026 21:58:23 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> Add triggered buffer functionality for the two channels the device
> provides (ALS and IR).
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

One trivial thing from me. I think all the feedback remaining on this one
from Sashiko is false positives.

> diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031x00.c
> index 6f9a7bad44d4..facb1b8e4241 100644
> --- a/drivers/iio/light/veml6031x00.c
> +++ b/drivers/iio/light/veml6031x00.c

>  
> +static int veml6031x00_buffer_preenable(struct iio_dev *iio)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	int ret, it_usec;
> +
> +	ret = pm_runtime_resume_and_get(data->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = veml6031x00_get_it(data, &it_usec);
> +	if (ret < 0) {
> +		pm_runtime_put_autosuspend(data->dev);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Wait one integration period + 10% margin so the first triggered
> +	 * read does not race with the sensor completing its first conversion
> +	 * after power-on.
> +	 */
> +	fsleep(it_usec + (it_usec / 10));
> +
> +	return 0;
> +}

> +
> +static irqreturn_t veml6031x00_trig_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *iio = pf->indio_dev;
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	int ch, ret, i = 0;
> +	struct {
> +		__le16 chans[2];
> +		aligned_s64 timestamp;
> +	} scan = { };

In case anyone wonders about the sashiko feedback, this is fine. The kernel
is carefully built with options (plus self tests) to ensure that padding is initialized
by doing this.  Sashiko is correct that the C spec (until recently?) doesn't require
that to be the case.	

> +
> +	if (test_bit(VEML6031X00_SCAN_ALS, iio->active_scan_mask) &&
> +	    test_bit(VEML6031X00_SCAN_IR, iio->active_scan_mask)) {
> +		ret = regmap_bulk_read(data->regmap,
> +				       VEML6031X00_REG_ALS_L,
> +				       &scan.chans, sizeof(scan.chans));
> +		if (ret)
> +			goto done;
> +	} else {
> +		iio_for_each_active_channel(iio, ch) {
> +			ret = regmap_bulk_read(data->regmap,
> +					       iio->channels[ch].address,
> +					       &scan.chans[i++],
> +					       sizeof(*scan.chans));
> +			if (ret)
> +				goto done;
> +		}
> +	}
> +
> +	iio_push_to_buffers_with_ts(iio, &scan, sizeof(scan), pf->timestamp);
> +
> +done:
> +	iio_trigger_notify_done(iio->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int veml6031x00_validate_part_id(struct veml6031x00_data *data)
>  {
>  	int part_id, ret;
> @@ -576,6 +683,13 @@ static int veml6031x00_probe(struct i2c_client *i2c)
>  	if (ret)
>  		return ret;
>  
> +	ret = devm_iio_triggered_buffer_setup(dev, iio, NULL,
> +					      veml6031x00_trig_handler,
> +					      &veml6031x00_buffer_setup_ops);

Why is this in the region in which the device is forced to be powered up?  

> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to register triggered buffer\n");
> +
>  	pm_runtime_put_autosuspend(dev);

I would have thought here was fine.

>  
>  	ret = devm_iio_device_register(dev, iio);
> 

