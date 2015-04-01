Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <cover.1427856701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1427856701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Date: Wed, 1 Apr 2015 16:02:33 +0300
Message-ID: <CAEnQRZCqHhd054N_5iq4qJHqQfgj4fwvADyFSh218AxCZsXxkA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Added LTR501 Interrupt support
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Apr 1, 2015 at 5:55 AM, Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> This patchset adds interrupt support for LTR501 chip. Also
> added acpi enumaration support.
>
> Please let me know your review comments.
>
> v1:
> 1. Added support to enable ALS & PS intterupts based
>    on threshold settings.
> 2. Added support to control intrrupt rate.
> 3. Added acpi enumeration support.
>
> Kuppuswamy Sathyanarayanan (3):
>   iio: ltr501: Add interrupt support
>   iio: ltr501: Add interrupt rate control support
>   iio: ltr501: Add ACPI enumeration support
>
>  drivers/iio/light/ltr501.c | 395 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 392 insertions(+), 3 deletions(-)

Nice :). Keep in mind that there are some pending patches for ltr501
and your code
might not apply.

I think at least this patch must be applied.

http://marc.info/?l=linux-iio&m=142779829617041&w=2

thanks,
Daniel.
