Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-173.synserver.de ([212.40.185.173]:1074 "EHLO
	smtp-out-173.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934271AbbDVP7d (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Apr 2015 11:59:33 -0400
Message-ID: <5537C565.4000704@metafoo.de>
Date: Wed, 22 Apr 2015 17:59:33 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	Daniel Baluta <daniel.baluta@gmail.com>
CC: Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v1 2/3] iio: ltr501: Add interrupt rate control support
References: <cover.1427856701.git.sathyanarayanan.kuppuswamy@linux.intel.com> <212b45fac712e84a3cf0bc5955def7d1b683a6bd.1427856701.git.sathyanarayanan.kuppuswamy@linux.intel.com> <CAEnQRZC=GtB7r=QG7DkDJOFz8bBQ-V+VD-DNkVG50-LubLMr8w@mail.gmail.com> <551C030E.1090309@metafoo.de> <CAEnQRZCsUiH_+GGxqPpLUDHVh_iu6O1QNTH5xdZuKojG11QZFQ@mail.gmail.com> <551C0B95.9080802@metafoo.de> <551C2EC4.1050208@linux.intel.com> <551C2F63.50609@metafoo.de> <551C41C0.2050609@linux.intel.com> <551C4562.9030607@linux.intel.com> <55265195.9080100@kernel.org> <5526FE97.8070705@linux.intel.com> <C91EC5E4-D042-41EE-94C8-191439F3F552@kernel.org>
In-Reply-To: <C91EC5E4-D042-41EE-94C8-191439F3F552@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/10/2015 07:51 AM, Jonathan Cameron wrote:
[...]
>>> So level rather than edge triggered.  Definitely what we put _period
>>> in for in the first place.  Admittedly persistence might have been a
>> better
>>> name, but too late now! (dratted ABI compatibility)
>>>
>>> J
>> But we cannot use period for this use case. According to _period ABI
>> description,
>> It specifies the period of time for which the condition must be true
>> for
>> getting a
>> valid event. But here, we are checking for number of times a condition
>> must be
>> true for generating a valid event.
> But we are checking that condition at a known sampling rate I assume?
> Hence
> period = persistence x 1/sampling frequency?

Sorry for highjacking this thread.

So period is for the time interval it has the event has to be asserted 
before it is registered. What would we call the same thing but for the 
de-assertion of the event? The event has to be de-asserted for X amount of 
time before it gets propagated.

Thanks,
- Lars

