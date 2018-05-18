Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from titan.imtexcloud.com ([52.52.55.48]:12040 "EHLO
        titan.imtexcloud.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751363AbeERRwD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 May 2018 13:52:03 -0400
To: <linux-iio@vger.kernel.org>, <pmeerw@pmeerw.net>
From: =?UTF-8?Q?Maxime_Roussin-B=c3=a9langer?= <roussinm@sonatest.com>
Subject: Re: SI1133 light sensor: Is there anything to refer to?
Message-ID: <55cc843b-5fb8-c8e5-b2e3-26bc706fc9b3@sonatest.com>
Date: Fri, 18 May 2018 13:42:11 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Peter,

Do you have any progress that could be shared for si1153?

Even if it's not complete I could use it to begin si1133.

Thanks,
Maxime.

>Excellent news. I'll keep a watch for this new driver to show up.
>In the meantime, we just got the sensor to respond correctly using
>i2cget|set commands.
>
>FYI, the issue we had was that the reset value of ADCCONFIGx is not 0x00
>(as specified by the datasheet), but 0x0f, which selected no photodiode.
>Hence, we received only noise values.
>
>Thanks a lot and have a good day
>
>--
>
>Olivier Dugas
>
>On 17-06-19 11:10 AM, Peter Meerwald-Stadler wrote:
>> Hello Olivier,
>>
>>> We've recently been trying to make the SI1133 light sensor work
according to
>>> what's written in its datasheet. Unfortunately many questions remain
and the
>>> si1145.c driver seems largely different from si1133. We believe that
any code
>>> sample would be of a great help. Are you aware of any driver,
unmerged patch
>>> or other code sample for this sensor?
>> the si1133 belongs in the same family as the si1153 which has a different
>> register layout than the previous chips, so I think a separate driver is
>> needed
>>
>> I do have an eval board for the si1153 and started a driver, but it's not
>> ready for submission (yet), the si1133 should be a lot simpler than the
>> si1153
>>
>> regards, p.
>>
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
