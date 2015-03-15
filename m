Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60530 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbbCOLu5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Mar 2015 07:50:57 -0400
Message-ID: <5505721F.4020800@kernel.org>
Date: Sun, 15 Mar 2015 11:50:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Haneen Mohammed <hamohammed.sa@gmail.com>,
	outreachy-kernel@googlegroups.com
CC: linux-iio@vger.kernel.org, daniel.baluta@intel.com
Subject: Re: [PATCH] iio : Add ABI documentation for thresh falling/rising
 value in accel
References: <20150312182600.GA23579@haneen-vb>
In-Reply-To: <20150312182600.GA23579@haneen-vb>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/03/15 18:26, Haneen Mohammed wrote:
> This patch adds ABI documentation entries for
> in_accel_thresh_falling_value, and in_accel_thresh_rising_value in /events.
> There is at least one user for these, lis3l02dq in accel.
> 
> Signed-off-by: Haneen Mohammed <hamohammed.sa@gmail.com>
hmm.. Your patch is fine, but I'm not sure we ever actually have
the _raw_thresh forms found throughout the ABI doc.
Looks like a hang over from a long time back.

Anyhow, for now applied your patch to the togreg branch of iio.git.

Jonathan
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 9a70c31..9a1a5fc 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -612,6 +612,8 @@ Description:
>  		a given event type is enabled a future point (and not those for
>  		whatever event was previously enabled).
>  
> +What:		/sys/.../events/in_accel_thresh_rising_value
> +What:		/sys/.../events/in_accel_thresh_falling_value
>  What:		/sys/.../events/in_accel_x_raw_thresh_rising_value
>  What:		/sys/.../events/in_accel_x_raw_thresh_falling_value
>  What:		/sys/.../events/in_accel_y_raw_thresh_rising_value
> 

