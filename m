Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59461 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbbC1LL6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2015 07:11:58 -0400
Message-ID: <55168C7C.9060704@kernel.org>
Date: Sat, 28 Mar 2015 11:11:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Alin Arhip <alin.g.arhip@intel.com>
CC: knaack.h@gmx.de, lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: iio: Add help option for generic_buffer
References: <1427460139-5136-1-git-send-email-alin.g.arhip@intel.com>
In-Reply-To: <1427460139-5136-1-git-send-email-alin.g.arhip@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/03/15 12:42, Alin Arhip wrote:
> From: Alin Gabriel Arhip <alin.g.arhip@intel.com>
> 
> This patch adds usage instructions and -h parameter to view available
> command line parameters.
> 
> Signed-off-by: Alin Gabriel Arhip <alin.g.arhip@intel.com>
Good in principal, but I wonder if we can't make it more informative.
Some of the help is talking more about internals of the code rather
than what the option means to the user!
> ---
>  tools/iio/generic_buffer.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
> index 8f8f058..8dd77ac 100644
> --- a/tools/iio/generic_buffer.c
> +++ b/tools/iio/generic_buffer.c
> @@ -166,7 +166,17 @@ int main(int argc, char **argv)
>  
>  	struct iio_channel_info *channels;
>  
> -	while ((c = getopt(argc, argv, "l:w:c:et:n:g")) != -1) {
> +	if (argc <= 1) {
> +		printf("Usage: %s -n <device_name> -t <trigger_name>\n"
> +			"\tIf trigger name is not specified the program\n"
> +			"\tassumes you want a dataready trigger associated\n"
> +			"\twith the device and goes looking for it.\n"
> +			"\tUse -h to see available command line parameters.\n",
> +			argv[0]);
> +		return -1;
> +	}
> +
> +	while ((c = getopt(argc, argv, "l:w:c:et:n:gh")) != -1) {
>  		switch (c) {
>  		case 'n':
>  			device_name = optarg;
> @@ -190,7 +200,15 @@ int main(int argc, char **argv)
>  		case 'g':
>  			notrigger = 1;
>  			break;
> -		case '?':
> +		case '?': case 'h':
> +			printf("Usage: %s -n <device_name> to set device name\n"
> +				"\t-t <trigger_name> to set trigger name\n"
> +				"\t-e to set noevents to 1\n"
This option was to allow reads of more than one sample (as that's what
poll used to support).  With the new poll support for watersheds
(in the software buffer) we probably want to drop this option entirely and
support those instead.


> +				"\t-c <num_loops> to set number of loops\n"
loops of what? Again, the meaning of this will change with support for
watershed based poll.
> +				"\t-w <timedelay> to set time delay\n"
to set time delay between attempts to read from the buffer.
> +				"\t-l <buf_len> to set buffer length\n"
> +				"\t-g to set notrigger to 1\n"
Make it explicit that some devices do not have a trigger as they push
the data directly to the buffer (typically hardware buffer equipped devices).
> +				"\t-h to see this help\n", argv[0]);
>  			return -1;
>  		}
>  	}
> 

