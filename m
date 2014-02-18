Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36921 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754030AbaBRI5S (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Feb 2014 03:57:18 -0500
Message-ID: <53032091.5080100@kernel.org>
Date: Tue, 18 Feb 2014 08:57:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Paul Cercueil <paul.cercueil@analog.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: ad5064: Explicitly configure whether to use
 external supply
References: <1392206518-1457-1-git-send-email-paul.cercueil@analog.com> <52FB66DB.3080904@metafoo.de> <52FB6A8F.4070404@metafoo.de>
In-Reply-To: <52FB6A8F.4070404@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/02/14 12:35, Lars-Peter Clausen wrote:
> On 02/12/2014 01:19 PM, Lars-Peter Clausen wrote:
>> On 02/12/2014 01:01 PM, Paul Cercueil wrote:
>>> Previously the driver would revert to internal supply if the
>>> external supply couldn't be found. This had multiple problems:
>>> - it caused silently ignored errors when a regulator was intended
>>>    to be supplied, but was not specified correctly.
>>> - if CONFIG_REGULATOR is disabled, regulator_get() will always
>>>    return a dummy regulator, which caused a device to always use
>>>    the external vref mode, even though there is none.
>>>
>>> This patch addresses the issue by adding a platform data structure,
>>> containing a boolean field use_external_ref. If the platform data
>>> structure is present and if that boolean is set, the external vref
>>> is used; otherwise the internal vref is used.
>>>
>>> In the case where an external vref is wanted but regulator_get()
>>> fails, the driver no longer reverts to using the internal vref,
>>> but returns an error instead.
>>>
>>> Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
>>
>> All three patches:
>>
>> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
>
> Uhm, actually no. I think for devices without an internal reference we should default to using the external reference if no platform data is specified. Everything else doesn't make too much sense.

Agreed. If present, we default to the internal reference ifan external
one is not provided.  The logic in the driver can check if one is specified,
whether or not config_regulator is enabled.

Jonathan



