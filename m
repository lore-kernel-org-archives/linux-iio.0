Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58802 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654Ab3JTUhn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Oct 2013 16:37:43 -0400
Message-ID: <52644D4D.9080309@kernel.org>
Date: Sun, 20 Oct 2013 22:38:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
CC: ldewangan@nvidia.com
Subject: Re: [PATCH] iio: Correct description how to convert microtesla to
 gauss
References: <1382203063-31141-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1382203063-31141-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/19/13 18:17, Peter Meerwald wrote:
> this just fixes the comment; however, I'm not sure if the driver reports
> measurements correctly; the raw values are 0.3 uT / LSB; IIO is supposed
> to report magnetic fields in Gauss, so the scale should be around 1/300
> (ignoring ASA) -- but value and scale are returned as VAL_INT
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git

Thanks,
> 
> ---
>  drivers/iio/magnetometer/ak8975.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 7105f22..ff284e5 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -263,7 +263,7 @@ static int ak8975_setup(struct i2c_client *client)
>   *
>   * HuT = H * 1229/4096, or roughly, 3/10.
>   *
> - * Since 1uT = 100 gauss, our final scale factor becomes:
> + * Since 1uT = 0.01 gauss, our final scale factor becomes:
>   *
>   * Hadj = H * ((ASA + 128) / 256) * 3/10 * 100
>   * Hadj = H * ((ASA + 128) * 30 / 256
> 
