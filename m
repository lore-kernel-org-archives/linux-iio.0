Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <548E1279.8050907@gmx.de>
References: <1417613513-28285-1-git-send-email-daniel.baluta@intel.com>
	<1417613513-28285-2-git-send-email-daniel.baluta@intel.com>
	<548E1279.8050907@gmx.de>
Date: Mon, 15 Dec 2014 12:50:43 +0200
Message-ID: <CAEnQRZDcTAvf-98=BzZscqMhdhwychOzkEyejh4W_1A_9UBxNQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] iio: imu: Add support for Kionix KMX61 sensor
From: Daniel Baluta <daniel.baluta@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: Daniel Baluta <daniel.baluta@intel.com>, Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Dec 15, 2014 at 12:43 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
> Daniel Baluta schrieb am 03.12.2014 um 14:31:
>> Minimal implementation for KMX61 6-axis accelerometer/magnetometer. It exports
>> raw accel/magn readings together with scale and sampling frequency.
>>
>> This driver uses two IIO devices one for accelerometer and one for magnetometer.
>>
> Hi Daniel,
> I think you dropped slightly too much code. In kmx61_set_odr() you stored the set
> odr bits in data->odr_bits previously, but now it's gone. But kmx61_get_odr()
> accesses data->odr_bits, which now remains in the state from driver initialization.
> Other than that, it's looking good.

Hi Hartmut,

Good catch. I will send a patch asap.
Thanks for feedback!

Daniel.
