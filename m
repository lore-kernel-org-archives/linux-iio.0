Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45244 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579Ab3GIVOM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Jul 2013 17:14:12 -0400
Message-ID: <51DC7D1F.3060901@kernel.org>
Date: Tue, 09 Jul 2013 22:14:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/5] iio staging: fix lis3l02dq, read error handling
References: <1373228646-5356-1-git-send-email-pmeerw@pmeerw.net> <1373228646-5356-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1373228646-5356-4-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/07/2013 09:24 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the fixes-togreg branch of iio.git

Peter, just as an aside please separate out actual code
fixes like this one into separate series from the comment typo fixes.
Whilst both are worthwhile, comment typos can always wait for the
next merge window, but code fixes want to go in asap and perhaps
back into stable.
> ---
>  drivers/staging/iio/accel/lis3l02dq_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
> index 1bfe5d8..8ed75a9 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_core.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_core.c
> @@ -257,6 +257,8 @@ static int lis3l02dq_read_raw(struct iio_dev *indio_dev,
>  			ret = lis3l02dq_read_reg_s16(indio_dev, reg, val);
>  		}
>  		mutex_unlock(&indio_dev->mlock);
> +		if (ret < 0)
> +			goto error_ret;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 0;
> 
