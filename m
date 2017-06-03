Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750759AbdFCIZ1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jun 2017 04:25:27 -0400
Date: Sat, 3 Jun 2017 09:25:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Michael Stecklein <m-stecklein@ti.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH] iio: humidity: hdc100x: document compatible HDC10xx
 devices
Message-ID: <20170603092523.77b3b0ee@kernel.org>
In-Reply-To: <1496416161-8180-1-git-send-email-m-stecklein@ti.com>
References: <1496416161-8180-1-git-send-email-m-stecklein@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 2 Jun 2017 10:09:21 -0500
Michael Stecklein <m-stecklein@ti.com> wrote:

> Include datasheet links to compatible HDC10xx devices.
> 
> Signed-off-by: Michael Stecklein <m-stecklein@ti.com>
Hi Michael,

Would you mind also adding the i2c_device_id entries for these
other parts and updating the kconfig help to mention that they
are supported?  Hmm. Matt, the driver should really have listed
all the parts explicitly in the first place. I was clearly
half asleep whilst reviewing this one.

We'll need to leave the hdc100x entry in there for backwards
compatibility but please add all the others.

Might also be worth taking this opportunity to do an additional
patch adding devicetree bindings for this driver.

If you don't have time for any or all of the above, feel free
to say so!

Thanks,

Jonathan
> ---
> 
> Tested on the HDC1080 but not the HDC1010 and HDC1050, however
> their datasheets describe identical functionality.
> 
>  drivers/iio/humidity/hdc100x.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> index aa17115..ef17613 100644
> --- a/drivers/iio/humidity/hdc100x.c
> +++ b/drivers/iio/humidity/hdc100x.c
> @@ -13,6 +13,12 @@
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>   * GNU General Public License for more details.
>   *
> + * Datasheets:
> + * http://www.ti.com/product/HDC1000/datasheet
> + * http://www.ti.com/product/HDC1008/datasheet
> + * http://www.ti.com/product/HDC1010/datasheet
> + * http://www.ti.com/product/HDC1050/datasheet
> + * http://www.ti.com/product/HDC1080/datasheet
>   */
>  
>  #include <linux/delay.h>

