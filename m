Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:44097 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754805AbaFNPHn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 14 Jun 2014 11:07:43 -0400
Message-ID: <539C65B4.5090504@kernel.org>
Date: Sat, 14 Jun 2014 16:09:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 10/12] staging:iio: Fix error handling in generic_buffer
 example
References: <1402549229-4449-1-git-send-email-pmeerw@pmeerw.net> <1402549229-4449-11-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402549229-4449-11-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/06/14 06:00, Peter Meerwald wrote:
> read() does not return -EAGAIN
> read() returns -1 and the errno value needs to be checked for -EAGAIN
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git

thanks
> ---
>   drivers/staging/iio/Documentation/generic_buffer.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
> index 40d0eca..044ea19 100644
> --- a/drivers/staging/iio/Documentation/generic_buffer.c
> +++ b/drivers/staging/iio/Documentation/generic_buffer.c
> @@ -305,9 +305,12 @@ int main(int argc, char **argv)
>   		read_size = read(fp,
>   				 data,
>   				 toread*scan_size);
> -		if (read_size == -EAGAIN) {
> -			printf("nothing available\n");
> -			continue;
> +		if (read_size < 0) {
> +			if (errno == -EAGAIN) {
> +				printf("nothing available\n");
> +				continue;
> +			} else
> +				break;
>   		}
>   		for (i = 0; i < read_size/scan_size; i++)
>   			process_scan(data + scan_size*i,
>

