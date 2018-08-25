Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbeHYMGL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Aug 2018 08:06:11 -0400
Date: Sat, 25 Aug 2018 09:27:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] MAINTAINERS: add entry for ltc1660 DAC driver
Message-ID: <20180825092754.109510f2@archlinux>
In-Reply-To: <20180821193126.15733-3-marcus.folkesson@gmail.com>
References: <20180821193126.15733-1-marcus.folkesson@gmail.com>
        <20180821193126.15733-3-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 21 Aug 2018 21:31:26 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Add entry for ltc1660 DAC driver and add myself as
> maintainer of this driver.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Applied.

Thanks,

Jonathan

> ---
> 
> Notes:
>     v2:
>     	- rename enumerated files, ltc166x* -> ltc1660*
> 
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9276da915d9d..3db1edaf68bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8363,6 +8363,13 @@ L:	linux-scsi@vger.kernel.org
>  S:	Maintained
>  F:	drivers/scsi/sym53c8xx_2/
>  
> +LTC1660 DAC DRIVER
> +M:	Marcus Folkesson <marcus.folkesson@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/dac/ltc1660.txt
> +F:	drivers/iio/dac/ltc1660.c
> +
>  LTC4261 HARDWARE MONITOR DRIVER
>  M:	Guenter Roeck <linux@roeck-us.net>
>  L:	linux-hwmon@vger.kernel.org
