Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:36832 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752567AbcKJDQe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Nov 2016 22:16:34 -0500
Received: by mail-qt0-f171.google.com with SMTP id w33so139039521qtc.3
        for <linux-iio@vger.kernel.org>; Wed, 09 Nov 2016 19:16:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161109231231.6223-1-colin.king@canonical.com>
References: <20161109231231.6223-1-colin.king@canonical.com>
From: Guenter Roeck <groeck@google.com>
Date: Wed, 9 Nov 2016 19:16:32 -0800
Message-ID: <CABXOdTc4Ey+FQ2w9sHxrBirz-fDX9kF2uBi=T5bTQv-NNpZ-8Q@mail.gmail.com>
Subject: Re: [PATCH] iio: cros_ec_sensors_core: fix unsigned compared less
 than zero on status
To: Colin King <colin.king@canonical.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-iio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Nov 9, 2016 at 3:12 PM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> status is a u8 hence the check if status is less than zero has no effect.
> Fix this by replacing status with int ret so the less than zero compare
> will correctly detect errors.
>
> Issue found with static analysis with CoverityScan, CID 1375919
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Good catch!

Fixes: 974e6f02e27e ("iio: cros_ec_sensors_core: Add common functions
for the ChromeOS EC Sensor Hub")
Reviewed-by: Guenter Roeck <groeck@chromium.org>

For the benefit of others, this is in today's linux-next.

Thanks,
Guenter

> ---
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index a3be799..416cae5 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -291,15 +291,15 @@ int cros_ec_sensors_read_lpc(struct iio_dev *indio_dev,
>                         return -EIO;
>
>                 /* Read status byte until EC is not busy. */
> -               status = cros_ec_sensors_read_until_not_busy(st);
> -               if (status < 0)
> -                       return status;
> +               ret = cros_ec_sensors_read_until_not_busy(st);
> +               if (ret < 0)
> +                       return ret;
>
>                 /*
>                  * Store the current sample id so that we can compare to the
>                  * sample id after reading the data.
>                  */
> -               samp_id = status & EC_MEMMAP_ACC_STATUS_SAMPLE_ID_MASK;
> +               samp_id = ret & EC_MEMMAP_ACC_STATUS_SAMPLE_ID_MASK;
>
>                 /* Read all EC data, format it, and store it into data. */
>                 ret = cros_ec_sensors_read_data_unsafe(indio_dev, scan_mask,
> --
> 2.10.2
>
