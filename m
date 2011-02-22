Return-Path: <khali@linux-fr.org>
Date: Tue, 22 Feb 2011 10:29:55 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Andrew Chew <AChew@nvidia.com>, chinyeow.sim.xt@renesas.com,
 gregkh@suse.de, devel@driverdev.osuosl.org, linux-iio@vger.kernel.org
Subject: Re: [RFC PATCH] staging: ak8975: add platform data.
Message-ID: <20110222102955.52be2b94@endymion.delvare>
In-Reply-To: <4D628E66.5090900@cam.ac.uk>
References: <1297764627-21077-1-git-send-email-chinyeow.sim.xt@renesas.com>
	<643E69AA4436674C8F39DCC2C05F763816BD96CFB5@HQMAIL03.nvidia.com>
	<4D628E66.5090900@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

On Mon, 21 Feb 2011 16:10:14 +0000, Jonathan Cameron wrote:
> On 02/15/11 20:49, Andrew Chew wrote:
> >> As some of the platform not support irq_to_gpio, we pass gpio port
> >> by platform data.
> > 
> > Looks good to me.
> > 
> > Signed-off-by: Andrew Chew <achew@nvidia.com>
> Firstly, please cc linux-iio for patches effecting iio drivers.
> 
> Hmm.. It's a bit of a pain that i2c devices don't take platform resources
> or we could avoid doing this entirely. I have a vague recollection of this
> being suggested in the past, but never happening (might have been for spi
> rather than i2c though...) Jean, can you comment on this?

I fear I don't have the slightest idea of what you're talking about.
"Taking platform resources"?

> Dmitry isn't going to want that header in the linux/input directory.

And he would be right. Header files containing platform data structures
for i2c device drivers go to include/linux/i2c.

-- 
Jean Delvare
