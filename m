Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbeIHTBV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Sep 2018 15:01:21 -0400
Date: Sat, 8 Sep 2018 15:15:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: pm8998: Add die temperature
 channel node to the ADC
Message-ID: <20180908151518.1a235bff@archlinux>
In-Reply-To: <20180906212206.GE22824@google.com>
References: <20180906210454.247219-1-mka@chromium.org>
        <20180906210454.247219-4-mka@chromium.org>
        <CAD=FV=WLcgKQWAp8HnBFZhZ4+32keMANcYJ+nGquePqsOnjJ7A@mail.gmail.com>
        <20180906212206.GE22824@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 6 Sep 2018 14:22:06 -0700
Matthias Kaehlcke <mka@chromium.org> wrote:

> On Thu, Sep 06, 2018 at 02:10:43PM -0700, Doug Anderson wrote:
> > Hi,
> > 
> > On Thu, Sep 6, 2018 at 2:04 PM, Matthias Kaehlcke <mka@chromium.org> wrote:  
> > > Add a channel node for the die temperature to the ADC.
> > >
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>  
> > 
> > Double-SoB?  
> 
> I must have run 'amend' with '-s' out of habit, which wasn't the right
> thing to do in this case :/
> 
> > ...presumably Andy can remove that when he lands and doesn't need a re-post...  
> 
> Andy, in case you need me to repost let me know.
Slightly worse than that (as was patch 1).  You accidentally used
-- rather than --- to separate the change log.  So I ended up with

Signed-off-by: M..
Reviewed-by: ..
Signed-off-by: M..
--
Changelog

Signed-off-by: J....

Good think the double signed off was raised as chances are I wouldn't
have notice it.

Jonathan
> 
> Thanks
> 
> Matthias
