Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34356 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbcE2T0j (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 15:26:39 -0400
Subject: Re: [PATCH 1/3] iio: st_sensors: Init trigger before irq request
To: Linus Walleij <linus.walleij@linaro.org>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
References: <3d90f889782a9c8380c3694e55a135ddd6de9bc4.1463164919.git.leonard.crestez@intel.com>
 <CACRpkdYV3nBbOh++bca7+5uhKt5Ct7ev5M8ZuvQ8OrPP+JPrdQ@mail.gmail.com>
 <d45245cd-5950-ce98-eebe-49f0d5fa95bb@intel.com>
 <CACRpkdZ4f9XPZ6kF2QV4TNaX4KPmzDBYBGo+pXgKw06EzbEtkA@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <71402233-e0f1-6496-92a4-59ebe2f433a3@kernel.org>
Date: Sun, 29 May 2016 20:26:37 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdZ4f9XPZ6kF2QV4TNaX4KPmzDBYBGo+pXgKw06EzbEtkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/05/16 22:54, Linus Walleij wrote:
> On Tue, May 24, 2016 at 2:33 PM, Crestez Dan Leonard
> <leonard.crestez@intel.com> wrote:
>> [Me]
>>> However I think my patch fixing the thread issue will collide
>>> by being close in context to this so it'd be great if you
>>> could resend it on top of
>>> "iio: st_sensors: switch to a threaded interrupt"?
>>
>> I checked my local git tree and this was already on top of v6 of that
>> patch.
> 
> OK no problem then.
> 
>> I think this issue is much less likely to cause problems without
>> it.
> 
> Yeah.
> 
>> Perhaps it should be incorporated into your patch?
> 
> No better keep them separate.
Went on fine. Applied to the fixes-togreg-post-rc1 branch.

Whilst technically this was ugly before, it only became an issue once
we had shared interrupts. As such I'm not marking it for stable.

Thanks,

Jonathan
> 
> Yours,
> Linus Walleij
> 

