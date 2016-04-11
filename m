Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <570A6364.4070600@kernel.org>
References: <1458825486-17188-1-git-send-email-linus.walleij@linaro.org>
	<1458825486-17188-2-git-send-email-linus.walleij@linaro.org>
	<56F8E550.6040305@kernel.org>
	<CACRpkdZx2L8JZ76iypApN7WCz7vgSVvamBamkzhQfyG+NdUcbw@mail.gmail.com>
	<CACRpkdb3JaL1KGOMmRCwUPPUW_NNQa4_hsQYCwazo8Q-SNbnLQ@mail.gmail.com>
	<570A6364.4070600@kernel.org>
Date: Mon, 11 Apr 2016 08:50:48 +0200
Message-ID: <CACRpkdYW2iSKtHhJUj5ZaWdFJjmbhF+wRw+P04sQZ=7mwxcefw@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: st_sensors: read each channel individually
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Apr 10, 2016 at 4:29 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 29/03/16 09:15, Linus Walleij wrote:
>> On Mon, Mar 28, 2016 at 11:20 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

>> So there are sensors out there that doesn't work well
>> with the bulk read optimization.
>>
>> I think this patch should be applied for fixes, tell me if
>> you need it rebased as the first patch (though I think it
>> will just apply).
>>
>> Giuseppe/Denis? Agree?
>
> Anyone want to comment on this?

I'd say apply it.

If bulk mode should be supported it needs to be opt-in
since the LIS331DL obviously cannot handle it.

Yours,
Linus Walleij
