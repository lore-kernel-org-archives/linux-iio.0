Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49878 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbaJYTLF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 25 Oct 2014 15:11:05 -0400
Message-ID: <544B7130.4000506@kernel.org>
Date: Sat, 25 Oct 2014 10:45:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] bmp280: use correct routine for division
References: <1414075979-5831-1-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1414075979-5831-1-git-send-email-vlad.dogaru@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/10/14 15:52, Vlad Dogaru wrote:
> The proper way to divide two signed 64-bit values is to use div64_s64.
> 
> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
Applied to the togreg branch of iio.git - initially pushed out as testing.
Thanks,.

Jonathan
> ---
> 
> Since v1: fix typo in commit message.
> 
>  drivers/iio/pressure/bmp280.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
> index fb91cb3..ce29ff9 100644
> --- a/drivers/iio/pressure/bmp280.c
> +++ b/drivers/iio/pressure/bmp280.c
> @@ -239,7 +239,7 @@ static u32 bmp280_compensate_press(struct bmp280_data *data,
>  		return 0;
>  
>  	p = ((((s64) 1048576 - adc_press) << 31) - var2) * 3125;
> -	do_div(p, var1);
> +	p = div64_s64(p, var1);
>  	var1 = (((s64) comp->dig_p9) * (p >> 13) * (p >> 13)) >> 25;
>  	var2 = (((s64) comp->dig_p8) * p) >> 19;
>  	p = ((p + var1 + var2) >> 8) + (((s64) comp->dig_p7) << 4);
> 
