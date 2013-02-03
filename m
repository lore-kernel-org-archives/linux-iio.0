Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:65095 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960Ab3BCQWH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Feb 2013 11:22:07 -0500
Date: Sun, 3 Feb 2013 08:22:13 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>
Subject: Re: [PATCH v2 4/4] iio: Add OF support
Message-ID: <20130203162213.GA21576@roeck-us.net>
References: <1359853180-5664-1-git-send-email-linux@roeck-us.net>
 <1359853180-5664-5-git-send-email-linux@roeck-us.net>
 <510E7195.4070803@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <510E7195.4070803@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Feb 03, 2013 at 03:17:57PM +0100, Lars-Peter Clausen wrote:
> On 02/03/2013 01:59 AM, Guenter Roeck wrote:
> > Provide bindings and parse OF data during initialization.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
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
> > - iio_channel_get now works for both OF and non-OF configurations.
> > 
> 
> From my point of view this looks good in general now, Just a few comments.
> 
> >  .../devicetree/bindings/iio/iio-bindings.txt       |   76 ++++++++
> >  drivers/iio/inkern.c                               |  186 ++++++++++++++++++++
> >  2 files changed, 262 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/iio-bindings.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> > new file mode 100644
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
> 
> Is the extra space at the begining of each sentence on purpose?
> 
Copied from clock code, and used throughout documentation here or there.
Not my style, really, and I'll likely forget to do it if/when I add text myself,
so I'll change it.

[ ... ]

> > +	iio_hwmon {
> > +		compatible = "iio-hwmon";
> > +		io-channels = <&adc 0>, <&adc 1>, <&adc 2>,
> > +			<&adc 3>, <&adc 4>, <&adc 5>,
> > +			<&adc 6>, <&adc 7>, <&adc 8>,
> > +			<&adc 9>, <&adc 10>, <&adc 11>;
> 
> I'm not sure how much sense this example makes, since you can only request
> those channels which have a name.
> 
It does - of_iio_channel_get_all() returns all channels even if there are no names.

> [...]
> 
> +
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
> 
> I think using kcalloc makes sense here.
> 
that would leave chan->data uninitialized, and I would have to initialize it
explicitly. also, if additional fields are ever added, we would risk having
uninitialized fields. Using kzalloc avoids a potential future error case, so I
would prefer to keep it.

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
> 
> Hm, I wonder if we can share some code with of_iio_get_channel here, since it
> is pretty much the same code. Maybe put the whole parse_phandle and device
> lookup in a heler function.
> 
Done; introduced __of_iio_get_channel to be called by both functions.

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
> > +static inline struct iio_channel *of_iio_channel_get_all(struct device *dev)
> > +{
> > +	return NULL;
> > +}
> > +
> > +#endif /* CONFIG_OF */
> >  
> >  static struct iio_channel *iio_channel_get_sys(const char *name,
> >  					       const char *channel_name)
> > @@ -150,7 +324,14 @@ struct iio_channel *iio_channel_get(struct device *dev,
> >  				    const char *channel_name)
> >  {
> >  	const char *name = dev ? dev_name(dev) : NULL;
> > +	struct iio_channel *channel;
> >  
> > +	if (dev) {
> > +		channel = of_iio_channel_get_by_name(dev->of_node,
> > +						     channel_name);
> > +		if (!IS_ERR(channel))
> 
> Hm, I wonder if we should use the same semantics as for of_iio_channel_get_all
> here. NULL means there is no channel use the map lookup and error code means
> there is a channel, but there was an error requesting it. As it is right now
> for probe deferral won't work, since EPROBE_DEFER is not passed on.
> 
Yes, you are right. I'll try, and also write some test code to actually test it
to make sure that it works as intended.
