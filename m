Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58997 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310AbcGXMJk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jul 2016 08:09:40 -0400
Subject: Re: [PATCH 3/3] iio: proximity: as3935: set up buffer timestamps for
 non-zero values
To: Alison Schofield <amsfield22@gmail.com>
References: <cover.1468203399.git.amsfield22@gmail.com>
 <5f812b15a69ff63f65c59deb9eec75a1ef26ccfc.1468203399.git.amsfield22@gmail.com>
Cc: tiberiu.a.breana@intel.com, mranostay@gmail.com, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ec44491f-ef93-1d4c-88d5-49bb77887382@kernel.org>
Date: Sun, 24 Jul 2016 13:09:37 +0100
MIME-Version: 1.0
In-Reply-To: <5f812b15a69ff63f65c59deb9eec75a1ef26ccfc.1468203399.git.amsfield22@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/07/16 16:26, Alison Schofield wrote:
> Use the iio_pollfunc_store_time parameter during triggered buffer
> set-up to get valid timestamps.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
Applied to the fixes-togreg-post-rc1 branch of iio.git and
marked for stable.

Oops to all of these ;)

Jonathan
> ---
>  drivers/iio/proximity/as3935.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index 2e3a70e..5656deb 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -397,7 +397,7 @@ static int as3935_probe(struct spi_device *spi)
>  		return ret;
>  	}
>  
> -	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> +	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
>  		&as3935_trigger_handler, NULL);
>  
>  	if (ret) {
> 

