Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41628 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab2FRHlF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jun 2012 03:41:05 -0400
Message-ID: <4FDEDB8F.3050604@kernel.org>
Date: Mon, 18 Jun 2012 08:41:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH RESEND] iio staging: fix tsl2x7x file mode
References: <1339952599-22105-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339952599-22105-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/17/2012 6:03 PM, Peter Meerwald wrote:
> just drop execute permission
>
> Signed-off-by: Peter Meerwald<pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
>
> ---
>   0 files changed
>   mode change 100755 =>  100644 drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2583
>   mode change 100755 =>  100644 drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2x7x
>   mode change 100755 =>  100644 drivers/staging/iio/light/tsl2x7x.h
>   mode change 100755 =>  100644 drivers/staging/iio/light/tsl2x7x_core.c
>
> diff --git a/drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2583 b/drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2583
> old mode 100755
> new mode 100644
> diff --git a/drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2x7x b/drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2x7x
> old mode 100755
> new mode 100644
> diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
> old mode 100755
> new mode 100644
> diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
> old mode 100755
> new mode 100644

