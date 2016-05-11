Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34257 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbcEKGBZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 May 2016 02:01:25 -0400
Received: by mail-oi0-f49.google.com with SMTP id k142so51683389oib.1
        for <linux-iio@vger.kernel.org>; Tue, 10 May 2016 23:01:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <90802d98-c7bc-bc14-214c-0d1c3bf19b14@intel.com>
References: <1462870813-24700-1-git-send-email-linus.walleij@linaro.org>
	<1462870813-24700-2-git-send-email-linus.walleij@linaro.org>
	<90802d98-c7bc-bc14-214c-0d1c3bf19b14@intel.com>
Date: Wed, 11 May 2016 08:01:24 +0200
Message-ID: <CACRpkda+MWGoO0OGzmk93B2JE97rbBvSF5yAy7pTPvTBCjFYug@mail.gmail.com>
Subject: Re: [PATCH 2/2 v6] iio: st_sensors: read surplus samples in trigger
From: Linus Walleij <linus.walleij@linaro.org>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, May 10, 2016 at 6:40 PM, Crestez Dan Leonard
<leonard.crestez@intel.com> wrote:
> [Me]
>> ChangeLog v5->v6:
>> - Add a loop counter to the threaded value poll function: let's
>>   just loop here for at maximum 10 loops before we exit and
>>   let the thread re-trigger if more interrupts arrived.
>
> This only serves to hide the problem.

Not really. The system can preempt after exiting the thread but
before processing the next set of samples.

> Version 5 seems preferable. Or
> even just adding msleep(10) in that infinite loop.

That provides a preemption point I guess but usleep_range()
is usually preferrable for such cases. 10ms is way to long
time to wait, because the max sample frequency will be
1/10ms = 100Hz and some ST sensors I have support
1kHz updates even. The usleep range would need to be
very short.

Yours,
Linus Walleij
