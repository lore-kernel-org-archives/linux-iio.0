Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34012 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbcDQSrQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Apr 2016 14:47:16 -0400
Received: by mail-oi0-f44.google.com with SMTP id k142so13533068oib.1
        for <linux-iio@vger.kernel.org>; Sun, 17 Apr 2016 11:47:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <571371DC.7000506@kernel.org>
References: <1458825486-17188-1-git-send-email-linus.walleij@linaro.org>
	<1458825486-17188-2-git-send-email-linus.walleij@linaro.org>
	<56F8E550.6040305@kernel.org>
	<CACRpkdZx2L8JZ76iypApN7WCz7vgSVvamBamkzhQfyG+NdUcbw@mail.gmail.com>
	<CACRpkdb3JaL1KGOMmRCwUPPUW_NNQa4_hsQYCwazo8Q-SNbnLQ@mail.gmail.com>
	<570A6364.4070600@kernel.org>
	<CACRpkdYW2iSKtHhJUj5ZaWdFJjmbhF+wRw+P04sQZ=7mwxcefw@mail.gmail.com>
	<571371DC.7000506@kernel.org>
Date: Sun, 17 Apr 2016 20:47:15 +0200
Message-ID: <CACRpkdZKyEBmaYembNSadC=9Zv7XiS_xr_OWVf+QoKotu0DD_A@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: st_sensors: read each channel individually
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Apr 17, 2016 at 1:22 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 11/04/16 07:50, Linus Walleij wrote:

>> If bulk mode should be supported it needs to be opt-in
>> since the LIS331DL obviously cannot handle it.
>>
> Unfortunately the context has changed a lot due to your earlier patch:
>
> iio: st_sensors: simplify buffer address handling
> which is in the togreg branch this is based on, but hasn't yet hit
> mainline.  Looking at dates it must have 'just missed' the last merge
> window.
>
> Given how different they are I think we are going to have to do different
> patches for current tree and a backported one.

OK

> So I'll pick this up in the togreg branch so we can move forward with
> that but can you roll one against current mainline as well.

It's no problem for me as I use the latest mainline all the time.

I'm more worried about anyone else out there trying to use
current -stable kernels with the LIS331DL.

I can't help but suspecting that there are lots of custom trees
out there with something like this fix (or another driver stack
altogether).

If anyone wants me to backport this, tell me.

Yours,
Linus Walleij
