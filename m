Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:34091 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbeHGTJk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Aug 2018 15:09:40 -0400
Date: Tue, 7 Aug 2018 10:54:26 -0600
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Brian Masney <masneyb@onstation.org>, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, jonathan@marek.ca,
        jmaneyrol@invensense.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mkelly@xevo.com, fischerdouglasc@gmail.com,
        bshah@kde.org, ctatlor97@gmail.com
Subject: Re: [PATCH v3 4/9] dt-bindings: iio: tsl2772: add new bindings
Message-ID: <20180807165426.GA7007@rob-hp-laptop>
References: <20180803001900.25371-1-masneyb@onstation.org>
 <20180803001900.25371-5-masneyb@onstation.org>
 <20180803224838.362d6cf5@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180803224838.362d6cf5@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Aug 03, 2018 at 10:48:38PM +0100, Jonathan Cameron wrote:
> On Thu,  2 Aug 2018 20:18:55 -0400
> Brian Masney <masneyb@onstation.org> wrote:
> 
> > This patch adds the new properties amstaos,proximity-diodes and
> > led-max-microamp to the tsl2772 driver. This patch also removes the
> > driver from the trivial-devices.txt.
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > ---
> This and the implementation look fine to me, but I'll leave them for
> now to give Rob time to take a look if he wants to.
> 
> Thanks,
> 
> Jonathan
> 
> > I got a Reviewed-by: Rob Herring <robh@kernel.org> on my last series but
> > didn't include it due to the new file tsl2772.txt in this patch. Device
> > tree bindings need to be complete.
> > 
> >  .../devicetree/bindings/iio/light/tsl2772.txt | 37 +++++++++++++++++++
> >  .../devicetree/bindings/trivial-devices.txt   | 10 -----
> >  2 files changed, 37 insertions(+), 10 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2772.txt

Reviewed-by: Rob Herring <robh@kernel.org>
