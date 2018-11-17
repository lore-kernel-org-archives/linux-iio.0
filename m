Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbeKRC5Q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Nov 2018 21:57:16 -0500
Date: Sat, 17 Nov 2018 16:39:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Stefan Popa <stefan.popa@analog.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, Michael.Hennerich@analog.com,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] dt-bindings: iio: adc: Add common ADCs
 properties to a separate file
Message-ID: <20181117163957.475ca71b@archlinux>
In-Reply-To: <20181116225319.GA26554@bogus>
References: <1542108061-3471-1-git-send-email-stefan.popa@analog.com>
        <20181116225319.GA26554@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 16 Nov 2018 16:53:19 -0600
Rob Herring <robh@kernel.org> wrote:

> On Tue, 13 Nov 2018 13:21:01 +0200, Stefan Popa wrote:
> > There are several ADC drivers that depend on the same device tree
> > bindings. Rather than continue to duplicate the properties, this patch
> > adds a common adc binding document that can be referenced. For beginning,
> > only two properties are documented.
> > 
> > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> > ---
> > Changes in v2, v3:
> > 	- N/A.
> > Changes in v4:
> > 	- Added this commit.
> > Changes in v5:
> > 	- Nothing changed.
> > 
> >  Documentation/devicetree/bindings/iio/adc/adc.txt | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adc.txt
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
