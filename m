Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42503 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeKDBSI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Nov 2018 21:18:08 -0400
From: Renato Lui Geh <renatogeh@gmail.com>
Date: Sat, 3 Nov 2018 13:06:19 -0300
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: [PATCH v3 2/3] staging: iio: ad7780: update voltage on read
Message-ID: <20181103160618.wioq7jbdh4z5yqdw@renatolg>
References: <cover.1541082656.git.renatogeh@gmail.com>
 <1bc4bdf6342d4bc0c2fea17fb3bcd79fabf0e1d1.1541082656.git.renatogeh@gmail.com>
 <b0c6d0356b83259e1adad3bf74cca3a56ae33847.camel@analog.com>
 <20181103131002.7956a08b@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
In-Reply-To: <20181103131002.7956a08b@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 1 Nov 2018 15:20:55 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
>
> This looks wrong.
> I admit this was done in the same way in the probe function, but that looks
> a bit wrong as well.
>
> Typically, the return value of `regulator_get_voltage()` would get checked
> with:
>
> ret = regulator_get_voltage(st->reg);
> if (ret < 0)
>    return ret;
> *val = ret / 1000;
>
> So, negative values are errors and zero & positive values are valid voltage
> values.

I see. So -EINVAL is only used when sent the wrong info type?
