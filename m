Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42685 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754AbbH0Sdt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2015 14:33:49 -0400
Subject: Re: DAC switch between current and voltage mode
To: Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean.nyekjaer@prevas.dk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	jic23@jic23.retrosnub.co.uk
References: <715D9F6A60DF2F458F39683D45F6609A7E22F4FC@VMPREVAS1.prevas.se>
 <55DABD39.5010804@prevas.dk> <55DB6629.6040603@metafoo.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55DF5808.9030001@kernel.org>
Date: Thu, 27 Aug 2015 19:33:44 +0100
MIME-Version: 1.0
In-Reply-To: <55DB6629.6040603@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/08/15 19:44, Lars-Peter Clausen wrote:
> On 08/24/2015 08:44 AM, Sean Nyekjær wrote:
>> Hi Lars-Peter
>>
>> Sorry the write again. Is the possible with the current iio interface to
>> switch a dac from voltage to current mode from userspace?
>> If not, will upstream be interrested in a patch if it's possible?
> 
> Hi,
> 
> Currently this does not work. A patch to add support for this is certainly
> welcome. I'm just not sure what the interface for this should look like.
> Maybe register both a current and a voltage channel and only allow one of
> them to be powered at a time.
That's certainly my initial thought on an interface as well... The only tricky
bit is what a read back of the 'other' channels value should report.  Perhaps
return -EBUSY?

Jonathan
> 
> - Lars
> 
> 
>>
>> Regards
>> Sean Nyekjær
>>
>> On 2015-08-20 11:57, Sean Nyekjær wrote:
>>> Hi all
>>>
>>> I'm in the process of creating a custom BSP with an ad5755 dac. It an
>>> requirement to be able to switch between voltage and current mode per
>>> channel from userspace.
>>> Is it possible with the current iio interface?
>>> Is there a feature in the pipeline where it's possible to do this switch?
>>>
>>> Regards
>>> Sean Nyekjær--
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

