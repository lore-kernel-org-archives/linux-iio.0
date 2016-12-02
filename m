Return-Path: <SRS0=aK7h=XR=gmail.com=aniroop.mathur@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161130144345epcms5p24751680d9fec0f33d5283db9e09410ca@epcms5p2>
References: <1480132046-5406-1-git-send-email-a.mathur@samsung.com>
 <fc667b4b-6d40-db6e-3855-7a181fa97458@kernel.org> <CGME20161130133557epcas2p2caca5d58770bf31614812d14b809fe8f@epcas2p2.samsung.com>
 <20161130144345epcms5p24751680d9fec0f33d5283db9e09410ca@epcms5p2>
From: Aniroop Mathur <aniroop.mathur@gmail.com>
Date: Sat, 3 Dec 2016 00:37:13 +0530
Message-ID: <CADYu30_bwMKDAW8MMFvZ_ERhOWhsOQy=Vj1E7Z8YnuRgqzcbdg@mail.gmail.com>
Subject: Re: Re: [PATCH] IIO: Change msleep to usleep_range for small msecs
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: "knaack.h@gmx.de" <knaack.h@gmx.de>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, SAMUEL SEQUEIRA <s.samuel@samsung.com>,
	Rahul Mahale <r.mahale@samsung.com>, a.mathur@samsung.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Nov 30, 2016 at 8:13 PM, Aniroop Mathur <a.mathur@samsung.com> wrote:
> On 30 Nov 2016 19:05, "Lars-Peter Clausen" <lars@metafoo.de> wrote:
>  >
>  > On 11/27/2016 11:51 AM, Jonathan Cameron wrote:
>  > > On 26/11/16 03:47, Aniroop Mathur wrote:
>  > >> msleep(1~20) may not do what the caller intends, and will often sleep longer.
>  > >> (~20 ms actual sleep for any value given in the 1~20ms range)
>  > >> This is not the desired behaviour for many cases like device resume time,
>  > >> device suspend time, device enable time, data reading time, etc.
>  > >> Thus, change msleep to usleep_range for precise wakeups.
>  > >>
>  > >> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
>  > > As these need individual review by the various original authors and driver maintainers to
>  > > establish the intent of the sleep, it would have been better to have done a series of
>  > > patches (one per driver) with the relevant maintainers cc'd on the ones that they care about.
>  > >
>  > > Most of these are ADI parts looked after by Lars though so perhaps wait for his comments
>  > > before respining.
>  >
>  > I agree with what Jonathan said. For most of these extending the maximum
>  > sleep time a bit further is ok.
>  >
>
> Well, its right that sleep a bit further is okay but this patch is not trying
> to solve any major bug. This patch is only trying to make the wake up more
> precise than before. So like with msleep(1), process could sleep for 20 ms
> so this patch only making the making the process to sleep for 1 ms as
> mentioned in the parameter. So I think, changing to usleep_range is only
> advantageous and does not cause any harm here.
> We have also applied the same change in enable/disable/suspend/resume
> functions in accel, gyro, mag, etc drivers and found decent results like the
> first sesor data is generated much faster than before so response time
> increased. This is critical as  sensor can run at a rate of 200Hz / 5ms or
> even more now a days in new devices. We even applied in probe as doing the
> same in many drivers contribute to a little saving overall in kernel boot up.
> Also, it is recommended and mentioned in kernel documentation to use
> usleep_range for 1-10 ms.
> Sources -
> https://www.kernel.org/doc/Documentation/timers/timers-howto.txt
> https://lkml.org/lkml/2007/8/3/250
>


Hello Mr. Jonathan / Mr. Lars / All,


Would you kindly update further about this change?


> Thanks.
>
> BR,
> Aniroop Mathur
