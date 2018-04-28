Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751354AbeD1RCd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Apr 2018 13:02:33 -0400
Date: Sat, 28 Apr 2018 18:02:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
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
Subject: Re: [PATCH v4 3/4] dt-bindings: iio: afe: add binding for
 current-sense-amplifier
Message-ID: <20180428180226.66ca35ae@archlinux>
In-Reply-To: <20180427143025.v2pbl6ejikjhsoyh@rob-hp-laptop>
References: <20180423210809.29586-1-peda@axentia.se>
        <20180423210809.29586-4-peda@axentia.se>
        <20180427143025.v2pbl6ejikjhsoyh@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 27 Apr 2018 09:30:25 -0500
Rob Herring <robh@kernel.org> wrote:

> On Mon, Apr 23, 2018 at 11:08:08PM +0200, Peter Rosin wrote:
> > Similar to current sense shunts, but an amplifier enables the use
> > of a smaller sense resistance.
> > 
> > Signed-off-by: Peter Rosin <peda@axentia.se>
> > ---
> >  .../bindings/iio/afe/current-sense-amplifier.txt   | 26 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 27 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
Applied

Thanks,

Jonathan
