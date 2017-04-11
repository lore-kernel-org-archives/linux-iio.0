Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:34801 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752317AbdDKHp6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Apr 2017 03:45:58 -0400
Received: by mail-io0-f177.google.com with SMTP id a103so61152469ioj.1
        for <linux-iio@vger.kernel.org>; Tue, 11 Apr 2017 00:45:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170410170001.GA2524@project>
References: <20170410170001.GA2524@project>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Apr 2017 09:45:56 +0200
Message-ID: <CACRpkdZMudg8UP-J_JM38v7CDLD4VwbFEgJesZ+MXc9O=+Ey2g@mail.gmail.com>
Subject: Re: [PATCH v2] IIO: bmp280-core.c: fix error in humidity calculation
To: Andreas Klinger <ak@it-klinger.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Vlad Dogaru <ddvlad@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
        Aniroop Mathur <a.mathur@samsung.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Apr 10, 2017 at 7:00 PM, Andreas Klinger <ak@it-klinger.de> wrote:

> While calculating the compensation of the humidity there are negative values
> interpreted as unsigned because of unsigned variables used.  These values as
> well as the constants need to be casted to signed as indicated by the
> documentation of the sensor.
>
> Changes in v2:
> - cast also constants to signed; otherwise calculation is not correct
>
> I removed the Acked-By of Linus Walleij because of another change in the
> calculation. Don't know how it should be treated.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

You guys do an awesome job at maintaining the sensor code, thanks.

Yours,
Linus Walleij
