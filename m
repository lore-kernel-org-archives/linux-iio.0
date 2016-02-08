Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37509 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756070AbcBHRPq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2016 12:15:46 -0500
In-Reply-To: <56B865FC.7020106@metafoo.de>
References: <56B1DCA4.9050903@parrot.com> <56B1E2D8.90308@metafoo.de> <56B63C8E.3020309@kernel.org> <56B865FC.7020106@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: using monotonic clok for timstamping
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Mon, 08 Feb 2016 17:15:37 +0000
To: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	linux-iio@vger.kernel.org
Message-ID: <EDC91D66-140E-4BC1-BA2C-06689BB8FC02@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 8 February 2016 09:55:08 GMT+00:00, Lars-Peter Clausen <lars@metafoo.de> wrote:
>On 02/06/2016 07:33 PM, Jonathan Cameron wrote:
>> On 03/02/16 11:22, Lars-Peter Clausen wrote:
>>> On 02/03/2016 11:55 AM, Gregor Boirie wrote:
>>>> Dear  all,
>>>>
>>>> Our application relies on precise and monotonic timestamping of IMU
>samples
>>>> (and other sensors).
>>>> I am wondering what reasons / use cases led to the choice of
>realtime clock
>>>> to implement
>>>> iio_get_time_ns (not to mention time gaps that may be seen after
>wake up
>>>> from sleep states).
>>>
>>> It's more of an oversight than a deliberate design decision. I
>noticed this
>>> problem as well a while ago and wanted to re-write things to use the
>>> monotonic clock, but then realized that this would be a ABI change
>so
>>> dropped it and forgot about it again.
>> There are certainly cases where the other clock would make sense (for
>slow
>> sampling device where being as correct as possible is the most
>important
>> thing).
>
>I'm not sure I understand what you are trying to say, maybe we are not
>on
>the same page. As far as I know both clocks have the same precession,
>but
>their absolute value differs.
>
>What iio_get_time_ns() currently returns is the system clock, which
>changes
>whenever the time is changed (e.g. to compensate for drift, or daylight
>saving, etc.). This is obviously not so great if that happens in the
>middle
>of the capture since what you care about is the relative distance
>between
>the samples and if your time base changes you have no idea what that is
>anymore.
>
>So the monotonic clock which just keeps going at a fixed interval would
>be
>the better choice.

In general I agree. My thought was that there are plausible usecases where a
 capture is every n minutes over days or years where a timestamp that tracks with
 'corrections' would make sense as intervals are not always the most
 important thing.

Most cases if course the monotonic clock is the best one. I chose badly a long time ago! Risk is someone is relying on it for some reason.

J

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
