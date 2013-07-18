Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yh0-f48.google.com ([209.85.213.48]:36520 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758838Ab3GRRlh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2013 13:41:37 -0400
Received: by mail-yh0-f48.google.com with SMTP id z12so1187720yhz.7
        for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2013 10:41:36 -0700 (PDT)
From: Mario Domenech Goulart <mario.goulart@gmail.com>
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
	<51E7F37B.4050803@metafoo.de> <87ppufx6ax.fsf@parenteses.org>
Date: Thu, 18 Jul 2013 17:41:33 +0000
In-Reply-To: <87ppufx6ax.fsf@parenteses.org> (Mario Domenech Goulart's message
	of "Thu, 18 Jul 2013 14:59:34 +0000")
Message-ID: <87ehavwysy.fsf@parenteses.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 18 Jul 2013 14:59:34 +0000 Mario Domenech Goulart <mario@ossystems.com.br> wrote:

> On Thu, 18 Jul 2013 15:54:03 +0200 Lars-Peter Clausen <lars@metafoo.de> wrote:
>
>> On 07/18/2013 02:02 PM, Otavio Salvador wrote:
>>> On Thu, Jul 18, 2013 at 2:50 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>>>
>>>> Well the standard API as Jonathan said is to expose all possible pin
>>>> combinations. In this case that might be up to 8x8=64 channels. In my
>>>> opinion that's fine, but on a specific board maybe not all combinations are
>>>> valid. So you might want to specify in your platform data or devicetree that
>>>> only a subset of these 64 channels is valid and should be exposed to
>>>> userspace. In my opinion it makes the most sense to handle this in the IIO
>>>> core since this is a generic requirement, nothing specific to this chip.
>>>> E.g. even for 'simple' converters you'll find situations where some pins
>>>> might not be connected.
>>> 
>>> Right and how should we do this?
>>> 
>>> Because it would not be 8x8 but it has also the single-ended
>>> combinations (using different N inputs).
>>
>> Does the device really support single ended, it looks to me as if it only
>> supports pseudo-differential configurations.
>
> That's not very clear to me either.  The datasheet states the chips have
> single-ended inputs, but the mux configuration always assume a positive
> input and a negative input.
>
> I'm assuming the "single-ended" mode refers to using an arbitrary input
> as negative reference to all the other n-1 inputs.  I suppose that'd be
> a pseudo-differential configuration, right?

Here's part of a message from a TI employee that explains the
single-ended mode:

  "The ADS1248 has 8 multiplexed inputs. When we describe a single ended
  input, we use one input as a common line, and use the remaining 7
  inputs measured against common. In this way we decribe this each as a
  single ended input. That's how we get 7 single ended inputs."

Quoted from
http://e2e.ti.com/support/data_converters/precision_data_converters/f/73/p/31638/110153.aspx#110153

Best wishes.
Mario
