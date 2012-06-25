Return-Path: <jic23@kernel.org>
Message-ID: <4FE8CB06.3050809@kernel.org>
Date: Mon, 25 Jun 2012 21:33:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk
Subject: Re: [PATCH 4/7] iio staging: generic_buffer cleanup
References: <1340651505-31081-1-git-send-email-pmeerw@pmeerw.net> <1340651505-31081-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340651505-31081-4-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 06/25/2012 08:11 PM, Peter Meerwald wrote:

Please run Checkpatch over your submissions just before sending them...

Fix the obvious whitespace issue before sending this on.
Nice tidy up otherwise.
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/Documentation/generic_buffer.c |   58 ++++++++++----------
>  1 file changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
> index 81358ac..ab228b4 100644
> --- a/drivers/staging/iio/Documentation/generic_buffer.c
> +++ b/drivers/staging/iio/Documentation/generic_buffer.c
> @@ -33,8 +33,8 @@
>  
>  /**
>   * size_from_channelarray() - calculate the storage size of a scan
> - * @channels: the channel info array
> - * @num_channels: size of the channel info array
> + * @channels:		the channel info array
> + * @num_channels:	number of channels
>   *
>   * Has the side effect of filling the channels[i].location values used
>   * in processing the buffer output.
> @@ -58,14 +58,15 @@ int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
>  void print2byte(int input, struct iio_channel_info *info)
>  {
>  	/* First swap if incorrect endian */
> -
>  	if (info->be)
>  		input = be16toh((uint16_t)input);
>  	else
>  		input = le16toh((uint16_t)input);
>  
> -	/* shift before conversion to avoid sign extension
> -	   of left aligned data */
> +	/* 
> +	 * Shift before conversion to avoid sign extension
> +	 * of left aligned data
> +	 */
>  	input = input >> info->shift;
>  	if (info->is_signed) {
>  		int16_t val = input;
> @@ -82,39 +83,39 @@ void print2byte(int input, struct iio_channel_info *info)
>  /**
>   * process_scan() - print out the values in SI units
>   * @data:		pointer to the start of the scan
> - * @infoarray:		information about the channels. Note
> + * @channels:		information about the channels. Note
>   *  size_from_channelarray must have been called first to fill the
>   *  location offsets.
> - * @num_channels:	the number of active channels
> + * @num_channels:	number of channels
>   **/
>  void process_scan(char *data,
> -		  struct iio_channel_info *infoarray,
> +		  struct iio_channel_info *channels,
>  		  int num_channels)
>  {
>  	int k;
>  	for (k = 0; k < num_channels; k++)
> -		switch (infoarray[k].bytes) {
> +		switch (channels[k].bytes) {
>  			/* only a few cases implemented so far */
>  		case 2:
> -			print2byte(*(uint16_t *)(data + infoarray[k].location),
> -				   &infoarray[k]);
> +			print2byte(*(uint16_t *)(data + channels[k].location),
> +				   &channels[k]);
>  			break;
>  		case 8:
> -			if (infoarray[k].is_signed) {
> +			if (channels[k].is_signed) {
>  				int64_t val = *(int64_t *)
>  					(data +
> -					 infoarray[k].location);
> -				if ((val >> infoarray[k].bits_used) & 1)
> -					val = (val & infoarray[k].mask) |
> -						~infoarray[k].mask;
> +					 channels[k].location);
> +				if ((val >> channels[k].bits_used) & 1)
> +					val = (val & channels[k].mask) |
> +						~channels[k].mask;
>  				/* special case for timestamp */
> -				if (infoarray[k].scale == 1.0f &&
> -				    infoarray[k].offset == 0.0f)
> +				if (channels[k].scale == 1.0f &&
> +				    channels[k].offset == 0.0f)
>  					printf(" %lld", val);
>  				else
>  					printf("%05f ", ((float)val +
> -							 infoarray[k].offset)*
> -					       infoarray[k].scale);
> +							 channels[k].offset)*
> +					       channels[k].scale);
>  			}
>  			break;
>  		default:
> @@ -129,7 +130,6 @@ int main(int argc, char **argv)
>  	unsigned long timedelay = 1000000;
>  	unsigned long buf_len = 128;
>  
> -
>  	int ret, c, i, j, toread;
>  	int fp;
>  
> @@ -146,7 +146,7 @@ int main(int argc, char **argv)
>  	int noevents = 0;
>  	char *dummy;
>  
> -	struct iio_channel_info *infoarray;
> +	struct iio_channel_info *channels;
>  
>  	while ((c = getopt(argc, argv, "l:w:c:et:n:")) != -1) {
>  		switch (c) {
> @@ -214,7 +214,7 @@ int main(int argc, char **argv)
>  	 * Parse the files in scan_elements to identify what channels are
>  	 * present
>  	 */
> -	ret = build_channel_array(dev_dir_name, &infoarray, &num_channels);
> +	ret = build_channel_array(dev_dir_name, &channels, &num_channels);
>  	if (ret) {
>  		printf("Problem reading scan element information\n");
>  		printf("diag %s\n", dev_dir_name);
> @@ -233,7 +233,7 @@ int main(int argc, char **argv)
>  		goto error_free_triggername;
>  	}
>  	printf("%s %s\n", dev_dir_name, trigger_name);
> -	/* Set the device trigger to be the data rdy trigger found above */
> +	/* Set the device trigger to be the data ready trigger found above */
>  	ret = write_sysfs_string_and_verify("trigger/current_trigger",
>  					dev_dir_name,
>  					trigger_name);
> @@ -251,7 +251,7 @@ int main(int argc, char **argv)
>  	ret = write_sysfs_int("enable", buf_dir_name, 1);
>  	if (ret < 0)
>  		goto error_free_buf_dir_name;
> -	scan_size = size_from_channelarray(infoarray, num_channels);
> +	scan_size = size_from_channelarray(channels, num_channels);
>  	data = malloc(scan_size*buf_len);
>  	if (!data) {
>  		ret = -ENOMEM;
> @@ -266,7 +266,7 @@ int main(int argc, char **argv)
>  
>  	/* Attempt to open non blocking the access dev */
>  	fp = open(buffer_access, O_RDONLY | O_NONBLOCK);
> -	if (fp == -1) { /*If it isn't there make the node */
> +	if (fp == -1) { /* If it isn't there make the node */
>  		printf("Failed to open %s\n", buffer_access);
>  		ret = -errno;
>  		goto error_free_buffer_access;
> @@ -297,16 +297,16 @@ int main(int argc, char **argv)
>  		}
>  		for (i = 0; i < read_size/scan_size; i++)
>  			process_scan(data + scan_size*i,
> -				     infoarray,
> +				     channels,
>  				     num_channels);
>  	}
>  
> -	/* Stop the ring buffer */
> +	/* Stop the buffer */
>  	ret = write_sysfs_int("enable", buf_dir_name, 0);
>  	if (ret < 0)
>  		goto error_close_buffer_access;
>  
> -	/* Disconnect from the trigger - just write a dummy name.*/
> +	/* Disconnect the trigger - just write a dummy name. */
>  	write_sysfs_string("trigger/current_trigger",
>  			dev_dir_name, "NULL");
>  
> 
