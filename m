Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52981 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752011AbcHUSvH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Aug 2016 14:51:07 -0400
Subject: Re: [PATCH v2] iio: temperature: add Kconfig selects for triggered
 buffer
To: Alison Schofield <amsfield22@gmail.com>
References: <20160815230929.GA12208@d830.WORKGROUP>
Cc: mranostay@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <153ef671-068c-a4b4-c987-bd7556e8c5e8@kernel.org>
Date: Sun, 21 Aug 2016 19:51:05 +0100
MIME-Version: 1.0
In-Reply-To: <20160815230929.GA12208@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/08/16 00:09, Alison Schofield wrote:
> Select IIO_BUFFER and IIO_TRIGGERED_BUFFER to compile maxim_thermocouple.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
Applied to the togreg branch of iio.git. 

Thanks Alison,

Jonathan
> ---
> Changes in v2
>  - split off from a group patch destined for another branch
>  - rebased on iio/togreg
> 
>  drivers/iio/temperature/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> index 1d3da05..5ea77a7 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -6,6 +6,8 @@ menu "Temperature sensors"
>  config MAXIM_THERMOCOUPLE
>  	tristate "Maxim thermocouple sensors"
>  	depends on SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  If you say yes here you get support for the Maxim series of
>  	  thermocouple sensors connected via SPI.
> 

