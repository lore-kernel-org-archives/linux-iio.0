Return-Path: <SRS0=ujoz=S3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D3FC10F11
	for <linux-iio@archiver.kernel.org>; Thu, 25 Apr 2019 01:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD965214AE
	for <linux-iio@archiver.kernel.org>; Thu, 25 Apr 2019 01:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="qQs56Uko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387949AbfDYBfT (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 24 Apr 2019 21:35:19 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52103 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387946AbfDYBfT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Apr 2019 21:35:19 -0400
Received: by mail-it1-f194.google.com with SMTP id s3so9807094itk.1
        for <linux-iio@vger.kernel.org>; Wed, 24 Apr 2019 18:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3bpnT0MKJFDMp8yH3bNjp+BARmsLopErc5UrP8dj8Fk=;
        b=qQs56Ukocl78Sf5FuGfxht/IptjPjK+pks9kLVauKAGQJud0FXwEZiSmAapugG+0uB
         GkxbjbIuN1E+6GTaNxrMogrZL/G2BpRDkO9Z7nfp5ZCVaivUk23l7c7ZbPtQEiBJ2PZq
         Uq+sANwEAuSRVA1kZf9HZJHifa+0udTWlR8Y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3bpnT0MKJFDMp8yH3bNjp+BARmsLopErc5UrP8dj8Fk=;
        b=l9UFRd6ZaOzgJFe83M310U6B/ehybNSWaSuAbueau5HeFBCRAIUU4lCEoxYIJTfCT4
         itndv2Us5MDy3YcNxQmBmZsKjhrZa4fOYaTnn3Z7za0NnzoU8Y3BK2w3fnhmJd7ng9qB
         FbDoKtCN7gMoL1LIzdtPj8uvYYuVzw1GfUgmaLdOMqL5YhbUGrn53+vKZYM2ssmwS5QS
         lYK1jcXE84M9aENoYtvBaOU+6kRGJsaemelXulCYHWAGh0qL5gC102jXp4IZlJe4/Zr7
         0eDlvav5Hy8CoJz/YMaa195RZ4F35KkWJChOpIsd4hafRHwXyKsc8GSS0YixoRZtCLmn
         nAww==
X-Gm-Message-State: APjAAAWt6m3uykQniWfQfVG2lEtEKSALNW7FpOszipTTWL68XpY6DOlX
        DuPLIR/PYs9F9YgCOMCoafNgEZWhFOH/jOQyAwwTNA==
X-Google-Smtp-Source: APXvYqy9S367pYw9RPDTzptJgtuOYTSS/K3PA1N7EYCSEjXz8IvMuuq3AvTeUmzsptcuZsgIb7q2BKeNu4pcp96cwLI=
X-Received: by 2002:a02:c043:: with SMTP id u3mr15408649jam.35.1556156118300;
 Wed, 24 Apr 2019 18:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <1556055738-14838-1-git-send-email-dagmcr@gmail.com>
In-Reply-To: <1556055738-14838-1-git-send-email-dagmcr@gmail.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Thu, 25 Apr 2019 09:35:07 +0800
Message-ID: <CAJCx=gkykSjn7uf67s2_NqB+-FYWF_oA_PknB7LcX5QRD_mp9Q@mail.gmail.com>
Subject: Re: [PATCH v2] iio: temperature: maxim_thermocouple: declare missing
 of table
To:     Daniel Gomez <dagmcr@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, javier@dowhile0.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 24, 2019 at 5:42 AM Daniel Gomez <dagmcr@gmail.com> wrote:
>
> Add missing <of_device_id> table for SPI driver relying on SPI
> device match since compatible is in a DT binding or in a DTS.
>
> Before this patch:
> modinfo drivers/iio/temperature/maxim_thermocouple.ko | grep alias
> alias:          spi:max31855
> alias:          spi:max6675
>
> After this patch:
> modinfo drivers/iio/temperature/maxim_thermocouple.ko | grep alias
> alias:          spi:max31855
> alias:          spi:max6675
> alias:          of:N*T*Cmaxim,max31855C*
> alias:          of:N*T*Cmaxim,max31855
> alias:          of:N*T*Cmaxim,max6675C*
> alias:          of:N*T*Cmaxim,max6675

Heh oops I missed that somehow in initial development.

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

>
> Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
> Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
> ---
>  drivers/iio/temperature/maxim_thermocouple.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
> index c31b963..c613a64 100644
> --- a/drivers/iio/temperature/maxim_thermocouple.c
> +++ b/drivers/iio/temperature/maxim_thermocouple.c
> @@ -10,6 +10,8 @@
>  #include <linux/init.h>
>  #include <linux/mutex.h>
>  #include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/spi/spi.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/trigger.h>
> @@ -262,9 +264,17 @@ static const struct spi_device_id maxim_thermocouple_id[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, maxim_thermocouple_id);
>
> +static const struct of_device_id maxim_thermocouple_of_match[] = {
> +        { .compatible = "maxim,max6675" },
> +        { .compatible = "maxim,max31855" },
> +        { },
> +};
> +MODULE_DEVICE_TABLE(of, maxim_thermocouple_of_match);
> +
>  static struct spi_driver maxim_thermocouple_driver = {
>         .driver = {
>                 .name   = MAXIM_THERMOCOUPLE_DRV_NAME,
> +               .of_match_table = maxim_thermocouple_of_match,
>         },
>         .probe          = maxim_thermocouple_probe,
>         .remove         = maxim_thermocouple_remove,
> --
> 2.7.4
>
