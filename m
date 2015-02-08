Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39193 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013AbbBHMAF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Feb 2015 07:00:05 -0500
Message-ID: <54D74FBF.7010000@kernel.org>
Date: Sun, 08 Feb 2015 11:59:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
	Hartmut Knaack <knaack.h@gmx.de>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joel Porquet <joel@porquet.org>,
	Darshana Padmadas <darshanapadmadas@gmail.com>,
	Catalina Mocanu <catalina.mocanu@gmail.com>,
	Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: trigger: iio-trig-periodic-rtc: Change
 type in printf format string
References: <1422394348-8057-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1422394348-8057-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/01/15 21:32, Rickard Strandqvist wrote:
> Wrong type in printf format string, requires 'unsigned int'
> but the argument type is 'int'
> 
> This was found using a static code analysis program called cppcheck
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Whilst you have identified a bug, I think the better fix would be to take frequency unsigned.
It is always treated as such in the driver so they type should probably reflect this.

If you want to put together such a patch that would be great. If not I'll
get to it at some point (probably!)
> ---
>  drivers/staging/iio/trigger/iio-trig-periodic-rtc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> index a24caf7..66d54a0 100644
> --- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> +++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> @@ -52,7 +52,7 @@ static ssize_t iio_trig_periodic_read_freq(struct device *dev,
>  	struct iio_trigger *trig = to_iio_trigger(dev);
>  	struct iio_prtc_trigger_info *trig_info = iio_trigger_get_drvdata(trig);
>  
> -	return sprintf(buf, "%u\n", trig_info->frequency);
> +	return sprintf(buf, "%d\n", trig_info->frequency);
>  }
>  
>  static ssize_t iio_trig_periodic_write_freq(struct device *dev,
> 

