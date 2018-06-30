Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751272AbeF3RfH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Jun 2018 13:35:07 -0400
Date: Sat, 30 Jun 2018 18:35:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, mchehab@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        rdunlap@infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: hx711: add maintainer for driver
Message-ID: <20180630183500.051452f0@archlinux>
In-Reply-To: <20180625151845.GA6392@arbeit>
References: <20180625151845.GA6392@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 25 Jun 2018 17:18:45 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> add a maintainer for driver hx711
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
I applied this one before (not certain I emailed to say that)
so please drop from future versions of the patch set.

Thanks,

Jonathan

> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4b65225d443a..cfb8a08777ac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2535,6 +2535,13 @@ S:	Maintained
>  F:	drivers/auxdisplay/
>  F:	include/linux/cfag12864b.h
>  
> +AVIA HX711 ANALOG DIGITAL CONVERTER IIO DRIVER
> +M:	Andreas Klinger <ak@it-klinger.de>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> +F:	drivers/iio/adc/hx711.c
> +
>  AX.25 NETWORK LAYER
>  M:	Ralf Baechle <ralf@linux-mips.org>
>  L:	linux-hams@vger.kernel.org

