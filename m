Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-084.synserver.de ([212.40.185.84]:1062 "EHLO
	smtp-out-080.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751601AbbEBRsw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 May 2015 13:48:52 -0400
Message-ID: <55450E00.6050403@metafoo.de>
Date: Sat, 02 May 2015 19:48:48 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: ad7606_par: Constify platform_device_id
References: <1430495002-31057-1-git-send-email-k.kozlowski.k@gmail.com>
In-Reply-To: <1430495002-31057-1-git-send-email-k.kozlowski.k@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/01/2015 05:43 PM, Krzysztof Kozlowski wrote:
> The platform_device_id is not modified by the driver and core uses it as
> const.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> ---
>   drivers/staging/iio/adc/ad7606_par.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
> index 9e24b4d4455f..1d48ae381d16 100644
> --- a/drivers/staging/iio/adc/ad7606_par.c
> +++ b/drivers/staging/iio/adc/ad7606_par.c
> @@ -119,7 +119,7 @@ static const struct dev_pm_ops ad7606_pm_ops = {
>   #define AD7606_PAR_PM_OPS NULL
>   #endif  /* CONFIG_PM */
>
> -static struct platform_device_id ad7606_driver_ids[] = {
> +static const struct platform_device_id ad7606_driver_ids[] = {
>   	{
>   		.name		= "ad7606-8",
>   		.driver_data	= ID_AD7606_8,
>

