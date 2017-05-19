Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36845 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754506AbdESV5t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 May 2017 17:57:49 -0400
Received: by mail-qk0-f175.google.com with SMTP id u75so71670869qka.3
        for <linux-iio@vger.kernel.org>; Fri, 19 May 2017 14:57:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170519212853.151172-1-mka@chromium.org>
References: <20170519212853.151172-1-mka@chromium.org>
From: Guenter Roeck <groeck@google.com>
Date: Fri, 19 May 2017 14:57:48 -0700
Message-ID: <CABXOdTeyRJigdSr6EsUTcoc6t6nCBP1u9nMPYTt5_+t-BZ3MnA@mail.gmail.com>
Subject: Re: [PATCH] iio: light: isl29018: Only declare ACPI table when ACPI
 is enabled
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Brian Masney <masneyb@onstation.org>,
        linux-iio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, May 19, 2017 at 2:28 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> This fixes the following warning when building with clang:
>
> drivers/iio/light/isl29018.c:808:36: error: variable
>     'isl29018_acpi_match' is not needed and will not be emitted
>     [-Werror,-Wunneeded-internal-declaration]
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/iio/light/isl29018.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
> index 917dd8b43e72..61f5924b472d 100644
> --- a/drivers/iio/light/isl29018.c
> +++ b/drivers/iio/light/isl29018.c
> @@ -807,6 +807,7 @@ static SIMPLE_DEV_PM_OPS(isl29018_pm_ops, isl29018_suspend, isl29018_resume);
>  #define ISL29018_PM_OPS NULL
>  #endif
>
> +#ifdef CONFIG_ACPI
>  static const struct acpi_device_id isl29018_acpi_match[] = {
>         {"ISL29018", isl29018},
>         {"ISL29023", isl29023},
> @@ -814,6 +815,7 @@ static const struct acpi_device_id isl29018_acpi_match[] = {
>         {},
>  };
>  MODULE_DEVICE_TABLE(acpi, isl29018_acpi_match);
> +#endif
>
>  static const struct i2c_device_id isl29018_id[] = {
>         {"isl29018", isl29018},
> --
> 2.13.0.303.g4ebf302169-goog
>
