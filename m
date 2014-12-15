Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <548E155A.7050000@gmx.de>
References: <1417613513-28285-1-git-send-email-daniel.baluta@intel.com>
	<1417613513-28285-4-git-send-email-daniel.baluta@intel.com>
	<548E155A.7050000@gmx.de>
Date: Mon, 15 Dec 2014 18:11:50 +0200
Message-ID: <CAEnQRZA6Y9bZJ=ukBYD3dKgVisVxj5cDu7BsP1mGuz+rK7Swvw@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] iio: imu: kmx61: Add PM runtime support
From: Daniel Baluta <daniel.baluta@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: Daniel Baluta <daniel.baluta@intel.com>, Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Dec 15, 2014 at 12:55 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
> Daniel Baluta schrieb am 03.12.2014 um 14:31:
>> By default both sensors are ACTIVE, in this way the driver
>> will work even if CONFIG_PM_RUNTIME is not selected.
>>
> Since kmx61_set_power_state() can return error codes, wouldn't it be better to
> handle them (as long as you are not using it in an error handler)?
> Thanks,

That's correct I will send a patch asap.

Daniel.
