Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbeGOJA7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Jul 2018 05:00:59 -0400
Date: Sun, 15 Jul 2018 09:38:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, mchehab@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        rdunlap@infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] iio: hx711: add delay until DOUT is ready
Message-ID: <20180715093843.11e86d5f@archlinux>
In-Reply-To: <20180710181903.GA5386@arbeit>
References: <20180710181903.GA5386@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 10 Jul 2018 20:19:03 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> On a system with parasitic capacitance it turned out that DOUT is not ready
> after 100 ns after PD_SCK has raised. A measurement showed almost 1000 ns
> until DOUT has reached its correct value.
> 
> With this patch its now possible to wait until data is ready.
> 
> The wait time should not be higher than the maximum PD_SCK high time which
> is corresponding to the datasheet 50000 ns.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Applied, thanks.

Jonathan

> ---
>  drivers/iio/adc/hx711.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> index 9430b54121e0..36b59d8957fb 100644
> --- a/drivers/iio/adc/hx711.c
> +++ b/drivers/iio/adc/hx711.c
> @@ -97,6 +97,14 @@ struct hx711_data {
>  	 * 2x32-bit channel + 64-bit timestamp
>  	 */
>  	u32			buffer[4];
> +	/*
> +	 * delay after a rising edge on SCK until the data is ready DOUT
> +	 * this is dependent on the hx711 where the datasheet tells a
> +	 * maximum value of 100 ns
> +	 * but also on potential parasitic capacities on the wiring
> +	 */
> +	u32			data_ready_delay_ns;
> +	u32			clock_frequency;
>  };
>  
>  static int hx711_cycle(struct hx711_data *hx711_data)
> @@ -110,6 +118,14 @@ static int hx711_cycle(struct hx711_data *hx711_data)
>  	 */
>  	preempt_disable();
>  	gpiod_set_value(hx711_data->gpiod_pd_sck, 1);
> +
> +	/*
> +	 * wait until DOUT is ready
> +	 * it turned out that parasitic capacities are extending the time
> +	 * until DOUT has reached it's value
> +	 */
> +	ndelay(hx711_data->data_ready_delay_ns);
> +
>  	val = gpiod_get_value(hx711_data->gpiod_dout);
>  	/*
>  	 * here we are not waiting for 0.2 us as suggested by the datasheet,
> @@ -120,6 +136,12 @@ static int hx711_cycle(struct hx711_data *hx711_data)
>  	gpiod_set_value(hx711_data->gpiod_pd_sck, 0);
>  	preempt_enable();
>  
> +	/*
> +	 * make it a square wave for addressing cases with capacitance on
> +	 * PC_SCK
> +	 */
> +	ndelay(hx711_data->data_ready_delay_ns);
> +
>  	return val;
>  }
>  
> @@ -458,6 +480,7 @@ static const struct iio_chan_spec hx711_chan_spec[] = {
>  static int hx711_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
>  	struct hx711_data *hx711_data;
>  	struct iio_dev *indio_dev;
>  	int ret;
> @@ -530,6 +553,22 @@ static int hx711_probe(struct platform_device *pdev)
>  	hx711_data->gain_set = 128;
>  	hx711_data->gain_chan_a = 128;
>  
> +	hx711_data->clock_frequency = 400000;
> +	ret = of_property_read_u32(np, "clock-frequency",
> +					&hx711_data->clock_frequency);
> +
> +	/*
> +	 * datasheet says the high level of PD_SCK has a maximum duration
> +	 * of 50 microseconds
> +	 */
> +	if (hx711_data->clock_frequency < 20000) {
> +		dev_warn(dev, "clock-frequency too low - assuming 400 kHz\n");
> +		hx711_data->clock_frequency = 400000;
> +	}
> +
> +	hx711_data->data_ready_delay_ns =
> +				1000000000 / hx711_data->clock_frequency;
> +
>  	platform_set_drvdata(pdev, indio_dev);
>  
>  	indio_dev->name = "hx711";

