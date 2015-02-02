Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <54CDFBE8.7060609@kernel.org>
References: <1420449702-2085-1-git-send-email-daniel.baluta@intel.com>
	<54AB179F.8020206@gmx.de>
	<54CDFBE8.7060609@kernel.org>
Date: Mon, 2 Feb 2015 13:23:55 +0200
Message-ID: <CAEnQRZCxqk3hKCq2fWeKVyEs_GRjWYtPzPHJLuAU6hr0hMOy7Q@mail.gmail.com>
Subject: Re: [PATCH v2] iio: imu: kmx61: Drop odr_bits from kmx61_samp_freq_table
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Daniel Baluta <daniel.baluta@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Feb 1, 2015 at 12:11 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 05/01/15 23:00, Hartmut Knaack wrote:
>> Daniel Baluta schrieb am 05.01.2015 um 10:21:
>>> odr_bits values are between 0 and 11, so we can use the index
>>> in kmx61_samp_freq_table instead of odr_bits structure member.
>>>
>>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
>> Reviewed-by: Hartmut Knaack <knaack.h@gmx.de>
> Applied to the togreg branch of iio.git - pushed out as testing.
>
> Sorry, I marked this to apply when there was a messup over my
> first pull request then failed to actually pick it up once that
> got resolved.  Now unfortunately 3.21 material.
>
> Ah well, not a critical change anyway, more of a cleanup ;)

Thanks!
