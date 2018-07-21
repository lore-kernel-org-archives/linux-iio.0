Return-Path: <SRS0=iPyx=KF=perches.com=joe@kernel.org>
Message-ID: <070dda6dd3b140ef5f6dbc965d7f8c1af934ec96.camel@perches.com>
Subject: Re: [PATCH 1/4] iio: adc: xilinx: Rename 'channels' variable name
 to 'iio_xadc_channels'
From: Joe Perches <joe@perches.com>
To: Jonathan Cameron <jic23@kernel.org>, Michal Simek
 <michal.simek@xilinx.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Manish Narani
	 <manish.narani@xilinx.com>, knaack.h@gmx.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, anirudh@xilinx.com, sgoud@xilinx.com
Date: Sat, 21 Jul 2018 09:22:05 -0700
In-Reply-To: <20180721171828.55395acc@archlinux>
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
	 <1531912331-26431-2-git-send-email-manish.narani@xilinx.com>
	 <d2c3ddfd-91da-e500-7b58-917d2da1d540@metafoo.de>
	 <7c4ee0db-ac33-b093-4dbb-1742fb029012@xilinx.com>
	 <20180721171828.55395acc@archlinux>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Sat, 2018-07-21 at 17:18 +0100, Jonathan Cameron wrote:
> On Thu, 19 Jul 2018 10:22:07 +0200
> Michal Simek <michal.simek@xilinx.com> wrote:
> 
> > On 18.7.2018 13:18, Lars-Peter Clausen wrote:
> > > On 07/18/2018 01:12 PM, Manish Narani wrote:  
> > > > This patch fix the following checkpatch warning in xadc driver.
> > > > - Reusing the krealloc arg is almost always a bug.
> > > > 
> > > > Renamed the 'channels' variable as 'iio_xadc_channels' to fix the above
> > > > warning.
> > > >  
> > > 
> > > This is a bug in checkpatch and should be fixed in checkpatch. The code is
> > > not actually re-using the parameter. channels and xadc_channels are
> > > independent variables, just checkpatch somehow does not realize this.  
> > 
> > I think it should be fine to have this patch in tree. Change in commit
> > message to reflect this should be enough. But that's just view.
> 
> Let's wait and see if Joe has time to take a look at this.  Might be better
> to fix checkpatch if it's not too hard!

I submitted a proposed patch.
I believe it works.

https://patchwork.kernel.org/patch/10533011/
