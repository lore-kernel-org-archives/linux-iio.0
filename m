Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:40709 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752916AbeAJLDq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jan 2018 06:03:46 -0500
Received: by mail-io0-f178.google.com with SMTP id v30so21996220iov.7
        for <linux-iio@vger.kernel.org>; Wed, 10 Jan 2018 03:03:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CALieaecgHPWG0sKRf6A6gwxP1TkSqsjX09ZULxGAMQj9f0P_pw@mail.gmail.com>
References: <1514556006-23293-1-git-send-email-mastichi@gmail.com>
 <CAHp75VfqKaARX2fTJ7BRTU7JLPg-OGROH1NMc_CSh3JZyqPycQ@mail.gmail.com>
 <20171229175449.760e734d@archlinux> <CALieaeeZXZ-6WKYXSMgLiiTO6eTFvdJjazOY9wx4VFk7YcA4Lg@mail.gmail.com>
 <20180101095342.4d4d5325@archlinux> <CALieaecknYWjOvUuD_Qhaepj0fwGBCPX0pcT3pgNTnLQ17WMSA@mail.gmail.com>
 <20180106131434.550e8e42@archlinux> <CALieaefJ-dPNMydGZD-jCC66gRs1SGqFNNs__y9BWyC05g5bqQ@mail.gmail.com>
 <20180107160820.05660804@archlinux> <CALieaecOxkh+SCnYA_ScoaKeRbYTdbKy7PH0=SuxcT3GEn3-Hw@mail.gmail.com>
 <CALieaecgHPWG0sKRf6A6gwxP1TkSqsjX09ZULxGAMQj9f0P_pw@mail.gmail.com>
From: Javier Martinez Canillas <javier@dowhile0.org>
Date: Wed, 10 Jan 2018 12:03:45 +0100
Message-ID: <CABxcv=niM23C7WB7fF9TAxG0nqVNYttta+hm4HyG0WuHQw04Gg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: max9611: fix module auto-loading
To: Dmitry Mastykin <mastichi@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Rob Herring <robh@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Dmitry,

On Wed, Jan 10, 2018 at 4:51 AM, Dmitry Mastykin <mastichi@gmail.com> wrote:
> Hello Johnatan,
> May be the issue is the same as Javier Martinez Canillas wrote:
> "What is not correct is to require OF-only drivers to have an I2C
> device ID table just as a workaround to have their modules
> auto-loading working."
> Please see: http://lkml.iu.edu/hypermail/linux/kernel/1712.0/01779.html
> So the problem is not in driver, but in auto-loading procedure.

I've posted [0] a fix for the I2C core some time ago. Could you please
give a try to that and maybe provide your {Tested,Reviewed}-by tag?

[0]: https://patchwork.kernel.org/patch/10089425/

Best regards,
Javier
