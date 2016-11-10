Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34431 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936192AbcKJUnX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Nov 2016 15:43:23 -0500
Received: by mail-qk0-f178.google.com with SMTP id q130so312096074qke.1
        for <linux-iio@vger.kernel.org>; Thu, 10 Nov 2016 12:43:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161110193957.GA18347@mwanda>
References: <20161110193957.GA18347@mwanda>
From: Guenter Roeck <groeck@google.com>
Date: Thu, 10 Nov 2016 12:43:21 -0800
Message-ID: <CABXOdTfXKmSFvH69hgCsONUZCmdOVrjSSpzO=Br2GcD-EVyPbA@mail.gmail.com>
Subject: Re: [patch] iio: cros_ec_sensors_core: signedness bug in cros_ec_sensors_read_lpc()
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Dan,

On Thu, Nov 10, 2016 at 11:39 AM, Dan Carpenter
<dan.carpenter@oracle.com> wrote:
> "status" is a u8 so checking for negatives doesn't work.  We can just
> use "ret" here instead.
>
> Fixes: 974e6f02e27e ("iio: cros_ec_sensors_core: Add common functions for the ChromeOS EC Sensor Hub.")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>

Also fixed with https://lkml.org/lkml/2016/11/9/807

Guenter

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
