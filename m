Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48821 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797AbcEAV0T (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 1 May 2016 17:26:19 -0400
Subject: Re: [PATCH 1/3] iio: bmi160: Fix output data rate for accel
To: Daniel Baluta <daniel.baluta@intel.com>
References: <1461930155-13871-1-git-send-email-daniel.baluta@intel.com>
 <1461930155-13871-2-git-send-email-daniel.baluta@intel.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ce5eceb0-9502-2a0d-7686-d94f5963e329@kernel.org>
Date: Sun, 1 May 2016 20:00:22 +0100
MIME-Version: 1.0
In-Reply-To: <1461930155-13871-2-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/04/16 12:42, Daniel Baluta wrote:
> Format is INT_PLUS_MICRO and micro odr part of ODR should
> be parts of a micro.
> 
> Also s/8000/800 this is obviously a typo.
> 
> Fixes: 77c4ad2d6a9 ("iio: imu: Add initial support for Bosch BMI160")
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
I can't set up a suitable fixes branch for this as I'm without internet to grab an
updated staging-next tree right now.  Will mark it to be sorted out when I get some time
back on a sensible internet connection (France is always a lot bigger than I expect it
to be for some reason...)

Anyhow, poke me if you don't hear anything before the end of the week.

Note this will probably have to go in post merge window now as I doubt I'll be doing
another pull before that opens.

Jonathan
> ---
>  drivers/iio/imu/bmi160/bmi160_core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> index 0bf92b0..cd9b75e 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -209,11 +209,11 @@ static const struct  bmi160_scale_item bmi160_scale_table[] = {
>  };
>  
>  static const struct bmi160_odr bmi160_accel_odr[] = {
> -	{0x01, 0, 78125},
> -	{0x02, 1, 5625},
> -	{0x03, 3, 125},
> -	{0x04, 6, 25},
> -	{0x05, 12, 5},
> +	{0x01, 0, 781250},
> +	{0x02, 1, 562500},
> +	{0x03, 3, 125000},
> +	{0x04, 6, 250000},
> +	{0x05, 12, 500000},
>  	{0x06, 25, 0},
>  	{0x07, 50, 0},
>  	{0x08, 100, 0},
> @@ -229,7 +229,7 @@ static const struct bmi160_odr bmi160_gyro_odr[] = {
>  	{0x08, 100, 0},
>  	{0x09, 200, 0},
>  	{0x0A, 400, 0},
> -	{0x0B, 8000, 0},
> +	{0x0B, 800, 0},
>  	{0x0C, 1600, 0},
>  	{0x0D, 3200, 0},
>  };
> 

