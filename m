Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:45299 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932751Ab1JZMCO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 26 Oct 2011 08:02:14 -0400
Message-ID: <4EA7F6CC.6050909@cam.ac.uk>
Date: Wed, 26 Oct 2011 13:02:20 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 1/2] staging:iio: Make write_event_value callback optional
References: <1319630467-6924-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1319630467-6924-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/26/11 13:01, Lars-Peter Clausen wrote:
> Some devices have fixed thresholds which can not be modified so make the
> write_event_value callback optional, so the drivers for these devices do not
> have to implement a boilerplate no-op callback.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/industrialio-core.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
> index cfa4fcb..d2eea07 100644
> --- a/drivers/staging/iio/industrialio-core.c
> +++ b/drivers/staging/iio/industrialio-core.c
> @@ -782,6 +782,9 @@ static ssize_t iio_ev_value_store(struct device *dev,
>  	unsigned long val;
>  	int ret;
>  
> +	if (!indio_dev->info->write_event_value)
> +		return -EINVAL;
> +
>  	ret = strict_strtoul(buf, 10, &val);
>  	if (ret)
>  		return ret;

