Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-006.synserver.de ([212.40.185.6]:1138 "EHLO
	smtp-out-002.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751377Ab2BPPAi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Feb 2012 10:00:38 -0500
Message-ID: <4F3D1A6C.7010308@metafoo.de>
Date: Thu, 16 Feb 2012 16:02:04 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 1/5] staging:iio: Add extended IIO channel info
References: <1329389351-21584-1-git-send-email-lars@metafoo.de> <4F3D142E.20403@cam.ac.uk>
In-Reply-To: <4F3D142E.20403@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/16/2012 03:35 PM, Jonathan Cameron wrote:
> Fairly busy day so just some initial comments.  I'll think about this some
> more when I get
> a chance...
>> Sometimes devices have per channel properties which either do not map
>> nicely to
>> the current channel info scheme (e.g. string properties) or are very device
>> specific, so it does not make sense to add generic support for them.
> For the second class is it so bad to just put them in via attrs?  The first
> I agree
> entirely should be supported in a fashion similar to this.  What you have
> here is
> going to involve a fairly similar amount of boiler plate.

With this you only need to specify the extended attributes once and can let
each channel use the same set. Without it you need to create a attribute for
each channel manually. Patch 2 in this series shows this quite nicely.

And as I wrote having support for similar chips with different channel
numbers makes this even worse.

>>
>> Currently drivers define these attributes by hand for each channel.
>> Depending on
>> the number of channels this can amount to quite a few lines of boilerplate
>> code.
>> Especially if a driver supports multiple variations of a chip with different
>> numbers of channels. In this case it becomes necessary to have a individual
>> attribute list per chip variation and also a individual iio_info struct.
>>
>> This patch introduces a new scheme for handling such per channel attributes
>> called extended channel info attributes. A extended channel info attribute
>> consist of a name, a flag whether it is shared and read and write callbacks.
>> The read and write callbacks are similar to the {read,write}_raw callbacks
>> and
>> take a IIO device and a channel as their first parameters, but instead of
>> pre-parsed integer values they directly get passed the raw string value,
>> which
>> has been written to the sysfs file.
>>
>> It is possible to assign a list of extended channel info attributes to a
>> channel. For each extended channel info attribute the IIO core will create
>> a new
>> sysfs attribute conforming to the IIO channel naming spec for the channels
>> type,
>> similar as for normal info attributes. Read and write access to this sysfs
>> attribute will be redirected to the extended channel info attributes read and
>> write callbacks.
> My questions with this are about how it will interact with in kernel users.
> It is definitely
> worth having a string type iio_info element.
> I wonder if we want to allow free naming?  Could we define an enum to cover
> 'string' type iio_info elements?

It is not intended to be used by in kernel users, it is just meant as a
replacement for the handcrafted per channel sysfs attributes.

>>
>> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
>> ---
>>   drivers/staging/iio/iio.h               |   23 ++++++++++++
>>   drivers/staging/iio/industrialio-core.c |   61
>> ++++++++++++++++++++++++++++---
>>   2 files changed, 78 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
>> index be6ced3..2a0cfbb 100644
>> --- a/drivers/staging/iio/iio.h
>> +++ b/drivers/staging/iio/iio.h
>> @@ -88,6 +88,25 @@ enum iio_endian {
>>       IIO_LE,
>>   };
>>
>> +struct iio_chan_spec;
>> +struct iio_dev;
>> +
>> +/**
>> + * struct iio_chan_spec_ext_info - Extended channel info attribute
>> + * @name:    Info attribute name
>> + * @shared:    Whether this attribute is shared between all channels.
>> + * @read:    Read callback for this info attribute, may be NULL.
>> + * @write:    Write callback for this info attribute, may be NULL.
>> + */
>> +struct iio_chan_spec_ext_info {
>> +    const char *name;
>> +    bool shared;
>> +    ssize_t (*read)(struct iio_dev *, struct iio_chan_spec const *,
>> +            char *buf);
>> +    ssize_t (*write)(struct iio_dev *, struct iio_chan_spec const *,
>> +            const char *buf, size_t len);
>> +};
> Is it worth making the callbacks also take the const char *name from above
> in the structure or
> define some sort of 'private' integer in here. I'm just thinking of aiding
> reuse of the
> callbacks

Yes, I've thought about it and decided against it, since we don't have a
user for this right now. So chances are that I'd get the interface wrong and
we need to modify it once we have real users anyway. Also coccinelle makes
it quite trivial to refactor a function or callback to take an additional
parameter.
