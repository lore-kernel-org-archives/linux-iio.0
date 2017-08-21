Return-Path: <SRS0=C9z+=7X=rere.qmqm.pl=mirq-linux@kernel.org>
Date: Mon, 21 Aug 2017 23:45:10 +0200
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/6] iio: accel: kxcjk1013: rename registers for KXTF9
 compatibility
Message-ID: <20170821214510.av6wufitda7jayiw@qmqm.qmqm.pl>
References: <cover.1502979014.git.mirq-linux@rere.qmqm.pl>
 <97ed7c895e7eec28b66d4e591c30d40b00322820.1502979014.git.mirq-linux@rere.qmqm.pl>
 <20170820105222.36dcaa38@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <20170820105222.36dcaa38@archlinux>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Aug 20, 2017 at 10:52:22AM +0100, Jonathan Cameron wrote:
> On Thu, 17 Aug 2017 16:21:36 +0200
> Micha³ Miros³aw <mirq-linux@rere.qmqm.pl> wrote:
> > Rename some registers that are shared between KXTF9 and KXCJK.
> > Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> 
> Hi Micha³,
> 
> I'm not keen on this change.   Going for generic names is always
> fragile as all it takes is another part coming along which is almost
> but not quite the same as you shared register set and we end up with
> a mess.
> 
> General convention for both register values and driver naming is they
> should be named after one supported part rather than trying to find
> a generic name that covers all supported parts.
> 
> So please revert this change and resend the series.
> 
> Sorry to be a pain, but this has gone wrong quite a lot of times in
> the past!

I removed the renaming, but left KXTF9-specific registers with KXTF9_
prefix. This is hard to avoid as some registers are named differently
in KXTF9 and KXCJK datasheets, but are otherwise compatible. There is
also a register that is the same but has different address.

I'll send v2 shortly.

BTW, I browsed through "sell sheets" of Kionix's accelerometers, and
I would guess that for eg. KXCJK-1013, "KXCJK" is a model, and "1013"
is variation. KXTF9 has two such variations differing only in supply
voltages it is calibrated to run with. Based on that I would rename
the driver to "kxcjk" to save on typing if there are more similar
parts to add later. There is KXSD9 driver (different register set), so
this would match clearly.

Best Regards,
Micha³ Miros³aw
