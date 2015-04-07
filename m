Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <01dd6c5e1f73bc2b1a170d750e7e81ca92171ce6.1427945689.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1427945689.git.sathyanarayanan.kuppuswamy@linux.intel.com>
	<01dd6c5e1f73bc2b1a170d750e7e81ca92171ce6.1427945689.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Date: Tue, 7 Apr 2015 13:36:31 +0300
Message-ID: <CAEnQRZCbbiS=-0SJKBuT5BOtjRAsDuYSyUeOL=tj=xNg=ECxkA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] iio: ltr501: Add interrupt rate control support
From: Daniel Baluta <daniel.baluta@intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Apr 2, 2015 at 6:51 AM, Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> Added rate control support for ALS and proximity
> threshold interrupts.
>
> Setting <n> to ALS intr_persist sysfs node would
> generate interrupt whenever ALS data cross either
> upper or lower threshold limits <n> number of times.
> Similarly setting <m> to proximity intr_persist sysfs
> node would genere interrupt whenever proximity data falls
> outside threshold limit <m> number of times.


Hi Sathya,

We might have a problem here because _period attribute should
be in seconds.

See:

http://lxr.free-electrons.com/source/Documentation/ABI/testing/sysfs-bus-iio#L785

thanks,
Daniel.
