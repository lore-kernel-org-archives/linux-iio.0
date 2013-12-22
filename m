Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46797 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296Ab3LVQCa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 Dec 2013 11:02:30 -0500
Message-ID: <52B70D15.5030006@kernel.org>
Date: Sun, 22 Dec 2013 16:02:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/1] staging: iio: hmc5843: Remove redundant of_match_ptr
 helper
References: <1387620148-27989-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1387620148-27989-1-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/21/13 10:02, Sachin Kamat wrote:
> 'hmc5843_of_match' is always compiled in. Hence the helper
> macro is not needed.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/staging/iio/magnetometer/hmc5843.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index 8802f72bedde..d4f4dd90c699 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -639,7 +639,7 @@ static struct i2c_driver hmc5843_driver = {
>  	.driver = {
>  		.name	= "hmc5843",
>  		.pm	= HMC5843_PM_OPS,
> -		.of_match_table = of_match_ptr(hmc5843_of_match),
> +		.of_match_table = hmc5843_of_match,
>  	},
>  	.id_table	= hmc5843_id,
>  	.probe		= hmc5843_probe,
> 
