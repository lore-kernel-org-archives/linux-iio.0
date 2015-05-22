Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-127.synserver.de ([212.40.185.127]:1677 "EHLO
	smtp-out-126.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756418AbbEVMkZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2015 08:40:25 -0400
Message-ID: <555F22E5.3020600@metafoo.de>
Date: Fri, 22 May 2015 14:36:53 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: Add I/Q modifiers
References: <1432052790-26458-1-git-send-email-lars@metafoo.de>	<CAEnQRZBW7aCmqasFsm5cFwv37BdwVb0W5LXOU7fhEHNbJqj1VA@mail.gmail.com>	<555C3BF4.8060906@metafoo.de> <CAEnQRZBbA95fUm8mhhstWwbqaeLj0H63AwV2MU2TphtqywHM-Q@mail.gmail.com>
In-Reply-To: <CAEnQRZBbA95fUm8mhhstWwbqaeLj0H63AwV2MU2TphtqywHM-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/20/2015 12:22 PM, Daniel Baluta wrote:
> On Wed, May 20, 2015 at 10:47 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 05/20/2015 07:57 AM, Daniel Baluta wrote:
>>>
>>> On Tue, May 19, 2015 at 7:26 PM, Lars-Peter Clausen <lars@metafoo.de>
>>> wrote:
>>>>
>>>> I/Q modifiers can be used to denote signals which are represented by a
>>>> in-phase and a quadrature component.
>>>>
>>>> The ABI documentation describes the I and Q modifiers for current and
>>>> voltage channels for now as those will be the most likely users.
>>>>
>>>
>>> Hi Lars,
>>>
>>> Is there a driver exposing this ABI?
>>
>>
>> There is a driver. It is not yet upstream though.
>
> In this case we should try to upstream that driver too. Or at least,
> add an example
> entry in our IIO dummy driver.

The driver will go upstream eventually, but there are a quite a few 
infrastructure dependencies, both in IIO and other parts of the kernel, that 
need to go upstream first. Sometimes it makes sense to split things into 
smaller parts and submit those things that are simple and ready rather than 
accumulating a patch-bomb of 50+ patches.

>
> It does make any sense to expose an ABI if no one is using it.

I'm using it :)
