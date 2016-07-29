Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35830 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbcG2GTK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Jul 2016 02:19:10 -0400
Received: by mail-lf0-f67.google.com with SMTP id l89so4791764lfi.2
        for <linux-iio@vger.kernel.org>; Thu, 28 Jul 2016 23:19:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1469745637-998-1-git-send-email-mranostay@gmail.com>
References: <1469745637-998-1-git-send-email-mranostay@gmail.com>
From: Daniel Baluta <daniel.baluta@intel.com>
Date: Fri, 29 Jul 2016 09:19:08 +0300
Message-ID: <CAEnQRZBeTWZVX6+EEuy75we1HoDKoFEXs8oLMcTc0oFXytasxQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ti-ads1015: fix incorrect referencing of
 ads1015_data pointer
To: Matt Ranostay <mranostay@gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	giorgio.nicole@arcor.de, Daniel Baluta <daniel.baluta@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Jul 29, 2016 at 1:40 AM, Matt Ranostay <mranostay@gmail.com> wrote:
> Reported-by: Giorgio <giorgio.nicole@arcor.de>
> Cc: Daniel Baluta <daniel.baluta@intel.com>
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>  drivers/iio/adc/ti-ads1015.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 73cbf0b54e54..fe96af6059d5 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -403,7 +403,8 @@ static const struct iio_info ads1015_info = {
>  #ifdef CONFIG_OF
>  static int ads1015_get_channels_config_of(struct i2c_client *client)
>  {
> -       struct ads1015_data *data = i2c_get_clientdata(client);
> +       struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +       struct ads1015_data *data = iio_priv(indio_dev);
>         struct device_node *node;
>
>         if (!client->dev.of_node ||
> --

Hi Matt,

Giorgio already sent a patch for this. I think we should go on his way
since he found the bug.

Daniel.
