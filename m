Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51313 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbaECKjo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 May 2014 06:39:44 -0400
Message-ID: <5364C7CE.7030705@kernel.org>
Date: Sat, 03 May 2014 11:41:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: Add intensity including ir and both modifiers
 to ABI documentation ex-post
References: <1399046089-6616-1-git-send-email-pmeerw@pmeerw.net> <1399046089-6616-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1399046089-6616-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/05/14 16:54, Peter Meerwald wrote:
> intensity has been in use for a long time but never documented
> it is beneficial to document what this is supposed to be
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Oops. I think added intensity in the first place though might have been in the
tsl2563 driver rather than my tsl2561 driver from prehistory of IIO.

Thanks for your work on filling in the gaps!

Applied to the togreg branch of iio.git

J
> ---
>   Documentation/ABI/testing/sysfs-bus-iio | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index ca3d3b7..9669c1f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -895,6 +895,16 @@ Description:
>   		on-chip EEPROM. After power-up or chip reset the device will
>   		automatically load the saved configuration.
>
> +What:		/sys/.../iio:deviceX/in_intensityY_raw
> +What:		/sys/.../iio:deviceX/in_intensityY_ir_raw
> +What:		/sys/.../iio:deviceX/in_intensityY_both_raw
> +KernelVersion:	3.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Unit-less light intensity. Modifiers both and ir indicate
> +		that measurements contains visible and infrared light
> +		components or just infrared light, respectively.
> +
>   What:		/sys/.../iio:deviceX/in_intensity_red_integration_time
>   What:		/sys/.../iio:deviceX/in_intensity_green_integration_time
>   What:		/sys/.../iio:deviceX/in_intensity_blue_integration_time
>

