Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32913 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752954AbdCOTdA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 15:33:00 -0400
Date: Wed, 15 Mar 2017 14:29:28 -0500
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, lars@metafoo.de, knaack.h@gmx.de,
        pmeerw@pmeerw.net, benjamin.gaignard@linaro.org,
        benjamin.gaignard@st.com, linus.walleij@linaro.org
Subject: Re: [PATCH v3 3/6] dt-bindings: iio: document interrupt trigger
 support
Message-ID: <20170315192928.p35tsixaokqxulwq@rob-hp-laptop>
References: <1488300679-3259-1-git-send-email-fabrice.gasnier@st.com>
 <1488300679-3259-4-git-send-email-fabrice.gasnier@st.com>
 <e6e2f05f-0dc0-f2a3-064b-268776a413c5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e6e2f05f-0dc0-f2a3-064b-268776a413c5@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Mar 05, 2017 at 12:16:28PM +0000, Jonathan Cameron wrote:
> On 28/02/17 16:51, Fabrice Gasnier wrote:
> > Document interrupt trigger that takes a generic interrupt, and
> > can be used as trigger source for sampling devices such as sensors,
> > ADCs...
> > 
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> I'm not convinced we want the earlier device tree binding doc at all.
> In the vast majority of cases that chunk on providers is irrelevant.
> What matters is to document the specific case as you have done here.
> 
> So this one I like, the earlier document less so, simply because
> it repeats what this more specific document has described.
> 
> So Rob, what do you think of 'just' this bit?

Yeah, it seems fine. Though, the #io-trigger-cells can be dropped.

Rob
