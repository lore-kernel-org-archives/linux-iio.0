Return-Path: <lars@metafoo.de>
Message-ID: <5511583C.4080501@metafoo.de>
Date: Tue, 24 Mar 2015 13:27:40 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>, jic23@kernel.org
CC: pmeerw@pmeerw.net, knaack.h@gmx.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 0/3] iio: add support for hardware fifo
References: <1427049220-2876-1-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1427049220-2876-1-git-send-email-octavian.purdila@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 03/22/2015 07:33 PM, Octavian Purdila wrote:
> Changes since v5:
>
>   * remove hwfifo_get_watermark operation from iio_info operations; the
>     driver can expose it dirrectly as a read-only buffer attribute and
>     there is not much gain from do it in the core
>
>   * in the case of non-blocking read flush with the full to read amount
>
>   * fix a few spelling errors
>
>   * add hwfifo_watermark_min, hwfifo_watermark_max,
>     hwfifo_watermark_available, hwfifo_enabled attributes to give
>     userspace more information of how to select a watermark that can
>     used to enable the hardware fifo
>
>   * rename hwfifo_flush to hwfifo_flush_to_buffer
>
>   * bmc150: avoid changing the iio_info to keep it constant
>
>   * bmc150: rename irq and threaded irq handlers
>

Looks pretty good to me now, thanks for doing this patch series. I'll try to 
give it some testing. If you don't hear anything else from me, that's a

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
