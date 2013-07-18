Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yh0-f53.google.com ([209.85.213.53]:37240 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625Ab3GRO7k (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2013 10:59:40 -0400
Received: by mail-yh0-f53.google.com with SMTP id a41so1129707yho.40
        for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2013 07:59:40 -0700 (PDT)
From: Mario Domenech Goulart <mario@ossystems.com.br>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Otavio Salvador <otavio@ossystems.com.br>,
	Marek Vasut <marex@denx.de>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: ADC setting for differential and single-ended channels
References: <CAP9ODKq7TkBnpQSvwMRT0Cdy5wwfDGZ3E0ddP5vHkEgmskbcyg@mail.gmail.com>
	<201307180531.02207.marex@denx.de>
	<CAP9ODKqXg4DwXs3eXPrNR1j3fw4_H5bt+xwfuYMHuYgM+QrKPg@mail.gmail.com>
	<201307180608.09345.marex@denx.de> <51E78230.8070602@metafoo.de>
	<CAP9ODKrUcrsOVgbfm4sqv=x_Cq_Jj0aD6DwwcWHXcvVfADZAHg@mail.gmail.com>
	<51E7F37B.4050803@metafoo.de>
Date: Thu, 18 Jul 2013 14:59:34 +0000
In-Reply-To: <51E7F37B.4050803@metafoo.de> (Lars-Peter Clausen's message of
	"Thu, 18 Jul 2013 15:54:03 +0200")
Message-ID: <87ppufx6ax.fsf@parenteses.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Lars,

On Thu, 18 Jul 2013 15:54:03 +0200 Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 07/18/2013 02:02 PM, Otavio Salvador wrote:
>> On Thu, Jul 18, 2013 at 2:50 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>>
>>> Well the standard API as Jonathan said is to expose all possible pin
>>> combinations. In this case that might be up to 8x8=64 channels. In my
>>> opinion that's fine, but on a specific board maybe not all combinations are
>>> valid. So you might want to specify in your platform data or devicetree that
>>> only a subset of these 64 channels is valid and should be exposed to
>>> userspace. In my opinion it makes the most sense to handle this in the IIO
>>> core since this is a generic requirement, nothing specific to this chip.
>>> E.g. even for 'simple' converters you'll find situations where some pins
>>> might not be connected.
>> 
>> Right and how should we do this?
>> 
>> Because it would not be 8x8 but it has also the single-ended
>> combinations (using different N inputs).
>
> Does the device really support single ended, it looks to me as if it only
> supports pseudo-differential configurations.

That's not very clear to me either.  The datasheet states the chips have
single-ended inputs, but the mux configuration always assume a positive
input and a negative input.

I'm assuming the "single-ended" mode refers to using an arbitrary input
as negative reference to all the other n-1 inputs.  I suppose that'd be
a pseudo-differential configuration, right?

Best wishes.
Mario
