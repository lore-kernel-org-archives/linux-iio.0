Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45240 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbbA2Snn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 29 Jan 2015 13:43:43 -0500
Message-ID: <54CA7F5D.6050700@kernel.org>
Date: Thu, 29 Jan 2015 18:43:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org
CC: linux-kernel@vger.kernel.org,
	Daniel Baluta <daniel.baluta@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 2/3] iio: Documentation: Fix calibheight unit
References: <1422384114-23392-1-git-send-email-irina.tirdea@intel.com> <1422384114-23392-3-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1422384114-23392-3-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/01/15 18:41, Irina Tirdea wrote:
> Change calibheight unit from centimeters to meters
> to follow iio guidelines of using SI units.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Applied to the togreg branch of iio.git.

Thanks,
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index b4ea9c5..588620e 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -347,7 +347,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_steps_calibheight
>  KernelVersion:	3.19
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> -		Height of the user (in centimeters) used by some pedometers
> +		Height of the user (in meters) used by some pedometers
>  		to compute the stride length, distance, speed and activity
>  		type.
>  
> 

