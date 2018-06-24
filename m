Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751637AbeFXNMS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Jun 2018 09:12:18 -0400
Date: Sun, 24 Jun 2018 14:12:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, mchehab@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        rdunlap@infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: hx711: add delay until DOUT is ready
Message-ID: <20180624141211.3765219d@archlinux>
In-Reply-To: <20180623185447.GA17853@arbeit>
References: <20180623185447.GA17853@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 23 Jun 2018 20:54:47 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> On a system with parasitic capacities it turned out that DOUT is not ready
> after 100 ns after PD_SCK has raised. A measurement showed almost 1000 ns
> until DOUT has reached its correct value.
> 
> With this patch its now possible to wait until data is ready.
> 
> The wait time should not be higher than the maximum PD_SCK high time which
> is corresponding to the datasheet 50000 ns.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

This looks fine to me.  Will pick up once we have a DT review for the binding.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/hx711.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> index 9430b54121e0..41e26ef324ee 100644
> --- a/drivers/iio/adc/hx711.c
> +++ b/drivers/iio/adc/hx711.c
> @@ -97,6 +97,13 @@ struct hx711_data {
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
>  };
>  
>  static int hx711_cycle(struct hx711_data *hx711_data)
> @@ -110,6 +117,14 @@ static int hx711_cycle(struct hx711_data *hx711_data)
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
> @@ -458,6 +473,7 @@ static const struct iio_chan_spec hx711_chan_spec[] = {
>  static int hx711_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
>  	struct hx711_data *hx711_data;
>  	struct iio_dev *indio_dev;
>  	int ret;
> @@ -530,6 +546,13 @@ static int hx711_probe(struct platform_device *pdev)
>  	hx711_data->gain_set = 128;
>  	hx711_data->gain_chan_a = 128;
>  
> +	ret = of_property_read_u32(np, "data-ready-delay-ns",
> +					&hx711_data->data_ready_delay_ns);
> +	if (ret < 0) {
> +		dev_warn(dev, "data-ready-delay-ns not set - assuming 0 ns\n");
> +		hx711_data->data_ready_delay_ns = 0;
> +	}
> +
>  	platform_set_drvdata(pdev, indio_dev);
>  
>  	indio_dev->name = "hx711";

