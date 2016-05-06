Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1462524763-24566-1-git-send-email-linus.walleij@linaro.org>
References: <1462524763-24566-1-git-send-email-linus.walleij@linaro.org>
Date: Fri, 6 May 2016 13:21:51 +0200
Message-ID: <CACRpkdYoWPx1Q7xxF2a+6FopY9Er0K7FhsyBVUxf8sWJT_S_zw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: st_sensors: switch to a threaded interrupt
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>, Crestez Dan Leonard <cdleonard@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, May 6, 2016 at 10:52 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> commit 98ad8b41f58dff6b30713d7f09ae3834b8df7ded
> ("iio: st_sensors: verify interrupt event to status") caused
> a regression when reading ST sensors from a HRTimer trigger
(...)
> ChangeLog v1->v2:
> - v1 was missing timestamps since nothing ever stamped them.
>   Restore the timestamps by simply using
>   iio_trigger_generic_data_rdy_poll()
>   as the top half of the threaded interrupt handler.

Bah what's wrong with me?

This just kicks the old code back into action.
Calls WAKE_THREAD on the cascaded trigger irqchip
and make everything like it was before :(

What I need to do is introduce a function to the core that
just timestamps the pollfunction and nothing else.

I'll respin again...

Yours,
Linus Walleij
