Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39244 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756189AbbBHMEi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Feb 2015 07:04:38 -0500
Message-ID: <54D750D2.9080601@kernel.org>
Date: Sun, 08 Feb 2015 12:04:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
	Hartmut Knaack <knaack.h@gmx.de>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Josef Gajdusek <atx@atalax.net>,
	Teodora Baluta <teodora.baluta@intel.com>,
	Marek Belisko <marek@goldelico.com>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: magnetometer: hmc5843_core: Change type
 in printf format string
References: <1422397297-9206-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1422397297-9206-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/01/15 22:21, Rickard Strandqvist wrote:
> Wrong type in printf format string, requires 'int'
> but the argument type is 'unsigned int'
> 
> This was found using a static code analysis program called cppcheck
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
This one is fixed to I'm afraid.  Very bad luck on timing as 2 weeks ago you'd have
been first to post a patch for it.
> ---
>  drivers/staging/iio/magnetometer/hmc5843_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843_core.c b/drivers/staging/iio/magnetometer/hmc5843_core.c
> index fd171d8..cd049bb 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843_core.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843_core.c
> @@ -217,7 +217,7 @@ static ssize_t hmc5843_show_measurement_configuration(struct device *dev,
>  		return ret;
>  	val &= HMC5843_MEAS_CONF_MASK;
>  
> -	return sprintf(buf, "%d\n", val);
> +	return sprintf(buf, "%u\n", val);
>  }
>  
>  static ssize_t hmc5843_set_measurement_configuration(struct device *dev,
> 

