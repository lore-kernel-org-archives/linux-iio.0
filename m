Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752989AbdHTOSW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Aug 2017 10:18:22 -0400
Date: Sun, 20 Aug 2017 15:18:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/4] iio: magnetometer: ak8974: add_device_randomness(fw
 + serial)
Message-ID: <20170820151818.7aa8f6e3@archlinux>
In-Reply-To: <CACRpkdZECwAscLNs7irNzu73Rm7A4SYViRcmcwpuvHLpx11bKQ@mail.gmail.com>
References: <cover.1502977929.git.mirq-linux@rere.qmqm.pl>
        <a90b0e9c8886114903498890a0ae2c66cb19b5f3.1502977929.git.mirq-linux@rere.qmqm.pl>
        <20170820112242.3008c3f8@archlinux>
        <CACRpkdZECwAscLNs7irNzu73Rm7A4SYViRcmcwpuvHLpx11bKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 20 Aug 2017 13:10:58 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sun, Aug 20, 2017 at 12:22 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> > On Thu, 17 Aug 2017 15:56:11 +0200
> > Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:  
> >> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>  
> >
> > Hmm. I wondered about the firmware version as a source of randomness, but
> > will leave it in here.  
> (...)
> >> +             add_device_randomness(&fw, sizeof(fw));  
> >
> > The firmware version seems rather to guessable to really count as randomness.
> > presumably it would constant for a particular batch of chips.  
> 
> That is true, this should go, not for security reasons but because it doesn't
> add much device-unique randomness.
Dropped the fw one...

J
> 
> Nothing we add with add_device_randomness() actually affects the entropy
> pool trust, it is just icing making it - maybe - even more random, so adding
> 256 zeroes is fine for the trust, just pointless and taking time for no good.
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

