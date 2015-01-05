Return-Path: <octavian.purdila@intel.com>
MIME-Version: 1.0
In-Reply-To: <54A9249E.1010906@kernel.org>
References: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com>
	<1419122556-8100-3-git-send-email-octavian.purdila@intel.com>
	<54A9249E.1010906@kernel.org>
Date: Mon, 5 Jan 2015 20:48:25 +1000
Message-ID: <CAE1zotLaVD6Z1c8KQyh3gJ+T7mXCtUiCbZ9vd6aD27JAGQkEFg@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] iio: buffer: refactor buffer attributes setup
From: Octavian Purdila <octavian.purdila@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jan 4, 2015 at 9:31 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 21/12/14 00:42, Octavian Purdila wrote:
>> Move all core (non-cusotm) buffer attributes to a vector to make it
> custom
>> easier to add more of them in the future.
>>
>> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
>
> A sensible tidy up.

Can you fix-up the commit message for me, or would you prefer a new
patch? I am travelling for the next two weeks with limited internet
access, so it might take a while to get to it.
