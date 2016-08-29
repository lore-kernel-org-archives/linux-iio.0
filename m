Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36381 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933015AbcH2NWD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2016 09:22:03 -0400
Received: by mail-oi0-f43.google.com with SMTP id f189so195066025oig.3
        for <linux-iio@vger.kernel.org>; Mon, 29 Aug 2016 06:21:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160826153137.701672-1-arnd@arndb.de>
References: <20160826153137.701672-1-arnd@arndb.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 29 Aug 2016 15:21:50 +0200
Message-ID: <CACRpkdbD-=o6CiZLLrEufi1QU+y-598QGDb5cH-VLRgDaeETKg@mail.gmail.com>
Subject: Re: [PATCH] iio: magn/ak8974: avoid unused function warning
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Aug 26, 2016 at 5:31 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The ak8974_configure() function is used only from the PM code,
> but that can be hidden when CONFIG_PM is disabled:
>
> drivers/iio/magnetometer/ak8974.c:201:12: error: 'ak8974_configure' defined but not used [-Werror=unused-function]
>
> This replaces the #ifdef with a __maybe_unused annotation, which
> will work correctly in all configurations and avoid the warning,
> as the compiler can now see where ak8974_configure is called from.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 7c94a8b2ee8c ("iio: magn: add a driver for AK8974")

Nice catch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
