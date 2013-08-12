Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34973 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755993Ab3HLKN2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 12 Aug 2013 06:13:28 -0400
Message-ID: <5208C369.20303@kernel.org>
Date: Mon, 12 Aug 2013 12:13:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Restore alphabetic order in Makefile
References: <1375979988-16697-1-git-send-email-pmeerw@pmeerw.net> <1375979988-16697-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1375979988-16697-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/08/13 17:39, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git. Thanks,
> ---
>  drivers/iio/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 161f769..7c85a4b 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -23,6 +23,6 @@ obj-y += frequency/
>  obj-y += imu/
>  obj-y += light/
>  obj-y += magnetometer/
> +obj-y += pressure/
>  obj-y += temperature/
>  obj-y += trigger/
> -obj-y += pressure/
> 
