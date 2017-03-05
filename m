Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:38583 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbdCEM5E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Mar 2017 07:57:04 -0500
Received: by mail-it0-f52.google.com with SMTP id m27so36289118iti.1
        for <linux-iio@vger.kernel.org>; Sun, 05 Mar 2017 04:57:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170301233757.GA10606@dtor-ws>
References: <20170301233757.GA10606@dtor-ws>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 5 Mar 2017 13:57:02 +0100
Message-ID: <CACRpkdYwdrSJD5YNc_PcHyC+Qy6Sq-4eCVwKHk20o0JTRDjT5w@mail.gmail.com>
Subject: Re: [PATCH] iio: magnetometer: ak8974: remove incorrect __exit markups
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Mar 2, 2017 at 12:37 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Even if bus is not hot-pluggable, devices can be unbound from the
> driver via sysfs, so we should not be using __exit annotations on
> remove() methods. The only exception is drivers registered with
> platform_driver_probe() which specifically disables sysfs bind/unbind
> attributes.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!
Linus Walleij
