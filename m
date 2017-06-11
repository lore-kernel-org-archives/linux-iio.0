Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751651AbdFKN6g (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Jun 2017 09:58:36 -0400
Date: Sun, 11 Jun 2017 14:58:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Cc: michal.simek@xilinx.com, rajnikant.bhojani@xilinx.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: xilinx-ams: add missing break in
 AMS_SUPPLY[78] cases
Message-ID: <20170611145831.040a2b45@kernel.org>
In-Reply-To: <1496776881-5265-1-git-send-email-jeff.dagenais@gmail.com>
References: <1496776881-5265-1-git-send-email-jeff.dagenais@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue,  6 Jun 2017 15:21:21 -0400
Jean-Francois Dagenais <jeff.dagenais@gmail.com> wrote:

> This would otherwise lead supply 7 and 8 to scale to 3V instead of
> 6V
> 
> Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Interesting... Driver isn't in mainline though and as far as I know
hasn't been submitted.

Jonathan
> ---
>  drivers/iio/adc/xilinx-ams.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> index fd4eb6d..6b3ab56 100644
> --- a/drivers/iio/adc/xilinx-ams.c
> +++ b/drivers/iio/adc/xilinx-ams.c
> @@ -255,6 +255,7 @@ static int ams_read_raw(struct iio_dev *indio_dev,
>  			case AMS_SUPPLY7:
>  			case AMS_SUPPLY8:
>  				*val = AMS_SUPPLY_SCALE_6VOLT;
> +				break;
>  			case AMS_SUPPLY9:
>  			case AMS_SUPPLY10:
>  				if (chan->scan_index < PS_SEQ_MAX)

