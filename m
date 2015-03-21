Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59368 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbbCUMAD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2015 08:00:03 -0400
Message-ID: <550D5D41.7070606@kernel.org>
Date: Sat, 21 Mar 2015 12:00:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Haneen Mohammed <hamohammed.sa@gmail.com>,
	outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org,
	daniel.baluta@intel.com, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: Add ABI documentation for out_voltage scan_elements
References: <1426588609-24683-1-git-send-email-hamohammed.sa@gmail.com>
In-Reply-To: <1426588609-24683-1-git-send-email-hamohammed.sa@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/03/15 10:36, Haneen Mohammed wrote:
> This patch adds ABI documentation entries for out_voltageY_en,
> out_voltageY_type, and out_voltageY_index.
> At least one user for these is preset:
> AD8366 SPI Dual-Digital VGA.
> 
> Signed-off-by: Haneen Mohammed <hamohammed.sa@gmail.com>
These aren't used in the mainline driver.  We don't have buffered support
for output channels yet.  Looking at Analog's tree I don't think they have
support for this driver doing buffered output either (I think they may have
some internal support or maybe it's just a plan on how to do it!)
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index fd026d9..bbb0bfd 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -994,6 +994,7 @@ What:		/sys/.../iio:deviceX/scan_elements/in_timestamp_en
>  What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_supply_en
>  What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_en
>  What:		/sys/.../iio:deviceX/scan_elements/in_voltageY-voltageZ_en
> +What:		/sys/.../iio:deviceX/scan_elements/out_voltageY_en
>  What:		/sys/.../iio:deviceX/scan_elements/in_incli_x_en
>  What:		/sys/.../iio:deviceX/scan_elements/in_incli_y_en
>  What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_en
> @@ -1011,6 +1012,7 @@ What:		/sys/.../iio:deviceX/scan_elements/in_magn_type
>  What:		/sys/.../iio:deviceX/scan_elements/in_incli_type
>  What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_type
>  What:		/sys/.../iio:deviceX/scan_elements/in_voltage_type
> +What:		/sys/.../iio:deviceX/scan_elements/out_voltageY_type
>  What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_supply_type
>  What:		/sys/.../iio:deviceX/scan_elements/in_timestamp_type
>  What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_type
> @@ -1049,6 +1051,7 @@ Description:
>  
>  What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_index
>  What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_supply_index
> +What:		/sys/.../iio:deviceX/scan_elements/out_voltageY_index
>  What:		/sys/.../iio:deviceX/scan_elements/in_accel_x_index
>  What:		/sys/.../iio:deviceX/scan_elements/in_accel_y_index
>  What:		/sys/.../iio:deviceX/scan_elements/in_accel_z_index
> 

