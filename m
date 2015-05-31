Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35721 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406AbbFAVQr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:16:47 -0400
Message-ID: <556B3809.6090201@kernel.org>
Date: Sun, 31 May 2015 17:34:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: Re: [PATCH 09/32] tools:iio:iio_event_monitor: save right errno
References: <cover.1433072539.git.knaack.h@gmx.de> <ebe100b3d8062b6e408551e7fd1bc5183467ed3d.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <ebe100b3d8062b6e408551e7fd1bc5183467ed3d.1433072539.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/05/15 13:39, Hartmut Knaack wrote:
> Move up error handling code to preserve the errno coming from ioctl(),
> before it may be changed by close().
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied.
> ---
>  tools/iio/iio_event_monitor.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index f6fdab4..578390d 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -275,15 +275,17 @@ int main(int argc, char **argv)
>  	}
>  
>  	ret = ioctl(fd, IIO_GET_EVENT_FD_IOCTL, &event_fd);
> -
> -	close(fd);
> -
>  	if (ret == -1 || event_fd == -1) {
>  		ret = -errno;
>  		fprintf(stdout, "Failed to retrieve event fd\n");
> +		if (close(fd) == -1)
> +			perror("Failed to close character device file");
> +
>  		goto error_free_chrdev_name;
>  	}
>  
> +	close(fd);
> +
>  	while (true) {
>  		ret = read(event_fd, &event, sizeof(event));
>  		if (ret == -1) {
> 

