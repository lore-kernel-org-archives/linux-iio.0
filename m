Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <55F889DA.9070504@kernel.org>
References: <1442303356-11764-1-git-send-email-linus.walleij@linaro.org>
	<55F889DA.9070504@kernel.org>
Date: Wed, 16 Sep 2015 09:00:16 +0200
Message-ID: <CACRpkdbSDpjvKejbEuwLZQvvFPXmgt=mME5oLWwVamkB7xT71w@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/4] iio: st_accel: set up available scan masks
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Sep 15, 2015 at 11:12 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 15/09/15 08:49, Linus Walleij wrote:

>> In order to enable triggered buffered input, IIO needs to
>> know what channels can be enabled for buffered input.
>> Set up a scan mask for X/Y/Z.

> This is only necessary if the device isn't capable of reading
> any subset of channels (i.e. there are restrictions).
> In this case reads seem to be accomplished on a channel by
> channel basis with no significant additional cost so I would
> not expect available_scan_masks to be specified.
>
> Doing this restricts the driver to having to read all 3 channels
> even if only one is desired.

You're right, this patch should be dropped. I actually figured that
out but forgot about it :/

Sorry for the fuzz .. let's focus on the other patches.

Yours,
Linus Walleij
