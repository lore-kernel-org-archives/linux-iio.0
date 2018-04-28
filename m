Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751354AbeD1RBS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Apr 2018 13:01:18 -0400
Date: Sat, 28 Apr 2018 18:01:11 +0100
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
Subject: Re: [PATCH v4 2/4] dt-bindings: iio: afe: add binding for
 voltage-divider
Message-ID: <20180428180111.2bbaee8c@archlinux>
In-Reply-To: <20180427142917.zdtopxwy72snrv2q@rob-hp-laptop>
References: <20180423210809.29586-1-peda@axentia.se>
        <20180423210809.29586-3-peda@axentia.se>
        <20180427142917.zdtopxwy72snrv2q@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 27 Apr 2018 09:29:17 -0500
Rob Herring <robh@kernel.org> wrote:

> On Mon, Apr 23, 2018 at 11:08:07PM +0200, Peter Rosin wrote:
> > An ADC is often used to measure other quantities indirectly. This
> > binding describe one cases, a "big" voltage measured with the help
> > of a voltage divider.
> > 
> > Signed-off-by: Peter Rosin <peda@axentia.se>
> > ---
> >  .../bindings/iio/afe/voltage-divider.txt           | 53 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 54 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/afe/voltage-divider.txt  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Same white space issue. Fixed.

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan
