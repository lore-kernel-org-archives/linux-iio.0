Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35561 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754106Ab3JXMnU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Oct 2013 08:43:20 -0400
Message-ID: <52692424.1040804@kernel.org>
Date: Thu, 24 Oct 2013 14:44:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/9] iio: core: Add misssing braces
References: <1382615615-20153-1-git-send-email-sachin.kamat@linaro.org> <1382615615-20153-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382615615-20153-2-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/24/13 12:53, Sachin Kamat wrote:
> Silences the following checkpatch warning:
> WARNING: sizeof *iio_attr should be sizeof(*iio_attr)
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to the togreg branch of iio.git

> ---
>  drivers/iio/industrialio-core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index e4780b4..18f72e3 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -685,7 +685,7 @@ int __iio_add_chan_devattr(const char *postfix,
>  	int ret;
>  	struct iio_dev_attr *iio_attr, *t;
>  
> -	iio_attr = kzalloc(sizeof *iio_attr, GFP_KERNEL);
> +	iio_attr = kzalloc(sizeof(*iio_attr), GFP_KERNEL);
>  	if (iio_attr == NULL) {
>  		ret = -ENOMEM;
>  		goto error_ret;
> 
