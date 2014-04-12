Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44492 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbaDLRiV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Apr 2014 13:38:21 -0400
Message-ID: <53497A5B.5010709@kernel.org>
Date: Sat, 12 Apr 2014 18:39:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Michael Welling <mwelling@ieee.org>, linux-iio@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jon.Brenner@ams.com
Subject: Re: [PATCH 3/3] Staging: iio: Switch from msleep to usleep range
 per timers-howto.txt
References: <1397096805-25168-1-git-send-email-mwelling@ieee.org> <1397096805-25168-4-git-send-email-mwelling@ieee.org>
In-Reply-To: <1397096805-25168-4-git-send-email-mwelling@ieee.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/04/14 03:26, Michael Welling wrote:
> Signed-off-by: Michael Welling <mwelling@ieee.org>
Hmm. I wonder if this is a little too tight on the range, but
given it is in a function that is likely to be called infrequently
it doesn't really matter.  Note this is where we find out whether
the datasheet is actually accurate is saying 3 msecs is long enough
by whether anyone screams :)

Also cc'd Jon as if anyone screams about this they are likely to do it
at him.  As a general rule, do cc the original author unless you know
there email bounces (and if so mention it in the cover letter as someone
might know where to get hold of them).

Applied to the togreg branch of iio.git - initially pushed out as testing.

Thanks,

Jonathan
> ---
>   drivers/staging/iio/light/tsl2583.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index f015fb4..fa96498 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -451,7 +451,7 @@ static int taos_chip_on(struct iio_dev *indio_dev)
>   		}
>   	}
>
> -	msleep(3);
> +	usleep_range(3000, 3500);
>   	/* NOW enable the ADC
>   	 * initialize the desired mode of operation */
>   	utmp = TSL258X_CNTL_PWR_ON | TSL258X_CNTL_ADC_ENBL;
>

