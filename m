Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <53BD9BD5.5030204@linux.intel.com>
Date: Wed, 09 Jul 2014 12:45:25 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Reyad Attiyat <reyad.attiyat@gmail.com>
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 jic23@kernel.org
Subject: Re: [PATCH v5 0/4] iio: Add support for rotation from north
References: <1404934213-2733-1-git-send-email-reyad.attiyat@gmail.com>
In-Reply-To: <1404934213-2733-1-git-send-email-reyad.attiyat@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 07/09/2014 12:30 PM, Reyad Attiyat wrote:
> This series of patches modifies magn-3d driver to handle the rotation
> from north usage. This is done by scanning the report and then building
> the iio arrays (vals and channels) dynamically.
>
> Changes from V4
> I use the address field of struct iio_chan_spec to hold the array index
> of the usage attribute. The scan_index field is generated when creating
> an iio channel.
>
> Reyad Attiyat (4):
>    iio: Documentation: Add documentation for rotation from north sensor
>      usage attributes
>    iio: types: Added support for rotation from north usage attributes
>    iio: hid-sensor-magn-3d: Scan for usage attributes before setting up
>      iio channels
>    iio: hid-sensor-magn-3d: Add support for rotation from north
>
>   Documentation/ABI/testing/sysfs-bus-iio       |  82 +++++++++++
>   drivers/iio/industrialio-core.c               |   4 +
>   drivers/iio/magnetometer/hid-sensor-magn-3d.c | 199 ++++++++++++++++++++------
>   include/linux/iio/types.h                     |   4 +
>   4 files changed, 245 insertions(+), 44 deletions(-)
>
Did you get chance to look at the cause of panic?

Thanks,
Srinivas
