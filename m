Return-Path: <bigeasy@linutronix.de>
Message-ID: <51B59935.3010506@linutronix.de>
Date: Mon, 10 Jun 2013 11:15:33 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Samuel Ortiz <sameo@linux.intel.com>, Felipe Balbi <balbi@ti.com>,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jonathan Cameron <jic23@cam.ac.uk>,
 Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [PATCH 12/22] iio/ti_tscadc: Update with IIO map interface
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de> <1370449495-29981-13-git-send-email-bigeasy@linutronix.de> <51B4B024.8070102@metafoo.de> <51B582D3.1050501@linutronix.de> <51B59071.9090908@metafoo.de>
In-Reply-To: <51B59071.9090908@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 06/10/2013 10:38 AM, Lars-Peter Clausen wrote:
> 
> You don't need to describe the channels in devicetree, except setting the
> "#io-channel-cells" property of your ADC node to 1. You also need to initialize
> the of_node property of your iio_device's struct's 'dev' field to the your adc
> node.

Aha. So right now I do have in my device tree:

       adc {
               ti,adc-channels = <4>;
       };

for the producer ADC node. But this seems wrong. Correct would be


       adctsc: adc {
               ti,adc-channels = <4>;
               #io-channel-cells = <1>;
       };

And the consumer can then specify everything. This seems to be looking
good. And with this the map piece can die.
Thanks.

> 
> After that it's just a matter of using, e.g.
> 
> 	io-channels = <&adc 1>;
> 	io-channel-names = "voltage";
> 
> in your consumer.
> 
> - Lars

Sebastian
