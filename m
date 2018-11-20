Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40317 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeKTOMz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Nov 2018 09:12:55 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so300059pfo.7
        for <linux-iio@vger.kernel.org>; Mon, 19 Nov 2018 19:45:55 -0800 (PST)
Subject: Re: [PATCH 1/2] iio: bmi160: snap timestamp closer to event
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
References: <20181119005347.747-1-martin@martingkelly.com>
 <CAEnQRZDYRnQc3Ja5+Jp4TCLZWShx-jC4V8MOoKnk1dA_1qV46w@mail.gmail.com>
From: Martin Kelly <martin@martingkelly.com>
Message-ID: <2358868f-3c01-2bf4-2d0d-3f78c10ba14a@martingkelly.com>
Date: Mon, 19 Nov 2018 19:45:53 -0800
MIME-Version: 1.0
In-Reply-To: <CAEnQRZDYRnQc3Ja5+Jp4TCLZWShx-jC4V8MOoKnk1dA_1qV46w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/19/18 12:45 AM, Daniel Baluta wrote:
> On Mon, Nov 19, 2018 at 2:54 AM Martin Kelly <martin@martingkelly.com> wrote:
>>
>> From: Martin Kelly <martin@martingkelly.com>
>>
>> Currently, we snap the timestamp after reading from the buffer and
>> processing the event. Technically, we can get a slightly more accurate
>> timestamp by snapping it prior to reading the data, since the data was
>> already generated prior to entering the trigger handler. This is not going
>> to make a huge difference, but we might as well improve slightly.
>>
>> Signed-off-by: Martin Kelly <martin@martingkelly.com>
> 
> Makes sense to me.
> 
> Acked-by: Daniel Baluta <daniel.baluta@gmail.com>
> 
> Would be nice to see some datapoints and compare the differences.
> 

I agree. I'm a bit short of time this week because of Thanksgiving, but
I'll try to do a bit of timing testing before and after the patch next week.
