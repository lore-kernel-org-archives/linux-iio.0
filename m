Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D233D25AF;
	Mon, 27 Jul 2026 21:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785186617; cv=none; b=bIEsdsek05k6uU4akflxrPyKyOe1GhWDL4wPzX8lWlNBBMnbCMSUvPZh1xwjDsuPLpdLiajjyICnOhdokFpOLufCcD3QPW4HXC19Mh/VjwsKpLh5c/tvbuBvKMfjlrOe8SvSNNtWYXMz6/33fmRbk8WO9yVzXJ5zF9B+SQjs8L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785186617; c=relaxed/simple;
	bh=z7Na/CW9d9kuz9kxR0XIshjkAB8HUndtynEiC9/WxmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WlObQGj4mZqKUfv3e8n+ZW57LbFDA267s+xIHAu2+aCiawwpahMKfaSz3+kdomuny4esXmlDfKruQgwCJcGiLVN39gDD0s6jChBCMYTs8+3JNCmlKandUA6lN0vPedkTVvDtqb+TFgColpGDqrlTXXDzfzl+vH37MaSL7hsybXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EG4GpXCL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EG4GpXCL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCC41F000E9;
	Mon, 27 Jul 2026 21:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785186615;
	bh=B1wg79wPP0dA6+mqPH5w7SbNqdQmRMVxA12m8vkP2cA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EG4GpXCLAGLpIv+Vkwdhb6VWqrsxJE7LxMtqvPHmlIiiy9syF8MWX8NKN9Svz8eQR
	 EQhWFmsADhsuguGZgxOqafKsxS7Ts2Njen7mN1qWQB72A6JxmWgnbUAhqu1szn8u6l
	 eu4XJNpK+85GK6Ex8TkexFewp1FCrQjFBq7jl6pKVOHl1SPCpGlif9CFMl9Q+anhuU
	 TGvlh92n23lUJClP20k/gFcm371IByNzRQeWqxxz6Jv6UUJuCdc6fMoxYa6mjLIUIA
	 mLJwV1ej5KlZgENIgTqZMMXXCEOpEawLvh2YELh2QTQwz5YJfpDQyQN422PJ7MlrTc
	 rbOfvmCgu3tiQ==
Date: Mon, 27 Jul 2026 22:10:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v9 10/17] iio: frequency: ad9910: initial driver
 implementation
Message-ID: <20260727221011.0aafb7f7@jic23-huawei>
In-Reply-To: <k5gfkzynht4d2hqaqhoqbrszah352dblvbopgaxwgwx26maeue@nv3hjwplqqv4>
References: <20260722-ad9910-iio-driver-v9-0-459d1df5ac56@analog.com>
	<20260722-ad9910-iio-driver-v9-10-459d1df5ac56@analog.com>
	<20260725233354.369b3fa2@jic23-huawei>
	<k5gfkzynht4d2hqaqhoqbrszah352dblvbopgaxwgwx26maeue@nv3hjwplqqv4>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 10:37:26 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 25/07/26 23:33, Jonathan Cameron wrote:
> > On Wed, 22 Jul 2026 16:50:19 +0100
> > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> >   
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > 
> > > Add the core AD9910 DDS driver infrastructure with single tone mode
> > > support. This includes SPI register access, profile management via GPIO
> > > pins, PLL/DAC configuration from firmware properties, and single tone
> > > frequency/phase/amplitude control through IIO attributes.
> > > 
> > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>  
> > 
> > ...
> >   
> > > diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
> > > new file mode 100644
> > > index 000000000000..b41b011af281
> > > --- /dev/null
> > > +++ b/drivers/iio/frequency/ad9910.c  
> > 
> > ...
> >   
> > > +static int ad9910_parse_fw(struct ad9910_state *st)
> > > +{
> > > +	static const char * const refclk_out_drv0[] = {
> > > +		"disabled", "low", "medium", "high",
> > > +	};
> > > +	struct device *dev = &st->spi->dev;
> > > +	const char *prop;
> > > +	u32 tmp;
> > > +	int ret;
> > > +
> > > +	st->data.pll_enabled = device_property_read_bool(dev, "adi,pll-enable");
> > > +	if (st->data.pll_enabled) {
> > > +		prop = "adi,charge-pump-current-microamp";
> > > +		if (device_property_present(dev, prop)) {
> > > +			ret = device_property_read_u32(dev, prop, &tmp);
> > > +			if (ret)
> > > +				return dev_err_probe(dev, ret, "property read: %s\n", prop);
> > > +
> > > +			if (tmp < AD9910_ICP_MIN_uA || tmp > AD9910_ICP_MAX_uA)
> > > +				return dev_err_probe(dev, -ERANGE,
> > > +						     "invalid charge pump current %u\n", tmp);
> > > +		} else {
> > > +			tmp = AD9910_ICP_MIN_uA;
> > > +		}
> > > +		st->data.pll_charge_pump_current = tmp;
> > > +
> > > +		prop = "adi,refclk-out-drive-strength";  
> > 
> > Sashiko did have a question about this.  I didn't care enough about the particular
> > combination restrictions on the clock being output, but please have a quick check.
> > https://sashiko.dev/#/patchset/20260722-ad9910-iio-driver-v9-0-459d1df5ac56%40analog.com
> > 
> > If it is possible but nonsensical, add a comment here.  
> 
> The datasheet states:
> 
> 	When the PLL is enabled, a buffered clock signal is available at 
> 	the REFCLK_OUT pin. This clock signal is the same frequency 
> 	as the REF_CLK input. This is especially useful when a crystal 
> 	is connected because it gives the user a replica of the crystal 
> 	clock for driving other external devices
> 
> REFCLK_OUT is basically the input to the PLL added some gain. So that is only
> applicable when PLL is enabled. By default, st->data.refclk_out_drv is zero
> so it is disabled when PLL is not being used.
> 
> This DT-property (adi,refclk-out-drive-strength) is also dependent on the
> adi,pll-enable property in the bindings.

Thanks for laying that out.  Maybe add a breadcrumb but not that important.

Jonathan


> 
> > > +		if (device_property_present(dev, prop)) {
> > > +			ret = device_property_match_property_string(dev, prop,
> > > +								    refclk_out_drv0,
> > > +								    ARRAY_SIZE(refclk_out_drv0));
> > > +			if (ret < 0)
> > > +				return dev_err_probe(dev, ret, "property read: %s\n", prop);
> > > +
> > > +			st->data.refclk_out_drv = ret;
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > > +}  
> 

