Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <5384B099.2070808@linux.intel.com>
Date: Tue, 27 May 2014 08:34:49 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Reyad Attiyat <reyad.attiyat@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 jic23@kernel.org
Subject: Re: [PATCH] IIO: Support for True/Magnetic north
References: <538076CA.6050809@kernel.org> <1401160821-5006-1-git-send-email-reyad.attiyat@gmail.com>
In-Reply-To: <1401160821-5006-1-git-send-email-reyad.attiyat@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi Reyad,

On 05/26/2014 08:20 PM, Reyad Attiyat wrote:
> Hey Jonathan and Srinivas,
>
> I have added in the needed magn_north iio sysfs attributes to the documentation.
> I hope I did everything correct.
> I noticed that the line length was very long as compensated is a  fairly long word.
> I'm thinking I could shorten some of the sysfs paths or shorten the name.
>
> For updating the hid-sensor-magn-3d do you have any tips on this? I'm thinking I'll need a
> dynamic iio_chan array that is passed to iio_register function. It would need to
> be dynamic in the sense it would only add channels if it found x, y, z, or one of
> the north attributes. I'll start working on this soon.

I think you mean dynamic " iio_chan_spec magn_3d_channels[]". Currently 
this is a
constant. So we can change this to add only channel, which are available.

Also your other changes must be submitted as series of patches, 
including the drivers using them.

Thanks,
Srinivas

> Thank You,
> Reyad Attiyat
>
>
>
> Reyad Attiyat (1):
>    IIO: Added iio magn_north ABI documentation
>
>   Documentation/ABI/testing/sysfs-bus-iio | 76 +++++++++++++++++++++++++++++++++
>   1 file changed, 76 insertions(+)
>
