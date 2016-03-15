Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35331 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932195AbcCOWH1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Mar 2016 18:07:27 -0400
Subject: Re: [PATCH 2/2] iio: mma8452: use runtime pm instead of device
 specific autosleep
To: Martin Kepplinger <martink@posteo.de>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net
References: <1457954789-4885-1-git-send-email-martink@posteo.de>
 <1457954789-4885-2-git-send-email-martink@posteo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56E8879D.4050409@kernel.org>
Date: Tue, 15 Mar 2016 22:07:25 +0000
MIME-Version: 1.0
In-Reply-To: <1457954789-4885-2-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/03/16 11:26, Martin Kepplinger wrote:
> What is this autosleep?
> -----------------------
> It slows down the device after x seconds of inactivity. The thing is, we have
> really achieved almost the same by runtime pm.
> 
> differnces are:
> 
> autosleep
>  * uses more power during inactivity
>  * the first read after inactivity slightly faster
>  * complicated to understand for the user
>  * no documented sysfs interface (afaik)
>  * complicated to read and maintain
> 
> runtime pm
>  * already merged in mma8452
>  * uses less power during inactivity
>  * first read after inactivity slower
>  * easy to use. well documented.
>  * easy to maintain and understand
> 
> The two approaches solve the same problem. runtime pm has more advantages
> than autosleep and comes quite close to it's behaviour anyways. As I see it,
> autosleep, even if somehow supported, would never be used anyways.
> 
> So resolve this issue by "ignoring" autosleep.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> Reviewed-by: Martina Kepplinger <martina.novakovic@zoho.com>
A good detailed explanation + to be cynical, if anyone actually wants to implement
it and provide numbers showing it is the best thing since sliced bread - the absence
of a comment about it not being done isn't going to stop them!

Applied, thanks,

Jonathan
> ---
>  drivers/iio/accel/mma8452.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index d0eeba0..375e45f 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -17,7 +17,7 @@
>   *
>   * 7-bit I2C slave address 0x1c/0x1d (pin selectable)
>   *
> - * TODO: orientation events, autosleep
> + * TODO: orientation events
>   */
>  
>  #include <linux/module.h>
> 

