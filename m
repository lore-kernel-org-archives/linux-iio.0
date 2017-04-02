Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:64377 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbdDBRaU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 13:30:20 -0400
Date: Sun, 2 Apr 2017 19:29:49 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Matt Ranostay <matt.ranostay@intel.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>, ddvlad@gmail.com,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
        Aniroop Mathur <a.mathur@samsung.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IIO: bmp280-core.c: fix error in humidity calculation
Message-ID: <20170402172949.GA1479@project>
References: <20170327100646.GA8128@project>
 <2bec8c26-f33c-d331-aa97-047871b4cc57@kernel.org>
 <CACRpkdb06PcUwC_zRThLXcw=haiDzuqP-gsVjchNnSWkootT0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACRpkdb06PcUwC_zRThLXcw=haiDzuqP-gsVjchNnSWkootT0Q@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Linus Walleij <linus.walleij@linaro.org> schrieb am Sun, 02. Apr 16:56:
> On Sun, Apr 2, 2017 at 11:32 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> > On 27/03/17 11:06, Andreas Klinger wrote:
> >> While calculating the compensation of the humidity there are negative
> >> values interpreted as unsigned because of unsigned variables used.
> >> These values need to be casted to signed as indicated by the documentation
> >> of the sensor.
> >>
> >> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> >
> > Looks superficially right to me, but would like an Ack from Linus Walleij.
> 
> I didn't work on these calculations, only infrastructure for the driver
> but FWIW:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Matt Ranostay @Intel is the person you probably want to ACK it though,
> he added the humidity calculations :)

It just turned out that there must be another error in the calculation. I'll fix
and test it first.

When i'm done i'll send a new version of the patch.

Andreas

> 
> Yours,
> Linus Walleij

-- 
