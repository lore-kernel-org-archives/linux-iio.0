Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:55383 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784AbaFBMHc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jun 2014 08:07:32 -0400
Received: by mail-ob0-f177.google.com with SMTP id wp4so4274473obc.22
        for <linux-iio@vger.kernel.org>; Mon, 02 Jun 2014 05:07:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <535B912B.8000005@kernel.org>
References: <1397416143-4396-1-git-send-email-linus.walleij@linaro.org>
	<1397416143-4396-6-git-send-email-linus.walleij@linaro.org>
	<53582E4C.3060800@kernel.org>
	<CACRpkdbmS39HL4Z8CSbtPtkWYqZn6hNCMdwzk+1fepKkSUAO1A@mail.gmail.com>
	<535B912B.8000005@kernel.org>
Date: Mon, 2 Jun 2014 14:07:31 +0200
Message-ID: <CACRpkdaNBNHQs58U1bm61NNi6wNjYb8-sFvbQ670Mve9xynMUg@mail.gmail.com>
Subject: Re: [PATCH 5/6] iio: st_sensors: add devicetree probing support
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Denis CIOCCA <denis.ciocca@st.com>,
	Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Apr 26, 2014 at 12:57 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 24/04/14 09:33, Linus Walleij wrote:
>>
>> On Wed, Apr 23, 2014 at 11:19 PM, Jonathan Cameron <jic23@kernel.org>
>> wrote:
>>
>>> I can't make up my mind whether I like this or not.
>>> Having said that it fixes an ABI compatibility issue that I couldn't
>>> see a way around so nicely done.
>>
>>
>> Lots of redundant strings is device trees second name.
>>
>>> (note I'll leave this set be for now given the device tree element
>>> and that it hasn't been 3 weeks yet)
>>
>>
>> I'll respin the patch anyway, the OF compatible table should
>> be in the core file rather than the .h file. I try to keep it in common
>> code so I2C and SPI alike be able to use the same table
>> atleast.
>
>
> Cool, I'll wait on that then (and the remaining week of the 3 weeks to tick
> by).

Hm I couldn't figure out any better way to do this when things
come around.

Feel free to merge this patch whenever you feel it's ready, I
guess after the merge window now.

Yours,
Linus Walleij
