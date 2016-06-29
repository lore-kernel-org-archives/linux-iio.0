Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34901 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbcF2OgB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jun 2016 10:36:01 -0400
Received: by mail-ob0-f174.google.com with SMTP id o10so15379067obp.2
        for <linux-iio@vger.kernel.org>; Wed, 29 Jun 2016 07:36:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1606271902270.5271@pmeerw.net>
References: <1467045020-2665-1-git-send-email-linus.walleij@linaro.org>
 <1467045020-2665-8-git-send-email-linus.walleij@linaro.org> <alpine.DEB.2.02.1606271902270.5271@pmeerw.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 Jun 2016 16:35:59 +0200
Message-ID: <CACRpkdb91nKYbXTPEOiS=dS+Xv9Z10K+S5mEt2cPFW-MZdtOzA@mail.gmail.com>
Subject: Re: [PATCH 07/10 v3] iio: pressure: bmp280: add SPI interface driver
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixed most of the stuff, minor clarification below:

On Mon, Jun 27, 2016 at 7:06 PM, Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:
> On Mon, 27 Jun 2016, Linus Walleij wrote:

>> +static const struct of_device_id bmp280_of_spi_match[] = {
>> +     { .compatible = "bosch,bmp085", },
>> +     { .compatible = "bosch,bmp180", },
>> +     { .compatible = "bosch,bmp181", },
>
> what is the BMP181 about? not mentioned so far

This variant exists in the corresponding misc driver in:
drivers/misc/bmp085-spi.c

So to be able to fully replace that driver with this driver, it's
included for completeness.

I updated the commit message to clarify this.

Yours,
Linus Walleij
