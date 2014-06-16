Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:33511 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755540AbaFPTxw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 16 Jun 2014 15:53:52 -0400
Message-ID: <539F4BC3.3060908@kernel.org>
Date: Mon, 16 Jun 2014 20:55:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: AK09911 : Remove duplicate indio_dev->name assignment
References: <1402945277-12721-1-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1402945277-12721-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/06/14 20:01, Srinivas Pandruvada wrote:
> Need to remove indio_dev->name assignment for id->name as id can
> be NULL. Copy paste bug from ak8975.c where it was fixed later.
>
> kbuild test robot errors:
> error: we previously assumed 'id' could be null (see line 288)
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the togreg branch of iio.git as a fixup to the original driver
patch (as that was last in the tree and I hadn't pushed it out properly yet ;)

Thanks,
> ---
>   drivers/iio/magnetometer/ak09911.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/iio/magnetometer/ak09911.c b/drivers/iio/magnetometer/ak09911.c
> index 62f980c..b2bc942 100644
> --- a/drivers/iio/magnetometer/ak09911.c
> +++ b/drivers/iio/magnetometer/ak09911.c
> @@ -298,7 +298,6 @@ static int ak09911_probe(struct i2c_client *client,
>   	indio_dev->channels = ak09911_channels;
>   	indio_dev->num_channels = ARRAY_SIZE(ak09911_channels);
>   	indio_dev->info = &ak09911_info;
> -	indio_dev->name = id->name;
>   	indio_dev->modes = INDIO_DIRECT_MODE;
>   	indio_dev->name = name;
>
>

