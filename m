Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52659 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752685AbcL3Sk6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 13:40:58 -0500
Subject: Re: [PATCHv4 1/8] fixed long description text exceeding 80 characters
To: Scott Matheina <scott@matheina.com>, linux-kernel@vger.kernel.org
References: <1482696216-8013-1-git-send-email-scott@matheina.com>
 <1482696216-8013-2-git-send-email-scott@matheina.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ad36749f-c14b-55cf-cbf6-d40a4f8b572c@kernel.org>
Date: Fri, 30 Dec 2016 18:40:56 +0000
MIME-Version: 1.0
In-Reply-To: <1482696216-8013-2-git-send-email-scott@matheina.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/12/16 19:56, Scott Matheina wrote:
> The description was split into 2 lines due to the line greatly
> exceeding the 80 character soft limit.

This is often deliberately done with strings.  It makes them
much easier to grep for in the source.  Adding the artificial
newline may destroy attempts by userspace tools to do their own
formatting of this string.

So best to leave this one alone.

Jonathan
> 
> Signed-off-by: Scott Matheina <scott@matheina.com>
> ---
>  drivers/staging/iio/addac/adt7316.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index a7d90c8..08413a8 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -2181,5 +2181,6 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
>  EXPORT_SYMBOL(adt7316_probe);
>  
>  MODULE_AUTHOR("Sonic Zhang <sonic.zhang@analog.com>");
> -MODULE_DESCRIPTION("Analog Devices ADT7316/7/8 and ADT7516/7/9 digital temperature sensor, ADC and DAC driver");
> +MODULE_DESCRIPTION("Analog Devices ADT7316/7/8 and ADT7516/7/9 digital\n"
> +		   "temperature sensor, ADC and DAC driver");
>  MODULE_LICENSE("GPL v2");
> 

