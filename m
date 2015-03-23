Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <550D5B65.10906@kernel.org>
References: <1426672326-6292-1-git-send-email-linus.walleij@linaro.org>
	<20150318153948.GQ3318@x1>
	<550D5B65.10906@kernel.org>
Date: Mon, 23 Mar 2015 10:21:50 +0100
Message-ID: <CACRpkdYuWL_rs9nzg8ivRehG6-yFOheo+ZugZ-1iqmAyhwVaLQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] iio: st-sensors: add support for lis3lv02d accelerometer
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Denis CIOCCA <denis.ciocca@st.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sat, Mar 21, 2015 at 12:52 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> We aren't going to move forward without doing something.
> Hence applied to the togreg branch of iio.git.

Thanks!

>  Lets see
> whether anyone cares enough to add the stuff the other driver supports
> and this one doesn't.

The one really interesting feature I saw was the free-fall detection.
I think it'd be nice if we had the ability to register for listening
to such events from the IIO accelerometer subsystem, but I'm
scared to even try to test it, god knows how many boards I'd
break before I had this properly supported...

Yours,
Linus Walleij
