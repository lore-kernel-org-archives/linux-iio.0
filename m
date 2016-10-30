Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42787 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757040AbcJ3QWM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Oct 2016 12:22:12 -0400
Subject: Re: [PATCH] iio: orientation: hid-sensor-rotation: Add PM function
To: Song Hongyan <hongyan.song@intel.com>, linux-iio@vger.kernel.org
References: <1477357563-16794-1-git-send-email-hongyan.song@intel.com>
Cc: srinivas.pandruvada@intel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5c8d5490-93c9-a8c8-2d25-dbec3e2dc86f@kernel.org>
Date: Sun, 30 Oct 2016 16:22:09 +0000
MIME-Version: 1.0
In-Reply-To: <1477357563-16794-1-git-send-email-hongyan.song@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/10/16 02:06, Song Hongyan wrote:
> Rotation sensor function does not work due to miss PM function.
> Add common hid sensor iio pm function for rotation sensor.
> 
> Signed-off-by: Song Hongyan <hongyan.song@intel.com>
Does this completely prevent the driver working or merely make it consume
too much power?

Only really makes a difference to which route it takes to mainline and how
fast it gets there!

Jonathan
> ---
>  drivers/iio/orientation/hid-sensor-rotation.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
> index b98b9d9..a97e802c 100644
> --- a/drivers/iio/orientation/hid-sensor-rotation.c
> +++ b/drivers/iio/orientation/hid-sensor-rotation.c
> @@ -335,6 +335,7 @@ static int hid_dev_rot_remove(struct platform_device *pdev)
>  	.id_table = hid_dev_rot_ids,
>  	.driver = {
>  		.name	= KBUILD_MODNAME,
> +		.pm     = &hid_sensor_pm_ops,
>  	},
>  	.probe		= hid_dev_rot_probe,
>  	.remove		= hid_dev_rot_remove,
> 

