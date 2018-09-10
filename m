Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45021 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbeIKAkF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Sep 2018 20:40:05 -0400
Date: Mon, 10 Sep 2018 14:44:24 -0500
From: Rob Herring <robh@kernel.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Philipp Rossak <embed3d@gmail.com>, lee.jones@linaro.org,
        mark.rutland@arm.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 14/30] dt-bindings: update the Allwinner GPADC device
 tree binding for H3 & A83T
Message-ID: <20180910194424.GA21461@bogus>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-15-embed3d@gmail.com>
 <20180831084854.q2uh63pw5vprqlzt@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180831084854.q2uh63pw5vprqlzt@flea>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Aug 31, 2018 at 10:48:54AM +0200, Maxime Ripard wrote:
> On Thu, Aug 30, 2018 at 05:45:02PM +0200, Philipp Rossak wrote:
> > Allwinner H3 features a thermal sensor like the one in A33, but has its
> > register re-arranged, the clock divider moved to CCU (originally the
> > clock divider is in ADC) and added a pair of bus clock and reset.
> > 
> > Allwinner A83T features a thermal sensor similar to the H3, the ths clock,
> > the bus clock and the reset was removed from the CCU. The THS in A83T
> > has a clock that is directly connected and runs with 24 MHz.
> > 
> > Update the binding document to cover H3 and A83T.
> > 
> > Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> 
> You probably want to have a look at:
> https://www.spinics.net/lists/arm-kernel/msg670167.html

Well, which is it? An ADC or thermal sensor?

Rob
