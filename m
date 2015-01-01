Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55732 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbbAAMOt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jan 2015 07:14:49 -0500
Message-ID: <54A53A37.4040406@kernel.org>
Date: Thu, 01 Jan 2015 12:14:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	linux-iio@vger.kernel.org
CC: octavian.purdila@intel.com, daniel.baluta@intel.com,
	lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net
Subject: Re: [PATCH 1/2] iio: light: Annotate Kconfig entry with module name
 information
References: <1419965330-4102-1-git-send-email-roberta.dobrescu@gmail.com> <1419965330-4102-2-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1419965330-4102-2-git-send-email-roberta.dobrescu@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/12/14 18:48, Roberta Dobrescu wrote:
> This patch fixes the following checkpatch.pl warning:
> WARNING: please write a paragraph that describes the config symbol fully
> 
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
Applied.
> ---
>  drivers/iio/light/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 5bea821..fce4d688 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -95,6 +95,9 @@ config HID_SENSOR_ALS
>  	  Say yes here to build support for the HID SENSOR
>  	  Ambient light sensor.
>  
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called hid-sensor-als.
> +
>  config HID_SENSOR_PROX
>  	depends on HID_SENSOR_HUB
>  	select IIO_BUFFER
> 

