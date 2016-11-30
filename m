Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <fc667b4b-6d40-db6e-3855-7a181fa97458@kernel.org>
References: <1480132046-5406-1-git-send-email-a.mathur@samsung.com> <fc667b4b-6d40-db6e-3855-7a181fa97458@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 30 Nov 2016 13:19:10 +0100
Message-ID: <CACRpkdbB9AYWiaoLtr6QLZXSsyGZYkDRy2F6VKopHxx+c=FsWg@mail.gmail.com>
Subject: Re: [PATCH] IIO: Change msleep to usleep_range for small msecs
To: Jonathan Cameron <jic23@kernel.org>
Cc: Aniroop Mathur <a.mathur@samsung.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, s.samuel@samsung.com, r.mahale@samsung.com,
	aniroop.mathur@gmail.com, Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Linus Walleij <linus.walleij@stericsson.com>, Vlad Dogaru <vlad.dogaru@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Nov 27, 2016 at 11:51 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 26/11/16 03:47, Aniroop Mathur wrote:

[bmp280.c]

>>       /* Wait to make sure we started up properly */
>> -     mdelay(data->start_up_time);
>> +     usleep_range(data->start_up_time, data->start_up_time + 100);
>
> As this in probe I doubt we really care.  Could just set it longer to shut up the warnings.
> Still would like some input from say Linus on this...

Hm, I don't think it's a big issue... this works too it just looks overworked.

On the runtime_resume() path we use msleep() instead which I guess is why
it is not changed in this patch, but they have the same purpose.

Yours,
Linus Walleij
