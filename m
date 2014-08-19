Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51678 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556AbaHSTNr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Aug 2014 15:13:47 -0400
Message-ID: <53F3A1E7.8070804@kernel.org>
Date: Tue, 19 Aug 2014 20:13:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add designated reviewers for IIO subsystem
References: <1408350589-22372-1-git-send-email-lars@metafoo.de> <alpine.DEB.2.01.1408181042300.4583@pmeerw.net> <53F27709.9000901@gmx.de>
In-Reply-To: <53F27709.9000901@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/08/14 22:58, Hartmut Knaack wrote:
> Peter Meerwald schrieb:
>> On Mon, 18 Aug 2014, Lars-Peter Clausen wrote:
>>
>>> Add those persons who generally tend to review new IIO patches to the list of
>>> designated reviewers to make sure that they are Cc'ed on new patches.
>>>
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>> ---
>>> Hartmut, Peter if you are OK with this please ack the patch, otherwise I can
>>> respin it to remove you.
>> Acked-by: Peter Meerwald <pmeerw@pmeerw.net>
> Acked-by: Hartmut Knaack <knaack.h@gmx.de>
Good idea!  Thanks to all 3 of you for the reviewing and it makes sense
to make it apparent to non regular readers of linux-iio.

Applied to the togreg branch of iio.git

J
>>
>>> ---
>>>  MAINTAINERS | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index aefa948..3f77be0 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -4580,6 +4580,9 @@ F:	drivers/media/rc/iguanair.c
>>>  
>>>  IIO SUBSYSTEM AND DRIVERS
>>>  M:	Jonathan Cameron <jic23@kernel.org>
>>> +R:	Hartmut Knaack <knaack.h@gmx.de>
>>> +R:	Lars-Peter Clausen <lars@metafoo.de>
>>> +R:	Peter Meerwald <pmeerw@pmeerw.net>
>>>  L:	linux-iio@vger.kernel.org
>>>  S:	Maintained
>>>  F:	drivers/iio/
>>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
