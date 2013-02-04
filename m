Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:28229 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711Ab3BDSBA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Feb 2013 13:01:00 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MHP00JCMJDIFGC0@mailout3.samsung.com> for
 linux-iio@vger.kernel.org; Tue, 05 Feb 2013 03:00:58 +0900 (KST)
Received: from amdc1227.localnet ([106.116.147.199])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MHP009TSJDKUR30@mmp2.samsung.com> for
 linux-iio@vger.kernel.org; Tue, 05 Feb 2013 03:00:58 +0900 (KST)
From: Tomasz Figa <t.figa@samsung.com>
To: devicetree-discuss@lists.ozlabs.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 4/4] iio: Add OF support
Date: Mon, 04 Feb 2013 19:00:55 +0100
Message-id: <1425676.koqAVBLNAe@amdc1227>
In-reply-to: <20130204175134.GA17776@roeck-us.net>
References: <1359853180-5664-1-git-send-email-linux@roeck-us.net>
 <20130204171214.GA23170@roeck-us.net> <20130204175134.GA17776@roeck-us.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Monday 04 of February 2013 09:51:34 Guenter Roeck wrote:
> On Mon, Feb 04, 2013 at 09:12:14AM -0800, Guenter Roeck wrote:
> > On Mon, Feb 04, 2013 at 12:14:52AM +0100, Tomasz Figa wrote:
> > > On Sunday 03 of February 2013 19:55:47 Lars-Peter Clausen wrote:
> > > > On 02/03/2013 06:30 PM, Tomasz Figa wrote:
> > > > > On Sunday 03 of February 2013 09:01:07 Guenter Roeck wrote:
> > > > >> On Sun, Feb 03, 2013 at 12:52:40PM +0100, Tomasz Figa wrote:
> > > > >>> On Sunday 03 of February 2013 12:29:23 Lars-Peter Clausen 
wrote:
> > > > >>>> On 02/03/2013 03:06 AM, Guenter Roeck wrote:
> > > > >>>>> On Sun, Feb 03, 2013 at 02:30:24AM +0100, Tomasz Figa wrote:
> > > > >>>>>> Hi Guenter,
> > > > >>>>>> 
> > > > >>>>>> Some comments inline.
> > > > >>>>>> 
> > > > >>>>>> On Saturday 02 of February 2013 16:59:40 Guenter Roeck 
wrote:
> > > > >>>>>>> Provide bindings and parse OF data during initialization.
> > > > >>>>>>> 
> > > > >>>>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > > >>>>>>> ---
> > > > >>>>>>> - Documentation update per feedback
> > > > >>>>>>> - Dropped io-channel-output-names from the bindings
> > > > >>>>>>> document.
> > > > >>>>>>> The
> > > > >>>>>>> property is not used in the code, and it is not entirely
> > > > >>>>>>> clear
> > > > >>>>>>> what
> > > > >>>>>>> it
> > > > >>>>>>> would be used for. If there is a need for it, we can add
> > > > >>>>>>> it back
> > > > >>>>>>> in
> > > > >>>>>>> later on.
> > > > >>>>>>> - Don't export OF specific API calls
> > > > >>>>>>> - For OF support, no longer depend on iio_map
> > > > >>>>>>> - Add #ifdef CONFIG_OF where appropriate, and ensure that
> > > > >>>>>>> the
> > > > >>>>>>> code
> > > > >>>>>>> still builds if it is not selected.
> > > > >>>>>>> - Change iio_channel_get to take device pointer as
> > > > >>>>>>> argument
> > > > >>>>>>> instead
> > > > >>>>>>> of
> > > > >>>>>>> device name. Retain old API as of_iio_channel_get_sys.
> > > > >>>>>>> - iio_channel_get now works for both OF and non-OF
> > > > >>>>>>> configurations.
> > > > >>>>>>> 
> > > > >>>>>>>  .../devicetree/bindings/iio/iio-bindings.txt       |   76
> > > > >>>>>>>  ++++++++
> > > > >>>>>>>  drivers/iio/inkern.c                               |  186
> > > > >>>>>>> 
> > > > >>>>>>> ++++++++++++++++++++ 2 files changed, 262 insertions(+)
> > > > >>>>>>> 
> > > > >>>>>>>  create mode 100644
> > > > >>>>>>> 
> > > > >>>>>>> Documentation/devicetree/bindings/iio/iio-bindings.txt
> > > > >>>>>>> 
> > > > >>>>>>> diff --git
> > > > >>>>>>> a/Documentation/devicetree/bindings/iio/iio-bindings.txt
> > > > >>>>>>> b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> > > > >>>>>>> new
> > > > >>>>>>> file
> > > > >>>>>>> mode
> > > > >>>>>>> 100644
> > > > >>>>>>> index 0000000..58df5f6
> > > > >>>>>>> --- /dev/null
> > > > >>>>>>> +++
> > > > >>>>>>> b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> > > > >>>>>>> @@ -0,0 +1,76 @@
> > > > >>>>>>> +This binding is a work-in-progress. It is derived from
> > > > >>>>>>> clock
> > > > >>>>>>> bindings,
> > > > >>>>>>> +and based on suggestions from Lars-Peter Clausen [1].
> > > > >>>>>>> +
> > > > >>>>>>> +Sources of IIO channels can be represented by any node in
> > > > >>>>>>> the
> > > > >>>>>>> device
> > > > >>>>>>> +tree.  Those nodes are designated as IIO providers.  IIO
> > > > >>>>>>> consumer
> > > > >>>>>>> +nodes use a phandle and IIO specifier pair to connect IIO
> > > > >>>>>>> provider
> > > > >>>>>>> +outputs to IIO inputs.  Similar to the gpio specifiers,
> > > > >>>>>>> an IIO
> > > > >>>>>>> +specifier is an array of one or more cells identifying
> > > > >>>>>>> the IIO
> > > > >>>>>>> +output on a device.  The length of an IIO specifier is
> > > > >>>>>>> defined
> > > > >>>>>>> by
> > > > >>>>>>> the
> > > > >>>>>>> +value of a #io-channel-cells property in the clock
> > > > >>>>>>> provider
> > > > >>>>>>> node.
> > > > >>>>>>> +
> > > > >>>>>>> +[1] http://marc.info/?l=linux-iio&m=135902119507483&w=2
> > > > >>>>>>> +
> > > > >>>>>>> +==IIO providers==
> > > > >>>>>>> +
> > > > >>>>>>> +Required properties:
> > > > >>>>>>> +#io-channel-cells: Number of cells in an IIO specifier;
> > > > >>>>>>> Typically 0
> > > > >>>>>>> for nodes +		   with a single IIO output and 1 for 
nodes
> > > > > 
> > > > > with
> > > > > 
> > > > >>>>>>> multiple +		   IIO outputs.
> > > > >>>>>>> +
> > > > >>>>>>> +For example:
> > > > >>>>>>> +
> > > > >>>>>>> +    adc: adc@35 {
> > > > >>>>>>> +	compatible = "maxim,max1139";
> > > > >>>>>>> +	reg = <0x35>;
> > > > >>>>>>> +        #io-channel-cells = <1>;
> > > > >>>>>>> +    };
> > > > >>>>>>> +
> > > > >>>>>>> +==IIO consumers==
> > > > >>>>>>> +
> > > > >>>>>>> +Required properties:
> > > > >>>>>>> +io-channels:	List of phandle and IIO specifier pairs, 
one
> > > > > 
> > > > > pair
> > > > > 
> > > > >>>>>>> +		for each IIO input to the device.  Note: if the
> > > > >>>>>>> +		IIO provider specifies '0' for #clock-cells, then
> > > > >>>>>>> +		only the phandle portion of the pair will appear.
> > > > >>>>>>> +
> > > > >>>>>>> +Optional properties:
> > > > >>>>>>> +io-channel-names:
> > > > >>>>>>> +		List of IIO input name strings sorted in the same
> > > > >>>>>>> +		order as the io-channels property.  Consumers
> > > 
> > > drivers
> > > 
> > > > >>>>>>> +		will use io-channel-names to match IIO input names
> > > > >>>>>>> +		with IIO specifiers.
> > > > >>>>>>> +io-channel-ranges:
> > > > >>>>>>> +		Empty property indicating that child nodes can
> > > 
> > > inherit
> > > 
> > > > >>> named
> > > > >>> 
> > > > >>>>>>> +		IIO channels from this node. Useful for bus nodes
> > > 
> > > to
> > > 
> > > > >>> provide
> > > > >>> 
> > > > >>>>>>> +		and IIO channel to their children.
> > > > >>>>>>> +
> > > > >>>>>>> +For example:
> > > > >>>>>>> +
> > > > >>>>>>> +    device {
> > > > >>>>>>> +        io-channels = <&adc 1>, <&ref 0>;
> > > > >>>>>>> +        io-channel-names = "vcc", "vdd";
> > > > >>>>>>> +    };
> > > > >>>>>>> +
> > > > >>>>>>> +This represents a device with two IIO inputs, named "vcc"
> > > > >>>>>>> and
> > > > >>>>>>> "vdd".
> > > > >>>>>>> +The vcc channel is connected to output 1 of the &adc
> > > > >>>>>>> device,
> > > > >>>>>>> and
> > > > >>>>>>> the
> > > > >>>>>>> +vdd channel is connected to output 0 of the &ref device.
> > > > >>>>>>> +
> > > > >>>>>>> +==Example==
> > > > >>>>>>> +
> > > > >>>>>>> +	adc: max1139@35 {
> > > > >>>>>>> +		compatible = "maxim,max1139";
> > > > >>>>>>> +		reg = <0x35>;
> > > > >>>>>>> +		#io-channel-cells = <1>;
> > > > >>>>>>> +	};
> > > > >>>>>>> +
> > > > >>>>>>> +	...
> > > > >>>>>>> +
> > > > >>>>>>> +	iio_hwmon {
> > > > >>>>>>> +		compatible = "iio-hwmon";
> > > > >>>>>>> +		io-channels = <&adc 0>, <&adc 1>, <&adc 2>,
> > > > >>>>>>> +			<&adc 3>, <&adc 4>, <&adc 5>,
> > > > >>>>>>> +			<&adc 6>, <&adc 7>, <&adc 8>,
> > > > >>>>>>> +			<&adc 9>, <&adc 10>, <&adc 11>;
> > > > >>>>>>> +		io-channel-names = "vcc", "vdd", "vref", "1.2V";
> > > > >>>>>>> +	};
> > > > >>>>>>> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > > > >>>>>>> index b289915..d48f2a8 100644
> > > > >>>>>>> --- a/drivers/iio/inkern.c
> > > > >>>>>>> +++ b/drivers/iio/inkern.c
> > > > >>>>>>> @@ -10,6 +10,7 @@
> > > > >>>>>>> 
> > > > >>>>>>>  #include <linux/export.h>
> > > > >>>>>>>  #include <linux/slab.h>
> > > > >>>>>>>  #include <linux/mutex.h>
> > > > >>>>>>> 
> > > > >>>>>>> +#include <linux/of.h>
> > > > >>>>>>> 
> > > > >>>>>>>  #include <linux/iio/iio.h>
> > > > >>>>>>>  #include "iio_core.h"
> > > > >>>>>>> 
> > > > >>>>>>> @@ -92,6 +93,179 @@ static const struct iio_chan_spec
> > > > >>>>>>> 
> > > > >>>>>>>  	return chan;
> > > > >>>>>>>  
> > > > >>>>>>>  }
> > > > >>>>>>> 
> > > > >>>>>>> +#ifdef CONFIG_OF
> > > > >>>>>>> +
> > > > >>>>>>> +static int iio_dev_node_match(struct device *dev, void
> > > > >>>>>>> *data)
> > > > >>>>>>> +{
> > > > >>>>>>> +	return !strcmp(dev->type->name, "iio_device") && dev-
> > > >
> > > >of_node
> > > >
> > > > >>> ==
> > > > >>> 
> > > > >>>>>> data;
> > > > >>>>>> 
> > > > >>>>>> Hmm, do you need to check type name here? One device node
> > > > >>>>>> should
> > > > >>>>>> rather
> > > > >>>>>> represent only one device, making node an unique
> > > > >>>>>> identifier.
> > > > >>>>>> 
> > > > >>>>>> It this is meant to be a sanity check, it could be done one
> > > > >>>>>> time
> > > > >>>>>> after
> > > > >>>>>> finding the device.
> > > > >>>>> 
> > > > >>>>> Hi Tomasz,
> > > > >>>>> 
> > > > >>>>> This is what Lars had suggested earlier:
> > > > >>>>>> Yes, use bus_find_device on iio_bus_type. A nice example
> > > > >>>>>> how to
> > > > >>>>>> use
> > > > >>>>>> this to lookup device by of node is
> > > > >>>>>> of_find_i2c_device_by_node.
> > > > >>>>>> For
> > > > >>>>>> IIO you also need to make sure that dev->type is
> > > > >>>>>> iio_dev_type,
> > > > >>>>>> since
> > > > >>>>>> both devices and triggers are registered on the same bus.
> > > > >>>>> 
> > > > >>>>> Is it really needed, or in other words would it be
> > > > >>>>> sufficient to
> > > > >>>>> check
> > > > >>>>> if of_node and data match each other ? Your reasoning makes
> > > > >>>>> sense
> > > > >>>>> to
> > > > >>>>> me, and I had thought about it as well, but I don't really
> > > > >>>>> know,
> > > > >>>>> and
> > > > >>>>> I don't know how I could test it and guarantee correctness
> > > > >>>>> either.
> > > > >>>>> I'll be happy to take the strcmp() out if someone tells me
> > > > >>>>> that it
> > > > >>>>> is
> > > > >>>>> definitely not needed ...
> > > > >>>> 
> > > > >>>> A IIO trigger and a IIO device may have the same of_node,
> > > > >>>> e.g. if
> > > > >>>> they
> > > > >>>> both belong to the same physical device. But you don't need
> > > > >>>> to do
> > > > >>>> the
> > > > >>>> strcmp just compare dev->type to iio_dev_type i.e. dev->type
> > > > >>>> ==
> > > > >>>> &iio_dev_type. Although it doesn't really matter in practice
> > > > >>>> first
> > > > >>>> check for the of_node then check for the type, since the
> > > > >>>> of_node
> > > > >>>> will
> > > > >>>> only match for a few devices at most, the type will match for
> > > > >>>> quite
> > > > >>>> a
> > > > >>>> few.
> > > > >>> 
> > > > >>> I must disagree.
> > > > >>> 
> > > > >>> If you have two IIO devices provided by one physical device,
> > > > >>> then in
> > > > >>> 
> > > > >>> device tree they should be represented as follows:
> > > > >>> 	phys-dev@12345678 {
> > > > >>> 	
> > > > >>> 		compatible = "some-physical-device";
> > > > >>> 		/* ... */
> > > > >>> 		
> > > > >>> 		my_trig: iio-trigger {
> > > > >>> 		
> > > > >>> 			/* ... */
> > > > >>> 		
> > > > >>> 		};
> > > > >>> 		
> > > > >>> 		my_dev: iio-device {
> > > > >>> 		
> > > > >>> 			/* ... */
> > > > >>> 		
> > > > >>> 		};
> > > > >>> 	
> > > > >>> 	};
> > > > >>> 
> > > > >>> Notice that phys-dev works here as an IIO bus on which its IIO
> > > > >>> devices
> > > > >>> are available. This is related to the convention that single
> > > > >>> OF
> > > > >>> device node represents single device, which would be violated
> > > > >>> otherwise.
> > > > >> 
> > > > >> Right now the iio device is a child of the physical device, and
> > > > >> I am
> > > > >> simply passing of_node on to it. guess you are saying that is
> > > > >> not
> > > > >> correct ?
> > > > >> 
> > > > >> If so, what would be the correct approach ? Something like the
> > > > >> following ?
> > > > >> 
> > > > >> 	voltage-sensor@35 {
> > > > >> 	
> > > > >> 		compatible = "maxim,max1139";
> > > > >> 		reg = <0x35>;
> > > > >> 		vcc-supply = <&reg_3p3v>;
> > > > >> 		vref-supply = <&reg_3p3v>;
> > > > >> 		
> > > > >> 		max1139-iio: iio-device {
> > > > >> 		
> > > > >> 			device_type = "iio_device";
> > > > >> 			#io-channel-cells = <1>;
> > > > >> 		
> > > > >> 		};
> > > > >> 	
> > > > >> 	};
> > > > >> 
> > > > >> and in the driver probe function:
> > > > >> 	if (parent->of_node)
> > > > >> 	
> > > > >> 		iio_dev->dev.of_node = of_find_node_by_type(parent-
> > > >
> > > >of_node,
> > > >
> > > > >> "iio_device");
> > > > >> 
> > > > >> Another option would be to use of_find_compatible_node() and
> > > > >> something
> > > > >> like compatible = "iio-device";
> > > > >> in the iio-device node.
> > > > > 
> > > > > A device node is defined as a node having compatible property.
> > > > > Other
> > > > > nodes should be seen as helper nodes, which do not represent
> > > > > devices
> > > > > (although they all have struct device_node in Linux).
> > > > > 
> > > > > Also, AFAIK, device_type is a deprecated property used by some
> > > > > legacy
> > > > > PowerPC machines and for current machines only compatible should
> > > > > be
> > > > > used.
> > > > > 
> > > > > So I guess the approach with compatible would be appropriate
> > > > > here.
> > > > > 
> > > > > However for physical devices providing only a single IIO device
> > > > > it
> > > > > might>
> > > > > 
> > > > > be better to allow simpler specification, like:
> > > > >  	max1139-iio: voltage-sensor@35 {
> > > > >  	
> > > > >  		compatible = "maxim,max1139", "iio_device";
> > > > 
> > > > I don't think this makes a lot of sense. First of all iio_device
> > > > an
> > > > artificial Linux term, while the device tree should describe the
> > > > hardware.
> > > 
> > > Well, if you look at an iio_device as a subdevice of a physical
> > > device
> > > then it should make a bit more sense. (See nodes of GPIO/pinctrl pin
> > > banks or regulators of a PMIC chip.)
> > > 
> > > > Secondly there is no generic iio driver which could match on
> > > > a node with a "iio_device" compability string and stuff would just
> > > > work. I mean we don't do
> > > > 
> > > > compatible = "atmel,at91sam9260-i2c", "i2c-master";
> > > > 
> > > > or similar either.
> > > 
> > > Right. We don't need the other compatible for simple devices with
> > > single subdevice. This is implied by the driver registering a
> > > single IIO driver using the node of physical device.
> > > 
> > > > >  		reg = <0x35>;
> > > > >  		vcc-supply = <&reg_3p3v>;
> > > > >  		vref-supply = <&reg_3p3v>;
> > > > > 		
> > > > > 		device_type = "iio_device";
> > > 
> > > Also we don't need this device_type. Basically we don't need to
> > > specify
> > > whether given node is an iio_device or an iio_trigger. It's up to
> > > the
> > > driver to register the node as a device or a trigger by setting
> > > dev.of_node field properly.
> > > 
> > > So my suggestion would be to make the bindings as following. For
> > > single
> > > 
> > > subdevice:
> > > 	voltage-sensor@35 {
> > > 	
> > > 		compatible = "maxim,max1139";
> > > 		reg = <0x35>;
> > > 		vcc-supply = <&reg_3p3v>;
> > > 		vref-supply = <&reg_3p3v>;
> > > 		#io-channel-cells = <1>;
> > > 	
> > > 	};
> > > 
> > > For multiple subdevices:
> > > 	voltage-sensor@35 {
> > > 	
> > > 		compatible = "maxim,max1139";
> > > 		reg = <0x35>;
> > > 		vcc-supply = <&reg_3p3v>;
> > > 		vref-supply = <&reg_3p3v>;
> > > 		
> > > 		subdevice1 {
> > > 		
> > > 			/* Subdevice specific data */
> > > 			#io-channel-cells = <1>;
> > > 		
> > > 		};
> > > 		
> > > 		subdevice2 {
> > > 		
> > > 			/* Subdevice specific data */
> > > 			#io-channel-cells = <1>;
> > > 		
> > > 		}
> > 
> > Please provide an example how to parse that. Obviously now I can not
> > look for "compatible" anymore. Sure, I can use of_get_child_by_name,
> > but that means the sub-device names would have to be well defined. Or
> > I could use of_find_node_by_name, but then I would need something
> > like
> > 
> >  	voltage-sensor@35 {
> >  	
> >  		compatible = "maxim,max1139";
> > 		
> > 		iio-device;
> > 		
> >  		reg = <0x35>;
> >  		vcc-supply = <&reg_3p3v>;
> >  		vref-supply = <&reg_3p3v>;
> >  		#io-channel-cells = <1>;
> >  	
> >  	};
> 
> Never mind. My brain is really too flu-foggy to do anything.
> 
> Looks like I can use of_find_node_by_name if subdevice1 and subdevice2
> have well defined names such as iio-device or iio-trigger. It might
> even be possible to encode multiple iio subdevices in names such as
> iio-device@0 and iio-device@1. But that would (or not ?) mean that the
> names should be something like the following for consistency.
> 
> 	iio-device@35 {
> 		compatible = "maxim,max1139";
> 		reg = <0x35>;
> 		vcc-supply = <&reg_3p3v>;
> 		vref-supply = <&reg_3p3v>;
> 		#io-channel-cells = <1>;
> 	};
> 
> For multiple subdevices:
> 
> 	voltage-sensor@35 {
> 		compatible = "maxim,max1139";
> 		reg = <0x35>;
> 		vcc-supply = <&reg_3p3v>;
> 		vref-supply = <&reg_3p3v>;
> 
> 		iio-device {
> 			/* Subdevice specific data */
> 			#io-channel-cells = <1>;
> 		};
> 
> 		iio-trigger {
> 			/* Subdevice specific data */
> 			#io-channel-cells = <1>;
> 		}
> 
> Does that make sense ?

Do you need to parse this from generic code at all?

A particular IIO device driver gets a pointer to voltage-sensor@35 node in 
its dev.of_node. In case of a simple device without multiple subdevices, 
the driver will set the of_node field of iio_device.dev (or 
iio_trigger.dev) field and register the iio_device using 
iio_device_register() (or iio_trigger_register()).

In case of multiple subdevices, the driver (not generic code) will iterate 
over its child nodes and registers iio_devices and/or iio_triggers with 
appropriate nodes set in iio_device/iio_trigger structs.

All the generic code should do is parsing the phandles in client nodes, 
looking up to which devices they belong and translating phandle arguments 
to channel numbers.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Linux Platform

