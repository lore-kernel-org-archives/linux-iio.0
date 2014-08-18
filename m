Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:60416 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977AbaHRV6k (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 18 Aug 2014 17:58:40 -0400
Message-ID: <53F27709.9000901@gmx.de>
Date: Mon, 18 Aug 2014 23:58:33 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add designated reviewers for IIO subsystem
References: <1408350589-22372-1-git-send-email-lars@metafoo.de> <alpine.DEB.2.01.1408181042300.4583@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1408181042300.4583@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Peter Meerwald schrieb:
> On Mon, 18 Aug 2014, Lars-Peter Clausen wrote:
>
>> Add those persons who generally tend to review new IIO patches to the list of
>> designated reviewers to make sure that they are Cc'ed on new patches.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>> Hartmut, Peter if you are OK with this please ack the patch, otherwise I can
>> respin it to remove you.
> Acked-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
>
>> ---
>>  MAINTAINERS | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index aefa948..3f77be0 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4580,6 +4580,9 @@ F:	drivers/media/rc/iguanair.c
>>  
>>  IIO SUBSYSTEM AND DRIVERS
>>  M:	Jonathan Cameron <jic23@kernel.org>
>> +R:	Hartmut Knaack <knaack.h@gmx.de>
>> +R:	Lars-Peter Clausen <lars@metafoo.de>
>> +R:	Peter Meerwald <pmeerw@pmeerw.net>
>>  L:	linux-iio@vger.kernel.org
>>  S:	Maintained
>>  F:	drivers/iio/
>>

