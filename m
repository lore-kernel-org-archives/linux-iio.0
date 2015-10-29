Return-Path: <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/4] i2c: added I2C_AQ_NO_CLK_STRETCH to i2c-bcm2835.c
To: Nicola Corna <nicola@corna.info>, Eric Anholt <eric@anholt.net>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1445976718-7449-3-git-send-email-nicola@corna.info>
Cc: Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 linux-iio@vger.kernel.org
From: Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <56319C4D.9020807@wwwdotorg.org>
Date: Wed, 28 Oct 2015 22:10:53 -0600
MIME-Version: 1.0
In-Reply-To: <1445976718-7449-3-git-send-email-nicola@corna.info>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 10/27/2015 02:11 PM, Nicola Corna wrote:
> As reported here
> http://www.advamation.com/knowhow/raspberrypi/rpi-i2c-bug.html
> the BCM2835 has a bug in its i2c implementation which prevents a correct
> clock stretching.

I was going to ask for some more official confirmation of this bug (e.g.
update to BCM2835_Peripherals.pdf), but it looks like it's already been
confirmed; check Gert van Loo's responses at:

https://www.raspberrypi.org/forums/viewtopic.php?p=146272

It might be useful to add this link into the patch description.
