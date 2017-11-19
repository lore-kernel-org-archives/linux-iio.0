Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752981AbdKSOzs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Nov 2017 09:55:48 -0500
Date: Sun, 19 Nov 2017 14:55:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Documentation: iio: Fix typo
Message-ID: <20171119145544.0f96daa4@archlinux>
In-Reply-To: <1509924300-14634-3-git-send-email-pmeerw@pmeerw.net>
References: <1509924300-14634-1-git-send-email-pmeerw@pmeerw.net>
        <1509924300-14634-3-git-send-email-pmeerw@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon,  6 Nov 2017 00:25:00 +0100
Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:

> Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Applied
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 2e3f919..a478740 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1290,7 +1290,7 @@ KernelVersion:	3.4
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Unit-less light intensity. Modifiers both and ir indicate
> -		that measurements contains visible and infrared light
> +		that measurements contain visible and infrared light
>  		components or just infrared light, respectively. Modifier uv indicates
>  		that measurements contain ultraviolet light components.
>  

