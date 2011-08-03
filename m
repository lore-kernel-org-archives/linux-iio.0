Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:40002 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995Ab1HCJQF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Aug 2011 05:16:05 -0400
Message-ID: <4E3913B5.5070905@cam.ac.uk>
Date: Wed, 03 Aug 2011 10:24:05 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
CC: gregkh@suse.de, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
Subject: Re: [PATCH] drivers:staging:remove the unused label error_ret
References: <1312362628-27127-1-git-send-email-gaowanlong@cn.fujitsu.com>
In-Reply-To: <1312362628-27127-1-git-send-email-gaowanlong@cn.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/03/11 10:10, Wanlong Gao wrote:
> remove the unused label error_ret in ad5791.c.
Got that one in my tree as well. For reference, the current state of
iio tree (including all sorts of fun unreviewed code
and liable to be rebased several times a day is)
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio-blue.git

Again, I haven't posted that series yet hence:
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

> ---
>  drivers/staging/iio/dac/ad5791.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
> index 64770d2..5b00b70 100644
> --- a/drivers/staging/iio/dac/ad5791.c
> +++ b/drivers/staging/iio/dac/ad5791.c
> @@ -381,7 +381,6 @@ error_put_reg_pos:
>  	if (!IS_ERR(reg_vdd))
>  		regulator_put(reg_vdd);
>  
> -error_ret:
>  	return ret;
>  }
>  

