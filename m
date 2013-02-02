Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43351 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546Ab3BBJyK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Feb 2013 04:54:10 -0500
Message-ID: <510CE23C.3030603@kernel.org>
Date: Sat, 02 Feb 2013 09:54:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: linux-iio@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>
Subject: Re: [PATCH 03/11] staging/iio: (iio_hwmon) Basic devicetree support
References: <1359668588-13678-1-git-send-email-linux@roeck-us.net> <1359668588-13678-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1359668588-13678-4-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/31/2013 09:43 PM, Guenter Roeck wrote:
> Add 'iio-hwmon' OF compatibility table entry to enable OF matches.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Applied to togreg branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

Thanks,
> ---
>  drivers/staging/iio/iio_hwmon.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/staging/iio/iio_hwmon.c b/drivers/staging/iio/iio_hwmon.c
> index 7f260ea..6a5bc5f 100644
> --- a/drivers/staging/iio/iio_hwmon.c
> +++ b/drivers/staging/iio/iio_hwmon.c
> @@ -165,10 +165,16 @@ static int iio_hwmon_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static struct of_device_id iio_hwmon_of_match[] = {
> +	{ .compatible = "iio-hwmon", },
> +	{ }
> +};
> +
>  static struct platform_driver __refdata iio_hwmon_driver = {
>  	.driver = {
>  		.name = "iio_hwmon",
>  		.owner = THIS_MODULE,
> +		.of_match_table = iio_hwmon_of_match,
>  	},
>  	.probe = iio_hwmon_probe,
>  	.remove = iio_hwmon_remove,
> 
