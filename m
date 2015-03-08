Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34980 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385AbbCHL23 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Mar 2015 07:28:29 -0400
Message-ID: <54FC325B.7020004@kernel.org>
Date: Sun, 08 Mar 2015 11:28:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Marek Belisko <marek@goldelico.com>, gregkh@linuxfoundation.org
CC: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, hns@goldelico.com
Subject: Re: [PATCH] staging: iio: hmc5843: Set iio name property in sysfs
References: <1425156882-27691-1-git-send-email-marek@goldelico.com>
In-Reply-To: <1425156882-27691-1-git-send-email-marek@goldelico.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/02/15 20:54, Marek Belisko wrote:
> Without this change file name for hmc5843 is empty in
> /sys/bus/iio/devices/iio\:device*/name
> 
> With this change name is reported correctly:
> cat /sys/bus/iio/devices/iio\:device*/name
> hmc5843
> 
> Signed-off-by: Marek Belisko <marek@goldelico.com>
Good catch, thanks.

Applied to the fixes-togreg branch of iio.git.

Jonathan
> ---
>  drivers/staging/iio/magnetometer/hmc5843_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843_core.c b/drivers/staging/iio/magnetometer/hmc5843_core.c
> index fd171d8..90cc18b 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843_core.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843_core.c
> @@ -592,6 +592,7 @@ int hmc5843_common_probe(struct device *dev, struct regmap *regmap,
>  	mutex_init(&data->lock);
>  
>  	indio_dev->dev.parent = dev;
> +	indio_dev->name = dev->driver->name;
>  	indio_dev->info = &hmc5843_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = data->variant->channels;
> 

