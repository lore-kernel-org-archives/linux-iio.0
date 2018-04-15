Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752460AbeDORlx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Apr 2018 13:41:53 -0400
Date: Sun, 15 Apr 2018 18:41:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Andrew F . Davis" <afd@ti.com>,
        Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: add unit converter
Message-ID: <20180415184146.72c1afd3@archlinux>
In-Reply-To: <20180411141555.15044-1-peda@axentia.se>
References: <20180410152802.30958-1-peda@axentia.se>
        <20180411141555.15044-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 11 Apr 2018 16:15:53 +0200
Peter Rosin <peda@axentia.se> wrote:

> Hi!
> 
> I'm now following up with one more binding for the unit-converter.
> This time with a real IC, namely LT6106 from Analog Devices. It's
> a current sense amplifier. I was a but unsure if I should have
> the Rin and Rout resistors in the binding or if I instead should
> have used the "gain". In the end I went with the resistors since
> while the normal case is an integer gain, that may not always be
> the case. And when it's not, that could get tricky. But I'm open
> for arguments on that.
> 
> Cheers,
> Peter
Trivial complaint of the day - why the same title for this email
as the previous series?  Had me really confused for a minute ;)

Seems like the whole driver is stabilizing.  If we do a v4 please
pull the whole lot into one series.

Jonathan

> 
> Peter Rosin (2):
>   dt-bindings: iio: afe: add binding for adi,lt6106
>   iio: afe: unit-converter: add support for adi,lt6106
> 
>  .../devicetree/bindings/iio/afe/adi,lt6106.txt     | 50 ++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  drivers/iio/afe/Kconfig                            |  3 +-
>  drivers/iio/afe/iio-unit-converter.c               | 54 ++++++++++++++++++++++
>  4 files changed, 107 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/adi,lt6106.txt
> 

