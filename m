Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:33773 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756549AbcDLMef (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 12 Apr 2016 08:34:35 -0400
Received: by mail-ob0-f182.google.com with SMTP id tz8so10337828obc.0
        for <linux-iio@vger.kernel.org>; Tue, 12 Apr 2016 05:34:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <56F8E6AC.9090609@kernel.org>
References: <1458825486-17188-1-git-send-email-linus.walleij@linaro.org>
	<1458825486-17188-3-git-send-email-linus.walleij@linaro.org>
	<56F8E6AC.9090609@kernel.org>
Date: Tue, 12 Apr 2016 14:34:29 +0200
Message-ID: <CACRpkdbBKXmgC+1BMFB66CwwfMdLpYaMHzRz6OxBJEV9TTA8Cg@mail.gmail.com>
Subject: Re: [PATCH 3/4] iio: st_sensors: verify interrupt event to status
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Mar 28, 2016 at 10:09 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 24/03/16 13:18, Linus Walleij wrote:
>> This makes all ST sensor drivers check that they actually have
>> new data available for the requested channel(s) before claiming
>> an IRQ, by reading the status register (which is conveniently
>> the same for all ST sensors) and check that the channel has new
>> data before proceeding to read it and fill the buffer.
>>
>> This way sensors can share an interrupt line: it can be flaged
>> as shared and then the sensor that did not fire will return
>> NO_IRQ, and the sensor that fired will handle the IRQ and
>> return IRQ_HANDLED.
>>
> Looks good and even matches on the archaic lis3l02dq I keep meaning
> to add to the driver :) (had that datasheet lying around)
>
> One day we'll figure out how to report 'overruns' sensibly at
> which point we can use the other bits in that register as well.
>
> Anyhow, will let this sit just a little longer as would like Denis
> and/or Giuseppe to have a look at it as well.

If no further comments I guess this could be applied?

Yours,
Linus Walleij
