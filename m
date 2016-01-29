Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55418 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932801AbcA2SBA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 29 Jan 2016 13:01:00 -0500
Date: Fri, 29 Jan 2016 12:00:07 -0600
From: Andreas Dannenberg <dannenberg@ti.com>
To: Alexander Koch <mail@alexanderkoch.net>
CC: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
	<pmeerw@pmeerw.net>, <mhornung.linux@gmail.com>, <balbi@ti.com>,
	<fengguang.wu@intel.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio: light: opt3001: trivial type refactoring
Message-ID: <20160129180007.GB7960@LTA0797059A>
References: <1452960878-1727-1-git-send-email-mail@alexanderkoch.net>
 <1452960878-1727-3-git-send-email-mail@alexanderkoch.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1452960878-1727-3-git-send-email-mail@alexanderkoch.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Jan 16, 2016 at 05:14:37PM +0100, Alexander Koch wrote:
> Change variable type of struct opt3001 members 'ok_to_ignore_lock' and
> 'result_ready' uint16-bitfield of length one to bool.
> 
> They are used as bool, let the compiler do the optimization.
> 
> Signed-off-by: Alexander Koch <mail@alexanderkoch.net>
> Signed-off-by: Michael Hornung <mhornung.linux@gmail.com>

Tested-by: Andreas Dannenberg <dannenberg@ti.com>

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
> -- 
> 2.7.0
> 
