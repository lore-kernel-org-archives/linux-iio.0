Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbeLBCt4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Dec 2018 21:49:56 -0500
Date: Sat, 1 Dec 2018 15:37:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Matheus Tavares <matheus.bernardino@usp.br>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com
Subject: Re: [PATCH v3 4/7] dt-bindings:iio:resolver: Add docs for ad2s90
Message-ID: <20181201153704.0f17dfcc@archlinux>
In-Reply-To: <20181127015227.GA11401@bogus>
References: <20181124002312.6923-1-matheus.bernardino@usp.br>
        <20181124002312.6923-5-matheus.bernardino@usp.br>
        <20181127015227.GA11401@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 26 Nov 2018 19:52:27 -0600
Rob Herring <robh@kernel.org> wrote:

> On Fri, 23 Nov 2018 22:23:09 -0200, Matheus Tavares wrote:
> > This patch adds the device tree binding documentation for the ad2s90
> > resolver-to-digital converter.
> > 
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > ---
> > Changes in v3:
> >  - Added reference to spi-bus documentation after spi properties, as
> >  suggested by Alexandru Ardelean.
> > 
> > Changes in v2:
> >  - Rewritten 'spi-cpol and spi-cpha' item to say that the device can
> >  work in either mode (0,0) or (1,1) and explain how they should be
> >  specified in DT.
> > 
> >  .../bindings/iio/resolver/ad2s90.txt          | 31 +++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing for the autobuilders
to play with it.

Thanks,

Jonathan
