Return-Path: <khali@linux-fr.org>
Date: Thu, 9 Jun 2011 10:29:48 +0200
From: Jean Delvare <khali@linux-fr.org>
To: anish singh <anish198519851985@gmail.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Ben Dooks <ben-i2c@fluff.org>,
 gregkh@suse.de, manuel.stahl@iis.fraunhofer.de,
 lucas.demarchi@profusion.mobi, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Linux I2C
 <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH] staging iio: Replace kmalloc with local variable
Message-ID: <20110609102948.7a3f8d57@endymion.delvare>
In-Reply-To: <BANLkTi=e0A2G-d+t4VF5V0gj+eNoh3KRnQ@mail.gmail.com>
References: <1307450354.1516.23.camel@anish-desktop>
	<4DEE20E7.4020008@cam.ac.uk>
	<20110607134135.GD15795@trinity.fluff.org>
	<20110607160206.6cb3168d@endymion.delvare>
	<BANLkTim5-ZKXtDkSQyHAJ9-iKtOPsJ917A@mail.gmail.com>
	<BANLkTi=e0A2G-d+t4VF5V0gj+eNoh3KRnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Thu, 9 Jun 2011 13:53:09 +0530, anish singh wrote:
> On Wed, Jun 8, 2011 at 10:41 AM, anish singh <anish198519851985@gmail.com>wrote:
> >  On Tue, Jun 7, 2011 at 7:32 PM, Jean Delvare <khali@linux-fr.org> wrote:
> >> To be clearer, it is down to the i2c BUS (adapter) driver, NOT the i2c
> >> device driver. So the patch is correct.
> >>
> > I think i can take Jean ack on this?If yes then Joanthan kindly apply
> > this patch and i think you didn't lead me in wrong way as whatever
> > said by you is corroborated by jean also i.e. it is I2C bus driver
> > responsiblity
> > to care about DMA.
> >
> Sorry to ping you again.Can i take your ack on this?

Yes of course.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare
