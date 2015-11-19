Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:33185 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756816AbbKSIdZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 19 Nov 2015 03:33:25 -0500
Received: by obbww6 with SMTP id ww6so54715129obb.0
        for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2015 00:33:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5649E96E.8030400@st.com>
References: <1447664287-17310-1-git-send-email-linus.walleij@linaro.org>
	<5649BA9A.50206@st.com>
	<CACRpkdaumSNemq63o7s5EeZuBtTKmXqzd9_Kb5ZfouNQbfvEOg@mail.gmail.com>
	<5649E96E.8030400@st.com>
Date: Thu, 19 Nov 2015 09:33:24 +0100
Message-ID: <CACRpkdbxPhPsHWoYZwvTOrofBPsj9ELeHVSopbM-m2Mg9qVR3w@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] iio: st_sensors: support active-low interrupts
From: Linus Walleij <linus.walleij@linaro.org>
To: Giuseppe BARBA <giuseppe.barba@st.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Denis CIOCCA <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Nov 16, 2015 at 3:34 PM, Giuseppe BARBA <giuseppe.barba@st.com> wrote:
> [Me]
>> For the accelerometer I guessed it's the same as the other sensors,
>> but as LSM303AGR also has DRDY for the magnetometer, I was
>> wondering if there is a bit for IHL and OD also for the magnetometer
>> side?
>
> Yes, the interrupt polarity is also present for magnetometer.
> This is namely IEA bit in the register CTRL_REG_M (0x63), bit 2 (mask
> 0x04). Following the bit description:
>
> Controls the polarity of the INT bit when an interrupt occurs.
> Default: 0
>
> If IEA = 0, then INT = 0 signals an interrupt
> If IEA = 1, then INT = 1 signals an interrupt

OK updated the patch, sending it out.

But does it also have an Open Drain bit?

Yours,
Linus Walleij
