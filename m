Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59395 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbbCUMCh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2015 08:02:37 -0400
Message-ID: <550D5DDA.9080108@kernel.org>
Date: Sat, 21 Mar 2015 12:02:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Fabian Frederick <fabf@skynet.be>, linux-kernel@vger.kernel.org
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 09/35 linux-next] iio: constify of_device_id array
References: <1426533469-25458-1-git-send-email-fabf@skynet.be> <1426533469-25458-10-git-send-email-fabf@skynet.be>
In-Reply-To: <1426533469-25458-10-git-send-email-fabf@skynet.be>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/03/15 19:17, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
Applied to the togreg branch of iio.git - initially pushed out as testing for the
autobuilders to play with it.

thanks,

Jonathan
> ---
>  drivers/iio/common/ssp_sensors/ssp_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
> index 55a90082..9a40097 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_dev.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
> @@ -437,7 +437,7 @@ int ssp_queue_ssp_refresh_task(struct ssp_data *data, unsigned int delay)
>  }
>  
>  #ifdef CONFIG_OF
> -static struct of_device_id ssp_of_match[] = {
> +static const struct of_device_id ssp_of_match[] = {
>  	{
>  		.compatible	= "samsung,sensorhub-rinato",
>  		.data		= &ssp_rinato_info,
> 

