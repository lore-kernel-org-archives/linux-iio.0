Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34838 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbbBUSeg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Feb 2015 13:34:36 -0500
Message-ID: <54E8CFBA.1020904@kernel.org>
Date: Sat, 21 Feb 2015 18:34:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "Tirdea, Irina" <irina.tirdea@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
	"Reus, Adriana" <adriana.reus@intel.com>
Subject: Re: [PATCH 0/2] bmc150-accel driver optimizations
References: <1424110621-16571-1-git-send-email-irina.tirdea@intel.com> <alpine.DEB.2.02.1502162026470.26763@pmeerw.net> <1F3AC3675D538145B1661F571FE1805F19A20DE0@irsmsx105.ger.corp.intel.com>
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F19A20DE0@irsmsx105.ger.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/02/15 12:05, Tirdea, Irina wrote:
> 
> 
>> -----Original Message-----
>> From: linux-iio-owner@vger.kernel.org [mailto:linux-iio-owner@vger.kernel.org] On Behalf Of Peter Meerwald
>> Sent: 16 February, 2015 21:27
>> To: Tirdea, Irina
>> Cc: Jonathan Cameron; linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; Pandruvada, Srinivas; Reus, Adriana
>> Subject: Re: [PATCH 0/2] bmc150-accel driver optimizations
>>
>>
>>> Adds optimization of i2c transactions in trigger handler and
>>> usage of available_scan_masks for bmc150-accel.
>>
>> same comments as for kxcjk-1013, this changes the capabilities of the
>> driver
>>
> Will fix the comments for all the patchsets.
> 
> Thanks,
> Irina
Same point as you made in the other driver applies here and this is fine
as the core will deal with it.

Anyhow, I'm happy with this, except for the excellent idea of putting
the emulation code into the i2c core.  No particular rush at the moment
given where we are in the cycle so might as well wait for that to pan out.

Jonathan
> 
>>> Irina Tirdea (2):
>>>   iio: accel: bmc150: use available_scan_masks
>>>   iio: accel: bmc150: optimize i2c transfers in trigger handler
>>>
>>>  drivers/iio/accel/bmc150-accel.c | 49 +++++++++++++++++++++++++++++++---------
>>>  1 file changed, 38 insertions(+), 11 deletions(-)
>>>
>>>
>>
>> --
>>
>> Peter Meerwald
>> +43-664-2444418 (mobile)
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

