Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:44297 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755326Ab3AaWU7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 31 Jan 2013 17:20:59 -0500
Date: Thu, 31 Jan 2013 23:20:54 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Guenter Roeck <linux@roeck-us.net>
cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [RFC 10/11] iio: Add OF support
In-Reply-To: <1359668588-13678-11-git-send-email-linux@roeck-us.net>
Message-ID: <alpine.DEB.2.01.1301312305190.30024@pmeerw.net>
References: <1359668588-13678-1-git-send-email-linux@roeck-us.net> <1359668588-13678-11-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> Provide bindings, new API access functions, and parse OF data
> during initialization.

nitpicking below

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  .../devicetree/bindings/iio/iio-bindings.txt       |   97 ++++++++
>  drivers/iio/inkern.c                               |  241 ++++++++++++++++----
>  include/linux/iio/consumer.h                       |    8 +
>  3 files changed, 299 insertions(+), 47 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/iio-bindings.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> new file mode 100644
> index 0000000..0f51c95
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> @@ -0,0 +1,97 @@
> +This binding is a work-in-progress, and are based on clock bindings and

is based

At first I got confused how clock bindings relate to this.

> +suggestions from Lars-Peter Clausen [1].
> +
> +Sources of IIO channels can be represented by any node in the device
> +tree.  Those nodes are designated as IIO providers.  IIO consumer
> +nodes use a phandle and IIO specifier pair to connect IIO provider
> +outputs to IIO inputs.  Similar to the gpio specifiers, an IIO
> +specifier is an array of one more more cells identifying the IIO

of one or more cells?

> +output on a device.  The length of an IIO specifier is defined by the
> +value of a #io-channel-cells property in the clock provider node.
> +
> +[1] http://marc.info/?l=linux-iio&m=135902119507483&w=2
> +
> +==IIO providers==
> +
> +Required properties:
> +#io-channel-cells: Number of cells in an IIO specifier; Typically 0 for nodes
> +		   with a single IIO output and 1 for nodes with multiple
> +		   IIO outputs.
> +
> +Optional properties:
> +io-channel-output-names:
> +		    Recommended to be a list of strings of IIO output signal
> +		    names indexed by the first cell in the IIO specifier.
> +		    However, the meaning of io-channel-output-names is domain
> +		    specific to the IIO provider, and is only provided to
> +		    encourage using the same meaning for the majority of IIO
> +		    providers.  This format may not work for IIO providers
> +		    using a complex IIO specifier format.  In those cases it
> +		    is recommended to omit this property and create a binding
> +		    specific names property.
> +
> +		    IIO consumer nodes must never directly reference
> +		    the provider's io-channel-output-names property.
> +
> +For example:
> +
> +    adc: adc@35 {
> +	compatible = "maxim,max1139";
> +	reg = <0x35>;
> +        #io-channel-cells = <1>;
> +        io-channel-output-names = "adc1", "adc2";
> +    };
> +
> +- this node defines a device with two named IIO outputs, the first named
> +  "adc1" and the second named "adc2".  Consumer nodes always reference
> +  IIO channels by index. The names should reflect the IIO output signal
> +  names for the device.

maybe start with: This node defines... as below?

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
> +		io-channel-names = "vcc", "vdd", "vref", "1.2V";
> +	};
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index c42aba6..af80a18 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -10,6 +10,7 @@
>  #include <linux/export.h>
>  #include <linux/slab.h>
>  #include <linux/mutex.h>
> +#include <linux/of.h>
>  
>  #include <linux/iio/iio.h>
>  #include "iio_core.h"
> @@ -26,13 +27,55 @@ struct iio_map_internal {
>  static LIST_HEAD(iio_map_list);
>  static DEFINE_MUTEX(iio_map_list_lock);
>  
> +static struct iio_map *iio_map_of_init(struct iio_dev *idev)
> +{
> +	struct device_node *np = idev->dev.of_node;
> +	struct iio_map *maps;
> +	u32 cells, channels = 1;
> +	int names, i, ret;
> +
> +	ret = of_property_read_u32(np, "#io-channel-cells", &cells);
> +	if (ret < 0 || cells > 1)
> +		return ERR_PTR(-EINVAL);
> +
> +	names = of_property_count_strings(np, "io-channel-output-names");
> +	if (names < 0)
> +		names = 0;
> +
> +	if (channels < names)
> +		channels = names;
> +
> +	maps = devm_kzalloc(&idev->dev, sizeof(*maps) * (channels + 1),
> +			    GFP_KERNEL);
> +	if (maps == NULL)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for (i = 0; i < channels; i++) {
> +		if (i < names) {
> +			ret = of_property_read_string_index(np,
> +				    "io-channel-output-names", i,
> +				    &maps[i].consumer_channel);
> +			if (ret < 0)
> +				return ERR_PTR(ret);
> +		}
> +		/* Use dummy for consumer device names */
> +		maps[i].consumer_dev_name = "of";
> +	}
> +	return maps;
> +}
> +
>  int iio_map_array_register(struct iio_dev *indio_dev, struct iio_map *maps)
>  {
>  	int i = 0, ret = 0;
>  	struct iio_map_internal *mapi;
>  
> -	if (maps == NULL)
> -		return 0;
> +	if (maps == NULL) {
> +		maps = iio_map_of_init(indio_dev);
> +		if (IS_ERR(maps))
> +			return PTR_ERR(maps);
> +		if (maps == NULL)
> +			return 0;
> +	}
>  
>  	mutex_lock(&iio_map_list_lock);
>  	while (maps[i].consumer_dev_name != NULL) {
> @@ -92,30 +135,14 @@ static const struct iio_chan_spec
>  	return chan;
>  }
>  
> -
> -struct iio_channel *iio_channel_get(const char *name, const char *channel_name)
> +struct iio_channel *iio_channel_get_common(struct iio_map_internal *c,
> +					   int index)
>  {
> -	struct iio_map_internal *c_i = NULL, *c = NULL;
>  	struct iio_channel *channel;
>  	int err;
>  
> -	if (name == NULL && channel_name == NULL)
> -		return ERR_PTR(-ENODEV);
> -
> -	/* first find matching entry the channel map */
> -	mutex_lock(&iio_map_list_lock);
> -	list_for_each_entry(c_i, &iio_map_list, l) {
> -		if ((name && strcmp(name, c_i->map->consumer_dev_name) != 0) ||
> -		    (channel_name &&
> -		     strcmp(channel_name, c_i->map->consumer_channel) != 0))
> -			continue;
> -		c = c_i;
> -		iio_device_get(c->indio_dev);
> -		break;
> -	}
> -	mutex_unlock(&iio_map_list_lock);
>  	if (c == NULL)
> -		return ERR_PTR(-ENODEV);
> +		return ERR_PTR(-EPROBE_DEFER);
>  
>  	channel = kzalloc(sizeof(*channel), GFP_KERNEL);
>  	if (channel == NULL) {
> @@ -125,7 +152,13 @@ struct iio_channel *iio_channel_get(const char *name, const char *channel_name)
>  
>  	channel->indio_dev = c->indio_dev;
>  
> -	if (c->map->adc_channel_label) {
> +	if (index >= 0) {
> +		if (index >= c->indio_dev->num_channels) {
> +			err = -EINVAL;
> +			goto error_no_chan;
> +		}
> +		channel->channel = &c->indio_dev->channels[index];
> +	} else if (c->map->adc_channel_label) {
>  		channel->channel =
>  			iio_chan_spec_from_name(channel->indio_dev,
>  						c->map->adc_channel_label);
> @@ -144,6 +177,60 @@ error_no_mem:
>  	iio_device_put(c->indio_dev);
>  	return ERR_PTR(err);
>  }
> +
> +struct iio_channel *of_iio_channel_get(struct device_node *np, int index)
> +{
> +	struct iio_map_internal *c_i, *c = NULL;
> +	int err, map_index;
> +	struct of_phandle_args iiospec;
> +
> +	if (index < 0)
> +		return ERR_PTR(-EINVAL);
> +
> +	err = of_parse_phandle_with_args(np, "io-channels",
> +					 "#io-channel-cells",
> +					 index, &iiospec);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	map_index = iiospec.args_count ? iiospec.args[0] : 0;
> +
> +	mutex_lock(&iio_map_list_lock);
> +	list_for_each_entry(c_i, &iio_map_list, l) {
> +		if (iiospec.np == c_i->indio_dev->dev.of_node) {
> +			c = c_i;
> +			iio_device_get(c->indio_dev);
> +			break;
> +		}
> +	}
> +	of_node_put(iiospec.np);
> +	mutex_unlock(&iio_map_list_lock);
> +	return iio_channel_get_common(c, index);
> +}
> +EXPORT_SYMBOL_GPL(of_iio_channel_get);
> +
> +struct iio_channel *iio_channel_get(const char *name,
> +				    const char *channel_name)
> +{
> +	struct iio_map_internal *c_i = NULL, *c = NULL;
> +
> +	if (name == NULL && channel_name == NULL)
> +		return ERR_PTR(-ENODEV);
> +
> +	/* first find matching entry the channel map */

of the channel map?

> +	mutex_lock(&iio_map_list_lock);
> +	list_for_each_entry(c_i, &iio_map_list, l) {
> +		if ((name && strcmp(name, c_i->map->consumer_dev_name) != 0) ||
> +		    (channel_name && strcmp(channel_name,
> +					    c_i->map->consumer_channel) != 0))
> +			continue;
> +		c = c_i;
> +		iio_device_get(c->indio_dev);
> +		break;
> +	}
> +	mutex_unlock(&iio_map_list_lock);
> +	return iio_channel_get_common(c, -1);
> +}
>  EXPORT_SYMBOL_GPL(iio_channel_get);
>  
>  void iio_channel_release(struct iio_channel *channel)
> @@ -159,24 +246,43 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
>  	struct iio_channel *chans;
>  	struct iio_map_internal *c = NULL;
>  	int nummaps = 0;
> -	int mapind = 0;
> +	int mapind;
>  	int i, ret;
>  
>  	if (dev == NULL)
>  		return ERR_PTR(-EINVAL);
> +
>  	name = dev_name(dev);
>  
>  	mutex_lock(&iio_map_list_lock);
>  	/* first count the matching maps */
> -	list_for_each_entry(c, &iio_map_list, l)
> -		if (name && strcmp(name, c->map->consumer_dev_name) != 0)
> -			continue;
> -		else
> -			nummaps++;
> -
> -	if (nummaps == 0) {
> -		ret = -ENODEV;
> -		goto error_ret;
> +	if (dev->of_node) {
> +		nummaps = 0;
> +		do {
> +			int ret;
> +
> +			ret = of_parse_phandle_with_args(dev->of_node,
> +							 "io-channels",
> +							 "#io-channel-cells",
> +							 nummaps, NULL);
> +			if (ret < 0)
> +				break;
> +		} while (++nummaps);
> +
> +		if (nummaps == 0) {
> +			ret = -ENODEV;
> +			goto error_ret;
> +		}
> +	} else {
> +		list_for_each_entry(c, &iio_map_list, l)
> +			if (strcmp(name, c->map->consumer_dev_name) != 0)
> +				continue;
> +			else
> +				nummaps++;
> +		if (nummaps == 0) {
> +			ret = -EPROBE_DEFER;
> +			goto error_ret;
> +		}
>  	}
>  
>  	/* NULL terminated array to save passing size */
> @@ -187,24 +293,65 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
>  	}
>  
>  	/* for each map fill in the chans element */
> -	list_for_each_entry(c, &iio_map_list, l) {
> -		if (name && strcmp(name, c->map->consumer_dev_name) != 0)
> -			continue;
> -		chans[mapind].indio_dev = c->indio_dev;
> -		chans[mapind].data = c->map->consumer_data;
> -		chans[mapind].channel =
> -			iio_chan_spec_from_name(chans[mapind].indio_dev,
> +	if (dev->of_node) {
> +		/*
> +		 * Device-tree based mapping, search for OF matches.
> +		 */
> +		for (mapind = 0; mapind < nummaps; mapind++) {
> +			int channel;
> +			struct of_phandle_args iiospec;
> +
> +			ret = of_parse_phandle_with_args(dev->of_node,
> +							 "io-channels",
> +							 "#io-channel-cells",
> +							 mapind, &iiospec);
> +			if (ret)
> +				goto error_free_chans;
> +			channel = iiospec.args_count ? iiospec.args[0] : 0;
> +			ret = -EPROBE_DEFER;
> +			list_for_each_entry(c, &iio_map_list, l) {
> +				if (iiospec.np == c->indio_dev->dev.of_node) {
> +					ret = 0;
> +					break;
> +				}
> +			}
> +			if (ret)
> +				goto error_free_chans;
> +			if (channel >= c->indio_dev->num_channels) {
> +				ret = -EINVAL;
> +				goto error_free_chans;
> +			}
> +			chans[mapind].indio_dev = c->indio_dev;
> +			chans[mapind].data = c->map->consumer_data;
> +			chans[mapind].channel =
> +			  &c->indio_dev->channels[channel];
> +			iio_device_get(c->indio_dev);
> +		}
> +	} else {
> +		/*
> +		 * Platform data based mapping, search for consumer
> +		 * device name.
> +		 */
> +		mapind = 0;
> +		list_for_each_entry(c, &iio_map_list, l) {
> +			if (strcmp(name, c->map->consumer_dev_name) != 0)
> +				continue;
> +			chans[mapind].indio_dev = c->indio_dev;
> +			chans[mapind].data = c->map->consumer_data;
> +			chans[mapind].channel =
> +				iio_chan_spec_from_name(c->indio_dev,
>  						c->map->adc_channel_label);
> -		if (chans[mapind].channel == NULL) {
> -			ret = -EINVAL;
> +			if (chans[mapind].channel == NULL) {
> +				ret = -EINVAL;
> +				goto error_free_chans;
> +			}
> +			iio_device_get(c->indio_dev);
> +			mapind++;
> +		}
> +		if (mapind < nummaps) {
> +			ret = -EPROBE_DEFER;
>  			goto error_free_chans;
>  		}
> -		iio_device_get(chans[mapind].indio_dev);
> -		mapind++;
> -	}
> -	if (mapind == 0) {
> -		ret = -ENODEV;
> -		goto error_free_chans;
>  	}
>  	mutex_unlock(&iio_map_list_lock);
>  
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index 6c44167..a347c15 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -41,6 +41,14 @@ struct iio_channel *iio_channel_get(const char *name,
>  				    const char *consumer_channel);
>  
>  /**
> + * of_iio_channel_get() - get description of all that is needed to access
> + *			channel from OF node pointer.
> + * @np:			Consumer's OF node pointer.
> + * @index:		Index pointing to the io-channels entry in np.
> + */
> +struct iio_channel *of_iio_channel_get(struct device_node *np, int index);
> +
> +/**
>   * iio_channel_release() - release channels obtained via iio_channel_get
>   * @chan:		The channel to be released.
>   */
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
