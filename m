Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49898 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbaJYTQC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 25 Oct 2014 15:16:02 -0400
Message-ID: <544B71ED.8000301@kernel.org>
Date: Sat, 25 Oct 2014 10:48:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	opw-kernel@googlegroups.com
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Add ABI documentation for RGBC intensity hardware
 gain factor
References: <1414186915-4035-1-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1414186915-4035-1-git-send-email-roberta.dobrescu@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/10/14 22:41, Roberta Dobrescu wrote:
> This patch adds documentation for RGBC in_intensity_*_hardwaregain.
> There is at least one user for these, ADJD-S311-CR999 digital color sensor
> driver.
> 
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
Applied to the togreg branch of iio.git - initially pushed out as
staging.

Thanks,

Jonathan
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index ffcadca..661a672 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -330,6 +330,10 @@ Description:
>  		are listed in this attribute.
>  
>  What		/sys/bus/iio/devices/iio:deviceX/out_voltageY_hardwaregain
> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_red_hardwaregain
> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_green_hardwaregain
> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_hardwaregain
> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_clear_hardwaregain
>  KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> 
