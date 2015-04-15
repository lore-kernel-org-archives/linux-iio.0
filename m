Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <1429048402-5311-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1429048402-5311-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Date: Wed, 15 Apr 2015 15:01:50 +0300
Message-ID: <CAEnQRZAxAWnQ_sGestwJ+NsHxCN=DqUHAjVhZpM04pWj3eQNgw@mail.gmail.com>
Subject: Re: [PATCH] iio: light: hid-sensor-prox: Fix modifier
From: Daniel Baluta <daniel.baluta@intel.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Apr 15, 2015 at 12:53 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> Currently in_proximity_(null)_raw is getting presented as raw sysfs
> attribute. Same with the scan_elements.
> The modifier doesn't apply to this channel.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---

Would be also nice to add a line like this:

Fixes COMMIT_ID ("Commit subject")

in order for stable teams to pick this up.

thanks,
Daniel.
