Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:60118 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753195AbcK3Nf7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Nov 2016 08:35:59 -0500
Subject: Re: [PATCH] IIO: Change msleep to usleep_range for small msecs
To: Jonathan Cameron <jic23@kernel.org>,
        Aniroop Mathur <a.mathur@samsung.com>, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1480132046-5406-1-git-send-email-a.mathur@samsung.com>
 <fc667b4b-6d40-db6e-3855-7a181fa97458@kernel.org>
Cc: s.samuel@samsung.com, r.mahale@samsung.com,
        aniroop.mathur@gmail.com,
        Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
        Linus Walleij <linus.walleij@stericsson.com>,
        Vlad Dogaru <vlad.dogaru@intel.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <d6278e93-54fd-62a1-0276-562345d36562@metafoo.de>
Date: Wed, 30 Nov 2016 14:35:47 +0100
MIME-Version: 1.0
In-Reply-To: <fc667b4b-6d40-db6e-3855-7a181fa97458@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/27/2016 11:51 AM, Jonathan Cameron wrote:
> On 26/11/16 03:47, Aniroop Mathur wrote:
>> msleep(1~20) may not do what the caller intends, and will often sleep longer.
>> (~20 ms actual sleep for any value given in the 1~20ms range)
>> This is not the desired behaviour for many cases like device resume time,
>> device suspend time, device enable time, data reading time, etc.
>> Thus, change msleep to usleep_range for precise wakeups.
>>
>> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
> As these need individual review by the various original authors and driver maintainers to
> establish the intent of the sleep, it would have been better to have done a series of
> patches (one per driver) with the relevant maintainers cc'd on the ones that they care about.
> 
> Most of these are ADI parts looked after by Lars though so perhaps wait for his comments
> before respining.

I agree with what Jonathan said. For most of these extending the maximum
sleep time a bit further is ok.

