Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <6c06e64f0cf6c5314b987490775cf9d85af1eda5.1427947743.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1427947743.git.sathyanarayanan.kuppuswamy@linux.intel.com>
	<6c06e64f0cf6c5314b987490775cf9d85af1eda5.1427947743.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Date: Thu, 2 Apr 2015 09:48:27 +0300
Message-ID: <CAEnQRZDAX=j8yDo7pbsVHkwSoBVKMO2d2gao_X1=9Jv5Z1wj1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] iio: ltr301: Add support for ltr301
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Apr 2, 2015 at 7:10 AM, Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> Added support for Liteon 301 Ambient light sensor. Since
> LTR301 and LTR501 are register compatible(and even have same
> part id), LTR501 driver has been extended to support both
> devices. LTR501 is similar to LTR301 in ALS sensing, But the
> only difference is, LTR501 also supports proximity sensing.
>
> LTR501 - ALS + Proximity combo
> LTR301 - ALS sensor.

I assume that you did not find the datasheet on LiteOn's website :D. Could you
send me your private copy?

I will try to rebase your LTR301 patch on my patches LTR559 [1].

thanks,
Daniel.

[1] http://article.gmane.org/gmane.linux.kernel.iio/16732
