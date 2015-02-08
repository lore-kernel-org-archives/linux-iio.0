Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39237 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756683AbbBHMDq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Feb 2015 07:03:46 -0500
Message-ID: <54D7509E.8030105@kernel.org>
Date: Sun, 08 Feb 2015 12:03:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
	Hartmut Knaack <knaack.h@gmx.de>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Mario Schuknecht <mario.schuknecht@dresearch-fe.de>,
	Aybuke Ozdemir <aybuke.147@gmail.com>,
	Tina Johnson <tinajohnson.1234@gmail.com>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: light: tsl2x7x_core: Change type in printf
 format string
References: <1422397204-9079-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1422397204-9079-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/01/15 22:20, Rickard Strandqvist wrote:
> Wrong type in printf format string, requires 'int'
> but the argument type is 'unsigned int'
> 
> This was found using a static code analysis program called cppcheck
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Another one with a fix already in place.
> ---
>  drivers/staging/iio/light/tsl2x7x_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
> index 423f96b..4a5dc26 100644
> --- a/drivers/staging/iio/light/tsl2x7x_core.c
> +++ b/drivers/staging/iio/light/tsl2x7x_core.c
> @@ -1147,7 +1147,7 @@ static ssize_t tsl2x7x_luxtable_show(struct device *dev,
>  	int offset = 0;
>  
>  	while (i < (TSL2X7X_MAX_LUX_TABLE_SIZE * 3)) {
> -		offset += snprintf(buf + offset, PAGE_SIZE, "%d,%d,%d,",
> +		offset += snprintf(buf + offset, PAGE_SIZE, "%u,%u,%u,",
>  			chip->tsl2x7x_device_lux[i].ratio,
>  			chip->tsl2x7x_device_lux[i].ch0,
>  			chip->tsl2x7x_device_lux[i].ch1);
> 

