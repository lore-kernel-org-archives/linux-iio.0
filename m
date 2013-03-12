Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:58755 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454Ab3CLQOg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 12 Mar 2013 12:14:36 -0400
Received: by mail-la0-f47.google.com with SMTP id fj20so15446lab.6
        for <linux-iio@vger.kernel.org>; Tue, 12 Mar 2013 09:14:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1362625743-10401-1-git-send-email-ch.naveen@samsung.com>
References: <1362625743-10401-1-git-send-email-ch.naveen@samsung.com>
Date: Tue, 12 Mar 2013 09:14:34 -0700
Message-ID: <CAD=FV=W4yYZYBT5=PY2VUsdz-zNAm=jnnw_SZzwjWzm_FuViLQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: exynos5_adc: fix compilation warnings
From: Doug Anderson <dianders@chromium.org>
To: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: linux-iio <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-samsung-soc@vger.kernel.org, gregkh@linuxfoundation.org,
	Naveen Krishna <naveenkrishna.ch@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Naveen,

On Wed, Mar 6, 2013 at 7:09 PM, Naveen Krishna Chatradhi
<ch.naveen@samsung.com> wrote:
> -       unsigned int            version;
> +       unsigned int            version;

Given that you've changed exynos_adc_get_version() to return an int,
shouldn't this be an int too (not unsigned)?


> -static inline unsigned int exynos_adc_get_version(struct platform_device *pdev)
> +static inline int exynos_adc_get_version(struct platform_device *pdev)
>  {
>         const struct of_device_id *match;
>
>         match = of_match_node(exynos_adc_match, pdev->dev.of_node);
> -       return (unsigned int)match->data;
> +       return (int)match->data;

Given that you're now checking for an error code below it seems like
you ought to generate one here.  ;)
...AKA: return an error if match is NULL--don't dereference NULL.


>  static int exynos_read_raw(struct iio_dev *indio_dev,
> @@ -117,7 +117,7 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
>                                 long mask)
>  {
>         struct exynos_adc *info = iio_priv(indio_dev);
> -       unsigned long timeout;
> +       int timeout;

Why change this to an "int" when
wait_for_completion_interruptible_timeout() returns a long?  I agree
with the removal of the "unsigned", though.


> +       version = exynos_adc_get_version(pdev);
> +       if (version < 0) {
> +               dev_err(&pdev->dev, "no matching of_node, err = %d\n", version);
> +               ret = version;
> +               goto err_iio;
> +       }
> +
> +       info->version = version;

Optional (and perhaps a matter of preference): I'd eliminate the
"version" variable here and just re-use "ret" for storing the result
of exynos_adc_get_version().


-Doug
