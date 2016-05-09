Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <CACRpkdbEnTYFe=xd-u0JcyOGRrHydRSVBvYHsWvc1T8CsmJSQA@mail.gmail.com>
References: <1462616744-9671-1-git-send-email-linus.walleij@linaro.org>
	<1462616744-9671-2-git-send-email-linus.walleij@linaro.org>
	<17FC1367-F51B-4B0C-94C7-9984C838ECEC@jic23.retrosnub.co.uk>
	<CACRpkdbEnTYFe=xd-u0JcyOGRrHydRSVBvYHsWvc1T8CsmJSQA@mail.gmail.com>
Date: Mon, 9 May 2016 16:47:28 +0200
Message-ID: <CACRpkdZ0HM3C+6uAKVTLg7SphV7yHsPH19cjy5To+1-6OF4mCg@mail.gmail.com>
Subject: Re: [PATCH 2/2 v4] iio: st_sensors: read surplus samples in trigger
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>, Crestez Dan Leonard <cdleonard@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, May 8, 2016 at 10:55 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> I thought about it tonight, and I need to add one more thing
> to make the solution perfect: avoid registering the interrupt
> with IRQF_ONESHOT.

After a bunch of tests it appears that this is actually all
that is needed.

The interrupt core will re-wake the thread if a second
IRQ came in to the hardirq (top half) during the processing
of the thread.

As we're checking status and dealing with shared
interrupts this makes sure we never miss events.

> Then we need the top half to tell the bottom half that a new
> IRQ has arrived.

So this is not needed.

Sending a v5.

Yours,
Linus Walleij
