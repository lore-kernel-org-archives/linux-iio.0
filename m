Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35697 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628AbbFAVQo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:16:44 -0400
Message-ID: <556B3330.3020906@kernel.org>
Date: Sun, 31 May 2015 17:13:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: Re: [PATCH 01/32] tools:iio:generic_buffer: fix order of freeing
 data
References: <cover.1433072539.git.knaack.h@gmx.de> <106ad3c604e57db622bd4a274a4429b25b5af1bd.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <106ad3c604e57db622bd4a274a4429b25b5af1bd.1433072539.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/05/15 13:39, Hartmut Knaack wrote:
> data gets allocated before buffer_access, so it should be freed in reverse
> order. Otherwise, if allocating buffer_access fails, an attempt to free it
> would be taken, which should not happen.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied to the togreg branch of iio.git which will get pushed out as
testing when I'm on a sensible net connection.

An unplanned work trip for the next few days (hopefully not longer).

Jonathan
> ---
>  tools/iio/generic_buffer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
> index f805493..15f2a40 100644
> --- a/tools/iio/generic_buffer.c
> +++ b/tools/iio/generic_buffer.c
> @@ -345,10 +345,10 @@ int main(int argc, char **argv)
>  
>  error_close_buffer_access:
>  	close(fp);
> -error_free_data:
> -	free(data);
>  error_free_buffer_access:
>  	free(buffer_access);
> +error_free_data:
> +	free(data);
>  error_free_buf_dir_name:
>  	free(buf_dir_name);
>  error_free_triggername:
> 

