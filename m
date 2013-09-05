Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:33173 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752581Ab3IETRo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 5 Sep 2013 15:17:44 -0400
Message-ID: <5228D8FA.6000301@metafoo.de>
Date: Thu, 05 Sep 2013 21:18:18 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 01/18] staging:iio:hmc5843: Fix measurement conversion
References: <1378170320-27538-1-git-send-email-pmeerw@pmeerw.net> <1378170320-27538-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1378170320-27538-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/03/2013 03:05 AM, Peter Meerwald wrote:
> recently broken, cd6fe06588423ff4cca85c85c4402027b04dccf1

When referring to a commit usually the commit title is also mentioned after the 
commit id. E.g. 12345678 ("abc foobar")

>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> ---
>   drivers/staging/iio/magnetometer/hmc5843.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index d2748c3..c3f3f53 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -229,7 +229,7 @@ static int hmc5843_read_measurement(struct iio_dev *indio_dev,
>   	if (result < 0)
>   		return -EINVAL;
>
> -	*val = result;
> +	*val = sign_extend32(result, 15);
>   	return IIO_VAL_INT;
>   }
>
>

