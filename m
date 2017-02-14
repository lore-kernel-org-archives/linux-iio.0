Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr00116.outbound.protection.outlook.com ([40.107.0.116]:10856
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754031AbdBNO3c (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Feb 2017 09:29:32 -0500
Subject: Re: [PULL] IIO fixes for 4.10 set 3 - a couple of regression fixes.
To: Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1485981657-14586-1-git-send-email-peda@axentia.se>
 <1485981657-14586-2-git-send-email-peda@axentia.se>
 <2648bf01-840e-d555-8a65-03d1d13c6ed2@kernel.org>
 <c080d4bb-9359-7218-cf30-1ea727b56184@axentia.se>
 <20170211071753.GB1345@kroah.com>
 <1e730cd9-8cb9-3752-cea0-58d4cd67695f@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Ken Lin <ken.lin@advantech.com>,
        <linux-iio@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <c6792954-db63-e311-4521-66f54a31a328@axentia.se>
Date: Tue, 14 Feb 2017 15:29:24 +0100
MIME-Version: 1.0
In-Reply-To: <1e730cd9-8cb9-3752-cea0-58d4cd67695f@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-02-11 10:16, Jonathan Cameron wrote:
> On 11/02/17 07:17, Greg Kroah-Hartman wrote:
>> On Fri, Feb 10, 2017 at 11:35:35PM +0100, Peter Rosin wrote:
>>>> On Sun, Feb 05, 2017 at 10:35:02AM +0000, Jonathan Cameron wrote:
>>>>> The following changes since commit 5c113b5e0082e90d2e1c7b12e96a7b8cf0623e27:
>>>>>
>>>>>   iio: dht11: Use usleep_range instead of msleep for start signal (2017-01-22 13:35:40 +0000)
>>>>>
>>>>> are available in the git repository at:
>>>>>
>>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.10c
>>>>
>>>> It's a bit late for 4.10 for me, can I just pull this into my -next
>>>> branch and will they get to 4.10.1 properly?  Meaning, do that have cc:
>>>> stable markings on them?  Or do you want to fix that up and resend this
>>>> request?
>>>
>>> Hi Greg,
>>>
>>> You should ask Ken Lin who has the HW and who is apparently affected.
>>> I think it's bad that you are willing to have a known regression hit
>>> v4.10 when all was fine in v4.9. Or perhaps you didn't realize that
>>> the regression was from this cycle?
>>>
>>> The fixes are obvious. I don't understand your hesitation.
>>
>> My "hesitation" is that I'm about to get on a plane for a day or so and
>> don't have the time to get this to Linus before 4.10-final is out this
>> Sunday.  Getting it in a week later should be ok, we all make mistakes,
>> as long as we fix them it's all good, and for 4.10.1 should be ok.
> Who knows, maybe Linus will delay another week anyway ;)  Wasn't looking
> that clear when I sent these out.
> 
> From my point of view, sure 4.10.1 should be fine. I'll put stable CCs
> on them. Will send the pull out shortly so I don't forget about them.
> 
> Pull request clearly now becomes first set of fixes for 4.11.

I would like to point out that one of the commit messages was destroyed
in the rebase. I.e. commit 9cf6cdba586c ("iio: pressure: mpl3115: do not
rely on structure field ordering") is now missing this line:

# cat /sys/bus/iio/devices/iio\:device1/in_pressure_scale_available

which was present before the "Segmentation fault" line before the patch
was rebased. Without the missing line, the commit message makes much
less sense...

Can this please be fixed? Perhaps there is even time for it to make v4.10?

Cheers,
peda

