Return-Path: <SRS0=fmzm=J3=gmail.com=robherring2@kernel.org>
Date: Wed, 11 Jul 2018 07:54:32 -0600
From: Rob Herring <robh@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	mark.rutland@arm.com, mchehab@kernel.org, davem@davemloft.net,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	linus.walleij@linaro.org, rdunlap@infradead.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] iio: hx711: fix spurious unit-address in example
Message-ID: <20180711135432.GA16230@rob-hp-laptop>
References: <20180710181937.GA5398@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180710181937.GA5398@arbeit>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jul 10, 2018 at 08:19:37PM +0200, Andreas Klinger wrote:
> Device tree compiler (dtc) gives a warning if a device node has "@" with a
> following number as it's name but no reg property.
> 
> Fix the example in the documentation of avia,hx711 to conform to dtc
> behavior.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  Documentation/devicetree/bindings/iio/adc/avia-hx711.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
