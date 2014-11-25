Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-207.synserver.de ([212.40.185.207]:1070 "EHLO
	smtp-out-207.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbaKYRAK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 25 Nov 2014 12:00:10 -0500
Message-ID: <5474B59B.8000101@metafoo.de>
Date: Tue, 25 Nov 2014 18:00:11 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>
CC: Vlad Dogaru <vlad.dogaru@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/4] Add valid sample channel
References: <1416919687-14271-1-git-send-email-vlad.dogaru@intel.com>	<5474B01D.8020701@metafoo.de> <CAEnQRZC_ax0n2b+pTiTVLk=0m+AzX7JkRHdB=8a70d8hQ3eD-Q@mail.gmail.com>
In-Reply-To: <CAEnQRZC_ax0n2b+pTiTVLk=0m+AzX7JkRHdB=8a70d8hQ3eD-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/25/2014 05:55 PM, Daniel Baluta wrote:
> On Tue, Nov 25, 2014 at 6:36 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 11/25/2014 01:48 PM, Vlad Dogaru wrote:
>>>
>>> This is an attempt to address the problem of buffering in devices which
>>> have
>>> different scan frequencies for different channels.
>>
>>
>> Will these frequencies still be related or completely arbitrary?
>
> For Kionix KMX61 we have the same set of frequencies for
> accelerometer and magnetometer (12.5, 25, 50, 100 Hz, etc)
> but for example at some point accel can be configured with 100 Hz
> and magnetometer with 12.5Hz.
>
> Does this matter?

I'm wondering if it makes more sense to register multiple buffers or devices 
if the frequencies are completely unrelated. E.g. in the KMX61 case it looks 
as if its simply two logical devices in the same physical package.

- Lars

