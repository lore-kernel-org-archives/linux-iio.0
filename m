Return-Path: <lars@metafoo.de>
Message-ID: <545D1EC3.30901@metafoo.de>
Date: Fri, 07 Nov 2014 20:34:27 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Joshua Lamorie <joshua.lamorie@xiphos.com>
CC: Jonathan Cameron <jic23@kernel.org>, michal.simek@xilinx.com,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, soren.brinkmann@xilinx.com,
 Fabien Proriol <Fabien.Proriol@jdsu.com>
Subject: Re: [PATCH] iio:xilinx-xadc:xadc_read_raw INFO_OFFSET
References: <1415387516-15051-1-git-send-email-joshua.lamorie@xiphos.com>
In-Reply-To: <1415387516-15051-1-git-send-email-joshua.lamorie@xiphos.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 11/07/2014 08:11 PM, Joshua Lamorie wrote:
> Added a condition for a read of IIO_CHAN_INFO_OFFSET to
> ensure that an offset is only provided for requests for XADC temperature. The
> previous assumption was that only requests for temperature would include a
> read of CHAN_INFO_OFFSET. However there is no way to restrict this in calling
> functions, such as iio_convert_raw_to_processed_unlocked() which is called when
> using the XADC as a device for iio_hwmon.

Fabien send pretty much the same patch yesterday. See 
http://thread.gmane.org/gmane.linux.kernel.iio/14579

- Lars
