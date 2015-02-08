Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39224 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261AbbBHMDM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Feb 2015 07:03:12 -0500
Message-ID: <54D7507C.1050106@kernel.org>
Date: Sun, 08 Feb 2015 12:03:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
	Hartmut Knaack <knaack.h@gmx.de>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Welling <mwelling@ieee.org>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Aybuke Ozdemir <aybuke.147@gmail.com>,
	Monam Agarwal <monamagarwal123@gmail.com>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: light: tsl2583: Change type in printf format
 string
References: <1422397145-8957-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1422397145-8957-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/01/15 22:19, Rickard Strandqvist wrote:
> Wrong type in printf format string, requires 'int'
> but the argument type is 'unsigned int'
> 
> This was found using a static code analysis program called cppcheck
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
This one is already fixed as well I'm afraid!
> ---
>  drivers/staging/iio/light/tsl2583.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index cc4ddcc..8afae8e 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -692,7 +692,7 @@ static ssize_t taos_luxtable_show(struct device *dev,
>  	int offset = 0;
>  
>  	for (i = 0; i < ARRAY_SIZE(taos_device_lux); i++) {
> -		offset += sprintf(buf + offset, "%d,%d,%d,",
> +		offset += sprintf(buf + offset, "%u,%u,%u,",
>  				  taos_device_lux[i].ratio,
>  				  taos_device_lux[i].ch0,
>  				  taos_device_lux[i].ch1);
> 

