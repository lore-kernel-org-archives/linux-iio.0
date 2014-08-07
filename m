Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36546 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471AbaHGKp4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 Aug 2014 06:45:56 -0400
Message-ID: <53E358E2.60302@kernel.org>
Date: Thu, 07 Aug 2014 11:45:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: accel: BMC150 accel documentation
References: <1407275825-29035-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1407275825-29035-3-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1407275825-29035-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/08/14 22:57, Srinivas Pandruvada wrote:
> Added any-motion trigger documentation.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-accel-bmc150 | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-accel-bmc150
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-accel-bmc150 b/Documentation/ABI/testing/sysfs-bus-iio-accel-bmc150
> new file mode 100644
> index 0000000..99847a9
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-accel-bmc150
> @@ -0,0 +1,7 @@
> +What:		/sys/bus/iio/devices/triggerX/name = "bmc150_accel-any-motion-devX"
> +KernelVersion:	3.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The BMC150 accelerometer kernel module provides an additional trigger,
> +		which sets driver in a mode, where data is pushed to the buffer
> +		only when there is any motion.
> 
