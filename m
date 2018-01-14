Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751287AbeANKvP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jan 2018 05:51:15 -0500
Date: Sun, 14 Jan 2018 10:51:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Martinez Canillas <javier@dowhile0.org>
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
Subject: Re: [PATCH v2] iio: adc: max9611: fix module auto-loading
Message-ID: <20180114105110.14ec8c8f@archlinux>
In-Reply-To: <CABxcv=kmnithguOYV03KASM2DF09yiRs7FPvnBM3fX=k9+soQw@mail.gmail.com>
References: <1514556006-23293-1-git-send-email-mastichi@gmail.com>
        <CAHp75VfqKaARX2fTJ7BRTU7JLPg-OGROH1NMc_CSh3JZyqPycQ@mail.gmail.com>
        <20171229175449.760e734d@archlinux>
        <CALieaeeZXZ-6WKYXSMgLiiTO6eTFvdJjazOY9wx4VFk7YcA4Lg@mail.gmail.com>
        <20180101095342.4d4d5325@archlinux>
        <CABxcv=kmnithguOYV03KASM2DF09yiRs7FPvnBM3fX=k9+soQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 10 Jan 2018 12:01:07 +0100
Javier Martinez Canillas <javier@dowhile0.org> wrote:

> Hello Jonathan,
> 
> On Mon, Jan 1, 2018 at 10:53 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> 
> [snip]
> 
> >
> > I may well be missing some subtle detail of course having spent only a few
> > minute looking at this!
> >  
> 
> Your understanding is correct. This change has nothing to do with
> module autoloading.
> 
> The .probe_new callback is only used to avoid requiring an I2C device
> ID table since the old .probe callback has a struct i2c_device_id as a
> parameter and so requires a table even in OF (or ACPI) only drivers.

OK, then let us revisit this patch once we have an answer on your one
fixing the autoprobing more generally.  Until we then we don't know
whether we need to add the i2c table in or not whether this suffices.

Jonathan

> 
> > Jonathan  
> 
> Best regards,
> Javier
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

