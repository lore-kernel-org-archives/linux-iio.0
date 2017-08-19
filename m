Return-Path: <SRS0=9n3S=7V=gmail.com=harinath922@kernel.org>
Subject: Re: [PATCH] iio: accel: mma8452: Bugfix to enbale and allow different
 events to work parallely.
To: Jonathan Cameron <jic23@kernel.org>
Cc: Martin Kepplinger <martink@posteo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, knaack.h@gmx.de,
 lars@metafoo.de, gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, amsfield22@gmail.com
References: <1502750644-8854-1-git-send-email-harinath922@gmail.com>
 <alpine.DEB.2.20.1708161455420.27224@vps.pmeerw.net>
 <0a512995-3fd5-e38e-73a6-417337515ce6@gmail.com>
 <13587F36-588D-4011-8E70-A8892F81887E@posteo.de>
 <9202ac3c-cc5b-2b45-ba37-d6a24364b9e6@gmail.com>
 <20170817154041.6292ea19@archlinux>
From: Harinath Nampally <harinath922@gmail.com>
Message-ID: <6473aa07-e3d6-5b2b-39d4-38456cf7b301@gmail.com>
Date: Fri, 18 Aug 2017 20:05:52 -0400
MIME-Version: 1.0
In-Reply-To: <20170817154041.6292ea19@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

> This patch fixes by detaching the event related information from
> chip_info struct,
>>> and based on channel type and event direction the corresponding
> event configuration registers
>>> are picked dynamically. Hence multiple events can be handled in
> read/write callbacks.
>> which chip can have which event(s)?
> I am planning to add 'supported events' field in
> One small point. Don't put the word bugfix in the title (and fix
> spelling of enable!).  I know this is obviously a false restriction
> on the driver, but it doesn't not work, it is just limited in features
> without this.
Sure, thanks for letting me know.


On 08/17/2017 10:40 AM, Jonathan Cameron wrote:
>>> This patch fixes by detaching the event related information from
>>> chip_info struct,
>>>>> and based on channel type and event direction the corresponding
>>> event configuration registers
>>>>> are picked dynamically. Hence multiple events can be handled in
>>> read/write callbacks.
>>>> which chip can have which event(s)?
>>> I am planning to add 'supported events' field in
> One small point. Don't put the word bugfix in the title (and fix
> spelling of enable!).  I know this is obviously a false restriction
> on the driver, but it doesn't not work, it is just limited in features
> without this.
