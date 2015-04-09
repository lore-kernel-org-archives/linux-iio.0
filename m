Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53727 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932855AbbDIQby (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2015 12:31:54 -0400
Message-ID: <5526A979.1010905@kernel.org>
Date: Thu, 09 Apr 2015 17:31:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 6/6] iio: sx9500: fix formatting
References: <1428065254-6444-1-git-send-email-vlad.dogaru@intel.com> <1428065254-6444-7-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1428065254-6444-7-git-send-email-vlad.dogaru@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/04/15 13:47, Vlad Dogaru wrote:
> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
Trivial and applies fine so applied to the togreg branch of iio.git
so we can both forget about it ;)
> ---
>  drivers/iio/proximity/sx9500.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> index 9738df1..2156037 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -1014,7 +1014,7 @@ MODULE_DEVICE_TABLE(acpi, sx9500_acpi_match);
>  
>  static const struct i2c_device_id sx9500_id[] = {
>  	{"sx9500", 0},
> -	{}
> +	{ },
>  };
>  MODULE_DEVICE_TABLE(i2c, sx9500_id);
>  
> 

