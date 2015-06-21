Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42825 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbbFUKBB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 06:01:01 -0400
Message-ID: <55868B5A.1010604@kernel.org>
Date: Sun, 21 Jun 2015 11:00:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Tiberiu Breana <tiberiu.a.breana@intel.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] tools: iio: Add single-byte case for generic_buffer
References: <1434381469-4373-1-git-send-email-tiberiu.a.breana@intel.com>
In-Reply-To: <1434381469-4373-1-git-send-email-tiberiu.a.breana@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/06/15 16:17, Tiberiu Breana wrote:
> Some sensors export data in an 8-bit format.
> Add a single-byte case for the generic_buffer tool so that
> these sensors' buffer data can be visualized.
> 
> Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
Hi Tiberiu,

Please take a closer look at the other cases handled, you've missed
application of the shift here and I'd also like you to cover the unsigned
case. Probably worth having a print1byte helper to keep it inline with
the other cases as well.

I was amazed that this wasn't already there ;) Oh well, guess we don't
actually have that many 8 bit of less devices or people aren't using
my dumb test code (much improved by others) with them anyway ;)

Jonathan
> ---
>  tools/iio/generic_buffer.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
> index f805493..0d438e3 100644
> --- a/tools/iio/generic_buffer.c
> +++ b/tools/iio/generic_buffer.c
> @@ -103,6 +103,14 @@ void process_scan(char *data,
>  	for (k = 0; k < num_channels; k++)
>  		switch (channels[k].bytes) {
>  			/* only a few cases implemented so far */
> +		case 1:
> +			if (channels[k].is_signed) {
> +				int8_t val = *(int8_t *)
> +					(data + channels[k].location);
> +				printf("%05f ",
> +					((float)val) * channels[k].scale);
> +			}
> +			break;
>  		case 2:
>  			print2byte(*(uint16_t *)(data + channels[k].location),
>  				   &channels[k]);
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
