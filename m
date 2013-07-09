Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45272 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887Ab3GIVPi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Jul 2013 17:15:38 -0400
Message-ID: <51DC7D79.5060505@kernel.org>
Date: Tue, 09 Jul 2013 22:15:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: fix typo, Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
References: <1373228646-5356-1-git-send-email-pmeerw@pmeerw.net> <1373228646-5356-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1373228646-5356-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/07/2013 09:24 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
> index d89aded..1254457 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
> @@ -18,4 +18,4 @@ Description:
>  		adjust the reference frequency accordingly.
>  		The value written has no effect until out_altvoltageY_frequency
>  		is updated. Consider to use out_altvoltageY_powerdown to power
> -		down the PLL and it's RFOut buffers during REFin changes.
> +		down the PLL and its RFOut buffers during REFin changes.
> 
