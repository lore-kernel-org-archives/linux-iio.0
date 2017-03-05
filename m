Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59679 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752444AbdCELPl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Mar 2017 06:15:41 -0500
Subject: Re: [RFC v2 2/7] IIO: Add bindings for simple sigma delta adc
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Rob Herring <robh@kernel.org>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-3-git-send-email-arnaud.pouliquen@st.com>
 <20170222151750.h5d7gycltwnk7b4t@rob-hp-laptop>
 <6943aaf5-b580-0fd1-7a2e-b99f7a266388@st.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "kernel@stlinux.com" <kernel@stlinux.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Olivier MOYSAN <olivier.moysan@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <dbf92596-d7b7-5bb0-2e59-cd54ffc78f4e@kernel.org>
Date: Sun, 5 Mar 2017 11:04:06 +0000
MIME-Version: 1.0
In-Reply-To: <6943aaf5-b580-0fd1-7a2e-b99f7a266388@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/02/17 11:15, Arnaud Pouliquen wrote:
> Hello Rob,
> 
> Please find my answers in-line
> 
> Regards,
> 
> Arnaud
> 
> On 02/22/2017 04:17 PM, Rob Herring wrote:
>> On Mon, Feb 13, 2017 at 05:38:24PM +0100, Arnaud Pouliquen wrote:
>>> Add documentation of device tree bindings to support
>>> sigma delta modulator in IIO framework.
>>>
>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>>> ---
>>>  Documentation/devicetree/bindings/iio/adc/simple_sd_adc.txt | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/simple_sd_adc.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/simple_sd_adc.txt b/Documentation/devicetree/bindings/iio/adc/simple_sd_adc.txt
>>> new file mode 100644
>>> index 0000000..2b3968a
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/adc/simple_sd_adc.txt
>>> @@ -0,0 +1,13 @@
>>> +Device-Tree bindings for simple sigma delta adc
>>
>> What makes it "simple"?
> "simple" sigma delta modulator are external chip that just converts
> analog signal in sigma delta modulation. No configuration needs.
> "Simple" is use to differentiate SD ADC that offers interfaces to
> activate some internal processing ( gain, offset compensation...)
My gut feeling would be to drop the term simple.  If device is more complex
it needs to be explicitly supported, hence will be named whatever!
> 
>>
>>> +
>>> +Required properties:
>>> +- compatible: should be "sd-modulator".
>>> +- #io-channel-cells = <1>: See the IIO bindings section "IIO consumers".
>>> +
>>> +Example node:
>>> +
>>> +	ads1202: simple_sd_adc@0 {
>>
>> Is ads1202 the actual chip? Then it should be in the compatible list.
> I tried to define a generic device to support several SD modulator
> chips, inspired by ALSA "dmic-codec" device.
> I have none exhaustive list of chip that can be handled by the driver,
> but i found several devices that could match...
> That why i did not use chip name in compatible list.
> What should be the best way to do it?
Rob, would the fallback approach (I brought this up in  another branch of
this discussion) work here,

compatible = "ads1201", "sd-modulator'?

Main advantage is that people won't then lie in their board files just to
avoid changing the driver to introduce their new part.  They'll just
be less specific than would be ideal.
> 
>>
>> unit address without a reg prop is an error. The node name should be 
>> "adc".
>>
>>> +		compatible = "sd-modulator";
>>> +		#io-channel-cells = <1>;
>>> +		status = "okay";
>>
>> Drop status from examples.
>>
>>> +	};
>>> -- 
>>> 1.9.1
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

