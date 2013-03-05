Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:49160 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448Ab3CEXoZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Mar 2013 18:44:25 -0500
Received: by mail-pb0-f54.google.com with SMTP id rr4so5151735pbb.13
        for <linux-iio@vger.kernel.org>; Tue, 05 Mar 2013 15:44:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1362341033-9506-2-git-send-email-jic23@kernel.org>
References: <1362341033-9506-1-git-send-email-jic23@kernel.org> <1362341033-9506-2-git-send-email-jic23@kernel.org>
From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Date: Wed, 6 Mar 2013 08:44:04 +0900
Message-ID: <CAHfPSqC95ahh6O9Fk0N06gw9tQxGPKsU943KNYTXCM+vP465Eg@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio:adc:exynos move to info_mask_(shared_by_type/separate)
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 4 March 2013 05:03, Jonathan Cameron <jic23@kernel.org> wrote:
> The original info_mask is going away in favour of the broken out versions.
>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Thanks, Jonathan.
> ---
>  drivers/iio/adc/exynos_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index ed6fdd7..6e968ae 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -198,7 +198,7 @@ static const struct iio_info exynos_adc_iio_info = {
>         .indexed = 1,                                   \
>         .channel = _index,                              \
>         .address = _index,                              \
> -       .info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,    \
> +       .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),   \
>         .datasheet_name = _id,                          \
>  }
>
> --
> 1.8.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
Shine bright,
(: Nav :)
