Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60474 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752416AbdCEOAn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Mar 2017 09:00:43 -0500
Subject: Re: [PATCH] iio: magnetometer: ak8974: remove incorrect __exit
 markups
To: Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20170301233757.GA10606@dtor-ws>
 <CACRpkdYwdrSJD5YNc_PcHyC+Qy6Sq-4eCVwKHk20o0JTRDjT5w@mail.gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3f5e389a-b171-9804-863c-ff33ac7c4b8c@kernel.org>
Date: Sun, 5 Mar 2017 13:54:02 +0000
MIME-Version: 1.0
In-Reply-To: <CACRpkdYwdrSJD5YNc_PcHyC+Qy6Sq-4eCVwKHk20o0JTRDjT5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/03/17 12:57, Linus Walleij wrote:
> On Thu, Mar 2, 2017 at 12:37 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> 
>> Even if bus is not hot-pluggable, devices can be unbound from the
>> driver via sysfs, so we should not be using __exit annotations on
>> remove() methods. The only exception is drivers registered with
>> platform_driver_probe() which specifically disables sysfs bind/unbind
>> attributes.
>>
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Added.
> 
> Thanks!
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

