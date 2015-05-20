Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37478 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbbETKWk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2015 06:22:40 -0400
Received: by wibt6 with SMTP id t6so54430507wib.0
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2015 03:22:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <555C3BF4.8060906@metafoo.de>
References: <1432052790-26458-1-git-send-email-lars@metafoo.de>
	<CAEnQRZBW7aCmqasFsm5cFwv37BdwVb0W5LXOU7fhEHNbJqj1VA@mail.gmail.com>
	<555C3BF4.8060906@metafoo.de>
Date: Wed, 20 May 2015 13:22:39 +0300
Message-ID: <CAEnQRZBbA95fUm8mhhstWwbqaeLj0H63AwV2MU2TphtqywHM-Q@mail.gmail.com>
Subject: Re: [PATCH] iio: Add I/Q modifiers
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, May 20, 2015 at 10:47 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 05/20/2015 07:57 AM, Daniel Baluta wrote:
>>
>> On Tue, May 19, 2015 at 7:26 PM, Lars-Peter Clausen <lars@metafoo.de>
>> wrote:
>>>
>>> I/Q modifiers can be used to denote signals which are represented by a
>>> in-phase and a quadrature component.
>>>
>>> The ABI documentation describes the I and Q modifiers for current and
>>> voltage channels for now as those will be the most likely users.
>>>
>>
>> Hi Lars,
>>
>> Is there a driver exposing this ABI?
>
>
> There is a driver. It is not yet upstream though.

In this case we should try to upstream that driver too. Or at least,
add an example
entry in our IIO dummy driver.

It does make any sense to expose an ABI if no one is using it.

Daniel.
