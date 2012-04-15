Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:11352 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465Ab2DOPoe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Apr 2012 11:44:34 -0400
Message-ID: <4F8AE9C6.9010901@nvidia.com>
Date: Sun, 15 Apr 2012 21:01:18 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	"lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH] staging:iio:isl29028 Add IIO_CHAN_INFO_RAW/PROCESSED
 entries
References: <1334490117-28009-1-git-send-email-jic23@kernel.org> <4F8AD058.6030705@kernel.org>
In-Reply-To: <4F8AD058.6030705@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sunday 15 April 2012 07:12 PM, Jonathan Cameron wrote:
> On 04/15/2012 12:41 PM, Jonathan Cameron wrote:
>> Precursor to making value read / write attribute optional.
>> This one stands along as it merged just before the series
>> doing all the other drivers.
>>
> Note there is also a one line change to remove the processed_val line
> in the obvious patch later in the series...
>
>> Signed-off-by: Jonathan Cameron<jic23@kernel.org>
>>

Acked-by: Laxman Dewangan <ldewangan@nvidia.com>

changes make more sense now.  I was thinking that what is mask 0 when I 
started this driver and after reading  other driver came to know about this.
>>   		switch (chan->type) {
>>   		case IIO_LIGHT:
>>   			ret = isl29028_als_get(chip, val);
>> @@ -391,12 +392,15 @@ static const struct iio_chan_spec isl29028_channels[] = {
>>   	{
>>   		.type = IIO_LIGHT,
>>   		.processed_val = 1,

processed_val should be removed here and already you have taken care.


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
