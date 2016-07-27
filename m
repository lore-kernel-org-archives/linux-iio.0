Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:17613 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753937AbcG0IJD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 27 Jul 2016 04:09:03 -0400
Message-ID: <57986CF3.4070602@parrot.com>
Date: Wed, 27 Jul 2016 10:12:35 +0200
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: Alison Schofield <amsfield22@gmail.com>, <jic23@kernel.org>
CC: <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools: iio: iio_generic_buffer: initialize channel array
 pointer
References: <20160727031734.GA31933@d830.WORKGROUP>
In-Reply-To: <20160727031734.GA31933@d830.WORKGROUP>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On 07/27/2016 05:17 AM, Alison Schofield wrote:
> Uninitialized channel pointer causes segmentation fault when we
> call free(channel) during cleanup() with no channels initialized.
> This happens when you exit early for usage errors.  Initialize
> the pointer to NULL when it is declared.
>
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> ---
>   tools/iio/iio_generic_buffer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> index 0e8a1f7..ae68bf0 100644
> --- a/tools/iio/iio_generic_buffer.c
> +++ b/tools/iio/iio_generic_buffer.c
> @@ -348,7 +348,7 @@ int main(int argc, char **argv)
>   	int notrigger = 0;
>   	char *dummy;
>   
> -	struct iio_channel_info *channels;
> +	struct iio_channel_info *channels = NULL;
>   
>   	register_cleanup();
>   
Tested-by: Gregor Boirie <gregor.boirie@parrot.com>

greg.
