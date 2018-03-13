Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33230 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbeCMWLJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Mar 2018 18:11:09 -0400
Received: by mail-wm0-f43.google.com with SMTP id s206so16080511wme.0
        for <linux-iio@vger.kernel.org>; Tue, 13 Mar 2018 15:11:08 -0700 (PDT)
Subject: Re: Moving ad2s1200 out of staging
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-iio@vger.kernel.org
References: <64cf50ba-b741-7799-b944-7950ec80e35b@gmail.com>
 <20180312180507.0000581f@huawei.com>
From: David Julian Veenstra <davidjulianveenstra@gmail.com>
Message-ID: <2abfa42b-00ac-4a66-54c5-58e42f1cd18b@gmail.com>
Date: Tue, 13 Mar 2018 23:11:06 +0100
MIME-Version: 1.0
In-Reply-To: <20180312180507.0000581f@huawei.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/12/2018 06:05 PM, Jonathan Cameron wrote:
> On Mon, 12 Mar 2018 16:36:50 +0100
> David Julian Veenstra <davidjulianveenstra@gmail.com> wrote:
>
>> Dear IIO Community,
>>
>> I have looked at the ad2s1200 driver. To clean up the code, I propose
>> the following:
>>
>> 1. Replace Licence with SPDX identifier
> This ha proved controversial and certainly isn't necessary to move
> a driver out of staging.
>
>> 2. Reorder variable declarations to prefer reverse
>>     Christmas tree ordering.
>> 3. Add newlines (e.g. before return statement)
>> 4. Add documentation to the device specific struct
>> 5. Sort headers alphabetically
>> 6. Remove indexed property for channels as only a single channel is needed
>>     per type
>>
>> If I understand the manual correctly, the unit of the angular velocity is
>> rps (not entirely sure). So to conform the IIO ABI, a scaling factor
>> needs to
>> be added (IIO_CHAN_INFO_SCALE). In addition it also misses either a
>> MOD_X, MOD_Y, or MOD_Z.
> Nature of resolvers is they don't have any concept of an axis like that
> so I wouldn't expect a modifier.
>
>> The documentation in Documentation/ABI/testing/sysfs-bus-iio does not
>> define what the unit should be for an angle. If the velocity is defined
>> as radians
>> per second, it would make sense for the angle to be defined in radians.
>> Is there
>> any agreement of what the unit should be for angles?
> There are other angle measurements already in place be it not simple axial
> rotation ones so we need to match them.
> See in_incli_x_raw for example.
>
>> Besides missing features, I did not find anything else wrong with the
>> driver.
> Cool - run through the changes you suggest and then propose a move.
> At that point you'll get a thorough review to see if there is anything
> much else that needs doing.
>
> I can see some more issues so I'll give a few hints:
> 1) How much is platform data used these days?
> 2) Does the platform data there conform to how we do things these days?
>
>> Best regards,
>> David Veenstra
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Dear Jonathan Cameron,

Thanks for the feedback and the hints. I'll look into the platform data.

Best regards,
David Veenstra
