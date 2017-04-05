Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33368 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755767AbdDEVut (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Apr 2017 17:50:49 -0400
Date: Wed, 5 Apr 2017 14:50:46 -0700
From: Stephen Boyd <sboyd@codeaurora.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rick Altherr <raltherr@google.com>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Rob Herring <robh@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-iio@vger.kernel.org, Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Hartmut Knaack <knaack.h@gmx.de>, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: Aspeed ADC
Message-ID: <20170405215046.GE7065@codeaurora.org>
References: <20170328215259.31622-1-raltherr@google.com>
 <20170328215259.31622-2-raltherr@google.com>
 <d05cadfe-e3d3-f4e8-129f-19dcd2f637da@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d05cadfe-e3d3-f4e8-129f-19dcd2f637da@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/01, Jonathan Cameron wrote:
> On 28/03/17 22:52, Rick Altherr wrote:
> > Aspeed BMC SoCs include a 16 channel, 10-bit ADC. Low and high threshold
> > interrupts are supported by the hardware but are not currently implemented.
> > 
> > Signed-off-by: Rick Altherr <raltherr@google.com>
> Two really trivial things inline. I'll fix them whilst applying rather than
> having you do a v6 - please do sanity check I haven't messed it up though!
> 
> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to play with it.
> 

Oh I was too late. Blame work. Anyway, I made some comments on
v4. If they're fixed in a later patch or discussed on list that's
fine. No worries on my end.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
