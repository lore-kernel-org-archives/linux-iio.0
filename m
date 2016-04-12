Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:12224 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756611AbcDLNEv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 12 Apr 2016 09:04:51 -0400
Subject: Re: IIO driver for si114x
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <570CDFD0.7060702@intel.com>
 <alpine.DEB.2.02.1604121404050.4383@pmeerw.net>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <570CF267.4020804@intel.com>
Date: Tue, 12 Apr 2016 16:04:39 +0300
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1604121404050.4383@pmeerw.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/12/2016 03:06 PM, Peter Meerwald-Stadler wrote:
>> I want to add support for a si1145 light sensor. Some brief googling finds a
>> bunch of old (2012) patches for an si114x driver in drivers/iio/light. Here's
>> the link to the old thread:
>>
>> http://comments.gmane.org/gmane.linux.kernel.iio/5478
>
> I have updated sources, not yet posted
> Matt Ranostay also indicated that he'd be willing to work on the device
I found some reasonably recent sources in the chromeos kernel:

https://chromium.googlesource.com/chromiumos/third_party/kernel-next/+/chromeos-4.4/drivers/iio/light/si114x.c

This driver seems to be only for si1141/42/43 models and will explicitly 
fail on probe with the part_id values reported by si1145. Some hacking 
made the driver probe and report some sort of values.

I'm not sure how well that driver is tested, it failed for me at 
register time because SI114X_CURRENT_CHANNEL has the default scan_index 
0 and this is detected as a duplicate despite the fact that scan_type is 
not otherwise filled. This check has been in the IIO core since 3.18.

If you have updated sources can you please post them?

--
Regards,
Leonard
