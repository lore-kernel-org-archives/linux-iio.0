Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbeKDCdW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Nov 2018 22:33:22 -0400
Date: Sat, 3 Nov 2018 17:21:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Renato Lui Geh <renatogeh@gmail.com>
Cc: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: [PATCH v3 2/3] staging: iio: ad7780: update voltage on read
Message-ID: <20181103172125.40541052@archlinux>
In-Reply-To: <20181103160618.wioq7jbdh4z5yqdw@renatolg>
References: <cover.1541082656.git.renatogeh@gmail.com>
        <1bc4bdf6342d4bc0c2fea17fb3bcd79fabf0e1d1.1541082656.git.renatogeh@gmail.com>
        <b0c6d0356b83259e1adad3bf74cca3a56ae33847.camel@analog.com>
        <20181103131002.7956a08b@archlinux>
        <20181103160618.wioq7jbdh4z5yqdw@renatolg>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 3 Nov 2018 13:06:19 -0300
Renato Lui Geh <renatogeh@gmail.com> wrote:

> On Thu, 1 Nov 2018 15:20:55 +0000
> "Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
> >
> > This looks wrong.
> > I admit this was done in the same way in the probe function, but that looks
> > a bit wrong as well.
> >
> > Typically, the return value of `regulator_get_voltage()` would get checked
> > with:
> >
> > ret = regulator_get_voltage(st->reg);
> > if (ret < 0)
> >    return ret;
> > *val = ret / 1000;
> >
> > So, negative values are errors and zero & positive values are valid voltage
> > values.  
> 
> I see. So -EINVAL is only used when sent the wrong info type?
yes. I actually misread what was there and thought we were just talking
about using a ret variable rather than returning the error via your
local variable.

Definitely want to pass on the error from regulator_get_voltage as
it may have more meaning than a simple -EINVAL.

Thanks,

Jonathan
