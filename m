Return-Path: <Thomas.Betker@rohde-schwarz.com>
In-Reply-To: <552F54A0.7010902@metafoo.de>
References: <1429125111-2926-1-git-send-email-thomas.betker@freenet.de> <552ECFF8.2070501@kernel.org> <552F54A0.7010902@metafoo.de>
To: lars@metafoo.de
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>, =?ISO-8859-1?Q?S=F6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
MIME-Version: 1.0
Subject: Re: [Patch 0/5] iio: adc: xilinx: Fix some minor issues
From: Thomas.Betker@rohde-schwarz.com
Message-ID: <OF92248924.230ACBC9-ONC1257E29.002B52C1-C1257E29.002C42CA@rohde-schwarz.com>
Date: Thu, 16 Apr 2015 10:03:23 +0200
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

Hello Lars-Peter:

> >>      Note that .extend_name = "vccint", "vccaux", ... also has the 
side
> >> effect of creating the sysfs nodes vccint_sampling_frequency,
> >> vccaux_sampling_frequency, ... [due to .info_mask_shared_by_all =
> >> BIT(IIO_CHAN_INFO_SAMP_FREQ)], which is probably not desired.
> > This last one sounds like a bug and definitely isn't the intended 
result!
> > The extended name should be ignored for shared_by values.
> 
> It was fixed a while ago, see 
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/
> commit/?id=77bfa8baa0c230eb3d8acccd7d341f406a32cdf4

You're right; my fault. I am using 3.14 (longterm), which doesn't contain 
this fix. And although I did read the mainline code for reference, I 
didn't check for this particular fix. Sorry.

Best regards,
Thomas Betker
