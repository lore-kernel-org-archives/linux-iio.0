Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47996 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbbADKgR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Jan 2015 05:36:17 -0500
Message-ID: <54A9179B.1000505@kernel.org>
Date: Sun, 04 Jan 2015 10:36:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Stefan Wahren <stefan.wahren@i2se.com>
CC: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH RFC] iio: inkern: add out of range error message
References: <1420136004-2058-1-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1420136004-2058-1-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/01/15 18:13, Stefan Wahren wrote:
> If the DT contains an invalid channel specifier then the probe of
> iio_hwmon fails with the following message:
> 
> iio_hwmon: probe of iio_hwmon failed with error -22
> 
> So it's better to print out the relevant channel specifier in
> error case to locate the problem.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Seems sensible.  Applied to the togreg branch of iio.git.
> ---
>  drivers/iio/inkern.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 866fe90..30a8d9c 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -116,8 +116,11 @@ static int __of_iio_simple_xlate(struct iio_dev *indio_dev,
>  	if (!iiospec->args_count)
>  		return 0;
>  
> -	if (iiospec->args[0] >= indio_dev->num_channels)
> +	if (iiospec->args[0] >= indio_dev->num_channels) {
> +		dev_err(&indio_dev->dev, "invalid channel index %u\n",
> +			iiospec->args[0]);
>  		return -EINVAL;
> +	}
>  
>  	return iiospec->args[0];
>  }
> 

