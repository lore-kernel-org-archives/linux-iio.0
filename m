Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:51941 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973Ab3BCQbR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Feb 2013 11:31:17 -0500
Date: Sun, 3 Feb 2013 08:31:24 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Doug Anderson <dianders@chromium.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>
Subject: Re: [PATCH v2 4/4] iio: Add OF support
Message-ID: <20130203163124.GC21576@roeck-us.net>
References: <1359853180-5664-1-git-send-email-linux@roeck-us.net>
 <1359853180-5664-5-git-send-email-linux@roeck-us.net>
 <5442549.pHUaeXTGsN@flatron>
 <20130203020651.GA7655@roeck-us.net>
 <510E4A13.3080800@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <510E4A13.3080800@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Feb 03, 2013 at 12:29:23PM +0100, Lars-Peter Clausen wrote:
> On 02/03/2013 03:06 AM, Guenter Roeck wrote:
> > On Sun, Feb 03, 2013 at 02:30:24AM +0100, Tomasz Figa wrote:
> >> Hi Guenter,
> >>
> >> Some comments inline.
> >>
> >> On Saturday 02 of February 2013 16:59:40 Guenter Roeck wrote:
> >>> Provide bindings and parse OF data during initialization.
> >>>
> >>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >>> ---
> >>> - Documentation update per feedback
> >>> - Dropped io-channel-output-names from the bindings document. The
> >>> property is not used in the code, and it is not entirely clear what it
> >>> would be used for. If there is a need for it, we can add it back in
> >>> later on.
> >>> - Don't export OF specific API calls
> >>> - For OF support, no longer depend on iio_map
> >>> - Add #ifdef CONFIG_OF where appropriate, and ensure that the code still
> >>> builds if it is not selected.
> >>> - Change iio_channel_get to take device pointer as argument instead of
> >>> device name. Retain old API as of_iio_channel_get_sys.
> >>> - iio_channel_get now works for both OF and non-OF configurations.
> >>>
> >>>  .../devicetree/bindings/iio/iio-bindings.txt       |   76 ++++++++
> >>>  drivers/iio/inkern.c                               |  186
> >>> ++++++++++++++++++++ 2 files changed, 262 insertions(+)
> >>>  create mode 100644
> >>> Documentation/devicetree/bindings/iio/iio-bindings.txt
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt
> >>> b/Documentation/devicetree/bindings/iio/iio-bindings.txt new file mode
> >>> 100644
> >>> index 0000000..58df5f6
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> >>> @@ -0,0 +1,76 @@
> >>> +This binding is a work-in-progress. It is derived from clock bindings,
> >>> +and based on suggestions from Lars-Peter Clausen [1].
> >>> +
> >>> +Sources of IIO channels can be represented by any node in the device
> >>> +tree.  Those nodes are designated as IIO providers.  IIO consumer
> >>> +nodes use a phandle and IIO specifier pair to connect IIO provider
> >>> +outputs to IIO inputs.  Similar to the gpio specifiers, an IIO
> >>> +specifier is an array of one or more cells identifying the IIO
> >>> +output on a device.  The length of an IIO specifier is defined by the
> >>> +value of a #io-channel-cells property in the clock provider node.
> >>> +
> >>> +[1] http://marc.info/?l=linux-iio&m=135902119507483&w=2
> >>> +
> >>> +==IIO providers==
> >>> +
> >>> +Required properties:
> >>> +#io-channel-cells: Number of cells in an IIO specifier; Typically 0 for
> >>> nodes +		   with a single IIO output and 1 for nodes with multiple
> >>> +		   IIO outputs.
> >>> +
> >>> +For example:
> >>> +
> >>> +    adc: adc@35 {
> >>> +	compatible = "maxim,max1139";
> >>> +	reg = <0x35>;
> >>> +        #io-channel-cells = <1>;
> >>> +    };
> >>> +
> >>> +==IIO consumers==
> >>> +
> >>> +Required properties:
> >>> +io-channels:	List of phandle and IIO specifier pairs, one pair
> >>> +		for each IIO input to the device.  Note: if the
> >>> +		IIO provider specifies '0' for #clock-cells, then
> >>> +		only the phandle portion of the pair will appear.
> >>> +
> >>> +Optional properties:
> >>> +io-channel-names:
> >>> +		List of IIO input name strings sorted in the same
> >>> +		order as the io-channels property.  Consumers drivers
> >>> +		will use io-channel-names to match IIO input names
> >>> +		with IIO specifiers.
> >>> +io-channel-ranges:
> >>> +		Empty property indicating that child nodes can inherit named
> >>> +		IIO channels from this node. Useful for bus nodes to provide
> >>> +		and IIO channel to their children.
> >>> +
> >>> +For example:
> >>> +
> >>> +    device {
> >>> +        io-channels = <&adc 1>, <&ref 0>;
> >>> +        io-channel-names = "vcc", "vdd";
> >>> +    };
> >>> +
> >>> +This represents a device with two IIO inputs, named "vcc" and "vdd".
> >>> +The vcc channel is connected to output 1 of the &adc device, and the
> >>> +vdd channel is connected to output 0 of the &ref device.
> >>> +
> >>> +==Example==
> >>> +
> >>> +	adc: max1139@35 {
> >>> +		compatible = "maxim,max1139";
> >>> +		reg = <0x35>;
> >>> +		#io-channel-cells = <1>;
> >>> +	};
> >>> +
> >>> +	...
> >>> +
> >>> +	iio_hwmon {
> >>> +		compatible = "iio-hwmon";
> >>> +		io-channels = <&adc 0>, <&adc 1>, <&adc 2>,
> >>> +			<&adc 3>, <&adc 4>, <&adc 5>,
> >>> +			<&adc 6>, <&adc 7>, <&adc 8>,
> >>> +			<&adc 9>, <&adc 10>, <&adc 11>;
> >>> +		io-channel-names = "vcc", "vdd", "vref", "1.2V";
> >>> +	};
> >>> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> >>> index b289915..d48f2a8 100644
> >>> --- a/drivers/iio/inkern.c
> >>> +++ b/drivers/iio/inkern.c
> >>> @@ -10,6 +10,7 @@
> >>>  #include <linux/export.h>
> >>>  #include <linux/slab.h>
> >>>  #include <linux/mutex.h>
> >>> +#include <linux/of.h>
> >>>
> >>>  #include <linux/iio/iio.h>
> >>>  #include "iio_core.h"
> >>> @@ -92,6 +93,179 @@ static const struct iio_chan_spec
> >>>  	return chan;
> >>>  }
> >>>
> >>> +#ifdef CONFIG_OF
> >>> +
> >>> +static int iio_dev_node_match(struct device *dev, void *data)
> >>> +{
> >>> +	return !strcmp(dev->type->name, "iio_device") && dev->of_node == 
> >> data;
> >>
> >> Hmm, do you need to check type name here? One device node should rather 
> >> represent only one device, making node an unique identifier.
> >>
> >> It this is meant to be a sanity check, it could be done one time after 
> >> finding the device.
> >>
> > Hi Tomasz,
> > 
> > This is what Lars had suggested earlier:
> > 
> >> Yes, use bus_find_device on iio_bus_type. A nice example how to use this to
> >> lookup device by of node is of_find_i2c_device_by_node. For IIO you also need
> >> to make sure that dev->type is iio_dev_type, since both devices and triggers
> >> are registered on the same bus.
> > 
> > Is it really needed, or in other words would it be sufficient to check if
> > of_node and data match each other ? Your reasoning makes sense to me, and I had
> > thought about it as well, but I don't really know, and I don't know how I could
> > test it and guarantee correctness either. I'll be happy to take the strcmp() out
> > if someone tells me that it is definitely not needed ...
> 
> A IIO trigger and a IIO device may have the same of_node, e.g. if they both
> belong to the same physical device. But you don't need to do the strcmp just
> compare dev->type to iio_dev_type i.e. dev->type == &iio_dev_type. Although it
> doesn't really matter in practice first check for the of_node then check for
> the type, since the of_node will only match for a few devices at most, the type
> will match for quite a few.
> 
iio_dev_type is defined as static variable in industrialio-core.c, which can be
loaded as module. To use it in inkern.c, I would have to move it there and make
it global. I can do that, but is it worth it just to safe the strcmp ?

Thanks,
Guenter
