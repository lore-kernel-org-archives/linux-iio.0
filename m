Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:43626 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755939Ab3DCR1m (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Apr 2013 13:27:42 -0400
Received: by mail-pd0-f180.google.com with SMTP id q11so965274pdj.39
        for <linux-iio@vger.kernel.org>; Wed, 03 Apr 2013 10:27:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1364970239-8242-2-git-send-email-sachin.kamat@linaro.org>
References: <1364970239-8242-1-git-send-email-sachin.kamat@linaro.org> <1364970239-8242-2-git-send-email-sachin.kamat@linaro.org>
From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Date: Wed, 3 Apr 2013 10:27:21 -0700
Message-ID: <CAHfPSqBvX8WFR6Up7mEior1USYZ=723MMNB+cFHrh8P6gv4YBQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] adc: exynos_adc: Fix incorrect variable type
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-iio@vger.kernel.org, jic23@cam.ac.uk, jic23@kernel.org,
	My self <ch.naveen@samsung.com>, patches@linaro.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2 April 2013 23:23, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> wait_for_completion_interruptible_timeout() returns negative value on error
> but is assigned to an unsigned variable. Though this might not matter much
> as the return value is only tested for '0', for the sake of code correctness
> modify the variable type suitably. Without this patch we get the following
> smatch error:
> drivers/iio/adc/exynos_adc.c:147 exynos_read_raw() error:
> 'wait_for_completion_interruptible_timeout()' returns negative and
> 'timeout' is unsigned
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/iio/adc/exynos_adc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index 22d034a..3bf5132 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -118,7 +118,7 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
>                                 long mask)
>  {
>         struct exynos_adc *info = iio_priv(indio_dev);
> -       unsigned long timeout;
> +       long timeout;
Sachin thank you for your efforts.

Apart from just changing it to long. we seem to have other corner cases
and a CL is under discussion https://patchwork.kernel.org/patch/2279591/

Doug, has replied on it as of today. We will come back with that CL soon.
>         u32 con1, con2;
>
>         if (mask != IIO_CHAN_INFO_RAW)
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
Shine bright,
(: Nav :)
