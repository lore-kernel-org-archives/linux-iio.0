Return-Path: <jonathan.cameron@huawei.com>
Date: Mon, 23 Oct 2017 14:09:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
CC: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <benjamin.gaignard@linaro.org>,
        <lars@metafoo.de>, <alexandre.torgue@st.com>,
        <linux-iio@vger.kernel.org>, <pmeerw@pmeerw.net>,
        <linux@armlinux.org.uk>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>, <knaack.h@gmx.de>,
        <linux-arm-kernel@lists.infradead.org>, <benjamin.gaignard@st.com>
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: stm32: add support for diff
 channels
Message-ID: <20171023140956.00002613@huawei.com>
In-Reply-To: <0726f676-0440-afbe-f275-ec7fdaa29c9f@st.com>
References: <1508246145-19417-1-git-send-email-fabrice.gasnier@st.com>
	<1508246145-19417-2-git-send-email-fabrice.gasnier@st.com>
	<20171021185401.529f2eb2@archlinux>
	<20171021202327.51dd2855@archlinux>
	<0726f676-0440-afbe-f275-ec7fdaa29c9f@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Mon, 23 Oct 2017 10:06:27 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> On 10/21/2017 09:23 PM, Jonathan Cameron wrote:
> > On Sat, 21 Oct 2017 18:54:01 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> >> On Tue, 17 Oct 2017 15:15:43 +0200
> >> Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
> >>  
> >>> STM32H7 ADC channels may be configured either as single-ended or
> >>> differential.
> >>> Add 'st,adc-diff-channels' property to support differential channels.
> >>> Differential channels are defined as a pair of positive and negative
> >>> inputs: vinp & vinn.
> >>>
> >>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>    
> >> Hmm. Fair enough.  Sometimes we support both types of channels
> >> and leave it to userspace, but in many cases that makes little sense
> >> - particularly if like I think is going on here, we aren't combining channels
> >> that can be separately read but rather the negative pin is simply unused
> >> when we are in single channel mode... (did I understand that right?)  
> > I clearly didn't understand.  This is same as other devices
> > in that we are picking a pair from the channels that can otherwise be
> > used as single end channels. (I think).   
> 
> Hi Jonathan,
> 
> Indeed, we're picking a pair from the channels that can be used as
> single channels otherwise.
> Also, it doesn't makes sense to leave the choice to userspace: when
> these channels are used in differential mode, both input should be
> biased. This is quite dependent on hardware (board), not really a
> runtime choice.
> Hope this clarifies ?
> 
> > 
> > For this binding I think I'd like to see an example added showing how
> > this works...  
> 
> You're right, I should have added that. Please let me know if I can add
> bellow example in v2:
Looks good to me.

Jonathan
> 
> Example to setup differential channels 1, 2 & 3 (with resp. 0, 6 & 7
> negative inputs):
> 	adc: adc@40022000 {
> 		compatible = "st,stm32h7-adc-core";
> 		...
> 		adc1: adc@0 {
> 			compatible = "st,stm32h7-adc";
> 			...
> 			st,adc-diff-channels = <1 0>, <2 6>, <3 7>;
> 		};
> 	};
> 
> Thanks for reviewing,
> Best Regards,
> Fabrice
> 
> > 
> > Thanks,
> > 
> > Jonathan  
> >>
> >> Jonathan
> >>  
> >>> ---
> >>>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 6 ++++++
> >>>  1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> >>> index 48bfcaa3..c3c8de1 100644
> >>> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> >>> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> >>> @@ -62,6 +62,12 @@ Required properties:
> >>>  - st,adc-channels: List of single-ended channels muxed for this ADC.
> >>>    It can have up to 16 channels on stm32f4 or 20 channels on stm32h7, numbered
> >>>    from 0 to 15 or 19 (resp. for in0..in15 or in0..in19).
> >>> +- st,adc-diff-channels: List of differential channels muxed for this ADC.
> >>> +  Depending on part used, some channels can be configured as differential
> >>> +  instead of single-ended (e.g. stm32h7). List here positive and negative
> >>> +  inputs pairs as <vinp vinn>, <vinp vinn>,... vinp and vinn are numbered
> >>> +  from 0 to 19 on stm32h7)
> >>> +  Note: At least one of "st,adc-channels" or "st,adc-diff-channels" is required.
> >>>  - #io-channel-cells = <1>: See the IIO bindings section "IIO consumers" in
> >>>    Documentation/devicetree/bindings/iio/iio-bindings.txt
> >>>      
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html  
> >   
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
