Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:34838 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717AbbEDKvt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 May 2015 06:51:49 -0400
Received: by wgyo15 with SMTP id o15so145928530wgy.2
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2015 03:51:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1430730785-17833-3-git-send-email-ao2@ao2.it>
References: <1430730785-17833-1-git-send-email-ao2@ao2.it>
	<1430730785-17833-3-git-send-email-ao2@ao2.it>
Date: Mon, 4 May 2015 13:51:47 +0300
Message-ID: <CAEnQRZCUqdRxizNCddWqzYtTJY43RCs=4Qrv0yDxytqW_aTKww@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] iio: accel: kxcjk-1013: add some blank lines for readability
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Antonio Ospite <ao2@ao2.it>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Bastien Nocera <hadess@hadess.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, May 4, 2015 at 12:13 PM, Antonio Ospite <ao2@ao2.it> wrote:
> Some extra blank lines between if checks don't hurt and improve
> readability.
>
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Bastien Nocera <hadess@hadess.net>
> Cc: linux-iio@vger.kernel.org
> ---

Looks nice :).

Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>

>  drivers/iio/accel/kxcjk-1013.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 5b7a860..937bfc2 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1147,8 +1147,10 @@ static const char *kxcjk1013_match_acpi_device(struct device *dev,
>         id = acpi_match_device(dev->driver->acpi_match_table, dev);
>         if (!id)
>                 return NULL;
> +
>         if (strcmp(id->id, "SMO8500") == 0)
>                 *is_smo8500_device = true;
> +
>         *chipset = (enum kx_chipset)id->driver_data;
>
>         return dev_name(dev);
> @@ -1163,6 +1165,7 @@ static int kxcjk1013_gpio_probe(struct i2c_client *client,
>
>         if (!client)
>                 return -EINVAL;
> +
>         if (data->is_smo8500_device)
>                 return -ENOTSUPP;
>
> --
> 2.1.4
>
