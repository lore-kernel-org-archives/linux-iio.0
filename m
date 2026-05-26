Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87D73B83FE;
	Tue, 26 May 2026 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779818609; cv=none; b=TSYq7oqQUW1XCmaBkUud/Zc94aFta5CTspR7Cg7v0fwMbYuXhd+kkB2YgsfCqhmPf9ZcaZU+QRgMdI22MnopLeTHrrE5uks9u7BTppyTjANduejBTQXGD5qoc7oZGLxAfwq0iWVelSerY2bcWCMlnLaIdw2jHvsoa/v5hYkHdJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779818609; c=relaxed/simple;
	bh=X4I975T6jwkzqJAyiwxn1+VSTBbO4DSaPY+n/CBMEsE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhjYDBsHXMHpMZkt9om58o1Ue+e7cg4h6C3Ry49PBZ6wHNCgwAUQhQhiLaAU4cq/jXqObgsrE0/syxKKpXkRh7OtwyJirgLjo21OqWOTEJO0S/ut/MX+qT6yuWJRlfhvNhsKXw7VufqlgtaTggMYFAttzicDVwiAD61tX61nxGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kf73GYco; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kf73GYco"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C69A1F000E9;
	Tue, 26 May 2026 18:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779818607;
	bh=8ePjgnHiWiOtG0Xv84ogSXVC8at/Eiize0jX/lITmDM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kf73GYcoiwomkbZuBiQyK5S++0GanNHXEuSSuZzNjr8rZlW+/h8JjOMER3sPbvG+R
	 sR5ylR382Jdc/JTtmXlr/06oKiA9D3Kj1H48u7O+Dcpzo9niVSxnqwRYdl/2y6JPHA
	 WuoV3oq4CSuRx2Z2xNanrvG/o5KxRZeOzQBj6jbgi47YJ3Sh1YNFqMLKiBuP4fz11s
	 TtGa+RhienQOceVtjVSHitfDo95xtQ72EJv+vAGETx0re755xN3R061OmMVVoA+km+
	 0+XAvDxAGuSFh/bMfrOypG+Aq5QR1BzKJcoyeV5A4R9xQ8FkL4YTrmIVkzreqfK3A+
	 dPoy01OhMFzRQ==
Date: Tue, 26 May 2026 19:03:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] iio: light: veml6031x00: add support for
 triggered buffers
Message-ID: <20260526190317.40c4c1a8@jic23-huawei>
In-Reply-To: <20260524-veml6031x00-v3-3-29165609b2b5@gmail.com>
References: <20260524-veml6031x00-v3-0-29165609b2b5@gmail.com>
	<20260524-veml6031x00-v3-3-29165609b2b5@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 May 2026 23:53:57 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> Add triggered buffer functionality for the two channels the device
> provides (ALS and IR).
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Trivial stuff only.
> diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031x00.c
> index 50979d239230..9968d4414dc9 100644
> --- a/drivers/iio/light/veml6031x00.c
> +++ b/drivers/iio/light/veml6031x00.c

> +
> +static int veml6031x00_buffer_postdisable(struct iio_dev *iio)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +
> +	pm_runtime_put_autosuspend(data->dev);
> +
> +	return 0;
> +}
> +
> +static const struct iio_buffer_setup_ops veml6031x00_buffer_setup_ops = {
> +	.preenable = veml6031x00_buffer_preenable,
> +	.postdisable = veml6031x00_buffer_postdisable,
> +};
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
> +
> +	if (*iio->active_scan_mask == (BIT(VEML6031X00_SCAN_ALS) |
> +				       BIT(VEML6031X00_SCAN_IR))) {
I'd prefer we always treat that as a bitmap and do the more costly check
test_bit(VEML6041X00_SCAN_ALS, iio->active_scan_mask) &&
test_bit(VEML6041X00_SCAN_IR, iio->active_scan_mask)
 

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
