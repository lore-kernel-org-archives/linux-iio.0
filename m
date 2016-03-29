Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <CACRpkdZx2L8JZ76iypApN7WCz7vgSVvamBamkzhQfyG+NdUcbw@mail.gmail.com>
References: <1458825486-17188-1-git-send-email-linus.walleij@linaro.org>
	<1458825486-17188-2-git-send-email-linus.walleij@linaro.org>
	<56F8E550.6040305@kernel.org>
	<CACRpkdZx2L8JZ76iypApN7WCz7vgSVvamBamkzhQfyG+NdUcbw@mail.gmail.com>
Date: Tue, 29 Mar 2016 10:15:56 +0200
Message-ID: <CACRpkdb3JaL1KGOMmRCwUPPUW_NNQa4_hsQYCwazo8Q-SNbnLQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: st_sensors: read each channel individually
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Mar 28, 2016 at 11:20 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Mon, Mar 28, 2016 at 10:03 AM, Jonathan Cameron <jic23@kernel.org> wrote:

>> I'd just like to know if this is a fix that needs to go upstream faster
>> than the open drain support or not.
(...)
>
> It *might* be that LIS331DL needs this to even work properly :/

I tested on a second board today, which has *only* the LIS331DL
mounted, on an active-high line.

It has the same problem, and this commit fixes it.

So there are sensors out there that doesn't work well
with the bulk read optimization.

I think this patch should be applied for fixes, tell me if
you need it rebased as the first patch (though I think it
will just apply).

Giuseppe/Denis? Agree?

Yours,
Linus Walleij
