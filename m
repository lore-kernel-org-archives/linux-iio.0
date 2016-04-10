Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44238 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460AbcDJO36 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2016 10:29:58 -0400
Subject: Re: [PATCH 2/4] iio: st_sensors: read each channel individually
To: Linus Walleij <linus.walleij@linaro.org>
References: <1458825486-17188-1-git-send-email-linus.walleij@linaro.org>
 <1458825486-17188-2-git-send-email-linus.walleij@linaro.org>
 <56F8E550.6040305@kernel.org>
 <CACRpkdZx2L8JZ76iypApN7WCz7vgSVvamBamkzhQfyG+NdUcbw@mail.gmail.com>
 <CACRpkdb3JaL1KGOMmRCwUPPUW_NNQa4_hsQYCwazo8Q-SNbnLQ@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <570A6364.4070600@kernel.org>
Date: Sun, 10 Apr 2016 15:29:56 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdb3JaL1KGOMmRCwUPPUW_NNQa4_hsQYCwazo8Q-SNbnLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/03/16 09:15, Linus Walleij wrote:
> On Mon, Mar 28, 2016 at 11:20 AM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
>> On Mon, Mar 28, 2016 at 10:03 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> 
>>> I'd just like to know if this is a fix that needs to go upstream faster
>>> than the open drain support or not.
> (...)
>>
>> It *might* be that LIS331DL needs this to even work properly :/
> 
> I tested on a second board today, which has *only* the LIS331DL
> mounted, on an active-high line.
> 
> It has the same problem, and this commit fixes it.
> 
> So there are sensors out there that doesn't work well
> with the bulk read optimization.
> 
> I think this patch should be applied for fixes, tell me if
> you need it rebased as the first patch (though I think it
> will just apply).
> 
> Giuseppe/Denis? Agree?
Anyone want to comment on this?

J
> 
> Yours,
> Linus Walleij
> 

