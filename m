Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35066 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbaKYQzm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 25 Nov 2014 11:55:42 -0500
Received: by mail-wi0-f182.google.com with SMTP id h11so2144347wiw.3
        for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2014 08:55:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5474B01D.8020701@metafoo.de>
References: <1416919687-14271-1-git-send-email-vlad.dogaru@intel.com>
	<5474B01D.8020701@metafoo.de>
Date: Tue, 25 Nov 2014 18:55:40 +0200
Message-ID: <CAEnQRZC_ax0n2b+pTiTVLk=0m+AzX7JkRHdB=8a70d8hQ3eD-Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add valid sample channel
From: Daniel Baluta <daniel.baluta@intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vlad Dogaru <vlad.dogaru@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Nov 25, 2014 at 6:36 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 11/25/2014 01:48 PM, Vlad Dogaru wrote:
>>
>> This is an attempt to address the problem of buffering in devices which
>> have
>> different scan frequencies for different channels.
>
>
> Will these frequencies still be related or completely arbitrary?

For Kionix KMX61 we have the same set of frequencies for
accelerometer and magnetometer (12.5, 25, 50, 100 Hz, etc)
but for example at some point accel can be configured with 100 Hz
and magnetometer with 12.5Hz.

Does this matter?

Daniel.
