Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39165 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbbDSNGK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Apr 2015 09:06:10 -0400
Message-ID: <5533A841.3060008@kernel.org>
Date: Sun, 19 Apr 2015 14:06:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>
CC: sathyanarayanan.kuppuswamy@linux.intel.com, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
	daniel.baluta@gmail.com
Subject: Re: [PATCH v7 0/2] Add support for LTR-301 and LTR-559 sensors
References: <1429018642-4838-1-git-send-email-daniel.baluta@intel.com> <5533A7F0.5090803@kernel.org>
In-Reply-To: <5533A7F0.5090803@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/04/15 14:04, Jonathan Cameron wrote:
> On 14/04/15 14:37, Daniel Baluta wrote:
>> This patchset adds support for LiteOn LTR301 ambient light sensor
>> and LTR559 ambient light and proximity sensor.
>>
>> v7:
>> 1. Rebase LTR-301 on top of LTR-559 and merged the patches into a single patchset
>> 2. Moved ltr501_chip_info_tbl below ltr501_info in patch 1 in order
>> to make patch 2 changes look natural. :)
>> 3. Moved "else" branch of id check from patch 2 to patch 1. Now it is no
>> longer possible to have a NULL name after this check. If id is not NULL
>> than id->name is one of ltr501_id already defined strings.
>>
>> v6:
>> 1. Changed the title in commit log
>>
>> v5:
>> 1. Rebased this patch on top of Daniel's LTR559 patchset
>>    (http://marc.info/?l=linux-kernel&m=142779827617036&w=2)
>> 2. Added info and channel members to chip_info struture.
>>
>> v4:
>> 1. Addressed minor comments from Peter Meerwald
>> 2. Changed invalid chip id errno from ENOSYS to ENODEV
>> 3. Fixed channel id index number
>> 4. Removed unused variable.
>>
>> v3:
>> 1. Sent v2 before by mistake. So sending the final version of v2 as v3.
>>
>> v2:
>> 1. Handled device id NULL case in probe
>> 2. Changed pr_warn to dev_warn
>>
>> v1:
>> Extended LTR501 driver to support both LTR301 and LTR501 device.
>>
>> Daniel Baluta (1):
>>   iio: ltr501: Add support for ltr559 chip
>>
>> Kuppuswamy Sathyanarayanan (1):
>>   iio: ltr501: Add support for ltr301
>>
>>  drivers/iio/light/Kconfig  |   3 +-
>>  drivers/iio/light/ltr501.c | 240 ++++++++++++++++++++++++++++++++++++++-------
>>  2 files changed, 209 insertions(+), 34 deletions(-)
>>
> 
> Sorry Daniel, I've confused this further by first taking the set that added
> interrupt support to this driver. Hence this series doesn't apply at all.
> 
> Don't suppose you could rebase on my testing branch to deal with that.
> 
> Sorry again, I was obviously half asleep and hadn't registered just how
> much pain these two sets were going to cause.
I think this is all just fuzz, but I'm more likely to mess it up that you!
> 
> Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

