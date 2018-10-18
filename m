Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:34732 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeJSCKu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Oct 2018 22:10:50 -0400
Subject: Re: [PATCH v2 1/1] staging: iio: adc: ad7280a: use crc8.h API to
 build crc table
To: Slawomir Stepien <sst@poczta.fm>
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org
References: <20181018114915.GA30276@x220.localdomain>
 <ef781380-2306-fb2a-8a9c-f95b23e59b0e@metafoo.de>
 <20181018180601.GA32323@x220.localdomain>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e43cabf2-5ed8-8538-abdb-be0e33ccf5eb@metafoo.de>
Date: Thu, 18 Oct 2018 20:08:22 +0200
MIME-Version: 1.0
In-Reply-To: <20181018180601.GA32323@x220.localdomain>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/18/2018 08:06 PM, Slawomir Stepien wrote:
> On paź 18, 2018 19:31, Lars-Peter Clausen wrote:
>> On 10/18/2018 01:49 PM, Slawomir Stepien wrote:
>>> The custom build function ad7280_crc8_build_table is not needed. The
>>> crc8_populate_msb function from linux/crc8.h will build the same crc
>>> table.
>>>
>>> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
>>
>> This looks good, thanks.
>>
>> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> Thank you.
> 
>> I supposed the code could be improved a bit further in a follow up patch by
>> only having one global table since it will be the same for all instances.
> 
> Yes that's a good idea.
> How should I proceed? v3 or a separate commit based on the changes in this
> commit? I think separate commit will be better, so I can make a good commit
> message...or maybe put it all in a patch series with your ack added to this
> change? Sorry I don't know the rules in such cases.

I think Jonathan will pick this patch up soon. I'd wait until the patch has
been applied and then send your next patch with further improvements to the
driver.
