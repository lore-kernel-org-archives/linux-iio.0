Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53196 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbcDQLWH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Apr 2016 07:22:07 -0400
Subject: Re: [PATCH 2/4] iio: st_sensors: read each channel individually
To: Linus Walleij <linus.walleij@linaro.org>
References: <1458825486-17188-1-git-send-email-linus.walleij@linaro.org>
 <1458825486-17188-2-git-send-email-linus.walleij@linaro.org>
 <56F8E550.6040305@kernel.org>
 <CACRpkdZx2L8JZ76iypApN7WCz7vgSVvamBamkzhQfyG+NdUcbw@mail.gmail.com>
 <CACRpkdb3JaL1KGOMmRCwUPPUW_NNQa4_hsQYCwazo8Q-SNbnLQ@mail.gmail.com>
 <570A6364.4070600@kernel.org>
 <CACRpkdYW2iSKtHhJUj5ZaWdFJjmbhF+wRw+P04sQZ=7mwxcefw@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <571371DC.7000506@kernel.org>
Date: Sun, 17 Apr 2016 12:22:04 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdYW2iSKtHhJUj5ZaWdFJjmbhF+wRw+P04sQZ=7mwxcefw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/04/16 07:50, Linus Walleij wrote:
> On Sun, Apr 10, 2016 at 4:29 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 29/03/16 09:15, Linus Walleij wrote:
>>> On Mon, Mar 28, 2016 at 11:20 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
>>> So there are sensors out there that doesn't work well
>>> with the bulk read optimization.
>>>
>>> I think this patch should be applied for fixes, tell me if
>>> you need it rebased as the first patch (though I think it
>>> will just apply).
>>>
>>> Giuseppe/Denis? Agree?
>>
>> Anyone want to comment on this?
> 
> I'd say apply it.
> 
> If bulk mode should be supported it needs to be opt-in
> since the LIS331DL obviously cannot handle it.
> 
Unfortunately the context has changed a lot due to your earlier patch:

iio: st_sensors: simplify buffer address handling
which is in the togreg branch this is based on, but hasn't yet hit
mainline.  Looking at dates it must have 'just missed' the last merge
window.

Given how different they are I think we are going to have to do different
patches for current tree and a backported one.

So I'll pick this up in the togreg branch so we can move forward with
that but can you roll one against current mainline as well.

Thanks,

Jonathan

