Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36910 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbcF2Qdy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jun 2016 12:33:54 -0400
Received: by mail-wm0-f47.google.com with SMTP id a66so81905016wme.0
        for <linux-iio@vger.kernel.org>; Wed, 29 Jun 2016 09:33:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1467202118-10386-6-git-send-email-linus.walleij@linaro.org>
References: <1467202118-10386-1-git-send-email-linus.walleij@linaro.org> <1467202118-10386-6-git-send-email-linus.walleij@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 29 Jun 2016 18:33:51 +0200
Message-ID: <CAPDyKFpLqdQkNZjzV7nDNF-FTHkDbMDczHnFn=BOWdKx1oVxGw@mail.gmail.com>
Subject: Re: [PATCH 5/6 v3] iio: magn: ak8975: make sure to power down at remove()
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Richard Leitner <dev@g0hl1n.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29 June 2016 at 14:08, Linus Walleij <linus.walleij@linaro.org> wrote:
> The code was not powering the magnetometer down properly at
> remove(): just cutting the regulators without first setting the
> device in power off mode. Fix this.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> ChangeLog v2->v3:
> - Rebase
> ChangeLog v1->v2:
> - New patch in the series after Ulf's review comment that this
>   should be separate.
> ---
>  drivers/iio/magnetometer/ak8975.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index c67cf3a6128d..43dc1c74be9e 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -990,6 +990,7 @@ static int ak8975_remove(struct i2c_client *client)
>
>         iio_device_unregister(indio_dev);
>         iio_triggered_buffer_cleanup(indio_dev);
> +       ak8975_set_mode(data, POWER_DOWN);
>         ak8975_power_off(data);
>
>         return 0;
> --
> 2.4.11
>
