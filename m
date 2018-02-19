Return-Path: <SRS0=oNRe=FO=opensource.cirrus.com=ckeepax@kernel.org>
Date: Mon, 19 Feb 2018 11:42:04 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: <broonie@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 4/5] iio: accel: bcm150: Remove handling for regmap
 raw_read_max
Message-ID: <20180219114204.nl3zsq55tezy7hvh@localhost.localdomain>
References: <20180215175220.2691-1-ckeepax@opensource.cirrus.com>
 <20180215175220.2691-4-ckeepax@opensource.cirrus.com>
 <20180217140935.74447c0b@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20180217140935.74447c0b@archlinux>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Feb 17, 2018 at 02:09:35PM +0000, Jonathan Cameron wrote:
> On Thu, 15 Feb 2018 17:52:19 +0000
> Charles Keepax <ckeepax@opensource.cirrus.com> wrote:
> 
> > The regmap core now handles splitting up transactions according to
> > max_raw_read, so this code is no longer required in client drivers.
> > 
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Hi Charles,
> 
> This looks fine to me.  I'll need to wait for Mark's patches to work
> their way through to mainline before I can apply this however.
> 
> Please give me a poke when that has happened if it looks like I have
> forgotten it.
> 

Yeah can do.

Thanks,
Charles
