Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35422 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbcBOJSV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2016 04:18:21 -0500
MIME-Version: 1.0
In-Reply-To: <1455526993-2132098-1-git-send-email-arnd@arndb.de>
References: <1455526993-2132098-1-git-send-email-arnd@arndb.de>
Date: Mon, 15 Feb 2016 11:18:20 +0200
Message-ID: <CAEnQRZBSYy2inu0mUtXEdhEKWQj5i-YUFDL61prvC_8P_L0adQ@mail.gmail.com>
Subject: Re: [PATCH] iio: health/afe4403: mark suspend/resume functions __maybe_unused
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	"Andrew F . Davis" <afd@ti.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Feb 15, 2016 at 11:02 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The newly added afe4403 driver implements suspend/resume using the
> SIMPLE_DEV_PM_OPS() macro, which leaves out references to the actual
> functions when CONFIG_PM is disabled, causing a harmless warning:
>
> health/afe4403.c:509:12: error: 'afe4403_suspend' defined but not used
> health/afe4403.c:530:12: error: 'afe4403_resume' defined but not used
>
> This marks the functions as __maybe_unused so we don't get those
> warnings.
>
Or we could put _suspend and _resume under CONFIG_PM_SLEEP.

We have:

:~/w/iio/drivers/iio$ ack-grep SIMPLE_DEV_PM_OPS | wc -l
31

and only 2 drivers using __maybe_unused.

:~/w/iio/drivers/iio$ ack-grep maybe_unused
gyro/itg3200_core.c
354:static int __maybe_unused itg3200_suspend(struct device *dev)
365:static int __maybe_unused itg3200_resume(struct device *dev)

adc/imx7d_adc.c
553:static int __maybe_unused imx7d_adc_suspend(struct device *dev)
566:static int __maybe_unused imx7d_adc_resume(struct device *dev)

For consistency, we should use CONFIG_PM_SLEEP and get rid of __maybe_unused.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: eec96d1e2d31 ("iio: health: Add driver for the TI AFE4403 heart monitor")
> ---
>  drivers/iio/health/afe4403.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
> index 91c046e40d2f..88e43f87b926 100644
> --- a/drivers/iio/health/afe4403.c
> +++ b/drivers/iio/health/afe4403.c
> @@ -506,7 +506,7 @@ static const struct of_device_id afe4403_of_match[] = {
>  MODULE_DEVICE_TABLE(of, afe4403_of_match);
>  #endif
>
> -static int afe4403_suspend(struct device *dev)
> +static int __maybe_unused afe4403_suspend(struct device *dev)
>  {
>         struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>         struct afe4403_data *afe = iio_priv(indio_dev);
> @@ -527,7 +527,7 @@ static int afe4403_suspend(struct device *dev)
>         return 0;
>  }
>
> -static int afe4403_resume(struct device *dev)
> +static int __maybe_unused afe4403_resume(struct device *dev)
>  {
>         struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>         struct afe4403_data *afe = iio_priv(indio_dev);
