Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88403A0E86
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786214404; cv=none; b=I7GzFCX1fV+f1ZIXQqvVyhcyB+Vwphn8OafkEsNXa1BdK7da08d4fuAn1Ey3d3W5rQBkmSTgQ98nuallHz7Vz0jDqiLSGNMaeJ0bsU3liT9QuAgXSGBhNbESjjJKdqzKBPZlqBN0u5DV4g7ygMMCxoRZlyl10D3tojEP1hESJts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786214404; c=relaxed/simple;
	bh=YaxF8qJo4fAqWyqBjcCVVgMqXcCWsBGS/GAEte/tGac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UhKUuFeKiAzaj5LtFoaBC3aQheWv3NPmEw90KUpQ+guEoGR3NmshbnFcSBOcDhyOnF8bqJBnCL8HLHCk/sNremkTWHqPy8ZgtlEKzbGyfVbp3DkR/S/zF8yZ+qZH5sb5oirIJs/LgDstiWGc4mJRkjakOaH5429sG6DGMN0pL2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=C5oR3mJK; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="C5oR3mJK"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6acc15016f1so359834eaf.3
        for <linux-iio@vger.kernel.org>; Sat, 08 Aug 2026 11:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786214401; x=1786819201; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r2kXLDnz6kpR8QNsVc1zaowwgblsmhTDwtZ568dODZI=;
        b=C5oR3mJKjeO0HIKXeju5AyOYQe03mL5dIxQH+/qnHQk6zGPHb3fExhosC/ULaB3eiO
         TUD3ho0XTXWOb2tyesbY5PUVggJ+/kRsfwHR1nNgq6sHzmn4OyEuUM+ygk8WxA7j4Vni
         ZKzucbkxEokjSwaS82ITyDmiOyENDoJT4k8HWALqdIt1OvDsrJ5gRVT6SdpqS9/MXcvW
         /CnpGNdgFglcJ8iE/70+zDKSN1XeZuKVXIevuzgo7kddiatoqCOv7il9dSuzku570gl4
         EekrsynwIb+jUnOWkDH5u+rcThh9ckCdrOY0swJ17dTwyRlPhJr98Exbn8HEuPpNKu7G
         KJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786214401; x=1786819201;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r2kXLDnz6kpR8QNsVc1zaowwgblsmhTDwtZ568dODZI=;
        b=KRzMOHsmSNZzCT1Fw247y6KkwwfSyfSZK2BcgOMkVOLar80KsVUaYCCQhNnvvaTGmy
         P63eLZMJd9EnxNKJZjuUiHZXMVzukqEsScVNJ8mHu2ejoXgPP4BsqjFU642KQo2Nikj4
         kDMGEel/LyjtJcF7G5zMhQUpM5qP6pM3f7R51bQS9S0v++jL+Njm0ljjJC8pr8nDHzUp
         rUAlz2ndyzMbe4VohXX22e0hA/G2H1XzXbEYmwVCoVStjjJwJd54shU9BH+WTI2jJs3z
         Wknja9n4EGhql5PLtPdy0wfwmDdP6PWq/358Fgb7dlxvyEl08bKTOJ+KdxFX9WPW57HR
         m47g==
X-Forwarded-Encrypted: i=1; AHgh+RppzpuUiC228xeH5UsN4KBl27Mf6vL0K9ycbZbo/SikQwoJmMAukAZaub71MUOkkIs8qerbmNHDkOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZnCUQn+fYisNZuyak4qgxucboazXLUu5g/9AHcByg0z+wdo2f
	BbtmWvUccyRMq3O+WMycH9wS1k87gp/bsYNopRlHVVBjFsGQtAuh3a7+wV8P9NoH5/c=
X-Gm-Gg: AR+sD12FfOilWEmjJx7YY3d6vLVkYHqI5/2TfJV9J18wNykfUD5JWW7ZcDNsSHQrIPB
	NFPbM5Bj0n2bH6RtfuPsgXHRCCvWXUXt0JchHfgBAOo1Js5hk1IXyfa10SIleEvN8KOrxsjsDCl
	EfFHImDb3kRrZj2uJtME97RaRr6xERwqUoLibqgACDrc7EJUulnMXU2ilxi22Wfy92MeJ2BDUoI
	NQQ13h0T+IJCY2REEkwT7mDEwZPiHDak1KJjbCLGqiOrae1UOpjs1bHoFyhwsSgE+kAyrS95or9
	glBNUKhruee6mZ48HrXFllbHUrxaDsF2sbBjz8lLgbPB37lOpTo4vrIS7pPajLK7eqjrp/rEaji
	Ib11ldPHR31UHcmZkHMLt1fF4IKl6ckLnsGVo4kf7WMO/eA9xhYktiSn/4nOJw89bXRnDFwleSK
	AtLG8Oke6T4+l4cqSupUsg0zzxgjpn0UmV7bJHpHDdUpa0vvRJ+subH1A4ioU4pEbHZ4hNHqAqH
	L/h8k/wH0cA44T100KOqlJaMNy6lgFaCdLajgQ=
X-Received: by 2002:a4a:ee0a:0:b0:6aa:f810:f579 with SMTP id 006d021491bc7-6ae96c10190mr17949909eaf.4.1786214400682;
        Sat, 08 Aug 2026 11:40:00 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:99c2:f16e:201c:3bb5? ([2600:8803:e7e4:500:99c2:f16e:201c:3bb5])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b056cad736sm989361eaf.0.2026.08.08.11.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Aug 2026 11:40:00 -0700 (PDT)
Message-ID: <1b6b6981-1a08-42a2-a03a-4366b980da13@baylibre.com>
Date: Sat, 8 Aug 2026 13:39:58 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] iio: adc: ti-ads1262: support triggered buffer
 sampling
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
 <20260807-ads126x-v3-7-f89925d72792@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260807-ads126x-v3-7-f89925d72792@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/26 10:58 PM, Kurt Borja wrote:
> Add triggered buffer support and a data-ready (DRDY) hardware trigger.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/iio/adc/Kconfig      |   2 +
>  drivers/iio/adc/ti-ads1262.c | 264 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 266 insertions(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index dbf76427912b..b9b561be8347 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1845,6 +1845,8 @@ config TI_ADS1262
>  	tristate "Texas Instruments ADS1262"
>  	depends on SPI
>  	select REGMAP
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  If you say yes here you get support for Texas Instruments ADS1262 and
>  	  ADS1263 ADC chips.
> diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
> index d5464b4f2bfb..24a7ecb9fbd4 100644
> --- a/drivers/iio/adc/ti-ads1262.c
> +++ b/drivers/iio/adc/ti-ads1262.c
> @@ -34,6 +34,9 @@
>  #include <asm/byteorder.h>
>  
>  #include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  
>  #define ADS1262_OPCODE_NOP			0x00
>  #define ADS1262_OPCODE_RESET			0x06
> @@ -225,6 +228,7 @@ struct ads1262_channel {
>  struct ads1262 {
>  	struct spi_device *spi;
>  	struct regmap *regmap;
> +	struct iio_trigger *trig;
>  	struct gpio_desc *reset_gpiod;
>  	struct gpio_desc *start_gpiod;
>  	unsigned long clk_rate;
> @@ -241,8 +245,16 @@ struct ads1262 {
>  	bool need_avss_uV;
>  	bool bipolar_supply;
>  
> +	IIO_DECLARE_BUFFER_WITH_TS(__be32, scan_buffer,
> +				   ADS1262_MAX_CHANNEL_COUNT);
> +
>  	/* Protects transfer buffers and concurrent SPI transfers */
>  	struct mutex xfer_lock;
> +	struct spi_message msg;
> +	struct spi_transfer xfer;
> +

Where does the 11 come from?

> +	u8 tx[11] __aligned(IIO_DMA_MINALIGN);
> +	u8 rx[11] __aligned(IIO_DMA_MINALIGN);

don't need second one to be aligned, they aren't indepedant.

>  };
>  
>  static const u32 ads1262_data_rate_div[] = {
> @@ -708,10 +720,242 @@ static const struct iio_info ads1262_iio_info = {
>  	.debugfs_reg_access = ads1262_debugfs_reg_access,
>  };
>  
> +static int ads1262_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ads1262 *st = iio_priv(indio_dev);
> +	unsigned int weight;
> +	unsigned long i;
> +	int ret;
> +
> +	weight = bitmap_weight(indio_dev->active_scan_mask,
> +			       iio_get_masklength(indio_dev));
> +
> +	if (weight > 1) {
> +		/*
> +		 * Multiple channels use software sequencing: a single
> +		 * contiguous transfer rewrites the per-channel configuration
> +		 * registers in two (non-contiguous) groups.
> +		 *
> +		 * Group 1: write protocol (2 bytes) + MODE0, MODE1, MODE2,
> +		 * INPMUX (4 registers).
> +		 *
> +		 * Group 2: write protocol (2 bytes) + IDACMUX, IDACMAG,
> +		 * REFMUX (3 registers).
> +		 *
> +		 * Total: 11 bytes
> +		 */
> +		st->xfer.len = 11;
> +	} else {
> +		/*
> +		 * A single channel is read by command (RDATA1), so the transfer
> +		 * holds the command byte plus the 4 conversion bytes.
> +		 *
> +		 * Total: 5 bytes
> +		 */
> +		st->xfer.len = 5;
> +
> +		/*
> +		 * When only one channel is enabled, we can't really avoid SPI
> +		 * activity from happening when the auxiliary ADC is in use,
> +		 * thus we have to read from the data-holding register (command
> +		 * mode).
> +		 */
> +		memset(st->tx, 0, st->xfer.len);
> +		st->tx[0] = ADS1262_OPCODE_RDATA1;
> +
> +		i = find_first_bit(indio_dev->active_scan_mask,
> +				   iio_get_masklength(indio_dev));
> +		ret = ads1262_channel_enable(st, &indio_dev->channels[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = ads1262_set_runmode(st, ADS1262_RUNMODE_CONTINUOUS);
> +	if (ret)
> +		return ret;
> +
> +	ret = spi_optimize_message(st->spi, &st->msg);
> +	if (ret)
> +		return ret;
> +
> +	ret = ads1262_dev_start(st);

Start really should be in buffer postenable as the trigger poll function
hasn't been set up yet. It is fine to move all of this to postenable.

> +	if (ret) {
> +		spi_unoptimize_message(&st->msg);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ads1262_buffer_postdisable(struct iio_dev *indio_dev)

Likewise, this needs to be predisable so that it stops triggering
the interrupt before we remove the trigger poll function.

> +{
> +	struct ads1262 *st = iio_priv(indio_dev);
> +	unsigned int weight;
> +
> +	ads1262_dev_stop(st);
> +	spi_unoptimize_message(&st->msg);
> +
> +	weight = bitmap_weight(indio_dev->active_scan_mask,
> +			       iio_get_masklength(indio_dev));
> +	if (weight > 1) {
> +		regcache_drop_region(st->regmap, ADS1262_MODE0_REG,
> +				     ADS1262_INPMUX_REG);
> +		regcache_drop_region(st->regmap, ADS1262_IDACMUX_REG,
> +				     ADS1262_REFMUX_REG);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct iio_buffer_setup_ops ads1262_buffer_ops = {
> +	.preenable = ads1262_buffer_preenable,
> +	.postdisable = ads1262_buffer_postdisable,
> +};
> +
> +static int ads1262_enable_and_read_last(struct ads1262 *st,
> +					const struct iio_chan_spec *spec,
> +					__be32 *val)
> +{
> +	struct ads1262_channel *chan;
> +	int ret;
> +
> +	lockdep_assert_held(&st->xfer_lock);

What happens if something else (e.g. gpio in the future) decides to do a
register write here. If it wins the race, will it unintentially read the
data? So do we also need to read the stored data via command here too?

> +
> +	if (spec) {
> +		guard(mutex)(&st->chan_lock);
> +
> +		chan = &st->channels[spec->scan_index];
> +
> +		/* Group 1: MODE0, MODE1, MODE2, INPMUX */
> +		st->tx[0] = ADS1262_MODE0_REG | ADS1262_OPCODE_WREG;
> +		st->tx[1] = ADS1262_INPMUX_REG - ADS1262_MODE0_REG;
> +		st->tx[2] = FIELD_PREP(ADS1262_MODE0_INPUT_CHOP_MASK, chan->input_chop) |
> +			    FIELD_PREP(ADS1262_MODE0_IDAC_CHOP_MASK, chan->idac_chop) |
> +			    FIELD_PREP(ADS1262_MODE0_RUNMODE_MASK, ADS1262_RUNMODE_CONTINUOUS) |
> +			    FIELD_PREP(ADS1262_MODE0_REFREV_MASK, chan->ref_reversal);
> +		st->tx[3] = FIELD_PREP(ADS1262_MODE1_FILTER_MASK, ADS1262_FILTER_FIR);
> +		st->tx[4] = FIELD_PREP(ADS1262_MODE2_DR_MASK, chan->data_rate) |
> +			    FIELD_PREP(ADS1262_MODE2_GAIN_MASK, chan->gain);
> +		st->tx[5] = FIELD_PREP(ADS1262_INPMUX_MUXP_MASK, spec->channel) |
> +			    FIELD_PREP(ADS1262_INPMUX_MUXN_MASK, spec->channel2);
> +
> +		/* Group 2: IDACMUX, IDACMAG, REFMUX */
> +		st->tx[6] = ADS1262_IDACMUX_REG | ADS1262_OPCODE_WREG;
> +		st->tx[7] = ADS1262_REFMUX_REG - ADS1262_IDACMUX_REG;
> +		st->tx[8] = FIELD_PREP(ADS1262_IDACMUX_MUX1_MASK, chan->idac_mux[0]) |
> +			    FIELD_PREP(ADS1262_IDACMUX_MUX2_MASK, chan->idac_mux[1]);
> +		st->tx[9] = FIELD_PREP(ADS1262_IDACMAG_MAG1_MASK, chan->idac_mag[0]) |
> +			    FIELD_PREP(ADS1262_IDACMAG_MAG2_MASK, chan->idac_mag[1]);
> +		st->tx[10] = FIELD_PREP(ADS1262_REFMUX_RMUXP_MASK, chan->ref_p) |
> +			     FIELD_PREP(ADS1262_REFMUX_RMUXN_MASK, chan->ref_n);
> +	} else {
> +		memset(st->tx, 0, sizeof(st->tx));
> +	}
> +
> +	ret = spi_sync(st->spi, &st->msg);
> +	if (ret)
> +		return ret;
> +
> +	memcpy(val, st->rx, sizeof(*val));
> +
> +	return 0;
> +}
> +
> +static int ads1262_fill_buffer_mult(struct iio_dev *indio_dev)
> +{
> +	struct ads1262 *st = iio_priv(indio_dev);
> +	unsigned int chan;
> +	__be32 val;
> +	int i = -1;
> +	int ret;
> +
> +	/*
> +	 * This routine enables and reads channels in a full-duplex fashion.
> +	 *
> +	 * When a channel is enabled, the previous conversion is clocked out of
> +	 * the shift data register on the same transfer (Section 9.4.7.1). This
> +	 * allows for low latency software sequencing but forbids any
> +	 * communication with the chip in-between or data corruption may occur,
> +	 * hence the need to take the xfer_lock for the whole operation.
> +	 */
> +	guard(mutex)(&st->xfer_lock);
> +
> +	iio_for_each_active_channel(indio_dev, chan) {
> +		ret = ads1262_enable_and_read_last(st, &indio_dev->channels[chan],
> +						   &val);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * After writing to the channel configuration registers, the
> +		 * conversion-cycle is restarted and the data registers are
> +		 * cleared. This means we have to reinit the completion after
> +		 * enabling to avoid reading stale data.
> +		 */
> +		reinit_completion(&st->drdy);

This seems racy still as DRDY could have been triggered already, in which case
we would time out waiting for the interrupt. Or does the DRDY toggle again
even if we don't read the data to trigger another conversion?

Would it be possible to make one big SPI messsage that contains all enabled
channels and just run that instead? Insted of waiting for drdy, it would have
to add a delay at the end of the sequence of xfers for setting up each channel
that was long enough to ensure that the conversion will be done when we read
it.

Or we could just do similar to the start_one() function and don't leave
it in continuous conversion mode. Using the delay option of spi xfers, we
could just tack on two more commands to start and stop the conversion after
after writing all of the mode stuff so that it still all happens in one SPI
message.

> +
> +		if (i > -1)
> +			st->scan_buffer[i] = val;
> +		i++;
> +
> +		ret = ads1262_wait_for_conversion(st);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return ads1262_enable_and_read_last(st, NULL, &st->scan_buffer[i]);
> +}
> +
> +static int ads1262_fill_buffer_one(struct iio_dev *indio_dev)
> +{
> +	struct ads1262 *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	guard(mutex)(&st->xfer_lock);
> +
> +	ret = spi_sync(st->spi, &st->msg);
> +	if (ret)
> +		return ret;
> +
> +	/* In command mode the conversion data is found at offset 1 */
> +	memcpy(st->scan_buffer, &st->rx[1], sizeof(*st->scan_buffer));
> +
> +	return 0;
> +}
> +
> +static irqreturn_t ads1262_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ads1262 *st = iio_priv(indio_dev);
> +	s64 ts = pf->timestamp;
> +	unsigned int weight;
> +	int ret;
> +
> +	weight = bitmap_weight(indio_dev->active_scan_mask,
> +			       iio_get_masklength(indio_dev));
> +
> +	if (weight == 1)

Could make this:

	if (io_validate_scan_mask_onehot(indio_dev))

> +		ret = ads1262_fill_buffer_one(indio_dev);
> +	else
> +		ret = ads1262_fill_buffer_mult(indio_dev);
> +	if (ret)
> +		goto out_notify_done;
> +
> +	iio_push_to_buffers_with_ts(indio_dev, st->scan_buffer,
> +				    sizeof(st->scan_buffer), ts);
> +
> +out_notify_done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static irqreturn_t ads1262_irq_handler(int irq, void *dev_id)
>  {
>  	struct ads1262 *st = dev_id;
>  
> +	iio_trigger_poll(st->trig);
>  	complete(&st->drdy);
>  
>  	return IRQ_HANDLED;
> @@ -1414,6 +1658,10 @@ static int ads1262_spi_probe(struct spi_device *spi)
>  	st->spi = spi;
>  	init_completion(&st->drdy);
>  
> +	st->xfer.tx_buf = st->tx;
> +	st->xfer.rx_buf = st->rx;
> +	spi_message_init_with_transfers(&st->msg, &st->xfer, 1);
> +
>  	ret = devm_mutex_init(dev, &st->chan_lock);
>  	if (ret)
>  		return ret;
> @@ -1459,6 +1707,22 @@ static int ads1262_spi_probe(struct spi_device *spi)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to configure device\n");
>  
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      iio_pollfunc_store_time,
> +					      ads1262_trigger_handler,
> +					      &ads1262_buffer_ops);
> +	if (ret)
> +		return ret;
> +
> +	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d-drdy", info->name,
> +					  iio_device_id(indio_dev));
> +	if (!st->trig)
> +		return -ENOMEM;
> +	iio_trigger_set_drvdata(st->trig, st);
> +	ret = devm_iio_trigger_register(dev, st->trig);
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * REVISIT: This chip has software polling capabilities, which could be
>  	 * used to stop depending on the 'drdy' IRQ.
> 

