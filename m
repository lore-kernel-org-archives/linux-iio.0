Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35827 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931AbbFAVRF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:17:05 -0400
Message-ID: <556C3221.5090001@kernel.org>
Date: Mon, 01 Jun 2015 11:21:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>,
	sudipm.mukherjee@gmail.com, daniel.baluta@intel.com,
	dan.carpenter@oracle.com, gregkh@linuxfoundation.org
CC: cristina.opriceana@gmail.com,
	driverdev-devel@linuxdriverproject.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/3] staging: iio_simple_dummy: fix init function
References: <1432974017-24547-1-git-send-email-rodriguez.twister@gmail.com> <1432974017-24547-2-git-send-email-rodriguez.twister@gmail.com>
In-Reply-To: <1432974017-24547-2-git-send-email-rodriguez.twister@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/05/15 09:20, Vladimirs Ambrosovs wrote:
> This patch fixes the init function for the iio_simple_dummy driver.
> The main issues were absence of kfree for the allocated array, and no
> devices being removed in case the probe function fails, running in a loop.
> 
> Signed-off-by: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
Thanks,

Applied to the togreg branch of iio.git which will get pushed
out as testing for the autobuilders to play with it once
I'm home from the fools errand I am currently on in a clean room
with no internet...

Jonathan
> ---
>  drivers/staging/iio/iio_simple_dummy.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
> index b47bf9f..d0a9963 100644
> --- a/drivers/staging/iio/iio_simple_dummy.c
> +++ b/drivers/staging/iio/iio_simple_dummy.c
> @@ -722,9 +722,16 @@ static __init int iio_dummy_init(void)
>  	for (i = 0; i < instances; i++) {
>  		ret = iio_dummy_probe(i);
>  		if (ret < 0)
> -			return ret;
> +			goto error_remove_devs;
>  	}
>  	return 0;
> +
> +error_remove_devs:
> +	while (i--)
> +		iio_dummy_remove(i);
> +
> +	kfree(iio_dummy_devs);
> +	return ret;
>  }
>  module_init(iio_dummy_init);
>  
> 

