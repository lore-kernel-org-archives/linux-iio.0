Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:61827 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944Ab3BCRas (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Feb 2013 12:30:48 -0500
Received: by mail-ee0-f45.google.com with SMTP id b57so2844775eek.4
        for <linux-iio@vger.kernel.org>; Sun, 03 Feb 2013 09:30:47 -0800 (PST)
From: Tomasz Figa <tomasz.figa@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Doug Anderson <dianders@chromium.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>
Subject: Re: [PATCH v2 4/4] iio: Add OF support
Date: Sun, 03 Feb 2013 18:30:47 +0100
Message-ID: <2327792.dx5ptVD6je@flatron>
In-Reply-To: <20130203170107.GD21576@roeck-us.net>
References: <1359853180-5664-1-git-send-email-linux@roeck-us.net> <1915802.t7OItgMRJy@flatron> <20130203170107.GD21576@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sunday 03 of February 2013 09:01:07 Guenter Roeck wrote:
> On Sun, Feb 03, 2013 at 12:52:40PM +0100, Tomasz Figa wrote:
> > On Sunday 03 of February 2013 12:29:23 Lars-Peter Clausen wrote:
> > > On 02/03/2013 03:06 AM, Guenter Roeck wrote:
> > > > On Sun, Feb 03, 2013 at 02:30:24AM +0100, Tomasz Figa wrote:
> > > >> Hi Guenter,
> > > >> 
> > > >> Some comments inline.
> > > >> 
> > > >> On Saturday 02 of February 2013 16:59:40 Guenter Roeck wrote:
> > > >>> Provide bindings and parse OF data during initialization.
> > > >>> 
> > > >>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > >>> ---
> > > >>> - Documentation update per feedback
> > > >>> - Dropped io-channel-output-names from the bindings document.
> > > >>> The
> > > >>> property is not used in the code, and it is not entirely clear
> > > >>> what
> > > >>> it
> > > >>> would be used for. If there is a need for it, we can add it back
> > > >>> in
> > > >>> later on.
> > > >>> - Don't export OF specific API calls
> > > >>> - For OF support, no longer depend on iio_map
> > > >>> - Add #ifdef CONFIG_OF where appropriate, and ensure that the
> > > >>> code
> > > >>> still builds if it is not selected.
> > > >>> - Change iio_channel_get to take device pointer as argument
> > > >>> instead
> > > >>> of
> > > >>> device name. Retain old API as of_iio_channel_get_sys.
> > > >>> - iio_channel_get now works for both OF and non-OF
> > > >>> configurations.
> > > >>> 
> > > >>>  .../devicetree/bindings/iio/iio-bindings.txt       |   76
> > > >>>  ++++++++
> > > >>>  drivers/iio/inkern.c                               |  186
> > > >>> 
> > > >>> ++++++++++++++++++++ 2 files changed, 262 insertions(+)
> > > >>> 
> > > >>>  create mode 100644
> > > >>> 
> > > >>> Documentation/devicetree/bindings/iio/iio-bindings.txt
> > > >>> 
> > > >>> diff --git
> > > >>> a/Documentation/devicetree/bindings/iio/iio-bindings.txt
> > > >>> b/Documentation/devicetree/bindings/iio/iio-bindings.txt new
> > > >>> file
> > > >>> mode
> > > >>> 100644
> > > >>> index 0000000..58df5f6
> > > >>> --- /dev/null
> > > >>> +++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> > > >>> @@ -0,0 +1,76 @@
> > > >>> +This binding is a work-in-progress. It is derived from clock
> > > >>> bindings,
> > > >>> +and based on suggestions from Lars-Peter Clausen [1].
> > > >>> +
> > > >>> +Sources of IIO channels can be represented by any node in the
> > > >>> device
> > > >>> +tree.  Those nodes are designated as IIO providers.  IIO
> > > >>> consumer
> > > >>> +nodes use a phandle and IIO specifier pair to connect IIO
> > > >>> provider
> > > >>> +outputs to IIO inputs.  Similar to the gpio specifiers, an IIO
> > > >>> +specifier is an array of one or more cells identifying the IIO
> > > >>> +output on a device.  The length of an IIO specifier is defined
> > > >>> by
> > > >>> the
> > > >>> +value of a #io-channel-cells property in the clock provider
> > > >>> node.
> > > >>> +
> > > >>> +[1] http://marc.info/?l=linux-iio&m=135902119507483&w=2
> > > >>> +
> > > >>> +==IIO providers==
> > > >>> +
> > > >>> +Required properties:
> > > >>> +#io-channel-cells: Number of cells in an IIO specifier;
> > > >>> Typically 0
> > > >>> for nodes +		   with a single IIO output and 1 for nodes 
with
> > > >>> multiple +		   IIO outputs.
> > > >>> +
> > > >>> +For example:
> > > >>> +
> > > >>> +    adc: adc@35 {
> > > >>> +	compatible = "maxim,max1139";
> > > >>> +	reg = <0x35>;
> > > >>> +        #io-channel-cells = <1>;
> > > >>> +    };
> > > >>> +
> > > >>> +==IIO consumers==
> > > >>> +
> > > >>> +Required properties:
> > > >>> +io-channels:	List of phandle and IIO specifier pairs, one 
pair
> > > >>> +		for each IIO input to the device.  Note: if the
> > > >>> +		IIO provider specifies '0' for #clock-cells, then
> > > >>> +		only the phandle portion of the pair will appear.
> > > >>> +
> > > >>> +Optional properties:
> > > >>> +io-channel-names:
> > > >>> +		List of IIO input name strings sorted in the same
> > > >>> +		order as the io-channels property.  Consumers drivers
> > > >>> +		will use io-channel-names to match IIO input names
> > > >>> +		with IIO specifiers.
> > > >>> +io-channel-ranges:
> > > >>> +		Empty property indicating that child nodes can inherit
> > 
> > named
> > 
> > > >>> +		IIO channels from this node. Useful for bus nodes to
> > 
> > provide
> > 
> > > >>> +		and IIO channel to their children.
> > > >>> +
> > > >>> +For example:
> > > >>> +
> > > >>> +    device {
> > > >>> +        io-channels = <&adc 1>, <&ref 0>;
> > > >>> +        io-channel-names = "vcc", "vdd";
> > > >>> +    };
> > > >>> +
> > > >>> +This represents a device with two IIO inputs, named "vcc" and
> > > >>> "vdd".
> > > >>> +The vcc channel is connected to output 1 of the &adc device,
> > > >>> and
> > > >>> the
> > > >>> +vdd channel is connected to output 0 of the &ref device.
> > > >>> +
> > > >>> +==Example==
> > > >>> +
> > > >>> +	adc: max1139@35 {
> > > >>> +		compatible = "maxim,max1139";
> > > >>> +		reg = <0x35>;
> > > >>> +		#io-channel-cells = <1>;
> > > >>> +	};
> > > >>> +
> > > >>> +	...
> > > >>> +
> > > >>> +	iio_hwmon {
> > > >>> +		compatible = "iio-hwmon";
> > > >>> +		io-channels = <&adc 0>, <&adc 1>, <&adc 2>,
> > > >>> +			<&adc 3>, <&adc 4>, <&adc 5>,
> > > >>> +			<&adc 6>, <&adc 7>, <&adc 8>,
> > > >>> +			<&adc 9>, <&adc 10>, <&adc 11>;
> > > >>> +		io-channel-names = "vcc", "vdd", "vref", "1.2V";
> > > >>> +	};
> > > >>> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > > >>> index b289915..d48f2a8 100644
> > > >>> --- a/drivers/iio/inkern.c
> > > >>> +++ b/drivers/iio/inkern.c
> > > >>> @@ -10,6 +10,7 @@
> > > >>> 
> > > >>>  #include <linux/export.h>
> > > >>>  #include <linux/slab.h>
> > > >>>  #include <linux/mutex.h>
> > > >>> 
> > > >>> +#include <linux/of.h>
> > > >>> 
> > > >>>  #include <linux/iio/iio.h>
> > > >>>  #include "iio_core.h"
> > > >>> 
> > > >>> @@ -92,6 +93,179 @@ static const struct iio_chan_spec
> > > >>> 
> > > >>>  	return chan;
> > > >>>  
> > > >>>  }
> > > >>> 
> > > >>> +#ifdef CONFIG_OF
> > > >>> +
> > > >>> +static int iio_dev_node_match(struct device *dev, void *data)
> > > >>> +{
> > > >>> +	return !strcmp(dev->type->name, "iio_device") && dev->of_node
> > 
> > ==
> > 
> > > >> data;
> > > >> 
> > > >> Hmm, do you need to check type name here? One device node should
> > > >> rather
> > > >> represent only one device, making node an unique identifier.
> > > >> 
> > > >> It this is meant to be a sanity check, it could be done one time
> > > >> after
> > > >> finding the device.
> > > > 
> > > > Hi Tomasz,
> > > > 
> > > > This is what Lars had suggested earlier:
> > > >> Yes, use bus_find_device on iio_bus_type. A nice example how to
> > > >> use
> > > >> this to lookup device by of node is of_find_i2c_device_by_node.
> > > >> For
> > > >> IIO you also need to make sure that dev->type is iio_dev_type,
> > > >> since
> > > >> both devices and triggers are registered on the same bus.
> > > > 
> > > > Is it really needed, or in other words would it be sufficient to
> > > > check
> > > > if of_node and data match each other ? Your reasoning makes sense
> > > > to
> > > > me, and I had thought about it as well, but I don't really know,
> > > > and
> > > > I don't know how I could test it and guarantee correctness either.
> > > > I'll be happy to take the strcmp() out if someone tells me that it
> > > > is
> > > > definitely not needed ...
> > > 
> > > A IIO trigger and a IIO device may have the same of_node, e.g. if
> > > they
> > > both belong to the same physical device. But you don't need to do
> > > the
> > > strcmp just compare dev->type to iio_dev_type i.e. dev->type ==
> > > &iio_dev_type. Although it doesn't really matter in practice first
> > > check for the of_node then check for the type, since the of_node
> > > will
> > > only match for a few devices at most, the type will match for quite
> > > a
> > > few.
> > 
> > I must disagree.
> > 
> > If you have two IIO devices provided by one physical device, then in
> > 
> > device tree they should be represented as follows:
> > 	phys-dev@12345678 {
> > 	
> > 		compatible = "some-physical-device";
> > 		/* ... */
> > 		
> > 		my_trig: iio-trigger {
> > 		
> > 			/* ... */
> > 		
> > 		};
> > 		
> > 		my_dev: iio-device {
> > 		
> > 			/* ... */
> > 		
> > 		};
> > 	
> > 	};
> > 
> > Notice that phys-dev works here as an IIO bus on which its IIO devices
> > are available. This is related to the convention that single OF
> > device node represents single device, which would be violated
> > otherwise.
> 
> Right now the iio device is a child of the physical device, and I am
> simply passing of_node on to it. guess you are saying that is not
> correct ?
> 
> If so, what would be the correct approach ? Something like the following
> ?
> 
> 	voltage-sensor@35 {
> 		compatible = "maxim,max1139";
> 		reg = <0x35>;
> 		vcc-supply = <&reg_3p3v>;
> 		vref-supply = <&reg_3p3v>;
> 
> 		max1139-iio: iio-device {
> 			device_type = "iio_device";
> 			#io-channel-cells = <1>;
> 		};
> 	};
> 
> and in the driver probe function:
> 
> 	if (parent->of_node)
> 		iio_dev->dev.of_node = of_find_node_by_type(parent->of_node,
> "iio_device");
> 
> Another option would be to use of_find_compatible_node() and something
> like compatible = "iio-device";
> in the iio-device node.

A device node is defined as a node having compatible property. Other nodes 
should be seen as helper nodes, which do not represent devices (although 
they all have struct device_node in Linux).

Also, AFAIK, device_type is a deprecated property used by some legacy 
PowerPC machines and for current machines only compatible should be used.

So I guess the approach with compatible would be appropriate here.

However for physical devices providing only a single IIO device it might 
be better to allow simpler specification, like:

 	max1139-iio: voltage-sensor@35 {
 		compatible = "maxim,max1139", "iio_device";
 		reg = <0x35>;
 		vcc-supply = <&reg_3p3v>;
 		vref-supply = <&reg_3p3v>;
		device_type = "iio_device";
 		#io-channel-cells = <1>;
 	};

The node would be parseable using the same code as for subnodes (first try 
to parse current node and if it fails - no iio_device in compatible list - 
parse child nodes), but you could simplify specification of simple 
devices.

Also keep in mind that of_find_compatible_node() and friends iterate over 
the whole flattened device tree (starting from the specified node), not 
just over child nodes of specified node. To iterate over child nodes 
for_each_child_of_node must be used.

The code would then be something like this:

	struct device_node *np;

	ret = iio_of_parse_node(dev->of_node);
	if (!ret)
		return 0;

	for_each_child_of_node(dev->of_node, np)
		iio_of_parse_node(np);

With the check for compatible property inside iio_of_parse_node().

Best regards,
Tomasz

