Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44991 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932075AbdBKJui (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Feb 2017 04:50:38 -0500
Subject: Re: [PATCH 6/7] iio: Documentation: add ABI documentation for
 in_proximity_sampling_frequency_available
To: Brian Masney <masneyb@onstation.org>
References: <20170209015431.17380-1-masneyb@onstation.org>
 <20170209015431.17380-7-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <46e0bf9a-1090-592b-33c2-8c5b5686b2ee@kernel.org>
Date: Sat, 11 Feb 2017 09:50:36 +0000
MIME-Version: 1.0
In-Reply-To: <20170209015431.17380-7-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/02/17 01:54, Brian Masney wrote:
> Add entry for the in_proximity_sampling_frequency_available sysfs
> entry to the existing sampling_frequency_available ABI documentation.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 530809c..1ce4603 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -55,6 +55,7 @@ Description:
>  		then it is to be found in the base device directory.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency_available
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity_sampling_frequency_available
>  What:		/sys/.../iio:deviceX/buffer/sampling_frequency_available
>  What:		/sys/bus/iio/devices/triggerX/sampling_frequency_available
>  KernelVersion:	2.6.35
> 

