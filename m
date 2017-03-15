Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58204 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbdCOWFV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 18:05:21 -0400
Subject: Re: [PATCH v2] Staging: iio: cdc: ad7152.c, use octal permissions
 instead of symbolic
To: Miguel Robles <miguel.robles@farole.net>,
        gregkh@linuxfoundation.org
References: <1489509221-12547-1-git-send-email-miguel.robles@farole.net>
Cc: linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <870c4b6a-3de0-5c6d-b617-cd52b039f62b@kernel.org>
Date: Wed, 15 Mar 2017 22:04:22 +0000
MIME-Version: 1.0
In-Reply-To: <1489509221-12547-1-git-send-email-miguel.robles@farole.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/03/17 16:33, Miguel Robles wrote:
> Fix checkpatch warnings:
> Symbolic permissions are not preferred. Consider using octal permissions.
> 
> Signed-off-by: Miguel Robles <miguel.robles@farole.net>
> ---
> Changes in v2:
> - Remove "[Patch]" from the subject.
While true, probably not worth the repost!

Jonathan
> 
>  drivers/staging/iio/cdc/ad7152.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
> index e8609b8..dd0c24c 100644
> --- a/drivers/staging/iio/cdc/ad7152.c
> +++ b/drivers/staging/iio/cdc/ad7152.c
> @@ -155,13 +155,13 @@ static ssize_t ad7152_start_gain_calib(struct device *dev,
>  }
>  
>  static IIO_DEVICE_ATTR(in_capacitance0_calibbias_calibration,
> -		       S_IWUSR, NULL, ad7152_start_offset_calib, 0);
> +		       0200, NULL, ad7152_start_offset_calib, 0);
>  static IIO_DEVICE_ATTR(in_capacitance1_calibbias_calibration,
> -		       S_IWUSR, NULL, ad7152_start_offset_calib, 1);
> +		       0200, NULL, ad7152_start_offset_calib, 1);
>  static IIO_DEVICE_ATTR(in_capacitance0_calibscale_calibration,
> -		       S_IWUSR, NULL, ad7152_start_gain_calib, 0);
> +		       0200, NULL, ad7152_start_gain_calib, 0);
>  static IIO_DEVICE_ATTR(in_capacitance1_calibscale_calibration,
> -		       S_IWUSR, NULL, ad7152_start_gain_calib, 1);
> +		       0200, NULL, ad7152_start_gain_calib, 1);
>  
>  /* Values are Update Rate (Hz), Conversion Time (ms) + 1*/
>  static const unsigned char ad7152_filter_rate_table[][2] = {
> 

