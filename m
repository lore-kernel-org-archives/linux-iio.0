Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39884 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbdCQSXG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Mar 2017 14:23:06 -0400
Date: Fri, 17 Mar 2017 18:21:20 +0000
In-Reply-To: <alpine.DEB.2.20.1703171817340.22010@vps.pmeerw.net>
References: <20170302184031.GA27741@gmail.com> <2e6ed211-baf2-9877-fbb4-b39aa75f4dee@kernel.org> <20170305134600.GB5467@gmail.com> <53b785e1-7956-2833-91b6-dd4632556f2d@kernel.org> <CANBTL1V5mo7GaeMspo0rUW=B+XEh0A_3X_Sa71n7MQPB1xTztQ@mail.gmail.com> <50348765-3a51-0f7b-e243-012890646dd7@kernel.org> <CANBTL1XBNK=W36QwnAzkPWvQ6psM4RoPs8YS1ydgC0FPFPPLKA@mail.gmail.com> <alpine.DEB.2.20.1703171817340.22010@vps.pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH] iio:light: Add support for STMicro VL6180 sensor
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mani Sadhasivam <manivannanece23@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        Linux iio <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <35925631-A755-45CD-AAF6-EF861C658F3C@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 17 March 2017 17:21:52 GMT+00:00, Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:
>
>> > A classic option would be to allow provision of a gpios to manually
>perform
>> > the reset.  Sounds like that's not an option on your board however.
>> >
>> > If not, is it possible to get the device to a known state by simply
>writing
>> > all it's registers?  If it's really impossible to continue in this
>state
>> > we need detailed explanation of why here in comments in the code.
>> 
>> Alright. I couldn't find a case where false reset might cause an
>issue. So,
>> it'd be better to skip the settings and allow the driver to work
>instead of
>> error out scenario.
>> 
>> Is this fine for you Jonathan?
>
>I think the fresh-out-of-reset thing is informative really
>we are writing the most relevant config registers anyway on probe
>
>I'd remove the check of the register or make it a log message only; the
>
>clearing of the register could be dependent on the check, however

Logging makes sense as might allow some future issue to be tracked down.
>
>regards, p.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
