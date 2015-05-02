Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:56639 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876AbbEBPcI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 2 May 2015 11:32:08 -0400
Message-ID: <56744.10.252.205.185.1430580699.squirrel@linux.intel.com>
In-Reply-To: <1430562348-27802-1-git-send-email-jic23@kernel.org>
References: <1430562348-27802-1-git-send-email-jic23@kernel.org>
Date: Sat, 2 May 2015 08:31:39 -0700 (PDT)
Subject: Re: [PATCH] iio:light:ltr501 bug in parameter sanity check.
From: "Kuppuswamy Sathyanarayanan"
	<sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Jonathan Cameron" <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, "Jonathan Cameron" <jic23@kernel.org>,
	"Kuppuswamy Sathyanarayanan"
	<sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Daniel Baluta" <daniel.baluta@intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Good find. Please proceed with merge.

Acked-by: Kuppuswamy Sathyanarayanan 
sathyanarayanan.kuppuswamy@linux.intel.com>

> Clearly the intent was to error if the value was not 0 or 1.
> As implemented we have (A != 0 || A != 1) which is always true
> as A is never both 0 and 1 at the same time.
>
> As the autobuilder suggested, && makes more sense for this error
> check.
>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Cc: Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: Daniel Baluta <daniel.baluta@intel.com>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
> This is obvious enough that I'll probably apply it shortly whether or
> not I get Acks.  However, Acks always good!
>
> drivers/iio/light/ltr501.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index ca4bf470a332..280eff19b872 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -976,7 +976,7 @@ static int ltr501_write_event_config(struct iio_dev
> *indio_dev,
>  	int ret;
>
>  	/* only 1 and 0 are valid inputs */
> -	if (state != 1  || state != 0)
> +	if (state != 1  && state != 0)
>  		return -EINVAL;
>
>  	switch (chan->type) {
> --
> 2.3.5
>
>


-- 
Sathyanarayanan Kuppuswamy
