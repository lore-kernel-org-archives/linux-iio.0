Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from antcom.de ([188.40.178.216]:53051 "EHLO chuck.antcom.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754053Ab2FGKPe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 7 Jun 2012 06:15:34 -0400
Message-ID: <4FD07F42.5060007@antcom.de>
Date: Thu, 07 Jun 2012 12:15:30 +0200
From: Roland Stigge <stigge@antcom.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: remove indio_dev pointer from max517_data
References: <1339057907-17381-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339057907-17381-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/06/12 10:31, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>

Acked-by: Roland Stigge <stigge@antcom.de>

> ---
>  drivers/iio/dac/max517.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
> index 92c77c8..352abe2 100644
> --- a/drivers/iio/dac/max517.c
> +++ b/drivers/iio/dac/max517.c
> @@ -43,7 +43,6 @@ enum max517_device_ids {
>  };
>  
>  struct max517_data {
> -	struct iio_dev		*indio_dev;
>  	struct i2c_client	*client;
>  	unsigned short		vref_mv[2];
>  };

