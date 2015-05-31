Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35767 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868AbbFAVQx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:16:53 -0400
Message-ID: <556B5217.6030607@kernel.org>
Date: Sun, 31 May 2015 19:25:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: Re: [PATCH 19/32] tools:iio:iio_event_monitor: add error handling
References: <15952408423424396a4ace1522055e17da4afc80.1433072539.git.knaack.h@gmx.de> <71c628bf5ac132bca29fcbcc42dc8eaadf761675.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <71c628bf5ac132bca29fcbcc42dc8eaadf761675.1433072539.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/05/15 13:40, Hartmut Knaack wrote:
> Add error handling to calls which can indicate a major problem by
> returning an error code.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied.
> ---
>  tools/iio/iio_event_monitor.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index 1374374..1316527 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -286,7 +286,10 @@ int main(int argc, char **argv)
>  		goto error_free_chrdev_name;
>  	}
>  
> -	close(fd);
> +	if (close(fd) == -1)  {
> +		ret = -errno;
> +		goto error_free_chrdev_name;
> +	}
>  
>  	while (true) {
>  		ret = read(event_fd, &event, sizeof(event));
> @@ -304,7 +307,9 @@ int main(int argc, char **argv)
>  		print_event(&event);
>  	}
>  
> -	close(event_fd);
> +	if (close(event_fd) == -1)
> +		perror("Failed to close event file");
> +
>  error_free_chrdev_name:
>  	free(chrdev_name);
>  error_ret:
> 

