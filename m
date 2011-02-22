Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:36896 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635Ab1BVSrk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Feb 2011 13:47:40 -0500
Message-ID: <4D6404E8.1050309@cam.ac.uk>
Date: Tue, 22 Feb 2011 18:48:08 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] IIO: Documentation: generic_buffer example: scan_size
 must be bytes_per_datum
References: <1297781180-5071-1-git-send-email-michael.hennerich@analog.com> <1297781180-5071-4-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1297781180-5071-4-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/15/11 14:46, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> In case a timestamp is present, scan size returned by size_from_channelarray()
> is not longer valid.
Really?  Shouldn't the timestamp just be picked up as another channel assuming
all the relevant attributes are present (which they should be...)

> However size_from_channelarray() must be still called
> in order to setup locations within the buffer.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/staging/iio/Documentation/generic_buffer.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
> index 131d9d0..c382452 100644
> --- a/drivers/staging/iio/Documentation/generic_buffer.c
> +++ b/drivers/staging/iio/Documentation/generic_buffer.c
> @@ -226,7 +226,13 @@ int main(int argc, char **argv)
>  	ret = write_sysfs_int("enable", buf_dir_name, 1);
>  	if (ret < 0)
>  		goto error_free_buf_dir_name;
> -	scan_size = size_from_channelarray(infoarray, num_channels);
> +
> +	scan_size = read_sysfs_posint("bytes_per_datum", buf_dir_name);
> +	if (ret < 0)
> +		goto error_free_buf_dir_name;
> +
> +	size_from_channelarray(infoarray, num_channels);
> +
>  	data = malloc(scan_size*buf_len);
>  	if (!data) {
>  		ret = -ENOMEM;

