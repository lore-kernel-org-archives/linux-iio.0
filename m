Return-Path: <bgat@billgatliff.com>
MIME-Version: 1.0
In-Reply-To: <20110223091939.3ba0b190@endymion.delvare>
References: <1297764627-21077-1-git-send-email-chinyeow.sim.xt@renesas.com>
	<643E69AA4436674C8F39DCC2C05F763816BD96CFB5@HQMAIL03.nvidia.com>
	<4D628E66.5090900@cam.ac.uk>
	<20110222102955.52be2b94@endymion.delvare>
	<4D63AD81.5080903@cam.ac.uk>
	<20110222215552.GA28740@sirena.org.uk>
	<20110223091939.3ba0b190@endymion.delvare>
Date: Wed, 23 Feb 2011 09:41:42 -0600
Message-ID: <AANLkTintdZHzK=VGPevzW=M2sTN62tVEi1a5mxF89wJW@mail.gmail.com>
Subject: Re: [RFC PATCH] staging: ak8975: add platform data.
From: Bill Gatliff <bgat@billgatliff.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Jonathan Cameron <jic23@cam.ac.uk>,
	Andrew Chew <AChew@nvidia.com>, chinyeow.sim.xt@renesas.com, gregkh@suse.de,
	devel@driverdev.osuosl.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Guys:


On Wed, Feb 23, 2011 at 2:19 AM, Jean Delvare <khali@linux-fr.org> wrote:
> On Tue, 22 Feb 2011 21:55:55 +0000, Mark Brown wrote:
>> There's no standard support for GPIOs as resources - this is always done
>> using platform data these days.
>
> Would it make sense to add this? I have no opinion on the question, not
> being a big user of GPIO, just wondering.


I for one would welcome an IORESOURCE_GPIO.

b.g.
-- 
Bill Gatliff
bgat@billgatliff.com
