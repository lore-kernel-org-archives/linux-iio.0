Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:54517 "EHLO mail.aswsp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754775AbcIHIRJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 8 Sep 2016 04:17:09 -0400
Message-ID: <57D11F7A.3020708@parrot.com>
Date: Thu, 8 Sep 2016 10:21:14 +0200
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 1/1] iio:core: fix IIO_VAL_FRACTIONAL sign handling
References: <e66c33d8d00c51878039a967f2650f7bc1866e90.1472840709.git.gregor.boirie@parrot.com> <e20dc6d8-7bd0-0feb-6464-a8af61b880a9@kernel.org> <32c015f4-bbd7-e2f4-3b4c-f7799ea95360@metafoo.de> <419daee6-1e68-dba4-3e04-3c13d58eea44@kernel.org> <57D0584E.2000709@parrot.com> <1fee492b-55f1-cffa-4bef-9e5ed421551d@metafoo.de>
In-Reply-To: <1fee492b-55f1-cffa-4bef-9e5ed421551d@metafoo.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 09/07/2016 08:54 PM, Lars-Peter Clausen wrote:
> On 09/07/2016 08:11 PM, Gregor Boirie wrote:
>> Just to mention that a somewhat similar patch might be needed to handle
>> negative
>> IIO_VAL_FRACTIONAL_LOG2 values.
> Hm, right, Michael's patch handled that. Do you want to send a patch, or do
> you prefer that somebody else sends it?
I'm sure Michael's patch will suit me, not to mention that I have no driver
requiring IIO_VAL_FRACTIONAL_LOG2 computation on my setup :)
Please, go ahead.

Regards,
Grégor.

>
> Thanks,
> - Lars

