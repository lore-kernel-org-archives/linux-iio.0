Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <552A9A85.6030108@kernel.org>
References: <cover.1428713872.git.sathyanarayanan.kuppuswamy@linux.intel.com>
	<c0bfd1b4f763e166eec1b6a1d8585cd0fca37de5.1428713872.git.sathyanarayanan.kuppuswamy@linux.intel.com>
	<552A9A85.6030108@kernel.org>
Date: Tue, 14 Apr 2015 15:07:42 +0300
Message-ID: <CAEnQRZDi1ycZerm-9i3PLK+obxG1syA1KqLygx5ivf7v8CJzwQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] iio: ltr501: Add support for ltr301
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>, Daniel Baluta <daniel.baluta@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Apr 12, 2015 at 7:17 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 11/04/15 01:59, Kuppuswamy Sathyanarayanan wrote:
>> Added support for Liteon 301 Ambient light sensor. Since
>> LTR-301 and LTR-501 are register compatible(and even have same
>> part id), LTR-501 driver has been extended to support both
>> devices. LTR-501 is similar to LTR-301 in ALS sensing, But the
>> only difference is, LTR-501 also supports proximity sensing.
>>
>> LTR-501 - ALS + Proximity combo
>> LTR-301 - ALS sensor.
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Looks good to me.  Will either pick this up with Daniel's final series
> (trivial bits outstanding there) or separately if he doesn't pick it up.
> After his has gone in obviously!
>
> Should I miss it by accident (it's been known to happen, particularly if
> a large delay happens for some reason :( then feel free to poke me!
>
> Jonathan

I will pick this up and resend together with patches for LTR559.

thanks,
Daniel.
