Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751731AbdHLMg3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Aug 2017 08:36:29 -0400
Date: Sat, 12 Aug 2017 13:05:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>, linux@armlinux.org.uk,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, lars@metafoo.de, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, benjamin.gaignard@linaro.org,
        benjamin.gaignard@st.com
Subject: Re: [PATCH 1/3] dt-bindings: iio: timer: stm32: add support for
 STM32H7
Message-ID: <20170812130541.227e0af3@archlinux>
In-Reply-To: <20170810171217.gxms3ect2gpbizba@rob-hp-laptop>
References: <1501751654-14153-1-git-send-email-fabrice.gasnier@st.com>
        <1501751654-14153-2-git-send-email-fabrice.gasnier@st.com>
        <20170810171217.gxms3ect2gpbizba@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 10 Aug 2017 12:12:17 -0500
Rob Herring <robh@kernel.org> wrote:

> On Thu, Aug 03, 2017 at 11:14:12AM +0200, Fabrice Gasnier wrote:
> > STM32H7 has slightly different triggers than previous versions.
> > Introduce st,stm32h7-timer-trigger compatible to handle this new variant.
> > 
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > ---
> >  Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)  
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks,
