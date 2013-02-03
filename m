Return-Path: <linux@roeck-us.net>
Date: Sat, 2 Feb 2013 18:06:51 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Doug Anderson <dianders@chromium.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>
Subject: Re: [PATCH v2 4/4] iio: Add OF support
Message-ID: <20130203020651.GA7655@roeck-us.net>
References: <1359853180-5664-1-git-send-email-linux@roeck-us.net>
 <1359853180-5664-5-git-send-email-linux@roeck-us.net>
 <5442549.pHUaeXTGsN@flatron>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5442549.pHUaeXTGsN@flatron>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Feb 03, 2013 at 02:30:24AM +0100, Tomasz Figa wrote:
> Hi Guenter,
> 
> Some comments inline.
> 
> On Saturday 02 of February 2013 16:59:40 Guenter Roeck wrote:
> > Provide bindings and parse OF data during initialization.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > - Documentation update per feedback
> > - Dropped io-channel-output-names from the bindings document. The
> > property is not used in the code, and it is not entirely clear what it
> > would be used for. If there is a need for it, we can add it back in
> > later on.
> > - Don't export OF specific API calls
> > - For OF support, no longer depend on iio_map
> > - Add #ifdef CONFIG_OF where appropriate, and ensure that the code still
> > builds if it is not selected.
> > - Change iio_channel_get to take device pointer as argument instead of
> > device name. Retain old API as of_iio_channel_get_sys.
> > - iio_channel_get now works for both OF and non-OF configurations.
> > 
> >  .../devicetree/bindings/iio/iio-bindings.txt       |   76 ++++++++
> >  drivers/iio/inkern.c                               |  186
> > ++++++++++++++++++++ 2 files changed, 262 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/iio/iio-bindings.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt
> > b/Documentation/devicetree/bindings/iio/iio-bindings.txt new file mode
> > 100644
> > index 0000000..58df5f6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> > @@ -0,0 +1,76 @@
> > +This binding is a work-in-progress. It is derived from clock bindings,
> > +and based on suggestions from Lars-Peter Clausen [1].
> > +
> > +Sources of IIO channels can be represented by any node in the device
> > +tree.  Those nodes are designated as IIO providers.  IIO consumer
> > +nodes use a phandle and IIO specifier pair to connect IIO provider
> > +outputs to IIO inputs.  Similar to the gpio specifiers, an IIO
> > +specifier is an array of one or more cells identifying the IIO
> > +output on a device.  The length of an IIO specifier is defined by the
> > +value of a #io-channel-cells property in the clock provider node.
> > +
> > +[1] http://marc.info/?l=linux-iio&m=135902119507483&w=2
> > +
> > +==IIO providers==
> > +
> > +Required properties:
> > +#io-channel-cells: Number of cells in an IIO specifier; Typically 0 for
> > nodes +		   with a single IIO output and 1 for nodes with multiple
> > +		   IIO outputs.
> > +
> > +For example:
> > +
> > +    adc: adc@35 {
> > +	compatible = "maxim,max1139";
> > +	reg = <0x35>;
> > +        #io-channel-cells = <1>;
> > +    };
> > +
> > +==IIO consumers==
> > +
> > +Required properties:
> > +io-channels:	List of phandle and IIO specifier pairs, one pair
> > +		for each IIO input to the device.  Note: if the
> > +		IIO provider specifies '0' for #clock-cells, then
> > +		only the phandle portion of the pair will appear.
> > +
> > +Optional properties:
> > +io-channel-names:
> > +		List of IIO input name strings sorted in the same
> > +		order as the io-channels property.  Consumers drivers
> > +		will use io-channel-names to match IIO input names
> > +		with IIO specifiers.
> > +io-channel-ranges:
> > +		Empty property indicating that child nodes can inherit named
> > +		IIO channels from this node. Useful for bus nodes to provide
> > +		and IIO channel to their children.
> > +
> > +For example:
> > +
> > +    device {
> > +        io-channels = <&adc 1>, <&ref 0>;
> > +        io-channel-names = "vcc", "vdd";
> > +    };
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
> > +	};
> > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > index b289915..d48f2a8 100644
> > --- a/drivers/iio/inkern.c
> > +++ b/drivers/iio/inkern.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/export.h>
> >  #include <linux/slab.h>
> >  #include <linux/mutex.h>
> > +#include <linux/of.h>
> > 
> >  #include <linux/iio/iio.h>
> >  #include "iio_core.h"
> > @@ -92,6 +93,179 @@ static const struct iio_chan_spec
> >  	return chan;
> >  }
> > 
> > +#ifdef CONFIG_OF
> > +
> > +static int iio_dev_node_match(struct device *dev, void *data)
> > +{
> > +	return !strcmp(dev->type->name, "iio_device") && dev->of_node == 
> data;
> 
> Hmm, do you need to check type name here? One device node should rather 
> represent only one device, making node an unique identifier.
> 
> It this is meant to be a sanity check, it could be done one time after 
> finding the device.
> 
Hi Tomasz,

This is what Lars had suggested earlier:

> Yes, use bus_find_device on iio_bus_type. A nice example how to use this to
> lookup device by of node is of_find_i2c_device_by_node. For IIO you also need
> to make sure that dev->type is iio_dev_type, since both devices and triggers
> are registered on the same bus.

Is it really needed, or in other words would it be sufficient to check if
of_node and data match each other ? Your reasoning makes sense to me, and I had
thought about it as well, but I don't really know, and I don't know how I could
test it and guarantee correctness either. I'll be happy to take the strcmp() out
if someone tells me that it is definitely not needed ...

> > +}
> > +
> > +static struct iio_channel *of_iio_channel_get(struct device_node *np,
> > int index) +{
> > +	struct iio_channel *channel;
> > +	struct device *idev;
> > +	struct iio_dev *indio_dev;
> > +	int err;
> > +	struct of_phandle_args iiospec;
> > +
> > +	if (index < 0)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	err = of_parse_phandle_with_args(np, "io-channels",
> > +					 "#io-channel-cells",
> > +					 index, &iiospec);
> > +	if (err)
> > +		return ERR_PTR(err);
> > +
> > +	idev = bus_find_device(&iio_bus_type, NULL, iiospec.np,
> > +			       iio_dev_node_match);
> > +	of_node_put(iiospec.np);
> > +	if (idev == NULL)
> > +		return ERR_PTR(-EPROBE_DEFER);
> > +
> > +	indio_dev = dev_to_iio_dev(idev);
> > +
> > +	channel = kzalloc(sizeof(*channel), GFP_KERNEL);
> > +	if (channel == NULL) {
> > +		err = -ENOMEM;
> > +		goto err_no_mem;
> > +	}
> > +
> > +	channel->indio_dev = indio_dev;
> > +	index = iiospec.args_count ? iiospec.args[0] : 0;
> 
> What happens here with remaining phandle arguments?
> 
> I'm not sure if such use case is needed for iio, but other subsystems give 
> the possibility of specifying custom xlate callback translating from a 
> custom specifier into channel number. (e.g. drivers/gpio/gpiolib-of.c)
> 
I don't have a use case, and I hesitate to implement something that may
never be used (and I can not really test it either). And without a use
case we would not even know if the implementation makes sense or not.

It should be possible to add additional functionality later if needed.

Thanks,
Guenter

> Best regards,
> Tomasz
> 
> > +	if (index >= indio_dev->num_channels) {
> > +		err = -EINVAL;
> > +		goto err_no_channel;
> > +	}
> > +	channel->channel = &indio_dev->channels[index];
> > +
> > +	return channel;
> > +
> > +err_no_channel:
> > +	kfree(channel);
> > +err_no_mem:
> > +	iio_device_put(indio_dev);
> > +	return ERR_PTR(err);
> > +}
> > +
> > +static struct iio_channel *of_iio_channel_get_by_name(struct
> > device_node *np, +						      const char 
> *name)
> > +{
> > +	struct iio_channel *chan = ERR_PTR(-ENOENT);
> > +
> > +	/* Walk up the tree of devices looking for a matching iio channel */
> > +	while (np) {
> > +		int index = 0;
> > +
> > +		/*
> > +		 * For named iio channels, first look up the name in the
> > +		 * "io-channel-names" property.  If it cannot be found, the
> > +		 * index will be an error code, and of_iio_channel_get()
> > +		 * will fail.
> > +		 */
> > +		if (name)
> > +			index = of_property_match_string(np, "io-channel-names",
> > +							 name);
> > +		chan = of_iio_channel_get(np, index);
> > +		if (!IS_ERR(chan))
> > +			break;
> > +		else if (name && index >= 0) {
> > +			pr_err("ERROR: could not get IIO channel %s:%s(%i)\n",
> > +				np->full_name, name ? name : "", index);
> > +			return chan;
> > +		}
> > +
> > +		/*
> > +		 * No matching IIO channel found on this node.
> > +		 * If the parent node has a "io-channel-ranges" property,
> > +		 * then we can try one of its channels.
> > +		 */
> > +		np = np->parent;
> > +		if (np && !of_get_property(np, "io-channel-ranges", NULL))
> > +			break;
> > +	}
> > +	return chan;
> > +}
> > +
> > +static struct iio_channel *of_iio_channel_get_all(struct device *dev)
> > +{
> > +	struct iio_channel *chans;
> > +	int i, mapind, nummaps = 0;
> > +	int ret;
> > +
> > +	do {
> > +		ret = of_parse_phandle_with_args(dev->of_node,
> > +						 "io-channels",
> > +						 "#io-channel-cells",
> > +						 nummaps, NULL);
> > +		if (ret < 0)
> > +			break;
> > +	} while (++nummaps);
> > +
> > +	if (nummaps == 0)	/* no error, return NULL to search map table */
> > +		return NULL;
> > +
> > +	/* NULL terminated array to save passing size */
> > +	chans = kzalloc(sizeof(*chans)*(nummaps + 1), GFP_KERNEL);
> > +	if (chans == NULL) {
> > +		ret = -ENOMEM;
> > +		goto error;
> > +	}
> > +
> > +	/* Search for OF matches */
> > +	for (mapind = 0; mapind < nummaps; mapind++) {
> > +		struct device *idev;
> > +		struct iio_dev *indio_dev;
> > +		int channel;
> > +		struct of_phandle_args iiospec;
> > +
> > +		ret = of_parse_phandle_with_args(dev->of_node,
> > +						 "io-channels",
> > +						 "#io-channel-cells",
> > +						 mapind, &iiospec);
> > +		if (ret)
> > +			goto error_free_chans;
> > +
> > +		idev = bus_find_device(&iio_bus_type, NULL, iiospec.np,
> > +				       iio_dev_node_match);
> > +		of_node_put(iiospec.np);
> > +		if (idev == NULL) {
> > +			ret = -EPROBE_DEFER;
> > +			goto error_free_chans;
> > +		}
> > +		indio_dev = dev_to_iio_dev(idev);
> > +		channel = iiospec.args_count ? iiospec.args[0] : 0;
> > +		if (channel >= indio_dev->num_channels) {
> > +			ret = -EINVAL;
> > +			goto error_free_chans;
> > +		}
> > +		chans[mapind].indio_dev = indio_dev;
> > +		chans[mapind].channel = &indio_dev->channels[channel];
> > +	}
> > +	return chans;
> > +
> > +error_free_chans:
> > +	for (i = 0; i < mapind; i++)
> > +		iio_device_put(chans[i].indio_dev);
> > +	kfree(chans);
> > +error:
> > +	return ERR_PTR(ret);
> > +}
> > +
> > +#else /* CONFIG_OF */
> > +
> > +static inline struct iio_channel *
> > +of_iio_channel_get_by_name(struct device_node *np, const char *name)
> > +{
> > +	return ERR_PTR(-ENOENT);
> > +}
> > +
> > +static inline struct iio_channel *of_iio_channel_get_all(struct device
> > *dev) +{
> > +	return NULL;
> > +}
> > +
> > +#endif /* CONFIG_OF */
> > 
> >  static struct iio_channel *iio_channel_get_sys(const char *name,
> >  					       const char *channel_name)
> > @@ -150,7 +324,14 @@ struct iio_channel *iio_channel_get(struct device
> > *dev, const char *channel_name)
> >  {
> >  	const char *name = dev ? dev_name(dev) : NULL;
> > +	struct iio_channel *channel;
> > 
> > +	if (dev) {
> > +		channel = of_iio_channel_get_by_name(dev->of_node,
> > +						     channel_name);
> > +		if (!IS_ERR(channel))
> > +			return channel;
> > +	}
> >  	return iio_channel_get_sys(name, channel_name);
> >  }
> >  EXPORT_SYMBOL_GPL(iio_channel_get);
> > @@ -173,6 +354,11 @@ struct iio_channel *iio_channel_get_all(struct
> > device *dev)
> > 
> >  	if (dev == NULL)
> >  		return ERR_PTR(-EINVAL);
> > +
> > +	chans = of_iio_channel_get_all(dev);
> > +	if (chans)
> > +		return chans;
> > +
> >  	name = dev_name(dev);
> > 
> >  	mutex_lock(&iio_map_list_lock);
> 
