Return-Path: <jic23@kernel.org>
Message-ID: <4EDE75D5.8020200@kernel.org>
Date: Tue, 06 Dec 2011 20:06:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Lars-Peter Clausen <lars@metafoo.de>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH V3 0/7] Add scan demux unit and use it in max1363
References: <1323121036-21094-1-git-send-email-jic23@kernel.org> <4EDE3738.70704@free-electrons.com> <4EDE39F1.9090408@metafoo.de> <9d02e5f5-0297-4dc4-bb04-000b175aa992@email.android.com>
In-Reply-To: <9d02e5f5-0297-4dc4-bb04-000b175aa992@email.android.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 12/06/2011 05:05 PM, Jonathan Cameron wrote:
> 
> 
> Lars-Peter Clausen <lars@metafoo.de> wrote:
> 
>> On 12/06/2011 04:39 PM, Maxime Ripard wrote:
>>> Hi Jonathan,
>>>
>>> I can't seem to find a proper way to apply this patchset. On what
>>> patchset is it based ?
>>>
>>> I'm still here with what seems to be a rather old version of your
>> tree
>>> (3413ec), but it is still the head of your git tree on kernel.org.
>>>
>>> Thanks,
>>> Maxime
>>
>> It should apply to staging/staging-next
> Sorry. This is all queued up locally. I just forgot to push last night! LarsPeter is also correct as my master branch is just staging-next plus stuff that has gone to Greg.
I have just pushed the master branch to kernel.org.

I have also pushed inkern-staging but the two extra patches in there
need a fair bit more cleaning up.  However, if anyone with a need for
an inkernel push interface (e.g. input client for iio device) wants
to test what is there, I'd certainly welcome any feedback.

Jonathan
