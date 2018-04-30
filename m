Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33671 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbeD3HsM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Apr 2018 03:48:12 -0400
Received: by mail-pg0-f65.google.com with SMTP id i194-v6so5790618pgd.0
        for <linux-iio@vger.kernel.org>; Mon, 30 Apr 2018 00:48:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180430051658.9856-1-shrirang.bagul@canonical.com>
References: <20180430051658.9856-1-shrirang.bagul@canonical.com>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Mon, 30 Apr 2018 09:48:11 +0200
Message-ID: <CAA2SeNKTjVO7JBVV3qJMJhdM-j=r+igd_nADe+NH3Rux0oW1qA@mail.gmail.com>
Subject: Re: [PATCH][for iio-for-4.17b] iio: humidity: hts221: Fix sensor
 reads after resume
To: Shrirang Bagul <shrirang.bagul@canonical.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> CTRL1 register (ODR & BDU settings) gets reset after system comes back
> from suspend, causing subsequent reads from the sensor to fail.
>
> This patch restores the CTRL1 register after resume.
>

Hi Shrirang,

is just CTRL1 reset after suspend/resume or also other registers? are
IIO triggers enabled before the suspend or
are you reading data from sysfs?

> Based on:
> git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git iio-for-4.17b
>
> Fixes: ffebe74b7c95 (iio: humidity: hts221: avoid useless ODR reconfiguration)
> Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
> ---
>  drivers/iio/humidity/hts221_core.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
> index 166946d4978d..5d7a652aa6d9 100644
> --- a/drivers/iio/humidity/hts221_core.c
> +++ b/drivers/iio/humidity/hts221_core.c
> @@ -658,12 +658,13 @@ static int __maybe_unused hts221_resume(struct device *dev)
>         struct hts221_hw *hw = iio_priv(iio_dev);
>         int err = 0;
>
> -       if (hw->enabled)
> -               err = regmap_update_bits(hw->regmap, HTS221_REG_CNTRL1_ADDR,
> -                                        HTS221_ENABLE_MASK,
> -                                        FIELD_PREP(HTS221_ENABLE_MASK,
> -                                                   true));
> -       return err;
> +       err = regmap_update_bits(hw->regmap, HTS221_REG_CNTRL1_ADDR,
> +                                HTS221_BDU_MASK,
> +                                FIELD_PREP(HTS221_BDU_MASK, 1));
> +       if (err < 0)
> +               return err;
> +
> +       return hts221_update_odr(hw, hw->odr);
>  }
>

Here you need to re-enable the sensor if it was running before the
suspend operation.
Regards,

Lorenzo

>  const struct dev_pm_ops hts221_pm_ops = {
> --
> 2.14.1
>



-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
