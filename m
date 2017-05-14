Return-Path: <SRS0=Dqta=4U=onstation.org=masneyb@kernel.org>
Date: Sun, 14 May 2017 16:08:34 -0400
From: Brian Masney <masneyb@onstation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
	jbrenner@taosinc.com
Subject: Re: [PATCH] iio: tsl2583: add runtime power management support
Message-ID: <20170514200834.GA10274@607924cbbc93>
References: <20170425080633.27464-1-masneyb@onstation.org>
 <59c35132-3c37-518e-cd57-2cde8584d60b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <59c35132-3c37-518e-cd57-2cde8584d60b@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Apr 26, 2017 at 06:16:34AM +0100, Jonathan Cameron wrote:
> On 25/04/17 09:06, Brian Masney wrote:
> > This patch adds runtime power management support to the tsl2583 driver.
> > The device is powered off after two seconds of inactivity. Verified that
> > the driver still functions correctly using a TSL2581 hooked up to a
> > Raspberry Pi 2.
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> Looks fine to me. Not being a particular expert in the runtime pm code
> I'd like to let it sit on the list for a little while in the hope of
> a bit of confirmation from those more knowledgeable about this than me.
> 
> Give me a poke if I haven't picked it up in the next week or two.

Hi Jonathan,

This is a friendly reminder to pick up this patch the next time that you
work on your queue.

Thanks,

Brian
