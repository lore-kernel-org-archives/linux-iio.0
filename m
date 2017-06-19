Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:55573 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbdFSSa4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jun 2017 14:30:56 -0400
Subject: Re: [PATCH v2 3/3] iio: adc: Fix polling of INA219 conversion ready
 flag
To: =?UTF-8?Q?Br=c3=bcns=2c_Stefan?= <Stefan.Bruens@rwth-aachen.de>,
        Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20170524000907.7788-1-stefan.bruens@rwth-aachen.de>
 <20170524205335.166b7085@kernel.org>
 <20170524205641.20252455@jic23.retrosnub.co.uk>
 <1598491.c75bYYbHRJ@sbruens-linux>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <72e8186a-101e-f1e3-b7f4-19a0805ff1af@ti.com>
Date: Mon, 19 Jun 2017 13:30:31 -0500
MIME-Version: 1.0
In-Reply-To: <1598491.c75bYYbHRJ@sbruens-linux>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 06/19/2017 01:24 PM, Brüns, Stefan wrote:
> On Mittwoch, 24. Mai 2017 21:56:54 CEST Jonathan Cameron wrote:
>> On Wed, 24 May 2017 20:53:35 +0100
>>
>> Jonathan Cameron <jic23@kernel.org> wrote:
>>> On Wed, 24 May 2017 02:09:07 +0200
>>>
>>> Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:
>>>> While the INA226 has a conversion ready flag (CVRF) in the R/W
>>>> Mask/Enable
>>>> register with read-to-clear semantics, the corresponding bit of the
>>>> INA219
>>>> (CNVR) is part of the bus voltage register. The flag is cleared by
>>>> reading
>>>> the power register.
>>>>
>>>> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
>>>
>>> Again, looks good to me, but I would like input form Marc or Andrew
>>> who are more familiar with these devices than me!
>>>
>>> Ping me in a week or two if nothing is happening and I look to have
>>> lost these!
>>
>> Ah Marc's old email is bouncing.  If no one has a more up to
>> data address I guess we'll be looking at Andrew to have a chance to
>> respond (which is more likely if I actually cc him ;)
> 
> Ping ;-)
> 

As for me, my silence is approval, nothing looks incorrect to me.

> Kind regards,
> 
> Stefan
> 
