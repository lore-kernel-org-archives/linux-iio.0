Return-Path: <SRS0=wVVy=MX=chromium.org=mka@kernel.org>
Date: Thu, 11 Oct 2018 13:52:58 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Rob Herring <robh@kernel.org>
Cc: Andy Gross <andy.gross@linaro.org>,
	David Brown <david.brown@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: vadc: Update example to include
 unit address for node 'usb-id-nopull'
Message-ID: <20181011205258.GN22824@google.com>
References: <20181004001432.21218-1-mka@chromium.org>
 <20181004001432.21218-2-mka@chromium.org>
 <20181005204743.GA17135@bogus>
 <20181011191134.GM22824@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20181011191134.GM22824@google.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Oct 11, 2018 at 12:11:34PM -0700, Matthias Kaehlcke wrote:
> Hi Rob,
> 
> On Fri, Oct 05, 2018 at 03:47:43PM -0500, Rob Herring wrote:
> > On Wed, Oct 03, 2018 at 05:14:31PM -0700, Matthias Kaehlcke wrote:
> > > The node has a reg property, therefore its name should include a unit
> > > address.
> > > 
> > > Also change the name from 'usb_id_nopull' to 'usb-id-nopull' to follow
> > > DT conventions.
> > 
> > This is ADC channels?
> 
> yes
> 
> > If so, then DT convention would really be "adc@...". 
> 
> ok, will update
> 
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > > Changes in v4:
> > > - patch added to the series
> > > ---
> > >  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> > > index d0c188e5c922..ff7aa5038ba6 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> > > +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> > > @@ -112,7 +112,7 @@ Example:
> > >  		io-channel-ranges;
> > >  
> > >  		/* Channel node */
> > > -		usb_id_nopull {
> > > +		usb-id-nopull@VADC_LR_MUX10_USB_ID {
> > >  			reg = <VADC_LR_MUX10_USB_ID>;
> > 
> > Defines are generally used when there's not well defined numbering such 
> > as clock ids. Interrupts and addresses are generally well defined and 
> > don't need defines.
> 
> ok, I'll update this to use literals

Actually I'm not convinced literals are the right answer here. It
makes perfect sense for a standard ADC, with a 1:1 mapping of channel
number and physical input. However in case of the VADC/ADC5 there
can be multiple channel numbers per input pin, the different values
are used to select a certain 'configuration' (eg. ADC5_BAT_THERM,
ADC5_BAT_THERM_30K_PU, ADC5_BAT_THERM_100K_PU,
ADC5_BAT_THERM_400K_PU). IMO using integer channel numbers here would
be more error prone and obfuscating than using the defines.
