Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:32854 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751917AbdDCR4E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2017 13:56:04 -0400
Received: by mail-it0-f52.google.com with SMTP id 68so13355657itx.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Apr 2017 10:56:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1491208718-32068-9-git-send-email-peda@axentia.se>
References: <1491208718-32068-1-git-send-email-peda@axentia.se> <1491208718-32068-9-git-send-email-peda@axentia.se>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 3 Apr 2017 19:56:02 +0200
Message-ID: <CACRpkdZMx4EEXqXzT435mE=yHkgCnFbtU0e__C0WD47L2cmjPw@mail.gmail.com>
Subject: Re: [PATCH 8/9] iio: gyro: mpu3050: stop double error reporting
To: Peter Rosin <peda@axentia.se>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Apr 3, 2017 at 10:38 AM, Peter Rosin <peda@axentia.se> wrote:

> i2c_mux_add_adapter already logs a message on failure.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
