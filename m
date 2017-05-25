Return-Path: <SRS0=+rG6=47=cogentembedded.com=nikita.yoush@kernel.org>
Subject: Re: [PATCH/RFC] iio: hi8435: do not enable all events by default
To: Jonathan Cameron <jic23@kernel.org>
References: <20170523080830.20571-1-nikita.yoush@cogentembedded.com>
 <20170524202735.3cf4e14e@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Sanchayan Maity <maitysanchayan@gmail.com>,
 Gregor Boirie <gregor.boirie@parrot.com>, Matt Ranostay
 <mranostay@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chris Healy <Chris.Healy@zii.aero>,
 Jeff White <Jeff.White@zii.aero>,
 Vladimir Barinov <vladimir.barinov@cogentembedded.com>
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <2e6019f5-94fc-bb13-f616-0c1cfe81a7db@cogentembedded.com>
Date: Thu, 25 May 2017 08:47:47 +0300
MIME-Version: 1.0
In-Reply-To: <20170524202735.3cf4e14e@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>



24.05.2017 22:27, Jonathan Cameron wrote:
> On Tue, 23 May 2017 11:08:30 +0300
> Nikita Yushchenko <nikita.yoush@cogentembedded.com> wrote:
> 
>> Having all events enabled by default is misleading.
>> Userspace should explicitly enable events they want to receive.
>>
>> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> I agree in principle, but this is a userspace ABI change.  Sadly we
> can't do it with out risking breaking userspace code...
> 
> One of those we should have caught in review, but now it's there
> we can't actually do anything about it unless we are absolutely
> sure no one will notice!

I see your point.

Still, isn't there subsystem-level default that all events are disabled
by default?  If such, then current hi8435 state breaks subsystem-level
rules, which is a [userspace-visible] bug.  I'm not sure how far should
we go in bug compatibility.

One crazy idea could be - make default selectable via device tree (with
default set to all-enabled to keep bug-compatibility).  But perhaps
that's over-reaction.
