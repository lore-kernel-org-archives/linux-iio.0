Return-Path: <linux@roeck-us.net>
Date: Wed, 6 Feb 2013 12:05:13 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Anton Vorontsov <cbou@mail.ru>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v4 2/2] iio: Add OF support
Message-ID: <20130206200513.GA18135@roeck-us.net>
References: <1360009566-26347-1-git-send-email-linux@roeck-us.net>
 <1360009566-26347-3-git-send-email-linux@roeck-us.net>
 <20130206182923.GA14417@roeck-us.net>
 <5112B101.7040709@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5112B101.7040709@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Feb 06, 2013 at 07:37:37PM +0000, Jonathan Cameron wrote:
> On 02/06/2013 06:29 PM, Guenter Roeck wrote:
> > Provide bindings and parse OF data during initialization.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> looks good to me.  Couple of little queries inline.
> 
> > ---
> > v4:
> > - Fixed wrong parameter to dummy of_iio_channel_get_by_name if CONFIG_OF is
> >   undefined, and wrong return value.
> > - Initialize indio_dev->of_node in iio_device_register if the calling driver
> >   neglected to do it.
> > v3:
> > - Cleaned up documentation (formatting, left-over clock references)
> > - Updated bindings description to permit sub-devices
> > - When searching for iio devices, use the pointer to the iio device type instead
> >   of strcmp. Rename iio_dev_type to iio_device_type (to match other device
> >   types) and make it global for that purpose. Check the OF node first, then the
> >   device type, as the node is less likely to match.
> > - Move the common code in of_iio_channel_get and of_iio_channel_get_all to
> >   __of_iio_channel_get.
> > - Return NULL from of_iio_channel_get_by_name if nothing is found, or
> >   an error if there is a problem with consistency or if the provider device is
> >   not yet available.
> > - In iio_channel_get, return if of_iio_channel_get_by_name() returns a channel
> >   or an error, and continue otherwise.
> > v2:
> > - Rebased to iio/togreg
> > - Documentation update per feedback
> > - Dropped io-channel-output-names from the bindings document. The property is
> >   not used in the code, and it is not entirely clear what it would be used for.
> >   If there is a need for it, we can add it back in later on.
> > - Don't export OF specific API calls
> > - For OF support, no longer depend on iio_map
> > - Add #ifdef CONFIG_OF where appropriate, and ensure that the code still builds
> >   if it is not selected.
> > - Change iio_channel_get to take device pointer as argument instead of device
> >   name. Retain old API as of_iio_channel_get_sys.
> > - iio_channel_get now works for both OF and non-OF configurations
> > - Use regulator to get vref for max1363 driver.
> > 
> >  drivers/iio/iio_core.h                             |    1 +
> >  drivers/iio/industrialio-core.c                    |    8 +-
> >  drivers/iio/inkern.c                               |  171 ++++++++++++++++++++
> >  4 files changed, 268 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/iio/iio-bindings.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> > new file mode 100644
> > index 0000000..2475c2e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> > @@ -0,0 +1,90 @@
> > +This binding is a work-in-progress. It is derived from clock bindings,
> > +and based on suggestions from Lars-Peter Clausen [1].
> > +
> > +Sources of IIO channels can be represented by any node in the device
> > +tree. Those nodes are designated as IIO providers. IIO consumer
> > +nodes use a phandle and IIO specifier pair to connect IIO provider
> > +outputs to IIO inputs. Similar to the gpio specifiers, an IIO
> > +specifier is an array of one or more cells identifying the IIO
> > +output on a device. The length of an IIO specifier is defined by the
> > +value of a #io-channel-cells property in the IIO provider node.
> > +
> > +[1] http://marc.info/?l=linux-iio&m=135902119507483&w=2
> > +
> > +==IIO providers==
> > +
> > +Required properties:
> > +#io-channel-cells: Number of cells in an IIO specifier; Typically 0 for nodes
> > +		   with a single IIO output and 1 for nodes with multiple
> > +		   IIO outputs.
> > +
> > +Example for a simple configuration with no trigger:
> > +
> > +	adc: voltage-sensor@35 {
> > +		compatible = "maxim,max1139";
> > +		reg = <0x35>;
> > +		#io-channel-cells = <1>;
> > +	};
> > +
> > +Example for a configuration with trigger:
> > +
> > +	adc@35 {
> > +		compatible = "maxim,max1139";
> > +		reg = <0x35>;
> > +
> > +		adc: iio-device {
> > +			#io-channel-cells = <1>;
> > +		};
> > +		trigger: iio-trigger {
> > +			#io-channel-cells = <1>;
> Why would the trigger have channel-cells?
> So far we don't have any device tree stuff for the triggers.

This comes from one of the examples passed around earlier.

Presumably, when triggers are supported through devicetree, you would have more
than one per device, meaning you need the same logic as for devices.

Though on the other side that isn't supported yet - I don't have hardware to
test, so I can not implement - or, rather, test - devicetree based trigger support.
I can take the entire thing out if you prefer - I don't really have a strong
opinion.

> > +		};
> > +	};
> > +
> > +==IIO consumers==
> > +
> > +Required properties:
> > +io-channels:	List of phandle and IIO specifier pairs, one pair
> > +		for each IIO input to the device. Note: if the
> > +		IIO provider specifies '0' for #io-channel-cells,
> > +		then only the phandle portion of the pair will appear.
> > +
> > +Optional properties:
> > +io-channel-names:
> > +		List of IIO input name strings sorted in the same
> > +		order as the io-channels property. Consumers drivers
> > +		will use io-channel-names to match IIO input names
> > +		with IIO specifiers.
> > +io-channel-ranges:
> > +		Empty property indicating that child nodes can inherit named
> > +		IIO channels from this node. Useful for bus nodes to provide
> > +		and IIO channel to their children.
> > +
> > +For example:
> > +
> > +	device {
> > +		io-channels = <&adc 1>, <&ref 0>;
> > +		io-channel-names = "vcc", "vdd";
> > +	};
> > +
> > +This represents a device with two IIO inputs, named "vcc" and "vdd".
> > +The vcc channel is connected to output 1 of the &adc device, and the
> > +vdd channel is connected to output 0 of the &ref device.
> > +
> > +==Example==
> > +
> > +	adc: max1139@35 {
> > +		compatible = "maxim,max1139";
> > +		reg = <0x35>;
> > +		#io-channel-cells = <1>;
> > +	};
> > +
> > +	...
> > +
> > +	iio_hwmon {
> > +		compatible = "iio-hwmon";
> > +		io-channels = <&adc 0>, <&adc 1>, <&adc 2>,
> > +			<&adc 3>, <&adc 4>, <&adc 5>,
> > +			<&adc 6>, <&adc 7>, <&adc 8>,
> > +			<&adc 9>, <&adc 10>, <&adc 11>;
> > +		io-channel-names = "vcc", "vdd", "vref", "1.2V";
> This example still seems a little odd. Why give one where there are
> more channels than names?

I just didn't have a better idea. Do you know of another iio consumer I could
use as example, one which doesn't use the get_all API ?

> > +	};
> > diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> > index f652e6a..05c1b74 100644
> > --- a/drivers/iio/iio_core.h
> > +++ b/drivers/iio/iio_core.h
> > @@ -18,6 +18,7 @@
> >  struct iio_chan_spec;
> >  struct iio_dev;
> >  
> > +extern struct device_type iio_device_type;
> >  
> >  int __iio_add_chan_devattr(const char *postfix,
> >  			   struct iio_chan_spec const *chan,
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 8848f16..6d8b027 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -847,7 +847,7 @@ static void iio_dev_release(struct device *device)
> >  	kfree(indio_dev);
> >  }
> >  
> > -static struct device_type iio_dev_type = {
> > +struct device_type iio_device_type = {
> >  	.name = "iio_device",
> >  	.release = iio_dev_release,
> >  };
> > @@ -869,7 +869,7 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
> >  
> >  	if (dev) {
> >  		dev->dev.groups = dev->groups;
> > -		dev->dev.type = &iio_dev_type;
> > +		dev->dev.type = &iio_device_type;
> >  		dev->dev.bus = &iio_bus_type;
> >  		device_initialize(&dev->dev);
> >  		dev_set_drvdata(&dev->dev, (void *)dev);
> > @@ -960,6 +960,10 @@ int iio_device_register(struct iio_dev *indio_dev)
> >  {
> >  	int ret;
> >  
> > +	/* If the calling driver did not initialize of_node, do it here */
> > +	if (!indio_dev->dev.of_node && indio_dev->dev.parent)
> > +		indio_dev->dev.of_node = indio_dev->dev.parent->of_node;
> > +
> I guess that's sensible, though I'd be inclined to check it and throw a wobbly
> if it isn't defined.  That way we have one 'right' place to do it.
> 
I had to look that one up :). "throw a wobbly" = "reached the end of rational thought and action"
or "to become suddenly very agitated or angry". Is that about right ?

I assume you mean the case where indio_dev->dev.of_node is NULL ? Problem is
that this can hapen anytime (and always if CONFIG_OF is undefined).
I'd be more concerned if indio_dev->dev.parent is NULL, which happens with
a couple of drivers if I interpret the code correctly. Otherwise it only matters
if the node should really point to a sub-node and not to the parent's node
itself - but presumably programmers should detect that while writing the driver.

Alternative would be to set of_node in all calling drivers. Unfortunately, there
are about one hundred callers, so that would be a substantial effort.

Not sure myself what the right approach is here - that is why I asked for
feedback about it in v3. I am open to suggestions.

Thanks,
Guenter
