Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52676 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237Ab3BCLjx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Feb 2013 06:39:53 -0500
Message-ID: <510E4C85.9060507@kernel.org>
Date: Sun, 03 Feb 2013 11:39:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: linux-iio@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>
Subject: Re: [RFC 10/11] iio: Add OF support
References: <1359668588-13678-1-git-send-email-linux@roeck-us.net> <1359668588-13678-11-git-send-email-linux@roeck-us.net> <510CEA6E.9010708@kernel.org> <20130202161054.GA10386@roeck-us.net>
In-Reply-To: <20130202161054.GA10386@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/02/2013 04:10 PM, Guenter Roeck wrote:
> On Sat, Feb 02, 2013 at 10:29:02AM +0000, Jonathan Cameron wrote:
>> On 01/31/2013 09:43 PM, Guenter Roeck wrote:
>>> Provide bindings, new API access functions, and parse OF data
>>> during initialization.
>>>
>> Firstly thanks for working on this Guenter, it's been a big hole
>> for a while largely because non of our largest developers were
>> actually using development platforms with device tree support.
>>
>> Given my knowledge of device tree is based on the odd article
>> and looking at similar sets of bindings this morning, my comments
>> are likely to be somewhat superficial and uninformed ;)
>>
>> Mostly on this one I'll take a back seat and let those who
>> know this stuff better come to a consensus.
>>
>> Jonathan
>>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>>  .../devicetree/bindings/iio/iio-bindings.txt       |   97 ++++++++
>>>  drivers/iio/inkern.c                               |  241 ++++++++++++++++----
>>>  include/linux/iio/consumer.h                       |    8 +
>>>  3 files changed, 299 insertions(+), 47 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/iio-bindings.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
>>> new file mode 100644
>>> index 0000000..0f51c95
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
>>> @@ -0,0 +1,97 @@
>>> +This binding is a work-in-progress, and are based on clock bindings and
>>> +suggestions from Lars-Peter Clausen [1].
>>> +
>>> +Sources of IIO channels can be represented by any node in the device
>>> +tree.  Those nodes are designated as IIO providers.  IIO consumer
>>> +nodes use a phandle and IIO specifier pair to connect IIO provider
>>> +outputs to IIO inputs.  Similar to the gpio specifiers, an IIO
>>> +specifier is an array of one more more cells identifying the IIO
>>> +output on a device.  The length of an IIO specifier is defined by the
>>> +value of a #io-channel-cells property in the clock provider node.
>>> +
>>> +[1] http://marc.info/?l=linux-iio&m=135902119507483&w=2
>>> +
>>> +==IIO providers==
>>> +
>>> +Required properties:
>>> +#io-channel-cells: Number of cells in an IIO specifier; Typically 0 for nodes
>>> +		   with a single IIO output and 1 for nodes with multiple
>>> +		   IIO outputs.
>>> +
>>> +Optional properties:
>>> +io-channel-output-names:
>>> +		    Recommended to be a list of strings of IIO output signal
>>> +		    names indexed by the first cell in the IIO specifier.
>>> +		    However, the meaning of io-channel-output-names is domain
>>> +		    specific to the IIO provider, and is only provided to
>>> +		    encourage using the same meaning for the majority of IIO
>>> +		    providers.  This format may not work for IIO providers
>>> +		    using a complex IIO specifier format.  In those cases it
>>> +		    is recommended to omit this property and create a binding
>>> +		    specific names property.
>>> +
>>> +		    IIO consumer nodes must never directly reference
>>> +		    the provider's io-channel-output-names property.
>>> +
>>> +For example:
>>> +
>>> +    adc: adc@35 {
>>> +	compatible = "maxim,max1139";
>>> +	reg = <0x35>;
>>> +        #io-channel-cells = <1>;
>>> +        io-channel-output-names = "adc1", "adc2";
>>> +    };
>>> +
>>> +- this node defines a device with two named IIO outputs, the first named
>>> +  "adc1" and the second named "adc2".  Consumer nodes always reference
>>> +  IIO channels by index. The names should reflect the IIO output signal
>>> +  names for the device.
>>> +
>>> +==IIO consumers==
>>> +
>>> +Required properties:
>>> +io-channels:	List of phandle and IIO specifier pairs, one pair
>>> +		for each IIO input to the device.  Note: if the
>>> +		IIO provider specifies '0' for #clock-cells, then
>>> +		only the phandle portion of the pair will appear.
>>> +
>>> +Optional properties:
>>> +io-channel-names:
>>> +		List of IIO input name strings sorted in the same
>>> +		order as the io-channels property.  Consumers drivers
>>> +		will use io-channel-names to match IIO input names
>>> +		with IIO specifiers.
>>> +io-channel-ranges:
>>> +		Empty property indicating that child nodes can inherit named
>>> +		IIO channels from this node. Useful for bus nodes to provide
>>> +		and IIO channel to their children.
>>> +
>>> +For example:
>>> +
>>> +    device {
>>> +        io-channels = <&adc 1>, <&ref 0>;
>>> +        io-channel-names = "vcc", "vdd";
>>> +    };
>>> +
>>> +This represents a device with two IIO inputs, named "vcc" and "vdd".
>>> +The vcc channel is connected to output 1 of the &adc device, and the
>>> +vdd channel is connected to output 0 of the &ref device.
>>> +
>>> +==Example==
>>> +
>>> +	adc: max1139@35 {
>>> +		compatible = "maxim,max1139";
>>> +		reg = <0x35>;
>>> +		#io-channel-cells = <1>;
>>> +	};
>>> +
>>> +	...
>>> +
>>> +	iio_hwmon {
>>> +		compatible = "iio-hwmon";
>>> +		io-channels = <&adc 0>, <&adc 1>, <&adc 2>,
>>> +			<&adc 3>, <&adc 4>, <&adc 5>,
>>> +			<&adc 6>, <&adc 7>, <&adc 8>,
>>> +			<&adc 9>, <&adc 10>, <&adc 11>;
>>> +		io-channel-names = "vcc", "vdd", "vref", "1.2V";
>> Having different numbers of channels and channel names seems
>> unusual... Deliberate or you got bored making up channel names?
>>
>> Why use indexed values for <&adc 0> etc rather than the output
>> channel names on adc?  For the iio_map stuff we initialy used
>> indexes but got a lot of responses that it was a silly idea and
>> naming was much more consistent and easy to follow.
>>
>> Is there a fundamental reason for it here?
>>
>> (note I don't mind either way as this seems more compact and cleaner
>> in some ways)
>>
> 
> It follows the structure used by clocks, which uses the provided name(s) to
> calculate an index into io-channels. This way, the provider does not have to
> provide the mapping, the consumer does not have to know the io-channel index,
> and the consumer code can call something like
> 
> 	channel = iio_get_channel(dev, "vcc");
> 
> In the above example, "vcc" will map to "<&adc, 0>", and "vref" to "<&adc, 2>".
> 
> This works for both platform data and OF data (though platform data will
> still need provider-based mapping, at least for now).
> 
> This lets the code use a static name (eg "vcc"), and the mapping to the actual
> provider happens through devicetree. Since the name is only used locally and
> consumer driver specific, there is no need to define globally unique names.
> 
> With this approach, the io channel map is not needed at all for the OF case.
> I had used it in this version of the patch set, but got rid of it now.
> 
> Actually, provider based mapping doesn't even work. If the consumer is
> instantiated before the provider, the mapping doesn't exist yet, and the
> call to iio_channel_get_all will fail. There is no way to prevent this,
> as providers can come online at any time and there is no means to enforce that
> all providers are already active by the time the consumers are instantiated.
> Even if a mapping exists, there is no way to know if it is complete, if a
> consumer is mapped to multiple providers.
> 
> With the consumer based mapping, iio_channel_get_all 'knows' that not all
> requested providers are available and can return -EPROBEDEFER in that case.
Thanks. That makes sense.  At the moment iio_hwmon is the only case that
does a 'get all'. Clearly things are easier when the driver is requesting a
specific set and we can do the back off much more easily.

> 
> As a side effect, we can also use the names - if provided - as channel
> labels in iio_hwmon.
> 
> Note this will require the iio_get_channel API to change from taking the
> consumer device name to taking the consumer device pointer as argument.
> This will enable it to work for both OF and non-OF cases, should address Lars'
> concerns about duplicate API functions, and synchronize the code to match how
> the clock framework works.

Agreed, doing this gives us a cleaner syntax as well.  Note there are other
users of that function in tree so be sure to get them all!

> 
> Thanks,
> Guenter
Thanks for the explanation.  What I was actually suggesting was something
like:

adc: max1139@35 {
		compatible = "maxim,max1139";
		reg = <0x35>;
		#io-channel-cells = <1>;
		io-channel-output-names = "adc1", "adc2", "adc3"				
	};

iio_hwmon {
	compatible = "iio-hwmon";
	io-channels = <&adc "adc1">, <&adc "adc2">, <&adc "adc3">,
	io-channel-names = "vcc", "vdd", "vref";
}

Having taken a look at the available syntax, those <> pairs have
to be unsigned integers?  Hence the additional level of indirection?

(sorry, I'm getting you to give me a tutorial on device tree syntax rather
than the actual issue here!)

I guess it was desirable to keep the syntax relatively simple but that occasionally
adds the requirement for a bit of indirection.



Jonathan

> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
