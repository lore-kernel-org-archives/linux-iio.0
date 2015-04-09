Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <552650FB.6000107@kernel.org>
References: <cover.1428372691.git.sathyanarayanan.kuppuswamy@linux.intel.com>
	<f944512157939827cd6f06b29bb3d1181692e9c1.1428372691.git.sathyanarayanan.kuppuswamy@linux.intel.com>
	<552650FB.6000107@kernel.org>
Date: Thu, 9 Apr 2015 15:20:25 +0300
Message-ID: <CAEnQRZDje3kaJE+LHPi0NnGDFY3oRuY2Ewrvj4NCzwzypdyS+w@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] iio: ltr301: Add support for ltr301
From: Daniel Baluta <daniel.baluta@intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Apr 9, 2015 at 1:14 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 07/04/15 03:16, Kuppuswamy Sathyanarayanan wrote:
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
> Patch naming convention
> iio:<name of driver>: Add support for ltr301
> so here would be
> iio:ltr501:Add support for ltr301.
>
> Otherwise, looks good to me.  A comment inline that it might
> make sense to introduced a ltr501_chip info structure and use
> static const struct ltr501_chip_info[2] = {
> [LTR301] = {
>        .info = ...
>        ....
>        },
> [LTR501] = {
> }};
>
> That way you make all the truely constant data apparently constant
> and loose the switch statement. It makes for an easier to review / simpler
> driver in the long run.
>
> I haven't checked but this is probably what Daniel was suggesting in
> his review for v1 of this patch.

Hi Sathya,

I think the best approach to get this merged in would be for you
to rebase your ltr301 patches on my patches for ltr559.

http://marc.info/?l=linux-kernel&m=142779827617036&w=2

Let me know if you have any questions.

Daniel.
