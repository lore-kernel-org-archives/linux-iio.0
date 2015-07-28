Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:34290 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755723AbbG1OqH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2015 10:46:07 -0400
MIME-Version: 1.0
In-Reply-To: <55B25295.303@metafoo.de>
References: <1437468216-12079-1-git-send-email-daniel.baluta@intel.com>
	<1437468216-12079-2-git-send-email-daniel.baluta@intel.com>
	<55B25295.303@metafoo.de>
Date: Tue, 28 Jul 2015 17:46:05 +0300
Message-ID: <CAEnQRZAuTUq9_wD5RqtPtfXAj9raR02W3_9mWwfLHnV6Q9G_Kw@mail.gmail.com>
Subject: Re: [PATCH v2] DocBook: Add initial documentation for IIO
From: Daniel Baluta <daniel.baluta@intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, smueller@chronox.de,
	mmarek@suse.cz, linux-doc@vger.kernel.org,
	Cristina Georgiana Opriceana <cristina.opriceana@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

<snip>

>> +      converters (DACs), that functionality is also supported.
>
>
> I wouldn't necessarily treat DACs and ADCs differently here. Maybe something
> like:
>
>   The main purpose of the Industrial I/O subsystem (IIO) is to provide
>   support for devices that in some sense perform either analog-to-digital
>   conversion (ADC) or digital-to-analog conversion (DAC) or both.

Ok. Fixed.

>> +    <para> In order to be useful, a buffer needs to have an associated
>> +      trigger. Future chapters will add details about triggers and how
>> +      drivers use triggers to start data capture, moving samples from
>> device
>> +      registers to buffer storage and then upward to user space
>> applications.
>
>
> Buffers don't have to have a trigger, only triggered buffers need them.
> Although admittedly most buffers will be triggered buffers. I think it's
> better to talk about buffers in general first and then discuss the different
> types of buffers and when to use them. In this context it should be
> mentioned that a triggered buffer needs a trigger to function.

I removed this paragraph for the moment, will try to add more info about
buffer here with a follow up patch.

<snip>

>> +        </itemizedlist>
>
>
> The scan type gained a repeat field a while ago.

Nice catch. Fixed. Also will send a patch to fix the ABI entry description.

<snip>

>> +    Here <emphasis> scan_index </emphasis> is used for ordering data
>> samples
>> +    (scans) when read from buffer.
>
>
> A bit more:
>
>   scan_index defines the relative order in which the enabled channels
>   are placed inside the buffer, a channel with a lower scan_index will be
>   placed before a channel with a higher index. Each channels needs to have
>   a unique scan_index.
>
>   It is important to realize that the scan_index does not define the
>   absolution position in the buffer. E.g. a channel with the scan_index = 3
>   will not be at offset 3 bytes or 3 words, but rather will be placed in
>   the buffer after any channel with a scan_index lower than 3 and before
>   any channel with a scan_index larger than 3.
>
>   Furthermore the scan indices do not have to be consecutive. E.g. A
>   channel spec array that defines 3 channels with the indices 1, 2 and 3 is
>   just as valid as a channel spec that uses the indices 100, 200, 300. The
>   relative order of the channels will be the same.
>
>   Setting scan_index to -1 can be used to indicate that the specific
>   channel does not support buffered capture. In this case no entries will
>   be created for the channel in the scan_elements directory.

Nice. I've included this in the documentation.

Thanks a lot Lars for your review.

Daniel.
