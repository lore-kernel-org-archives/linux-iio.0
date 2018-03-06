Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:41636 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753024AbeCFNlO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Mar 2018 08:41:14 -0500
Date: Tue, 06 Mar 2018 13:41:14 +0000
In-Reply-To: <1520341471.12790.35.camel@nxp.com>
References: <20180305140224.dgh3rcywgxgxsxbx@smtp.gmail.com> <1520259685.12790.12.camel@nxp.com> <e876642e-0286-9602-884f-00f026d6873f@metafoo.de> <f8f972b2-837d-b242-6fa3-40bf21952b0b@analog.com> <20180306123628.sawzr3k7ek3rkz46@smtp.gmail.com> <1520341471.12790.35.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: Work plan to move meter out of staging
To: Daniel Baluta <daniel.baluta@nxp.com>,
        "rodrigosiqueiramelo@gmail.com" <rodrigosiqueiramelo@gmail.com>,
        "michael.hennerich@analog.com" <michael.hennerich@analog.com>
CC: "lars@metafoo.de" <lars@metafoo.de>,
        "21cnbao@gmail.com" <21cnbao@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <94A1C1A3-D492-41D3-A022-B1E1A2E6ED57@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 6 March 2018 13:04:31 GMT, Daniel Baluta <daniel.baluta@nxp.com> wrote:
>On Ma, 2018-03-06 at 09:36 -0300, Rodrigo Siqueira wrote:
>> Hi,
>> 
>> > 
>> > On 05.03.2018 17:30, Lars-Peter Clausen wrote:
>> > In general I think this is a great idea, however looking at it from
>a
>> > different angle -
>> > Most of the supported metering circuits are already marked as not
>> > recommended for new designs.
>> > While Analog Devices have a very strong product portfolio in the
>Metering IC
>> > space, all of the parts in
>> > staging/iio/meter are from 2011 and before and have already seen
>multiple
>> > product iterations since then.
>> > A major rework of these drivers might require testing,
>unfortunately these
>> > drivers were developed by a different team which now pursues
>different
>> > responsibilities.
>> > So I won’t be able to test them again, and therefore I’m also a bit
>hesitant
>> > to lift them out of staging.
>> I have seen your message a few minutes ago, just after I sent a patch
>> series that removes checkpatch problems from meter module. Anyway,
>after
>> your comments, I believe that is a better idea to work on another
>module
>> in the staging. Is that ok Daniel?
>
>Hi,
>
>I think it is still a good idea to make the checkpatch changes in the
>meter directory
>from staging. 
For work already done I agree but perhaps we can find a better target for effort going forward.

Michael, what is the position on the CDC drivers and the resolver ones? 

Jonathan
>> 
>> Just for curiosity, what is the process to remove meter from staging?
>
>Make sure we use the standard IIO interfaces, good quality code and
>good testing :).
>
>thanks,
>Daniel.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
