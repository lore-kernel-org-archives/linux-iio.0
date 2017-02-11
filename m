Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45213 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753600AbdBKKcW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Feb 2017 05:32:22 -0500
Subject: Re: [PATCH 1/4] iio: chemical: add particle number concentration
 channel type
To: Tomasz Duszynski <tduszyns@gmail.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20170205150100.10685-1-tduszyns@gmail.com>
 <alpine.DEB.2.02.1702051620230.21159@pmeerw.net>
 <20170205160646.GA2191@Arch.lan>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5fb87d43-fd4f-4d8a-28fe-3dac53be69a6@kernel.org>
Date: Sat, 11 Feb 2017 10:32:19 +0000
MIME-Version: 1.0
In-Reply-To: <20170205160646.GA2191@Arch.lan>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/02/17 16:06, Tomasz Duszynski wrote:
> On Sun, Feb 05, 2017 at 04:21:27PM +0100, Peter Meerwald-Stadler wrote:
>>
>>> This patch adds channel type for expressing particle number
>>> concentration.
>>
>> numberconcentration sound a bit strange to be, more like a number
>> theoretic concept
>>
>> how about particlecontentration? or numberparticles?
>>
> Agree it may sound a bit strange but in fact it is a formal physical quantity
> with SI unit. Perhaps I can leave it as is to stay consistent with
> science world?
Wikipedia seems to suggest that there are several choices, but this is
a common one in Chemistry so fair enough.

Jonathan
>>> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
>>> ---
>>>  Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
>>>  drivers/iio/industrialio-core.c         | 1 +
>>>  include/uapi/linux/iio/types.h          | 1 +
>>>  3 files changed, 9 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>>> index 530809ccfacf..481771e585ee 100644
>>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>>> @@ -1608,3 +1608,10 @@ Description:
>>>  		provides an absolute positional reference (e.g. a pulse once per
>>>  		revolution) which may be used to home positional systems as
>>>  		required.
>>> +
>>> +What:		/sys/bus/iio/devices/iio:deviceX/in_numberconcentration_input
>>> +KernelVersion: 	4.12
>>> +Contact:	linux-iio@vger.kernel.org
>>> +Description:
>>> +		Reading of particulates number in a volume of a mixture.
>>> +		Unit is in 1/m3.
>>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>>> index d18ded45bedd..451e3bb8d623 100644
>>> --- a/drivers/iio/industrialio-core.c
>>> +++ b/drivers/iio/industrialio-core.c
>>> @@ -85,6 +85,7 @@ static const char * const iio_chan_type_name_spec[] = {
>>>  	[IIO_COUNT] = "count",
>>>  	[IIO_INDEX] = "index",
>>>  	[IIO_GRAVITY]  = "gravity",
>>> +	[IIO_NUMBERCONCENTRATION] = "numberconcentration",
>>>  };
>>>
>>>  static const char * const iio_modifier_names[] = {
>>> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
>>> index ffafd6c25a48..52696e251c4d 100644
>>> --- a/include/uapi/linux/iio/types.h
>>> +++ b/include/uapi/linux/iio/types.h
>>> @@ -43,6 +43,7 @@ enum iio_chan_type {
>>>  	IIO_COUNT,
>>>  	IIO_INDEX,
>>>  	IIO_GRAVITY,
>>> +	IIO_NUMBERCONCENTRATION,
>>>  };
>>>
>>>  enum iio_modifier {
>>>
>>
>> --
>>
>> Peter Meerwald-Stadler
>> +43-664-2444418 (mobile)

