Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:4993 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932685AbdHVMsP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Aug 2017 08:48:15 -0400
Date: Tue, 22 Aug 2017 13:47:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
CC: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/6] iio: accel: kxcjk1013: rename registers for KXTF9
 compatibility
Message-ID: <20170822134749.00003e7f@huawei.com>
In-Reply-To: <20170821214510.av6wufitda7jayiw@qmqm.qmqm.pl>
References: <cover.1502979014.git.mirq-linux@rere.qmqm.pl>
        <97ed7c895e7eec28b66d4e591c30d40b00322820.1502979014.git.mirq-linux@rere.qmqm.pl>
        <20170820105222.36dcaa38@archlinux>
        <20170821214510.av6wufitda7jayiw@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 21 Aug 2017 23:45:10 +0200
Micha³ Miros³aw <mirq-linux@rere.qmqm.pl> wrote:

> On Sun, Aug 20, 2017 at 10:52:22AM +0100, Jonathan Cameron wrote:
> > On Thu, 17 Aug 2017 16:21:36 +0200
> > Micha³ Miros³aw <mirq-linux@rere.qmqm.pl> wrote:  
> > > Rename some registers that are shared between KXTF9 and KXCJK.
> > > Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>  
> > 
> > Hi Micha³,
> > 
> > I'm not keen on this change.   Going for generic names is always
> > fragile as all it takes is another part coming along which is almost
> > but not quite the same as you shared register set and we end up with
> > a mess.
> > 
> > General convention for both register values and driver naming is they
> > should be named after one supported part rather than trying to find
> > a generic name that covers all supported parts.
> > 
> > So please revert this change and resend the series.
> > 
> > Sorry to be a pain, but this has gone wrong quite a lot of times in
> > the past!  
> 
> I removed the renaming, but left KXTF9-specific registers with KXTF9_
> prefix. This is hard to avoid as some registers are named differently
> in KXTF9 and KXCJK datasheets, but are otherwise compatible. There is
> also a register that is the same but has different address.

That's what I expected. Thanks.
> 
> I'll send v2 shortly.
> 
> BTW, I browsed through "sell sheets" of Kionix's accelerometers, and
> I would guess that for eg. KXCJK-1013, "KXCJK" is a model, and "1013"
> is variation. KXTF9 has two such variations differing only in supply
> voltages it is calibrated to run with. Based on that I would rename
> the driver to "kxcjk" to save on typing if there are more similar
> parts to add later. There is KXSD9 driver (different register set), so
> this would match clearly.

While that makes sense, be careful not to change anything that is
reflected in userspace ABI and that includes module names.  Tends
to break things in odd ways.

Jonathan
> 
> Best Regards,
> Micha³ Miros³aw
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

