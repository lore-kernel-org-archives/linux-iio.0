Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr30134.outbound.protection.outlook.com ([40.107.3.134]:56766
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751354AbeFDFV2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 4 Jun 2018 01:21:28 -0400
Subject: Re: [PATCH] iio: adc: ti-ads8688: use the auto sequence feature
To: Jonathan Cameron <jic23@kernel.org>
Cc: pmeerw@pmeerw.net, linux-iio@vger.kernel.org
References: <20180530211821.8496-1-sean.nyekjaer@prevas.dk>
 <20180603162835.59676a01@archlinux>
From: =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean.nyekjaer@prevas.dk>
Message-ID: <307d7ecc-b45f-7841-32f7-694da69fe37d@prevas.dk>
Date: Mon, 4 Jun 2018 07:21:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180603162835.59676a01@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 2018-06-03 17:28, Jonathan Cameron wrote:
> On Wed, 30 May 2018 23:18:21 +0200
> Sean Nyekjaer <sean.nyekjaer@prevas.dk> wrote:
> 
>> The TI ADS8688 have a auto sequence feature that allows
>> to continuesly reading new values from the chosen channels.
>> Lets enable it and we will be able to sample at the double speed
>> vs the old implementation
>>
>> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> 
> hmm. Technically it's an ABI change as someone may be relying on the
> ability to do sysfs reads whilst we are also using the chardev interface.
> However, I doubt anyone is so lest see if anyone notices ;)
> 
> One comment inline. Otherwise looks fine to me.
> 
> With care, we could gotten the speed up without using autosequencing
> but that doesn't really matter as that isn't what we were doing previously.
> 
> Thanks,
> 
> Jonathan
> 
>> ---
Oh i din't know that we must always be able to read from sysfs, with 
this adc the auto sequencing will stop if a manual read is done :-(
Maybe I could change it so the auto trigger mode will still be calling 
the channels manually? That way we will have the same amount of 
channels, but greater freedom to be able to do sysfs reads...

>> +static int ads8688_update_scan_mode(struct iio_dev *indio_dev,
>> +	const unsigned long *active_scan_mask)
>> +{
>> +	int scan_count;
>> +
>> +	scan_count = bitmap_weight(active_scan_mask, indio_dev->masklength);
> 
> What is scan_count for?
Woops, just some cp for debugging :-) Will remove it

/Sean
