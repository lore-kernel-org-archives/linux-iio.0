Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39276 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917AbbBHMGr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Feb 2015 07:06:47 -0500
Message-ID: <54D75154.4000904@kernel.org>
Date: Sun, 08 Feb 2015 12:06:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: resolver: ad2s1210: Change type in printf
 format string
References: <1422397354-9326-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1422397354-9326-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/01/15 22:22, Rickard Strandqvist wrote:
> Wrong type in printf format string, requires 'int'
> but the argument type is 'unsigned int'
> 
> This was found using a static code analysis program called cppcheck
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Finally one I don't already have a fix in place for!
Applied to the togreg branch of iio.git.
Note this will first get pushed out as staging when I get a few minutes at
home (no sign of my plane yet that was meant to leave an hour ago...)
> ---
>  drivers/staging/iio/resolver/ad2s1210.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index b4c14ba..a8ecf87 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -198,7 +198,7 @@ static ssize_t ad2s1210_show_fclkin(struct device *dev,
>  {
>  	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
>  
> -	return sprintf(buf, "%d\n", st->fclkin);
> +	return sprintf(buf, "%u\n", st->fclkin);
>  }
>  
>  static ssize_t ad2s1210_store_fclkin(struct device *dev,
> @@ -237,7 +237,7 @@ static ssize_t ad2s1210_show_fexcit(struct device *dev,
>  {
>  	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
>  
> -	return sprintf(buf, "%d\n", st->fexcit);
> +	return sprintf(buf, "%u\n", st->fexcit);
>  }
>  
>  static ssize_t ad2s1210_store_fexcit(struct device *dev,
> 

