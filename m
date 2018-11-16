Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45486 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKQJHV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Nov 2018 04:07:21 -0500
Date: Fri, 16 Nov 2018 16:53:02 -0600
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Stefan Popa <stefan.popa@analog.com>, mark.rutland@arm.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] dt-bindings: iio: adc: Add common ADCs properties
 to a separate file
Message-ID: <20181116225302.GA23266@bogus>
References: <1542108061-3471-1-git-send-email-stefan.popa@analog.com>
 <20181116183838.6a079255@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181116183838.6a079255@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Nov 16, 2018 at 06:38:38PM +0000, Jonathan Cameron wrote:
> On Tue, 13 Nov 2018 13:21:01 +0200
> Stefan Popa <stefan.popa@analog.com> wrote:
> 
> > There are several ADC drivers that depend on the same device tree
> > bindings. Rather than continue to duplicate the properties, this patch
> > adds a common adc binding document that can be referenced. For beginning,
> > only two properties are documented.
> > 
> > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Looks very sensible to me, but as we are looking at a some generalization
> here, I'd like an Ack from Rob if possible (as he suggested it I think :)

Looks fine to me, but I don't have any clue if this will be flexible 
enough for various h/w.

Rob
