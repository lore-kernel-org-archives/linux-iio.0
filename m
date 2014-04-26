Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55161 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbaDZK4R (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 26 Apr 2014 06:56:17 -0400
Message-ID: <535B912B.8000005@kernel.org>
Date: Sat, 26 Apr 2014 11:57:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Denis CIOCCA <denis.ciocca@st.com>,
	Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 5/6] iio: st_sensors: add devicetree probing support
References: <1397416143-4396-1-git-send-email-linus.walleij@linaro.org>	<1397416143-4396-6-git-send-email-linus.walleij@linaro.org>	<53582E4C.3060800@kernel.org> <CACRpkdbmS39HL4Z8CSbtPtkWYqZn6hNCMdwzk+1fepKkSUAO1A@mail.gmail.com>
In-Reply-To: <CACRpkdbmS39HL4Z8CSbtPtkWYqZn6hNCMdwzk+1fepKkSUAO1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/04/14 09:33, Linus Walleij wrote:
> On Wed, Apr 23, 2014 at 11:19 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>
>> I can't make up my mind whether I like this or not.
>> Having said that it fixes an ABI compatibility issue that I couldn't
>> see a way around so nicely done.
>
> Lots of redundant strings is device trees second name.
>
>> (note I'll leave this set be for now given the device tree element
>> and that it hasn't been 3 weeks yet)
>
> I'll respin the patch anyway, the OF compatible table should
> be in the core file rather than the .h file. I try to keep it in common
> code so I2C and SPI alike be able to use the same table
> atleast.

Cool, I'll wait on that then (and the remaining week of the 3 weeks to tick
by).

