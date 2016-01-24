Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45163 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbcAXPCH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jan 2016 10:02:07 -0500
Subject: Re: [PATCH v2 2/3] iio: light: opt3001: trivial type refactoring
To: Alexander Koch <mail@alexanderkoch.net>
References: <1452960878-1727-1-git-send-email-mail@alexanderkoch.net>
 <1452960878-1727-3-git-send-email-mail@alexanderkoch.net>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	mhornung.linux@gmail.com, dannenberg@ti.com, balbi@ti.com,
	fengguang.wu@intel.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56A4E76E.6060309@kernel.org>
Date: Sun, 24 Jan 2016 15:02:06 +0000
MIME-Version: 1.0
In-Reply-To: <1452960878-1727-3-git-send-email-mail@alexanderkoch.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/01/16 16:14, Alexander Koch wrote:
> Change variable type of struct opt3001 members 'ok_to_ignore_lock' and
> 'result_ready' uint16-bitfield of length one to bool.
> 
> They are used as bool, let the compiler do the optimization.
> 
> Signed-off-by: Alexander Koch <mail@alexanderkoch.net>
> Signed-off-by: Michael Hornung <mhornung.linux@gmail.com>
I find it hard to care much about this one, but consistency is
always good and the bitfield never made much sense in here.

Applied to the togreg branch of iio.git - pushed out as testing... etc.

Thanks,

Jonathan
> ---
>  drivers/iio/light/opt3001.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> index aefbd79..b05c484 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c
> @@ -79,8 +79,8 @@ struct opt3001 {
>  	struct device		*dev;
>  
>  	struct mutex		lock;
> -	u16			ok_to_ignore_lock:1;
> -	u16			result_ready:1;
> +	bool			ok_to_ignore_lock;
> +	bool			result_ready;
>  	wait_queue_head_t	result_ready_queue;
>  	u16			result;
>  
> 

