Return-Path: <leonard.crestez@intel.com>
Subject: Re: [PATCH 1/3] iio: st_sensors: Init trigger before irq request
To: Linus Walleij <linus.walleij@linaro.org>
References: <3d90f889782a9c8380c3694e55a135ddd6de9bc4.1463164919.git.leonard.crestez@intel.com>
 <CACRpkdYV3nBbOh++bca7+5uhKt5Ct7ev5M8ZuvQ8OrPP+JPrdQ@mail.gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Daniel Baluta <daniel.baluta@intel.com>,
 Giuseppe Barba <giuseppe.barba@st.com>, Denis Ciocca <denis.ciocca@st.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <d45245cd-5950-ce98-eebe-49f0d5fa95bb@intel.com>
Date: Tue, 24 May 2016 15:33:45 +0300
MIME-Version: 1.0
In-Reply-To: <CACRpkdYV3nBbOh++bca7+5uhKt5Ct7ev5M8ZuvQ8OrPP+JPrdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 05/24/2016 02:27 PM, Linus Walleij wrote:
> On Fri, May 13, 2016 at 8:43 PM, Crestez Dan Leonard
> <leonard.crestez@intel.com> wrote:
> 
>> This fixes a possible race where an interrupt arrives before complete
>> initialization and crashes because iio_trigger_get_drvdata returns NULL.
>>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Giuseppe Barba <giuseppe.barba@st.com>
>> Cc: Denis Ciocca <denis.ciocca@st.com>
>> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
>> ---
>> I ran into this while breaking the driver. But since the interrupt line can be
>> shared the handler should always be able to accept and ignore a call.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> However I think my patch fixing the thread issue will collide
> by being close in context to this so it'd be great if you
> could resend it on top of
> "iio: st_sensors: switch to a threaded interrupt"?

I checked my local git tree and this was already on top of v6 of that
patch. I think this issue is much less likely to cause problems without
it. Perhaps it should be incorporated into your patch?

I'll resend if it causes conflicts for Jonathan.

-- 
Regards,
Leonard
