Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44069 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753433AbbFUNyx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 09:54:53 -0400
Message-ID: <5586C22C.7000307@kernel.org>
Date: Sun, 21 Jun 2015 14:54:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
CC: stephan.kleisinger@gmail.com
Subject: Re: [PATCH] iio: light: tcs3414: Fix bug preventing to set integration
 time
References: <1434316175-24657-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1434316175-24657-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/06/15 22:09, Peter Meerwald wrote:
> the millisecond values in tcs3414_times should be checked against
> val2, not val, which is always zero.
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Reported-by: Stephan Kleisinger <stephan.kleisinger@gmail.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/light/tcs3414.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
> index 71c2bde..f8b1df0 100644
> --- a/drivers/iio/light/tcs3414.c
> +++ b/drivers/iio/light/tcs3414.c
> @@ -185,7 +185,7 @@ static int tcs3414_write_raw(struct iio_dev *indio_dev,
>  		if (val != 0)
>  			return -EINVAL;
>  		for (i = 0; i < ARRAY_SIZE(tcs3414_times); i++) {
> -			if (val == tcs3414_times[i] * 1000) {
> +			if (val2 == tcs3414_times[i] * 1000) {
>  				data->timing &= ~TCS3414_INTEG_MASK;
>  				data->timing |= i;
>  				return i2c_smbus_write_byte_data(
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
