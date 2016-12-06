Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wj0-f181.google.com ([209.85.210.181]:34723 "EHLO
        mail-wj0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbcLFJpZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Dec 2016 04:45:25 -0500
Received: by mail-wj0-f181.google.com with SMTP id tg4so58012151wjb.1
        for <linux-iio@vger.kernel.org>; Tue, 06 Dec 2016 01:45:25 -0800 (PST)
Date: Tue, 6 Dec 2016 09:48:35 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, fabrice.gasnier@st.com,
        gerald.baeza@st.com, arnaud.pouliquen@st.com,
        linus.walleij@linaro.org, linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v3 7/7] ARM: dts: stm32: add stm32 general purpose timer
 driver in DT
Message-ID: <20161206094835.GB25385@dell.home>
References: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
 <1480673842-20804-8-git-send-email-benjamin.gaignard@st.com>
 <20161202132251.GL2683@dell>
 <e15186cb-a93e-c2e7-13bb-6704be5e8949@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <e15186cb-a93e-c2e7-13bb-6704be5e8949@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 05 Dec 2016, Alexandre Torgue wrote:
> On 12/02/2016 02:22 PM, Lee Jones wrote:
> > On Fri, 02 Dec 2016, Benjamin Gaignard wrote:
> > 
> > > Add general purpose timers and it sub-nodes into DT for stm32f4.
> > > Define and enable pwm1 and pwm3 for stm32f469 discovery board
> > > 
> > > version 3:
> > > - use "st,stm32-timer-trigger" in DT
> > > 
> > > version 2:
> > > - use parameters to describe hardware capabilities
> > > - do not use references for pwm and iio timer subnodes
> > > 
> > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > > ---
> > >  arch/arm/boot/dts/stm32f429.dtsi      | 333 +++++++++++++++++++++++++++++++++-
> > >  arch/arm/boot/dts/stm32f469-disco.dts |  28 +++
> > >  2 files changed, 360 insertions(+), 1 deletion(-)

[...]

If you're only commenting on a little piece of the patch, it's always
a good idea to trim the rest.

> > > diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
> > > index 8a163d7..df4ca7e 100644
> > > --- a/arch/arm/boot/dts/stm32f469-disco.dts
> > > +++ b/arch/arm/boot/dts/stm32f469-disco.dts
> > > @@ -81,3 +81,31 @@
> > >  &usart3 {
> > >  	status = "okay";
> > >  };
> > > +
> > > +&gptimer1 {
> > > +	status = "okay";
> > > +
> > > +	pwm1@0 {
> > > +		pinctrl-0	= <&pwm1_pins>;
> > > +		pinctrl-names	= "default";
> > > +		status = "okay";
> > > +	};
> > > +
> > > +	timer1@0 {
> > > +		status = "okay";
> > > +	};
> > > +};
> > 
> > This is a much *better* format than before.
> > 
> > I still don't like the '&' syntax though.
> 
> Please keep "&" format to match with existing nodes.

Right.  I wasn't suggesting that he differs from the current format in
*this* set.  I am suggesting that we change the format in a subsequent
set though.

> > > +&gptimer3 {
> > > +	status = "okay";
> > > +
> > > +	pwm3@0 {
> > > +		pinctrl-0	= <&pwm3_pins>;
> > > +		pinctrl-names	= "default";
> > > +		status = "okay";
> > > +	};
> > > +
> > > +	timer3@0 {
> > > +		status = "okay";
> > > +	};
> > > +};
> > 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
