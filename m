Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtprelay0220.hostedemail.com ([216.40.44.220]:41150 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753160AbaHECCX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Aug 2014 22:02:23 -0400
Message-ID: <1407204139.16152.106.camel@joe-AO725>
Subject: Re: [PATCH v2 8/8] staging: iio: accel: sca3000_core.c: Add blank
 line between declarations and code
From: Joe Perches <joe@perches.com>
To: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	jic23@kernel.org
Date: Mon, 04 Aug 2014 19:02:19 -0700
In-Reply-To: <1407203223-9700-9-git-send-email-mopsfelder@gmail.com>
References: <1407203223-9700-1-git-send-email-mopsfelder@gmail.com>
	 <1407203223-9700-9-git-send-email-mopsfelder@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 2014-08-04 at 22:47 -0300, Murilo Opsfelder Araujo wrote:
> This patch adds missing blank line between declarations and code, and
> adjust code to fit 80-chars limit.
[]
> diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
[]
> @@ -506,7 +506,8 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
>  				mutex_unlock(&st->lock);
>  				return ret;
>  			}
> -			*val = ((st->rx[0] & 0x3F) << 3) | ((st->rx[1] & 0xE0) >> 5);
> +			*val = ((st->rx[0] & 0x3F) << 3)
> +				| ((st->rx[1] & 0xE0) >> 5);

Please don't strain to fit 80 columns.

If this is done, please strive to make it
quickly intelligible for humans.

I think this would be better as:

+			*val = ((st->rx[0] & 0x3F) << 3) |
+			       ((st->rx[1] & 0xE0) >> 5);

so that the mask and shift are aligned.


