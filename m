Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33800 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415AbbHaQJW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 31 Aug 2015 12:09:22 -0400
Received: by igui7 with SMTP id i7so59284166igu.1
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2015 09:09:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55E46C08.80602@kernel.org>
References: <cover.1440459082.git.knaack.h@gmx.de>
	<55E46C08.80602@kernel.org>
Date: Mon, 31 Aug 2015 19:09:21 +0300
Message-ID: <CALT56yOWN5U5gcmGo=PfGBDUxMpNpVDhUYshF3B+KV39598Qqw@mail.gmail.com>
Subject: Re: [PATCH 0/6] fixes, cleanup and improvements for m62332
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

2015-08-31 18:00 GMT+03:00 Jonathan Cameron <jic23@kernel.org>:
> On 28/08/15 22:59, Hartmut Knaack wrote:
>> A set of patches to address some issues I spotted during review.
>>
>> Hartmut Knaack (6):
>>   iio:dac:m62332: share scale and offset
>>   iio:dac:m62332: shutdown on remove
>>   iio:dac:m62332: use ARRAY_SIZE
>>   iio:dac:m62332: drop unrequired variable
>>   iio:dac:m62332: address some style issues
>>   iio:dac:m62332: use dynamic scale
>>
>>  drivers/iio/dac/m62332.c | 63 +++++++++++++++++++++++++-----------------------
>>  1 file changed, 33 insertions(+), 30 deletions(-)
>>
> Other than letting this series sit on the list a few days longer,
> for Dmitry or others to take a look at it, I'm happy with this series.

The changes look good, however I'd like to test them on my hardware first.

-- 
With best wishes
Dmitry
