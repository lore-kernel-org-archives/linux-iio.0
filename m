Return-Path: <knaack.h@gmx.de>
Message-ID: <5598F27B.9030307@gmx.de>
Date: Sun, 05 Jul 2015 11:01:47 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Tiberiu Breana <tiberiu.a.breana@intel.com>,
 linux-iio@vger.kernel.org
CC: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2] tools: iio: Add single-byte case for generic_buffer
References: <1435917456-2973-1-git-send-email-tiberiu.a.breana@intel.com>
In-Reply-To: <1435917456-2973-1-git-send-email-tiberiu.a.breana@intel.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

Resending to see if vger.kernel.org is up again.

Tiberiu Breana schrieb am 03.07.2015 um 11:57:
> Some sensors export data in an 8-bit format.
> Add a single-byte case for the generic_buffer tool so that
> these sensors' buffer data can be visualized.
> 
> Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
Reviewed-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
> v2: added the print1byte function to apply the channel shift and
> address both signed and unsigned cases.
> ---
>  tools/iio/generic_buffer.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
> index fc362d2..0e73723 100644
> --- a/tools/iio/generic_buffer.c
> +++ b/tools/iio/generic_buffer.c
> @@ -61,6 +61,23 @@ int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
>  	return bytes;
>  }
>  
> +void print1byte(uint8_t input, struct iio_channel_info *info)
> +{
> +	/*
> +	 * Shift before conversion to avoid sign extension
> +	 * of left aligned data
> +	 */
> +	input >>= info->shift;
> +	input &= info->mask;
> +	if (info->is_signed) {
> +		int8_t val = (int8_t)(input << (8 - info->bits_used)) >>
> +			     (8 - info->bits_used);
> +		printf("%05f ", ((float)val + info->offset) * info->scale);
> +	} else {
> +		printf("%05f ", ((float)input + info->offset) * info->scale);
> +	}
> +}
> +
>  void print2byte(uint16_t input, struct iio_channel_info *info)
>  {
>  	/* First swap if incorrect endian */
> @@ -152,6 +169,10 @@ void process_scan(char *data,
>  	for (k = 0; k < num_channels; k++)
>  		switch (channels[k].bytes) {
>  			/* only a few cases implemented so far */

Not sure though how long we should keep that comment. ^^^^^
I probably had more reason to get rid of it during my rework.

> +		case 1:
> +			print1byte(*(uint8_t *)(data + channels[k].location),
> +				   &channels[k]);
> +			break;
>  		case 2:
>  			print2byte(*(uint16_t *)(data + channels[k].location),
>  				   &channels[k]);
> 
