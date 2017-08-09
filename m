Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752050AbdHINNy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Aug 2017 09:13:54 -0400
Date: Wed, 9 Aug 2017 14:13:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>, linux@armlinux.org.uk,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, lars@metafoo.de, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: adc: stm32: add optional
 st,min-sample-time-nsecs
Message-ID: <20170809141341.777bdd85@archlinux>
In-Reply-To: <20170803170154.bizlx2dvdbwtgmoy@rob-hp-laptop>
References: <1500912640-23927-1-git-send-email-fabrice.gasnier@st.com>
        <1500912640-23927-3-git-send-email-fabrice.gasnier@st.com>
        <20170803170154.bizlx2dvdbwtgmoy@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 3 Aug 2017 12:01:54 -0500
Rob Herring <robh@kernel.org> wrote:

> On Mon, Jul 24, 2017 at 06:10:39PM +0200, Fabrice Gasnier wrote:
> > STM32 ADC allows each channel to be sampled with a different sampling
> > time. There's an application note that deals with this: 'How to get
> > the best ADC accuracy in STM32...' It basically depends on analog input
> > signal electrical properties (depends on board).
> > 
> > Add optional 'st,min-sample-time-nsecs' property so this can be tuned
> > in dt.
> > 
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > ---
> > Changes in v2:
> > - Use 'st,min-sample-time-nsecs' instead of 'min-sample-time'.
> > ---
> >  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 5 +++++
> >  1 file changed, 5 insertions(+)  
> 
> Acked-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testings.

Thanks for review Rob and thanks for the patch Fabrice.

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

