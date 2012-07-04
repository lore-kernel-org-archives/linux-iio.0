Return-Path: <sha@pengutronix.de>
Date: Wed, 4 Jul 2012 08:27:23 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Zhang, Sonic" <Sonic.Zhang@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 3/3] staging iio adt7410: make 16bit mode default
Message-ID: <20120704062723.GB2698@pengutronix.de>
References: <1341307288-1926-1-git-send-email-s.hauer@pengutronix.de>
 <1341307288-1926-4-git-send-email-s.hauer@pengutronix.de>
 <DB904C5425BA6F4E8424B3B51A1414D17140805E78@NWD2CMBX1.ad.analog.com>
 <4FF353C7.8040804@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FF353C7.8040804@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jul 03, 2012 at 09:19:19PM +0100, Jonathan Cameron wrote:
> On 07/03/2012 11:42 AM, Zhang, Sonic wrote:
> > Acked-by: Sonic Zhang <sonic.zhang@analog.com>
> > 
> >> -----Original Message-----
> >> From: Sascha Hauer [mailto:s.hauer@pengutronix.de]
> >> Sent: Tuesday, July 03, 2012 5:21 PM
> >> To: linux-iio@vger.kernel.org
> >> Cc: Jonathan Cameron; Zhang, Sonic; Sascha Hauer
> >> Subject: [PATCH 3/3] staging iio adt7410: make 16bit mode default
> >>
> >> In 13bit mode the lower three bits of the adc value contain
> >> flags. The driver does not use these flags at all, so make 16bit
> >> mode the default.
> >>
> >> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> merged (for next version rather than fixes as whilst a reasonable
> change, it's not a fix).
> 
> Anyhow, please do note that the intent is to move this driver out
> to hwmon. It's a long way from abi compliant for iio. I just mention
> this to avoid you wasting time pulling it nearer to the abi (if
> you were thinking of doing so of course!)

Ok, good to know, thanks. I already wondered why this driver is in iio
instead of hwmon. Right now I have no further plans for this driver.
Would you recommend me to convert it to hwmon first should I have to
revisit this driver?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
