Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57028 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754868Ab3I2RoP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 Sep 2013 13:44:15 -0400
Message-ID: <52487515.7080601@kernel.org>
Date: Sun, 29 Sep 2013 19:44:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 01/18] iio: Extend the event config interface
References: <1380200317-19355-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1380200317-19355-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/26/13 13:58, Lars-Peter Clausen wrote:
> The event configuration interface of the IIO framework has not been getting the
> same attention as other parts. As a result it has not seen the same improvements
> as e.g. the channel interface has seen with the introduction of the channel spec
> struct. Currently all the event config callbacks take a u64 (the so called event
> code) to pass all the different information about for which event the callback
> is invoked. The callback function then has to extract the information it is
> interested in using some macros with rather long names. Most information encoded
> in the event code comes straight from the iio_chan_spec struct the event was
> registered for. Since we always have a handle to the channel spec when we call
> the event callbacks the first step is to add the channel spec as a parameter to
> the event callbacks. The two remaining things encoded in the event code are the
> type and direction of the event. Instead of passing them in one parameter, add
> one parameter for each of them and remove the eventcode from the event
> callbacks. The patch also adds a new iio_event_info parameter to the
> {read,write}_event_value callbacks. This makes it possible, similar to the
> iio_chan_info_enum for channels, to specify additional properties other than
> just the value for an event. Furthermore the new interface will allow to
> register shared events. This is e.g. useful if a device allows configuring a
> threshold event, but the threshold setting is the same for all channels.
>
> To implement this the patch adds a new iio_event_spec struct which is similar to
> the iio_chan_spec struct. It as two field to specify the type and the direction
> of the event. Furthermore it has a mask field for each one of the different
> iio_shared_by types. These mask fields holds which kind of attributes should be
> registered for the event. Creation of the attributes follows the same rules as
> the for the channel attributes. E.g. for the separate_mask there will be a
> attribute for each channel with this event, for the shared_by_type there will
> only be one attribute per channel type. The iio_chan_spec struct gets two new
> fields, 'event_spec' and 'num_event_specs', which is used to specify which the
> events for this channel. These two fields are going to replace the channel's
> event_mask field.
>
> For now both the old and the new event config interface coexist, but over the
> few patches all drivers will be converted from the old to the new interface.
> Once that is done all code for supporting the old interface will be removed.
>

A nice bit of work.

Only one thing really came to mind. Is it worth us adding another field to the
struct iio_device_attribute to avoid the dance to cram the event index and the
offset into the one value?  If we want to avoid adding memory usage, small though
it would be, perhaps drop an appropriate union in there to make this code easier
to follow?  Obviously the attribute creation functions might get fiddlier though.

Although it would cause a fair bit of churn to change it, the name of 'address'
in there is rather misleading now as it very rarely actually contains an address!

One trivial naming question otherwise.

...
> -static int iio_device_add_event_sysfs(struct iio_dev *indio_dev,
> +static int iio_device_add_event(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, unsigned int spec_offset,
spec_offset vs spec_index?
Unless some fairly nefarous games are played in a driver, this value
will always be an index into an array.  Offset made me wonder, wrt to
which base position...
> +	enum iio_event_type type, enum iio_event_direction dir,
> +	enum iio_shared_by shared_by, const unsigned long *mask)
> +{
> +	ssize_t (*show)(struct device *, struct device_attribute *, char *);
...
