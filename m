Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54667 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab2GCRaO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 Jul 2012 13:30:14 -0400
Message-ID: <4FF32C26.5000303@kernel.org>
Date: Tue, 03 Jul 2012 18:30:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio staging: missing newline in printf
References: <1341096463-13789-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1341096463-13789-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/30/2012 11:47 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Merged thanks.
> ---
>  drivers/staging/iio/Documentation/iio_utils.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
> index 5244fa0..cf32ae0 100644
> --- a/drivers/staging/iio/Documentation/iio_utils.h
> +++ b/drivers/staging/iio/Documentation/iio_utils.h
> @@ -453,7 +453,7 @@ inline int find_type_by_name(const char *name, const char *type)
>  
>  	dp = opendir(iio_dir);
>  	if (dp == NULL) {
> -		printf("No industrialio devices available");
> +		printf("No industrialio devices available\n");
>  		return -ENODEV;
>  	}
>  
> 


