Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49683 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbaAKQQK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jan 2014 11:16:10 -0500
Message-ID: <52D16E53.3050404@kernel.org>
Date: Sat, 11 Jan 2014 16:16:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
CC: kbuild test robot <fengguang.wu@intel.com>
Subject: Re: [PATCH] iio:pressure:mpl3115: Fix sparse cast to restricted __be32
 warning
References: <1389452093-16214-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1389452093-16214-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 11/01/14 14:54, Peter Meerwald wrote:
>>> drivers/iio/pressure/mpl3115.c:101:46: sparse: cast to restricted __be32
>>> drivers/iio/pressure/mpl3115.c:115:46: sparse: cast to restricted __be32
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: kbuild test robot <fengguang.wu@intel.com>
Applied ot the togreg branch of iio.git.
I upped the Cc to a reported-by to give the credit where it is due.

Thanks,
> ---
>   drivers/iio/pressure/mpl3115.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
> index ac8c8ab..ba6d0c5 100644
> --- a/drivers/iio/pressure/mpl3115.c
> +++ b/drivers/iio/pressure/mpl3115.c
> @@ -77,7 +77,7 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
>   			    int *val, int *val2, long mask)
>   {
>   	struct mpl3115_data *data = iio_priv(indio_dev);
> -	s32 tmp = 0;
> +	__be32 tmp = 0;
>   	int ret;
>
>   	switch (mask) {
>
