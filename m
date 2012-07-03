Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56240 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755264Ab2GCUCM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 Jul 2012 16:02:12 -0400
Message-ID: <4FF34FC2.2090000@kernel.org>
Date: Tue, 03 Jul 2012 21:02:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: kernel version typo in sysfs-bus-iio
References: <1341138013-28267-1-git-send-email-pmeerw@pmeerw.net> <1341138013-28267-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1341138013-28267-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/01/2012 11:20 AM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
merged thanks.
> ---
>  Documentation/ABI/testing/sysfs-bus-iio |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index a3774a7..2f06d40 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -275,7 +275,7 @@ What:		/sys/.../iio:deviceX/in_voltage-voltage_scale_available
>  What:		/sys/.../iio:deviceX/out_voltageX_scale_available
>  What:		/sys/.../iio:deviceX/out_altvoltageX_scale_available
>  What:		/sys/.../iio:deviceX/in_capacitance_scale_available
> -KernelVersion:	2.635
> +KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		If a discrete set of scale values is available, they
> 


