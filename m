Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35430 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752612AbdHTLK7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Aug 2017 07:10:59 -0400
Received: by mail-oi0-f50.google.com with SMTP id e124so132156762oig.2
        for <linux-iio@vger.kernel.org>; Sun, 20 Aug 2017 04:10:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170820112242.3008c3f8@archlinux>
References: <cover.1502977929.git.mirq-linux@rere.qmqm.pl> <a90b0e9c8886114903498890a0ae2c66cb19b5f3.1502977929.git.mirq-linux@rere.qmqm.pl>
 <20170820112242.3008c3f8@archlinux>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 20 Aug 2017 13:10:58 +0200
Message-ID: <CACRpkdZECwAscLNs7irNzu73Rm7A4SYViRcmcwpuvHLpx11bKQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: magnetometer: ak8974: add_device_randomness(fw + serial)
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Aug 20, 2017 at 12:22 PM, Jonathan Cameron <jic23@kernel.org> wrote=
:
> On Thu, 17 Aug 2017 15:56:11 +0200
> Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl> wrote:
>> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
>
> Hmm. I wondered about the firmware version as a source of randomness, but
> will leave it in here.
(...)
>> +             add_device_randomness(&fw, sizeof(fw));
>
> The firmware version seems rather to guessable to really count as randomn=
ess.
> presumably it would constant for a particular batch of chips.

That is true, this should go, not for security reasons but because it doesn=
't
add much device-unique randomness.

Nothing we add with add_device_randomness() actually affects the entropy
pool trust, it is just icing making it - maybe - even more random, so addin=
g
256 zeroes is fine for the trust, just pointless and taking time for no goo=
d.

Yours,
Linus Walleij
