Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33489 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbbDRTUg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 18 Apr 2015 15:20:36 -0400
Message-ID: <5532AE82.7070407@kernel.org>
Date: Sat, 18 Apr 2015 20:20:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: hid-sensor-press: Fix modifier
References: <1429048458-5379-1-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1429048458-5379-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/04/15 22:54, Srinivas Pandruvada wrote:
> Fix "null" in the raw attribute and scan elements.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
applied, stable ccd.
> ---
>  drivers/iio/pressure/hid-sensor-press.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
> index 7bb8d4c..3cf0bd6 100644
> --- a/drivers/iio/pressure/hid-sensor-press.c
> +++ b/drivers/iio/pressure/hid-sensor-press.c
> @@ -47,8 +47,6 @@ struct press_state {
>  static const struct iio_chan_spec press_channels[] = {
>  	{
>  		.type = IIO_PRESSURE,
> -		.modified = 1,
> -		.channel2 = IIO_NO_MOD,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>  		BIT(IIO_CHAN_INFO_SCALE) |
> 

