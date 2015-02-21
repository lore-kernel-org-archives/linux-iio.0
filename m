Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34782 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbbBUS0r (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Feb 2015 13:26:47 -0500
Message-ID: <54E8CDE2.8070503@kernel.org>
Date: Sat, 21 Feb 2015 18:26:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "Tirdea, Irina" <irina.tirdea@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
	"Reus, Adriana" <adriana.reus@intel.com>
Subject: Re: [PATCH 0/2] kxcjk-1013 driver optimizations
References: <1424110909-16878-1-git-send-email-irina.tirdea@intel.com> <alpine.DEB.2.02.1502162011090.26763@pmeerw.net> <1F3AC3675D538145B1661F571FE1805F19A20DB9@irsmsx105.ger.corp.intel.com>
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F19A20DB9@irsmsx105.ger.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/02/15 12:03, Tirdea, Irina wrote:
> 
> 
>> -----Original Message-----
>> From: Peter Meerwald [mailto:pmeerw@pmeerw.net]
>> Sent: 16 February, 2015 21:14
>> To: Tirdea, Irina
>> Cc: Jonathan Cameron; linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; Pandruvada, Srinivas; Reus, Adriana
>> Subject: Re: [PATCH 0/2] kxcjk-1013 driver optimizations
>>
>>
>>> Adds optimization of i2c transactions in trigger handler and
>>> usage of available_scan_masks for kxcjk-1013.
>>
>> the 'optimization' changes the capabilities of the driver, reading
>> individual channel is not possible anymore
>>
> We can still read individual channels, just that the driver does not see that anymore and the demux is handled by the iio core.
> available_scan_masks contains the bitmap superset for all channels we can enable (I will remove the 0 available_scan_mask as it does not makes sense).
Careful. That's there as a null terminator for this list of available scan masks.
> When a new channel is enabled, the iio core checks if the new mask is a subset of any entry in available_scan_masks. 
> When the buffer is pushed from the driver, the iio core will select only the enabled channel values.

Pretty much.  IIRC This originally went in as part of handling multiple clients on these
data streams, but it was rapidly pointed out that lots of drivers spun their own
versions to break out particular elements from a multichannel read.
As such, using the generic form saved on repetition in these cases as well.
A good, complex example is drivers/iio/adc/max1363 in which really weird combinations
of channels (but far from all) are available for bulk capture and reading.
> 
>>> Adriana Reus (2):
>>>   iio: accel: kxcjk-1013: use available_scan_masks
>>>   iio: accel: kxcjk-1013: optimize i2c transfers in trigger handler
>>>
>>>  drivers/iio/accel/kxcjk-1013.c | 50 ++++++++++++++++++++++++++++++++----------
>>>  1 file changed, 39 insertions(+), 11 deletions(-)
>>>
>>>
>>
>> --
>>
>> Peter Meerwald
>> +43-664-2444418 (mobile)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

