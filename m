Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <d45245cd-5950-ce98-eebe-49f0d5fa95bb@intel.com>
References: <3d90f889782a9c8380c3694e55a135ddd6de9bc4.1463164919.git.leonard.crestez@intel.com>
	<CACRpkdYV3nBbOh++bca7+5uhKt5Ct7ev5M8ZuvQ8OrPP+JPrdQ@mail.gmail.com>
	<d45245cd-5950-ce98-eebe-49f0d5fa95bb@intel.com>
Date: Tue, 24 May 2016 23:54:43 +0200
Message-ID: <CACRpkdZ4f9XPZ6kF2QV4TNaX4KPmzDBYBGo+pXgKw06EzbEtkA@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: st_sensors: Init trigger before irq request
From: Linus Walleij <linus.walleij@linaro.org>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>, Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, May 24, 2016 at 2:33 PM, Crestez Dan Leonard
<leonard.crestez@intel.com> wrote:
> [Me]
>> However I think my patch fixing the thread issue will collide
>> by being close in context to this so it'd be great if you
>> could resend it on top of
>> "iio: st_sensors: switch to a threaded interrupt"?
>
> I checked my local git tree and this was already on top of v6 of that
> patch.

OK no problem then.

> I think this issue is much less likely to cause problems without
> it.

Yeah.

> Perhaps it should be incorporated into your patch?

No better keep them separate.

Yours,
Linus Walleij
