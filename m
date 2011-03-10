Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:51416 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab1CJMHj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 10 Mar 2011 07:07:39 -0500
Message-ID: <4D78BF40.6040407@cam.ac.uk>
Date: Thu, 10 Mar 2011 12:08:32 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 1/3] IIO: DAC: AD5446: Add missing ID table entries
References: <1299757966-25592-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1299757966-25592-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/10/11 11:52, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/dac/ad5446.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
> index dcec297..4f1d881 100644
> --- a/drivers/staging/iio/dac/ad5446.c
> +++ b/drivers/staging/iio/dac/ad5446.c
> @@ -295,8 +295,10 @@ static int ad5446_remove(struct spi_device *spi)
>  static const struct spi_device_id ad5446_id[] = {
>  	{"ad5444", ID_AD5444},
>  	{"ad5446", ID_AD5446},
> -	{"ad5542a", ID_AD5542A},
>  	{"ad5512a", ID_AD5512A},
> +	{"ad5542a", ID_AD5542A},
> +	{"ad5543", ID_AD5543},
> +	{"ad5553", ID_AD5553},
>  	{"ad5620-2500", ID_AD5620_2500}, /* AD5620/40/60: */
>  	{"ad5620-1250", ID_AD5620_1250}, /* part numbers may look differently */
>  	{"ad5640-2500", ID_AD5640_2500},

