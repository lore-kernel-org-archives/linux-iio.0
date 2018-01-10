Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:40119 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751261AbeAJLBJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jan 2018 06:01:09 -0500
Received: by mail-io0-f193.google.com with SMTP id v30so21987692iov.7
        for <linux-iio@vger.kernel.org>; Wed, 10 Jan 2018 03:01:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180101095342.4d4d5325@archlinux>
References: <1514556006-23293-1-git-send-email-mastichi@gmail.com>
 <CAHp75VfqKaARX2fTJ7BRTU7JLPg-OGROH1NMc_CSh3JZyqPycQ@mail.gmail.com>
 <20171229175449.760e734d@archlinux> <CALieaeeZXZ-6WKYXSMgLiiTO6eTFvdJjazOY9wx4VFk7YcA4Lg@mail.gmail.com>
 <20180101095342.4d4d5325@archlinux>
From: Javier Martinez Canillas <javier@dowhile0.org>
Date: Wed, 10 Jan 2018 12:01:07 +0100
Message-ID: <CABxcv=kmnithguOYV03KASM2DF09yiRs7FPvnBM3fX=k9+soQw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: max9611: fix module auto-loading
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dmitry Mastykin <mastichi@gmail.com>,
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

Hello Jonathan,

On Mon, Jan 1, 2018 at 10:53 AM, Jonathan Cameron <jic23@kernel.org> wrote:

[snip]

>
> I may well be missing some subtle detail of course having spent only a few
> minute looking at this!
>

Your understanding is correct. This change has nothing to do with
module autoloading.

The .probe_new callback is only used to avoid requiring an I2C device
ID table since the old .probe callback has a struct i2c_device_id as a
parameter and so requires a table even in OF (or ACPI) only drivers.

> Jonathan

Best regards,
Javier
