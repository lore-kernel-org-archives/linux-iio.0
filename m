Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46768 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816Ab3JLKcn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2013 06:32:43 -0400
Message-ID: <52593379.2060405@kernel.org>
Date: Sat, 12 Oct 2013 12:33:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 02/20] iio: Extend the event config interface
References: <1381155094-20166-1-git-send-email-lars@metafoo.de> <1381155094-20166-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1381155094-20166-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/07/13 15:11, Lars-Peter Clausen wrote:
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
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
I like this patch a lot.  I fear at somepoint we'll need the equivalent
callbacks as we have for write_raw to allow the expected type of a write
to be queried.  We can add that when needed though.

Applied to the togreg branch of iio.git

More fuzz because I took your [PATCH] iio: Add a helper to free a list of IIO device attributes
first.
