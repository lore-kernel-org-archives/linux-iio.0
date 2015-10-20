Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from netline-mail3.netline.ch ([78.47.214.34]:41461 "EHLO
	netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbbJTF7t (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 20 Oct 2015 01:59:49 -0400
Subject: Re: iio:ad5064: Add support for LTC2617
To: Lars-Peter Clausen <lars@metafoo.de>, jic23@kernel.org
References: <CAEnQRZC4sxWXkUgz7316NrzHYa9GkfneG82PcPKgK00S76W=GA@mail.gmail.com>
 <1444912264-44606-1-git-send-email-marc.andre@netline.ch>
 <5624D136.9030100@metafoo.de>
Cc: knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
From: Marc Andre <marc.andre@netline.ch>
Message-ID: <5625D850.7060201@netline.ch>
Date: Tue, 20 Oct 2015 07:59:44 +0200
MIME-Version: 1.0
In-Reply-To: <5624D136.9030100@metafoo.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 19.10.2015 13:17, Lars-Peter Clausen wrote:
> On 10/15/2015 02:31 PM, Marc Andre wrote:
>> I've updated the patches according to the feedback of Peter and Daniel.
>> - Added datasheet links to the description of patch 1/2.
>> - Added 90kohm_to_gnd to ABI documentation sysfs-bus-iio
>>
> Looks good to me. You can add
>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
>
> I'd prefer though if you change the order of the patches. Patch 1 refactor
> the macros so you can specify the ext_info. Patch 2 add support for the LTC
> devices, this way we don't end up with a intermediate step where power-down
> is broken.
I will do that, but I am currently traveling on a business trip, I will 
send it towards the end of the week. I assume I can put the Acked-by on 
as long as the code doesn't change.

>> **** Original intro *****
>>
>> Based on the discussion after submitting my patch to add a new driver
>> for LTC2617, I've now implemented the support for the LTC2617 (and
>> similar) devices into the AD5064 driver.
>>
>> I've split the implementation into two patches. The first patch adds
>> basic support for LTC2617. The second patch fixes the power down
>> functionality because the LTC handle that differently than the AD
>> devices.
>>
>> [PATCH v2 1/2] iio:ad5064: Add support for ltc2617 and similar devices
>> [PATCH v2 2/2] iio:ad5064: Fix power down operation with LTC2617
>>
>> Best Regards,
>> Marc
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Marc André, André-Netline
eBusiness-Solutions

André-Netline
Könizstr. 161
CH-3097 Liebefeld

Tel. 031 974 16 66
Fax: 031 974 16 65
marc.andre@netline.ch
http://www.netline.ch

