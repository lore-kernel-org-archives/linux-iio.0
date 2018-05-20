Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751331AbeETN51 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 May 2018 09:57:27 -0400
Date: Sun, 20 May 2018 14:57:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Kelly <mkelly@xevo.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tools: iio: iio_generic_buffer: allow continuous
 looping
Message-ID: <20180520145723.06fb5119@archlinux>
In-Reply-To: <20180518001446.15607-2-mkelly@xevo.com>
References: <20180518001446.15607-1-mkelly@xevo.com>
        <20180518001446.15607-2-mkelly@xevo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 17 May 2018 17:14:46 -0700
Martin Kelly <mkelly@xevo.com> wrote:

> Sometimes it's useful to stream samples forever, such as when
> stress-testing a driver overnight to check for memory leaks or other
> issues. When the program receives a signal, it will gracefully cleanup,
> so it is still safe to terminate at any time.
> 
> Add support for specifying a negative -c option, meaning that we should
> loop forever. To do so, we need to use a long long (instead of just
> long) for num_loops so that current code specifying num_loops greater
> than UNSIGNED_LONG_MAX doesn't break.
> 
> Signed-off-by: Martin Kelly <mkelly@xevo.com>

Seems reasonable and I agree this is better than defaulting to infinite looping.

Definitely likely to be test scripts out there relying on it terminating when
the count isn't specified.

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to ignore it.

Thanks,

Jonathan

> ---
> v2:
> - Make j unsigned long long to match num_loops.
> 
> Another option for implementing this would be to implicitly assume looping
> forever if -c is not specified (instead of the current default of 2). I did not
> do this out of fear of breaking existing users but would be OK with doing so, as
> I like it as a default. If you'd like to go this route, let me know.
> 
>  tools/iio/iio_generic_buffer.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> index aa765c11992b..3040830d7797 100644
> --- a/tools/iio/iio_generic_buffer.c
> +++ b/tools/iio/iio_generic_buffer.c
> @@ -248,7 +248,7 @@ void print_usage(void)
>  		"Capture, convert and output data from IIO device buffer\n"
>  		"  -a         Auto-activate all available channels\n"
>  		"  -A         Force-activate ALL channels\n"
> -		"  -c <n>     Do n conversions\n"
> +		"  -c <n>     Do n conversions, or loop forever if n < 0\n"
>  		"  -e         Disable wait for event (new data)\n"
>  		"  -g         Use trigger-less mode\n"
>  		"  -l <n>     Set buffer length to n samples\n"
> @@ -330,12 +330,12 @@ static const struct option longopts[] = {
>  
>  int main(int argc, char **argv)
>  {
> -	unsigned long num_loops = 2;
> +	unsigned long long num_loops = 2;
>  	unsigned long timedelay = 1000000;
>  	unsigned long buf_len = 128;
>  
>  	ssize_t i;
> -	unsigned long j;
> +	unsigned long long j;
>  	unsigned long toread;
>  	int ret, c;
>  	int fp = -1;
> @@ -369,7 +369,7 @@ int main(int argc, char **argv)
>  			break;	
>  		case 'c':
>  			errno = 0;
> -			num_loops = strtoul(optarg, &dummy, 10);
> +			num_loops = strtoll(optarg, &dummy, 10);
>  			if (errno) {
>  				ret = -errno;
>  				goto error;
> @@ -637,7 +637,7 @@ int main(int argc, char **argv)
>  		goto error;
>  	}
>  
> -	for (j = 0; j < num_loops; j++) {
> +	for (j = 0; j < num_loops || num_loops < 0; j++) {
>  		if (!noevents) {
>  			struct pollfd pfd = {
>  				.fd = fp,

