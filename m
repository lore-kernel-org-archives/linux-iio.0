Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6918854707C;
	Sat, 26 Sep 2026 00:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790383585; cv=none; b=dLdi8PnfzFA190ekXf+kke53otqI3zJUvpdk9hOoNqegyhi9c1djRpeZD6/HhF5DE981pjxAf0wmiApObGc4jcvQlLm0PebxtL0ovWqwddgoAV1PDrerbnDK9yaxkPv0+HJznJEqSM8sua1CyR/bK6MeektFc5o3MYB3XqS9vP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790383585; c=relaxed/simple;
	bh=mnyTyMpKZYo0kiEZ8uizCOYZ+lB18jykjeKqir4AWuE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PkB5KBl/j0w30PSmmKQU6+TYv5wrP/wD9GnUd4xMD5R/WcZPIZ07tn5xgCgFNfv4ZajXWGiMcGSh+yMsBSMcfR2hpsB/UHkqzJRoQAvzD++a4M2gSUDsetqD2sMfHi6OFOLlFLQJ075TgSls76blMRVT+0SnsDxzGnjBayYByeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kM04wztB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kM04wztB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1971D1F000FF;
	Sat, 26 Sep 2026 00:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790383584;
	bh=zhUd/UIVaGPK1OS/xr4lPfCgqoDRv+CzJXrl2rMMcsE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kM04wztBCqCqWuqBr4Y+MjIGfWJ82vsbCQPGQZVMuwAT6OhnQvUxqwklHODoKyPBG
	 wE4ATOTLcimREg5mvwTzoUmC9aHuemaP0cYjGZSl2eAVVL0NNyL/PufrAgboOlMkzL
	 6rKWdLn23cWQurdx5TOU8c5MiarQacskNKU8vECFoWnqzZdRREebmlf7U9wn31noXC
	 ph7c6DwVQdeUd/DEmFaELaWxeF9XZGvuyWjpIN9xEJy0ec1v3zlatki+r1/NrtZgEt
	 el9sTae29jp1AuVZTwvmxdAHEc0v73nMVG5kzA0dsmz7qXuLsfOtESsLGLPFmvQlpE
	 tggvNr4cuiD3g==
Date: Sat, 26 Sep 2026 01:46:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, Chris Hall <c-hall@ti.com>, Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>
Subject: Re: [PATCH] iio: adc: ti-ads112c14: add gpio support
Message-ID: <20260926014620.3b07660f@jic23-hlaptop>
In-Reply-To: <20260925-iio-adc-ti-ads112c14-gpio-v1-1-2a2b218ebf3a@baylibre.com>
References: <20260925-iio-adc-ti-ads112c14-gpio-v1-1-2a2b218ebf3a@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 16:50:47 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Add support for using the AIN4/GPIO0 to AIN7/GPIO3 pins as GPIOs when
> the gpio-controller property is present.
> 
> Pins that are already used for something else according to the
> devicetree are excluded from the valid GPIO mask. This includes analog
> inputs and excitation current outputs used by channels, REFP/REFN when
> an external reference is used, the /FAULT and /DRDY interrupts and the
> external clock input.
> 
> The per-pin register field macros are replaced with parameterized ones
> so that they can be used with the GPIO offset.

Can we pull that out as a trivial precursor? Feels like it will
reduce the noise for the more interesting new stuff.

Otherwise, only thing is a suggestion on how to perhaps
couple using the pins with reserving them in the parse function.

Thanks,

Jonathan


> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/ti-ads112c14.c | 198 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 180 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
> index 3c877126b0be..1c0519716faa 100644
> --- a/drivers/iio/adc/ti-ads112c14.c
> +++ b/drivers/iio/adc/ti-ads112c14.c

>  #define   ADS112C14_DIGITAL_CFG_CODING			BIT(1)
>  
>  #define ADS112C14_REG_GPIO_CFG				0x0B
> -#define   ADS112C14_GPIO_CFG_GPIO3_CFG			GENMASK(7, 6)
> -#define   ADS112C14_GPIO_CFG_GPIO2_CFG			GENMASK(5, 4)
> -#define   ADS112C14_GPIO_CFG_GPIO1_CFG			GENMASK(3, 2)
> -#define   ADS112C14_GPIO_CFG_GPIO0_CFG			GENMASK(1, 0)
> +#define   ADS112C14_GPIO_CFG_GPIO_CFG(n)		(GENMASK(1, 0) << (2 * (n)))

Trivial but I'd have slightly preferred to have seen these
macros all done as a precursor patch.

>  #define     ADS112C14_GPIO_CFG_GPIO_CFG_DISABLED	  0
>  #define     ADS112C14_GPIO_CFG_GPIO_CFG_INPUT		  1
>  #define     ADS112C14_GPIO_CFG_GPIO_CFG_OUTPUT_PUSH_PULL  2
> @@ -147,10 +142,7 @@

> @@ -393,6 +390,135 @@ struct ads112c14_data {
>  						 ARRAY_SIZE(ads112c14_sys_mon_channels));
>  };
>  
> +static void ads112c14_reserve_gpio_for_ain(unsigned long *gpio_reserved_mask,
> +					   u32 ain)
> +{

See below - but maybe this should return ain.

> +	if (ain >= 4 && ain <= 7)
> +		set_bit(ain - 4, gpio_reserved_mask);
> +}


>  static irqreturn_t ads112c14_drdy_irq_handler(int irq, void *private)
>  {
>  	struct iio_dev *indio_dev = private;
> @@ -1913,7 +2039,8 @@ static int ads112c14_populate_idac_mag(u32 current_nA, u8 *idac_mag)
>  }
>  
>  static int ads112c14_parse_channels(struct iio_dev *indio_dev,
> -				    bool *need_avdd_ref, bool *need_ext_ref)
> +				    bool *need_avdd_ref, bool *need_ext_ref,
> +				    unsigned long *gpio_reserved_mask)
>  {
>  	struct ads112c14_data *data = iio_priv(indio_dev);
>  	struct device *dev = indio_dev->dev.parent;
> @@ -1981,6 +2108,8 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
>  			 * for single-ended channels when taking measurements.
>  			 */
>  			spec->channel2 = ADS112C14_MUX_CFG_AIN_GND;
> +
> +			ads112c14_reserve_gpio_for_ain(gpio_reserved_mask, pair[0]);
>  		} else if (fwnode_property_present(child, "diff-channels")) {
>  			ret = fwnode_property_read_u32_array(child, "diff-channels",
>  							     pair, ARRAY_SIZE(pair));
> @@ -1995,6 +2124,9 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
>  			spec->differential = 1;
>  			spec->channel = pair[0];
>  			spec->channel2 = pair[1];
> +
> +			ads112c14_reserve_gpio_for_ain(gpio_reserved_mask, pair[0]);
> +			ads112c14_reserve_gpio_for_ain(gpio_reserved_mask, pair[1]);
>  		} else {
>  			return dev_err_probe(dev, -EINVAL,
>  					     "channel node missing channel type property\n");
> @@ -2026,6 +2158,10 @@ static int ads112c14_parse_channels(struct iio_dev *indio_dev,
>  			measurement->idac1_mux = pair[0];
>  			measurement->idac2_mux = measurement->iadc_count > 1 ? pair[1] : 0;
>  
> +			ads112c14_reserve_gpio_for_ain(gpio_reserved_mask, pair[0]);
> +			if (measurement->iadc_count > 1)

Put this and the setting of measurement->iadc2_mux under the same if()
Currently the mix of styles are making the match up of the two harder to spot.
Hmm. I wonder if we can do something fun like.

			meaurement->idac1_mux =
				ads112c14_reserve_gpio_for_ain(gpio_reserved_mask, pair[0]);
			if (measurement->iadc_count > 1)
				meaurement->idac2_mux =
					ads112c14_reserve_gpio_for_ain(gpio_reserved_mask, pair[1]);

Even better if we give that helper and the mask shorter names.  resv probably enough for
reserve for instance.


> +				ads112c14_reserve_gpio_for_ain(gpio_reserved_mask, pair[1]);
> +


