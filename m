Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46877 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759120AbdENPYq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 May 2017 11:24:46 -0400
Subject: Re: [PATCH v2 1/3] staging: iio: meter: Add the comment for mutex
 definition.
To: Harinath Nampally <harinath922@gmail.com>, lars@metafoo.de
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20170509074617.x6bdqs7innxhrude@mwanda>
 <cover.1494370925.git.harinath922@gmail.com>
 <3aa61726d979dbaf85a116341d169a933218904b.1494370925.git.harinath922@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ec2a58d2-4c92-18af-176f-b52e0f4d770a@kernel.org>
Date: Sun, 14 May 2017 16:24:44 +0100
MIME-Version: 1.0
In-Reply-To: <3aa61726d979dbaf85a116341d169a933218904b.1494370925.git.harinath922@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/05/17 00:41, Harinath Nampally wrote:
> This patch fixes below checkpatch.pl warning:
> CHECK: struct mutex definition without comment
> 
> Signed-off-by: Harinath Nampally <harinath922@gmail.com>
They description is no longer correct. This moves a comment
rather than adding one.

J
> ---
> Changes in v2:
>   - Removed the extra comment for mutex in the struct.
> 	
>   drivers/staging/iio/meter/ade7753.c | 3 ++-
>   1 file changed, 1 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
> index b71fbd3..cffe6bf 100644
> --- a/drivers/staging/iio/meter/ade7753.c
> +++ b/drivers/staging/iio/meter/ade7753.c
> @@ -78,12 +78,13 @@
>   /**
>    * struct ade7753_state - device instance specific data
>    * @us:         actual spi_device
> + * @buf_lock:       mutex to protect tx and rx
>    * @tx:         transmit buffer
>    * @rx:         receive buffer
> - * @buf_lock:       mutex to protect tx and rx
>    **/
>   struct ade7753_state {
>   	struct spi_device   *us;
>   	struct mutex        buf_lock;
>   	u8          tx[ADE7753_MAX_TX] ____cacheline_aligned;
>   	u8          rx[ADE7753_MAX_RX];
> 

