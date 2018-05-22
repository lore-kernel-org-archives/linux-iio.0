Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:41309 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752663AbeEVUyQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 May 2018 16:54:16 -0400
Date: Tue, 22 May 2018 15:54:13 -0500
From: Rob Herring <robh@kernel.org>
To: Siddartha Mohanadoss <smohanad@codeaurora.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        cdevired@codeaurora.org, rphani@codeaurora.org,
        sivaa@codeaurora.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add DT binding document for
 PMIC5 ADC
Message-ID: <20180522205413.GA28348@rob-hp-laptop>
References: <1525815501-27588-1-git-send-email-smohanad@codeaurora.org>
 <20180512111543.4f65dddd@archlinux>
 <18857b67-0865-7794-d981-87beb3f9c22f@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18857b67-0865-7794-d981-87beb3f9c22f@codeaurora.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, May 15, 2018 at 04:57:03PM -0700, Siddartha Mohanadoss wrote:
> Hi Jonathan,
> 
> Thanks for the comments.
> 
> 
> On 05/12/2018 03:15 AM, Jonathan Cameron wrote:
> > On Tue,  8 May 2018 14:38:21 -0700
> > Siddartha Mohanadoss <smohanad@codeaurora.org> wrote:
> > 
> > > PMIC5 ADC has support for clients to measure voltage and current
> > > on inputs connected to the PMIC. Clients include reading voltage
> > > phone power and on board system thermistors for thermal management.
> > > ADC5 on certain PMIC has support to read battery current.
> > > 
> > > This change adds documentation.
> > > 
> > > Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> > Hi Siddartha,
> > 
> > Some complexity in here!  Anyhow, a few comments inline and we will definitely
> > be wanting guidance from the devicetree people for this one.
> > 
> > Jonathan
> > 
> > > ---
> > >   .../devicetree/bindings/iio/adc/qcom,spmi-adc5.txt | 137 +++++++++++++++++++++
> > >   1 file changed, 137 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5.txt b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5.txt
> > > new file mode 100644
> > > index 0000000..c9268ba
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5.txt
> > > @@ -0,0 +1,137 @@
> > > +Qualcomm Technologies Inc. SPMI PMIC5 voltage and current ADC
> > > +
> > > +SPMI PMIC5 voltage ADC (ADC) provides interface to clients to read
> > > +voltage. The VADC is a 16-bit sigma-delta ADC.
> > > +
> > > +ADC node:
> > > +
> > > +- compatible:
> > > +    Usage: required
> > > +    Value type: <string>
> > > +    Definition: Should contain "qcom,spmi-adc5" for PMIC5 ADC driver.
> > > +		Should contain "qcom,spmi-adc-rev2" for PMIC refresh ADC driver.

Chip specific compatible strings please unless you convince me there are 
a large number of chips per above compatible.

Bindings are for hardware, not drivers.

> > > +
> > > +- reg:
> > > +    Usage: required
> > > +    Value type: <prop-encoded-array>
> > > +    Definition: VADC base address and length in the SPMI PMIC register map.
> > > +
> > > +- #address-cells:
> > > +    Usage: required
> > > +    Value type: <u32>
> > > +    Definition: Must be one. Child node 'reg' property should define ADC
> > > +            channel number.
> > > +
> > > +- #size-cells:
> > > +    Usage: required
> > > +    Value type: <u32>
> > > +    Definition: Must be zero.
> > > +
> > > +- #io-channel-cells:
> > > +    Usage: required
> > > +    Value type: <u32>
> > > +    Definition: Must be one. For details about IIO bindings see:
> > > +            Documentation/devicetree/bindings/iio/iio-bindings.txt
> > > +
> > > +- interrupts:
> > > +    Usage: optional
> > > +    Value type: <prop-encoded-array>
> > > +    Definition: End of conversion interrupt.
> > > +
> > > +Channel node properties:
> > > +
> > > +- reg:
> > > +    Usage: required
> > > +    Value type: <u32>
> > > +    Definition: ADC channel number.
> > > +            See include/dt-bindings/iio/qcom,spmi-vadc.h
> > > +
> > > +- label:
> > > +    Usage: required
> > > +    Value type: <empty>
> > > +    Definition: ADC datasheet channel name.
> > > +            For thermistor inputs connected to generic AMUX or GPIO inputs
> > > +            these can vary across platform for the same pins. Hence select
> > > +            the datasheet name for this channel.

Why do you need this? If the name comes from a datasheet list, then 
perhaps you should list the exact string here. Otherwise, there's a lot 
left to the user in terms of capitalization, etc.

> > > +
> > > +- qcom,pre-scaling:
> > > +    Usage: required
> > > +    Value type: <u32 array>
> > > +    Definition: Used for scaling the channel input signal before the signal is
> > > +            fed to VADC. The configuration for this node is to know the
> > > +            pre-determined ratio and use it for post scaling. Select one from
> > > +            the following options.
> > > +            <1 1>, <1 3>, <1 4>, <1 6>, <1 20>, <1 8>, <10 81>, <1 10>
> > > +            If property is not found default value depending on chip will be used.
> > > +
> > > +- qcom,decimation:
> > > +    Usage: optional
> > > +    Value type: <u32>
> > > +    Definition: This parameter is used to decrease ADC sampling rate.
> > > +            Quicker measurements can be made by reducing decimation ratio.
> > > +            For PMIC5 ADC, combined two step decimation values are 250, 420 and 840.
> > > +            If property is not found, default value of 840 will be used.
> > The odd indenting here needs sorting.  Mixture of spaces and tabs at the moment.
> Ok, will take a look.
> > Hmm. In someways this is a policy decision so should be pushed up to userspace,
> > but given the 'right' value will be somewhat dependent on what you are doing
> > with the channel and what is wired to it, it could arguably have a 'right' value
> > for a given circuit.  This is really just the sampling frequency wrapped
> > up in decimation of something, I'm guessing some input clock?
> Yes. It's number of samples collected over a 4.8MHz clock.
> The only reason to update this value would be if client wants to get
> the conversion results back sooner. Hence left this as an optional property.
> > 
> > Let's see what the Device-tree people think on this one!  Personally I have
> > never really minded devicetree providing sensible defaults.  We can put
> > control on these things later, if there is a usecase for changing them.

I don't have a problem with this in DT, though my first thought was it 
should be common. Then after reading some on decimation, I'm not sure it 
would always just be a single 32-bit value?

> > 
> > > +	    For PMIC refresh ADC, supported decimation values are 256, 512, 1024.
> > > +	    If property is not found, default value of 1024 will be used.
> > > +
> > > +- qcom,ratiometric:
> > > +    Usage: optional
> > > +    Value type: <empty>
> > > +    Definition: Channel calibration type. If this property is specified
> > > +            VADC will use the VDD reference (1.875V) and GND for channel
> > > +            calibration. If property is not found, channel will be
> > > +            calibrated with 0V and 1.25V reference channels, also
> > > +            known as absolute calibration.
> > > +
> > > +- qcom,hw-settle-time:
> > > +    Usage: optional
> > > +    Value type: <u32>
> > > +    Definition: Time between AMUX getting configured and the ADC starting
> > > +            conversion.
> > > +	    For PMIC5, delay = 15us for value 0,
> > > +			100us * (value) for values 0 < value < 11, and
> > > +            		2ms * (value - 10) otherwise.
> > > +            Valid values are: 15, 100, 200, 300, 400, 500, 600, 700, 800,
> > This description is very confusing given the different uses of 'value'
> > None of the values you have allowed is less than 11 so the first condition
> > doesn't apply.
> The 'value' is an index programmed in the hardware to achieve the
> hardware settling delay specified under valid values. I will update the
> documentation here.
> > 
> > > +            900 us and 1, 2, 4, 6, 8, 10 ms
> > > +            If property is not found, channel will use 15us.
> > > +	    For PMIC rev2, delay = 100us * (value) for values 0 < value < 11, and
> > > +			2ms * (value - 10) otherwise.
> > > +            Valid values are: 0, 100, 200, 300, 400, 500, 600, 700, 800,
> > > +            900 us and 1, 2, 4, 6, 8, 10 ms
> > > +            If property is not found, channel will use 0 us.
> > > +
> > > +- qcom,avg-samples:
> > > +    Usage: optional
> > > +    Value type: <u32>
> > > +    Definition: Number of samples to be used for measurement.
> > > +            Averaging provides the option to obtain a single measurement
> > > +            from the ADC that is an average of multiple samples. The value
> > > +            selected is 2^(value).
> > > +            Valid values are: 1, 2, 4, 8, 16
> > > +            If property is not found, 1 sample will be used.
> > As with decimation, this is arguably not a feature of the hardware, but
> > a software decision...

We already have a common property for touchscreens and vendor properties 
for a few ADCs, so we should define a common one.

Now, sadly, I've just found that all these properties are already 
defined in bindings/iio/adc/qcom,spmi-vadc.txt. Why didn't you add these 
compatibles to the existing binding. Then we're not reviewing the same 
thing again...

Rob
