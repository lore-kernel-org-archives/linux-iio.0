Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbeKYVaq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Nov 2018 16:30:46 -0500
Date: Sun, 25 Nov 2018 10:39:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: hofrat@osadl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, carlo@caione.org, khilman@baylibre.com,
        yixun.lan@amlogic.com, xingyu.chen@amlogic.com,
        gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: meson-saradc: check for devm_kasprintf
 failure
Message-ID: <20181125103953.6d7bcf76@archlinux>
In-Reply-To: <CAFBinCAXt1GPFMptVXrGYi-TsgSxSyNqeWFuz=B=vWV3c1+zwA@mail.gmail.com>
References: <1542872803-29060-1-git-send-email-hofrat@osadl.org>
        <CAFBinCAXt1GPFMptVXrGYi-TsgSxSyNqeWFuz=B=vWV3c1+zwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 22 Nov 2018 22:44:55 +0100
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> On Thu, Nov 22, 2018 at 8:52 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
> >
> > devm_kasprintf() may return NULL on failure of internal allocation thus
> > the assignments to  init.name  are not safe if not checked. On error
> > meson_sar_adc_clk_init() returns negative values so -ENOMEM in the
> > (unlikely) failure case of devm_kasprintf() should be fine here.
> >
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs")  
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> thank you for the patch!
> I tested the non-error case on my Odroid-C1 and it still works fine.
Applied.  I also added a tested by tag for you Martin as it's always nice
for the log to reflect when people make the effort!

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> 
> 
> Regards
> Martin
