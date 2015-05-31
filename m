Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35743 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714AbbFAVQu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:16:50 -0400
Message-ID: <556B39B8.9070001@kernel.org>
Date: Sun, 31 May 2015 17:41:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: Re: [PATCH 12/32] tools:iio:generic_buffer: sign-extend and shift
 data
References: <15952408423424396a4ace1522055e17da4afc80.1433072539.git.knaack.h@gmx.de> <09b071f8d6ae17166a1230ee8708ed65f2e2978d.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <09b071f8d6ae17166a1230ee8708ed65f2e2978d.1433072539.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/05/15 13:39, Hartmut Knaack wrote:
> Refactor process_scan() to handle signed and unsigned data, respect shifts
> and the data mask for 2, 4 and 8 byte sized scan elements.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Nice clean up though diff had fun mixing the lines of code
to make the patch appear interesting at times ;)

Applied.
> ---
>  tools/iio/generic_buffer.c | 97 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 62 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
> index a3cf8e3..bd974b8 100644
> --- a/tools/iio/generic_buffer.c
> +++ b/tools/iio/generic_buffer.c
> @@ -59,33 +59,80 @@ int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
>  	return bytes;
>  }
>  
> -void print2byte(int input, struct iio_channel_info *info)
> +void print2byte(uint16_t input, struct iio_channel_info *info)
>  {
>  	/* First swap if incorrect endian */
>  	if (info->be)
> -		input = be16toh((uint16_t)input);
> +		input = be16toh(input);
>  	else
> -		input = le16toh((uint16_t)input);
> +		input = le16toh(input);
>  
>  	/*
>  	 * Shift before conversion to avoid sign extension
>  	 * of left aligned data
>  	 */
>  	input >>= info->shift;
> +	input &= info->mask;
>  	if (info->is_signed) {
> -		int16_t val = input;
> +		int16_t val = (int16_t)(input << (16 - info->bits_used)) >>
> +			      (16 - info->bits_used);
> +		printf("%05f ", ((float)val + info->offset) * info->scale);
> +	} else {
> +		printf("%05f ", ((float)input + info->offset) * info->scale);
> +	}
> +}
>  
> -		val &= (1 << info->bits_used) - 1;
> -		val = (int16_t)(val << (16 - info->bits_used)) >>
> -			(16 - info->bits_used);
> -		printf("%05f ", ((float)val + info->offset)*info->scale);
> +void print4byte(uint32_t input, struct iio_channel_info *info)
> +{
> +	/* First swap if incorrect endian */
> +	if (info->be)
> +		input = be32toh(input);
> +	else
> +		input = le32toh(input);
> +
> +	/*
> +	 * Shift before conversion to avoid sign extension
> +	 * of left aligned data
> +	 */
> +	input >>= info->shift;
> +	input &= info->mask;
> +	if (info->is_signed) {
> +		int32_t val = (int32_t)(input << (32 - info->bits_used)) >>
> +			      (32 - info->bits_used);
> +		printf("%05f ", ((float)val + info->offset) * info->scale);
>  	} else {
> -		uint16_t val = input;
> +		printf("%05f ", ((float)input + info->offset) * info->scale);
> +	}
> +}
>  
> -		val &= (1 << info->bits_used) - 1;
> -		printf("%05f ", ((float)val + info->offset)*info->scale);
> +void print8byte(uint64_t input, struct iio_channel_info *info)
> +{
> +	/* First swap if incorrect endian */
> +	if (info->be)
> +		input = be64toh(input);
> +	else
> +		input = le64toh(input);
> +
> +	/*
> +	 * Shift before conversion to avoid sign extension
> +	 * of left aligned data
> +	 */
> +	input >>= info->shift;
> +	input &= info->mask;
> +	if (info->is_signed) {
> +		int64_t val = (int64_t)(input << (64 - info->bits_used)) >>
> +			      (64 - info->bits_used);
> +		/* special case for timestamp */
> +		if (info->scale == 1.0f && info->offset == 0.0f)
> +			printf("%" PRId64 " ", val);
> +		else
> +			printf("%05f ",
> +			       ((float)val + info->offset) * info->scale);
> +	} else {
> +		printf("%05f ", ((float)input + info->offset) * info->scale);
>  	}
>  }
> +
>  /**
>   * process_scan() - print out the values in SI units
>   * @data:		pointer to the start of the scan
> @@ -108,32 +155,12 @@ void process_scan(char *data,
>  				   &channels[k]);
>  			break;
>  		case 4:
> -			if (!channels[k].is_signed) {
> -				uint32_t val = *(uint32_t *)
> -					(data + channels[k].location);
> -				printf("%05f ", ((float)val +
> -						 channels[k].offset)*
> -				       channels[k].scale);
> -
> -			}
> +			print4byte(*(uint32_t *)(data + channels[k].location),
> +				   &channels[k]);
>  			break;
>  		case 8:
> -			if (channels[k].is_signed) {
> -				int64_t val = *(int64_t *)
> -					(data +
> -					 channels[k].location);
> -				if ((val >> channels[k].bits_used) & 1)
> -					val = (val & channels[k].mask) |
> -						~channels[k].mask;
> -				/* special case for timestamp */
> -				if (channels[k].scale == 1.0f &&
> -				    channels[k].offset == 0.0f)
> -					printf("%" PRId64 " ", val);
> -				else
> -					printf("%05f ", ((float)val +
> -							 channels[k].offset)*
> -					       channels[k].scale);
> -			}
> +			print8byte(*(uint64_t *)(data + channels[k].location),
> +				   &channels[k]);
>  			break;
>  		default:
>  			break;
> 

