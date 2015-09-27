Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37213 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756116AbbI0Pjb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Sep 2015 11:39:31 -0400
Subject: Re: [PATCH] iio: lidar: add missing MODULE_DEVICE_TABLE for dt
To: Matt Ranostay <mranostay@gmail.com>, lars@metafoo.de,
	pmeerw@pmeerw.net
References: <1442989323-12247-1-git-send-email-mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56080DB2.8030801@kernel.org>
Date: Sun, 27 Sep 2015 16:39:30 +0100
MIME-Version: 1.0
In-Reply-To: <1442989323-12247-1-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/09/15 07:22, Matt Ranostay wrote:
> The device tree compatible strings weren't properly
> registered for the pulsedlight-lidar-lite-v2 driver.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
Applied.
> ---
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> index 185a7ab..961f9f99 100644
> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> @@ -271,6 +271,7 @@ static const struct of_device_id lidar_dt_ids[] = {
>  	{ .compatible = "pulsedlight,lidar-lite-v2" },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, lidar_dt_ids);
>  
>  static struct i2c_driver lidar_driver = {
>  	.driver = {
> 

