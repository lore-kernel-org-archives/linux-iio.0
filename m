Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <1429199662.24805.40.camel@spandruv-DESK3.jf.intel.com>
Subject: Re: [PATCH] iio: light: hid-sensor-prox: Fix modifier
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen
	 <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org"
	 <linux-iio@vger.kernel.org>
Date: Thu, 16 Apr 2015 08:54:22 -0700
In-Reply-To: <CAEnQRZAxAWnQ_sGestwJ+NsHxCN=DqUHAjVhZpM04pWj3eQNgw@mail.gmail.com>
References: 
	<1429048402-5311-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <CAEnQRZAxAWnQ_sGestwJ+NsHxCN=DqUHAjVhZpM04pWj3eQNgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Wed, 2015-04-15 at 15:01 +0300, Daniel Baluta wrote: 
> On Wed, Apr 15, 2015 at 12:53 AM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > Currently in_proximity_(null)_raw is getting presented as raw sysfs
> > attribute. Same with the scan_elements.
> > The modifier doesn't apply to this channel.
> >
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > ---
> 
> Would be also nice to add a line like this:
> 
> Fixes COMMIT_ID ("Commit subject")
> 
> in order for stable teams to pick this up.
We can add tag
Cc: stable@vger.kernel.org

Usually Jonathan copies after his merge.

Thanks,
Srinivas

> 
> thanks,
> Daniel.
