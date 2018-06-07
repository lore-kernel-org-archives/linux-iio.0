Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-dm3nam03on0045.outbound.protection.outlook.com ([104.47.41.45]:37620
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932418AbeFGQb0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 7 Jun 2018 12:31:26 -0400
Subject: Re: [PATCH] tools: iio: iio_generic_buffer: allow infinite looping
To: Dan Carpenter <dan.carpenter@oracle.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20180607083110.gjfmdfuzw2my6sl5@kili.mountain>
From: Martin Kelly <mkelly@xevo.com>
Message-ID: <6cf189db-adba-a731-f0cf-523e1d2970d7@xevo.com>
Date: Thu, 7 Jun 2018 09:31:06 -0700
MIME-Version: 1.0
In-Reply-To: <20180607083110.gjfmdfuzw2my6sl5@kili.mountain>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/07/2018 01:31 AM, Dan Carpenter wrote:
> I think the num_loops variable was intended to be signed so that we
> could set it to -1 and it would loop forever.  Right now it just loops
> for a very long time.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> index 3040830d7797..84545666a09c 100644
> --- a/tools/iio/iio_generic_buffer.c
> +++ b/tools/iio/iio_generic_buffer.c
> @@ -330,7 +330,7 @@ static const struct option longopts[] = {
>   
>   int main(int argc, char **argv)
>   {
> -	unsigned long long num_loops = 2;
> +	long long num_loops = 2;
>   	unsigned long timedelay = 1000000;
>   	unsigned long buf_len = 128;
>   

Good catch, thanks.

Reviewed-by: Martin Kelly <mkelly@xevo.com>
