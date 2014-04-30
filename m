Return-Path: <dianders@google.com>
MIME-Version: 1.0
Sender: dianders@google.com
In-Reply-To: <536161F5.7090508@kernel.org>
References: <1398850015-17761-1-git-send-email-ch.naveen@samsung.com>
	<1398850015-17761-6-git-send-email-ch.naveen@samsung.com>
	<536161F5.7090508@kernel.org>
Date: Wed, 30 Apr 2014 16:23:27 -0700
Message-ID: <CAD=FV=U-_0FWNHrqWp+rfmucKO5GQibCr8N09M8NVSb180ieBQ@mail.gmail.com>
Subject: Re: [PATCH 5/5 v3] iio: exynos_adc: do a reinit_completion before the conversion
From: Doug Anderson <dianders@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>, linux-iio <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Naveen Krishna <naveenkrishna.ch@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>, "cpgs ." <cpgs@samsung.com>,
	Grant Grundler <grundler@chromium.org>, Tomasz Figa <t.figa@samsung.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Jonathan,

On Wed, Apr 30, 2014 at 1:49 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 30/04/14 10:26, Naveen Krishna Chatradhi wrote:
>>
>> Add reinit_completion() before the wait_for_completion_timeout in
>> raw_read() call.
>>
>> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>> Reviewed-by: Doug Anderson <dianders@chromium.org>
>
> Applied to the togreg branch of iio.git
> I wasn't sure if this one was technically a fix, but as it isn't
> marked clearly as such it can go in during the next merge window.
> I won't have pushed this out to a non rebasing branch until tomorrow
> so if this fixes an observed issue then let me know and it might move
> to the fixes-togreg branch.

As far as I know this doesn't fix an observed issue.  I believe it was
requested as part of a previous review and is finally reposted.  I
believe it's just extra precautions to make sure that some old IRQ
didn't accidentally complete us between the last transaction and this
one.

Old discussion is somewhere around here
<https://patchwork.kernel.org/patch/2279591/>

Thanks!

-Doug
