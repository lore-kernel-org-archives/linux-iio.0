Return-Path: <lars@metafoo.de>
Message-ID: <510E7195.4070803@metafoo.de>
Date: Sun, 03 Feb 2013 15:17:57 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 devicetree-discuss@lists.ozlabs.org,
 Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
 Doug Anderson <dianders@chromium.org>,
 Tomasz Figa <tomasz.figa@gmail.com>,
 Grant Likely <grant.likely@secretlab.ca>,
 Rob Herring <rob.herring@calxeda.com>
Subject: Re: [PATCH v2 4/4] iio: Add OF support
References: <1359853180-5664-1-git-send-email-linux@roeck-us.net> <1359853180-5664-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1359853180-5664-5-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 02/03/2013 01:59 AM, Guenter Roeck wrote:
> Provide bindings and parse OF data during initialization.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> - Documentation update per feedback
> - Dropped io-channel-output-names from the bindings document. The property is
>   not used in the code, and it is not entirely clear what it would be used for.
>   If there is a need for it, we can add it back in later on.
> - Don't export OF specific API calls
> - For OF support, no longer depend on iio_map
> - Add #ifdef CONFIG_OF where appropriate, and ensure that the code still builds
>   if it is not selected.
> - Change iio_channel_get to take device pointer as argument instead of device
>   name. Retain old API as of_iio_channel_get_sys.
> - iio_channel_get now works for both OF and non-OF configurations.
> 

>From my point of view this looks good in general now, Just a few comments.

>  .../devicetree/bindings/iio/iio-bindings.txt       |   76 ++++++++
>  drivers/iio/inkern.c                               |  186 ++++++++++++++++++++
>  2 files changed, 262 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/iio-bindings.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> new file mode 100644
> index 0000000..58df5f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> @@ -0,0 +1,76 @@
> +This binding is a work-in-progress. It is derived from clock bindings,
> +and based on suggestions from Lars-Peter Clausen [1].
> +
> +Sources of IIO channels can be represented by any node in the device
> +tree.  Those nodes are designated as IIO providers.  IIO consumer
> +nodes use a phandle and IIO specifier pair to connect IIO provider
> +outputs to IIO inputs.  Similar to the gpio specifiers, an IIO
> +specifier is an array of one or more cells identifying the IIO
> +output on a device.  The length of an IIO specifier is defined by the
> +value of a #io-channel-cells property in the clock provider node.
> +

Is the extra space at the begining of each sentence on purpose?

> +[1] http://marc.info/?l=linux-iio&m=135902119507483&w=2
> +
> +==IIO providers==
> +
> +Required properties:
> +#io-channel-cells: Number of cells in an IIO specifier; Typically 0 for nodes
> +		   with a single IIO output and 1 for nodes with multiple
> +		   IIO outputs.
> +
> +For example:
> +
> +    adc: adc@35 {
> +	compatible = "maxim,max1139";
> +	reg = <0x35>;
> +        #io-channel-cells = <1>;

You are mixing tabs and spaces here for indention.

> +    };
> +
> +==IIO consumers==
> +
> +Required properties:
> +io-channels:	List of phandle and IIO specifier pairs, one pair
> +		for each IIO input to the device.  Note: if the
> +		IIO provider specifies '0' for #clock-cells, then
> +		only the phandle portion of the pair will appear.
> +
> +Optional properties:
> +io-channel-names:
> +		List of IIO input name strings sorted in the same
> +		order as the io-channels property.  Consumers drivers
> +		will use io-channel-names to match IIO input names
> +		with IIO specifiers.
> +io-channel-ranges:
> +		Empty property indicating that child nodes can inherit named
> +		IIO channels from this node. Useful for bus nodes to provide
> +		and IIO channel to their children.
> +
> +For example:
> +
> +    device {
> +        io-channels = <&adc 1>, <&ref 0>;
> +        io-channel-names = "vcc", "vdd";
> +    };
> +
> +This represents a device with two IIO inputs, named "vcc" and "vdd".
> +The vcc channel is connected to output 1 of the &adc device, and the
> +vdd channel is connected to output 0 of the &ref device.
> +
> +==Example==
> +
> +	adc: max1139@35 {
> +		compatible = "maxim,max1139";
> +		reg = <0x35>;
> +		#io-channel-cells = <1>;
> +	};
> +
> +	...
> +
> +	iio_hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels = <&adc 0>, <&adc 1>, <&adc 2>,
> +			<&adc 3>, <&adc 4>, <&adc 5>,
> +			<&adc 6>, <&adc 7>, <&adc 8>,
> +			<&adc 9>, <&adc 10>, <&adc 11>;

I'm not sure how much sense this example makes, since you can only request
those channels which have a name.

> +		io-channel-names = "vcc", "vdd", "vref", "1.2V";
> +	};
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index b289915..d48f2a8 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -10,6 +10,7 @@
[...]

+
> +static struct iio_channel *of_iio_channel_get_all(struct device *dev)
> +{
> +	struct iio_channel *chans;
> +	int i, mapind, nummaps = 0;
> +	int ret;
> +
> +	do {
> +		ret = of_parse_phandle_with_args(dev->of_node,
> +						 "io-channels",
> +						 "#io-channel-cells",
> +						 nummaps, NULL);
> +		if (ret < 0)
> +			break;
> +	} while (++nummaps);
> +
> +	if (nummaps == 0)	/* no error, return NULL to search map table */
> +		return NULL;
> +
> +	/* NULL terminated array to save passing size */
> +	chans = kzalloc(sizeof(*chans)*(nummaps + 1), GFP_KERNEL);

I think using kcalloc makes sense here.

> +	if (chans == NULL) {
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	/* Search for OF matches */
> +	for (mapind = 0; mapind < nummaps; mapind++) {
> +		struct device *idev;
> +		struct iio_dev *indio_dev;
> +		int channel;
> +		struct of_phandle_args iiospec;
> +
> +		ret = of_parse_phandle_with_args(dev->of_node,
> +						 "io-channels",
> +						 "#io-channel-cells",
> +						 mapind, &iiospec);
> +		if (ret)
> +			goto error_free_chans;
> +
> +		idev = bus_find_device(&iio_bus_type, NULL, iiospec.np,
> +				       iio_dev_node_match);
> +		of_node_put(iiospec.np);
> +		if (idev == NULL) {
> +			ret = -EPROBE_DEFER;
> +			goto error_free_chans;
> +		}
> +		indio_dev = dev_to_iio_dev(idev);
> +		channel = iiospec.args_count ? iiospec.args[0] : 0;
> +		if (channel >= indio_dev->num_channels) {
> +			ret = -EINVAL;
> +			goto error_free_chans;
> +		}

Hm, I wonder if we can share some code with of_iio_get_channel here, since it
is pretty much the same code. Maybe put the whole parse_phandle and device
lookup in a heler function.

> +		chans[mapind].indio_dev = indio_dev;
> +		chans[mapind].channel = &indio_dev->channels[channel];
> +	}
> +	return chans;
> +
> +error_free_chans:
> +	for (i = 0; i < mapind; i++)
> +		iio_device_put(chans[i].indio_dev);
> +	kfree(chans);
> +error:
> +	return ERR_PTR(ret);
> +}
> +
> +#else /* CONFIG_OF */
> +
> +static inline struct iio_channel *
> +of_iio_channel_get_by_name(struct device_node *np, const char *name)
> +{
> +	return ERR_PTR(-ENOENT);
> +}
> +
> +static inline struct iio_channel *of_iio_channel_get_all(struct device *dev)
> +{
> +	return NULL;
> +}
> +
> +#endif /* CONFIG_OF */
>  
>  static struct iio_channel *iio_channel_get_sys(const char *name,
>  					       const char *channel_name)
> @@ -150,7 +324,14 @@ struct iio_channel *iio_channel_get(struct device *dev,
>  				    const char *channel_name)
>  {
>  	const char *name = dev ? dev_name(dev) : NULL;
> +	struct iio_channel *channel;
>  
> +	if (dev) {
> +		channel = of_iio_channel_get_by_name(dev->of_node,
> +						     channel_name);
> +		if (!IS_ERR(channel))

Hm, I wonder if we should use the same semantics as for of_iio_channel_get_all
here. NULL means there is no channel use the map lookup and error code means
there is a channel, but there was an error requesting it. As it is right now
for probe deferral won't work, since EPROBE_DEFER is not passed on.


> +			return channel;
> +	}
>  	return iio_channel_get_sys(name, channel_name);
>  }
>  EXPORT_SYMBOL_GPL(iio_channel_get);
> @@ -173,6 +354,11 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
>  
>  	if (dev == NULL)
>  		return ERR_PTR(-EINVAL);
> +
> +	chans = of_iio_channel_get_all(dev);
> +	if (chans)
> +		return chans;
> +
>  	name = dev_name(dev);
>  
>  	mutex_lock(&iio_map_list_lock);
