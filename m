Return-Path: <jacob.jun.pan@linux.intel.com>
Date: Mon, 6 Apr 2015 11:39:50 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: IIO <linux-iio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lee Jones <lee.jones@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Hartmut Knaack <knaack.h@gmx.de>, Aaron Lu <aaron.lu@intel.com>, Todd
 Brandt <todd.e.brandt@linux.intel.com>
Subject: Re: [PATCH] iio/axp288_adc: add missing channel info mask
Message-ID: <20150406113950.3ebfa694@icelake>
In-Reply-To: <550D5EE7.20208@kernel.org>
References: <1426527265-14979-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<550D5EE7.20208@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Sat, 21 Mar 2015 12:07:03 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> > -		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED)
> > +		| BIT(IIO_CHAN_INFO_RAW),
> >  	},  
> These cases strike me as problematic.  You should not need both.  If
> the consumer is reading _raw from a channel that only supplies
> PROCESSED then that is the bug, not the lack of support for a raw
> read.
> >  };
Very sorry about the delay, you are right that we should just need RAW.
V2 patch just sent.

Thanks,

Jacob
