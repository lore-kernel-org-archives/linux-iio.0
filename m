Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:35584 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754869AbeFYKGg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jun 2018 06:06:36 -0400
Date: Mon, 25 Jun 2018 11:06:16 +0100
In-Reply-To: <CAEnQRZCOVrYk=oifne81Fo_ky_3vLq85AwA2v6qJ68s7HRMTDQ@mail.gmail.com>
References: <1529562877-9357-1-git-send-email-himanshujha199640@gmail.com> <1529562877-9357-4-git-send-email-himanshujha199640@gmail.com> <20180622144435.0000613b@huawei.com> <CAEnQRZCOVrYk=oifne81Fo_ky_3vLq85AwA2v6qJ68s7HRMTDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [RFC 3/3] iio: imu: bme680: Add ACPI support
To: Daniel Baluta <daniel.baluta@gmail.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
CC: Himanshu Jha <himanshujha199640@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <AF0F37DE-70F9-4B88-BEE1-48516E1795BB@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 25 June 2018 08:40:08 BST, Daniel Baluta <daniel.baluta@gmail.com> wrote:
>On Fri, Jun 22, 2018 at 4:44 PM, Jonathan Cameron
><jonathan.cameron@huawei.com> wrote:
>> On Thu, 21 Jun 2018 12:04:37 +0530
>> Himanshu Jha <himanshujha199640@gmail.com> wrote:
>>
>>> Add support to probe the bme680 sensor on the i2c bus using
>>> ACPI.
>>>
>>> Cc: Daniel Baluta <daniel.baluta@gmail.com>
>>> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
>>
>> This looks fine.  Do we know for sure that they use that ACPI
>> ID?  For these sorts of devices, it's fairly common to have entirely
>> random ids presented.   Also, I'm a little curious to know, what
>> ACPI based device has one of these?
>
>Hi Jonathan,
>
>I am not aware of any ACPI device using our chosen ID. We just
>picked BME0680 based on previous drivers from Bosch.
>
>It is useful to enumerate the sensor via ACPI because our
>qemu testing setup uses ACPI.

Cool. Any docs on that setup?  Would be useful blog post if easy to do.

J
>
>thanks,
>Daniel.
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
