Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33396 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbbFOFmc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Jun 2015 01:42:32 -0400
Received: by igbos3 with SMTP id os3so10937566igb.0
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2015 22:42:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1434316175-24657-1-git-send-email-pmeerw@pmeerw.net>
References: <1434316175-24657-1-git-send-email-pmeerw@pmeerw.net>
Date: Mon, 15 Jun 2015 11:12:31 +0530
Message-ID: <CAM=Q2ctzDwAGfCipu2PoaE-vbnoag2K+1sAUOrDO8pwbqb1sgA@mail.gmail.com>
Subject: Re: [PATCH] iio: light: tcs3414: Fix bug preventing to set
 integration time
From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jun 15, 2015 at 2:39 AM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
> the millisecond values in tcs3414_times should be checked against
> val2, not val, which is always zero.
nit :

may be the variable name could be little more descriptive.

>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Reported-by: Stephan Kleisinger <stephan.kleisinger@gmail.com>
> ---
>  drivers/iio/light/tcs3414.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
> index 71c2bde..f8b1df0 100644
> --- a/drivers/iio/light/tcs3414.c
> +++ b/drivers/iio/light/tcs3414.c
> @@ -185,7 +185,7 @@ static int tcs3414_write_raw(struct iio_dev *indio_dev,
>                 if (val != 0)
>                         return -EINVAL;
>                 for (i = 0; i < ARRAY_SIZE(tcs3414_times); i++) {
> -                       if (val == tcs3414_times[i] * 1000) {
> +                       if (val2 == tcs3414_times[i] * 1000) {
>                                 data->timing &= ~TCS3414_INTEG_MASK;
>                                 data->timing |= i;
>                                 return i2c_smbus_write_byte_data(
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
