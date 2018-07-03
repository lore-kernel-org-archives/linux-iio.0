Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34113 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753159AbeGCVsq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Jul 2018 17:48:46 -0400
Date: Tue, 3 Jul 2018 15:48:43 -0600
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andreas Klinger <ak@it-klinger.de>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: hx711: add data-ready-delay-ns property in DT
Message-ID: <20180703214843.GA484@rob-hp-laptop>
References: <20180625151802.GA6369@arbeit>
 <20180630183232.540ce031@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180630183232.540ce031@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Jun 30, 2018 at 06:32:32PM +0100, Jonathan Cameron wrote:
> On Mon, 25 Jun 2018 17:18:02 +0200
> Andreas Klinger <ak@it-klinger.de> wrote:
> 
> > add data-ready-delay-ns property for hx711 ADC
> > this is the delay after rising PD_SCK until DOUT is read and assumed to be
> > ready
> > 
> > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> 
> Hmm. It's not particularly generic... I think this should have
> have vendor prefix until we have some visibility of whether it
> is a common thing we want to standardise around or not.

Agreed. Doesn't look like any interface I've seen before.

Since it's bit-banging, seems to me it would be better to specify the 
frequency for PD_SCK and sample DOUT just before or after setting PD_SCK 
low. 

Rob

> I'll also be waiting for a devicetree ack on this one as it's a
> tiny bit unusual.
> 
> Thanks,
> 
> Jonathan
