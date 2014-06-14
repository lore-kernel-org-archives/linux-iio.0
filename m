Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:44087 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754805AbaFNPHC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 14 Jun 2014 11:07:02 -0400
Message-ID: <539C658A.8060108@kernel.org>
Date: Sat, 14 Jun 2014 16:08:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 09/12] staging:iio: Fix mention of INDIO_RING_TRIGGERED
 to INDIO_BUFFER_TRIGGERED
References: <1402549229-4449-1-git-send-email-pmeerw@pmeerw.net> <1402549229-4449-10-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402549229-4449-10-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/06/14 06:00, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git

Thanks,
> ---
>   drivers/staging/iio/Documentation/trigger.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/iio/Documentation/trigger.txt b/drivers/staging/iio/Documentation/trigger.txt
> index 64e2e08..7c0e505 100644
> --- a/drivers/staging/iio/Documentation/trigger.txt
> +++ b/drivers/staging/iio/Documentation/trigger.txt
> @@ -31,5 +31,5 @@ consumers.
>   Trigger Consumers
>
>   Currently triggers are only used for the filling of software
> -buffers and as such any device supporting INDIO_RING_TRIGGERED has the
> +buffers and as such any device supporting INDIO_BUFFER_TRIGGERED has the
>   consumer interface automatically created.
>

