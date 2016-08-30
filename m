Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48351 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755674AbcH3Q0I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Aug 2016 12:26:08 -0400
In-Reply-To: <CAKzfze-T6UqYp05YiGvHzxkV1bupSov0y_-p+0AiOtkbJETiKQ@mail.gmail.com>
References: <4284e190-84c2-07cc-1157-ef6d2fdd0e8c@gmail.com> <CAKzfze-T6UqYp05YiGvHzxkV1bupSov0y_-p+0AiOtkbJETiKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: iio channel sync
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Tue, 30 Aug 2016 17:26:00 +0100
To: Matt Ranostay <mranostay@gmail.com>,
        Joshua Clayton <stillcompiling@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Message-ID: <9706EDAC-1039-4D89-B5D8-CA327FA1E300@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 30 August 2016 08:41:18 BST, Matt Ranostay <mranostay@gmail.com> wrote:
>On Mon, Aug 29, 2016 at 10:03 AM, Joshua Clayton
><stillcompiling@gmail.com> wrote:
>> Jonathan,
>>
>> I have an out-of tree driver I am working on mainlining.
>>
>> The device is a sensor that gets phase and amplitude (x and y) data
>>
>> on multiple physical and/or time multiplexed channels.
>>
>> It also has up to 4 optical encoders to get physical location.
>>
>> The existing driver bundles x and y together with a snapshot
>>
>> of the encoder sums at that moment.
>>
>>
>> This seems like a good fit for iio, but one item is bothering me.
>>
>> How is synchronization between streams usually handled with
>>
>> iio drivers? Timing can be important.
>
>Wouldn't the trigger buffer framework be good enough for this?
Perhaps you could describe your usecase a little more?

Is the interesting bit that you want to sync streams with different sampling frequencies?
Are those encoders better represented by a separate driver? (In which case I have some thoughts on simple additions to IIO trigger handling that might help - basically a hold off on triggers until all relevant devices are attached)


>
>>
>> Joshua Clayton
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
>in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
