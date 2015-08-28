Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57224 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739AbbH1KAO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 28 Aug 2015 06:00:14 -0400
Date: Fri, 28 Aug 2015 12:00:10 +0200
From: Jean Delvare <jdelvare@suse.de>
To: "Nicola Corna" <nicola@corna.info>
Cc: "Jonathan Cameron" <jic23@kernel.org>,
	"Wolfram Sang" <wsa@the-dreams.de>,
	"Lars-Peter Clausen" <lars@metafoo.de>,
	"Peter Meerwald" <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	"Hartmut Knaack" <knaack.h@gmx.de>
Subject: Re: [PATCH 2/3] iio:humidity:si7020: added No Hold read mode
Message-ID: <20150828120010.76e45e44@endymion.delvare>
In-Reply-To: <3d9e0164f7d0186d5c6385622dff7e4d@rainloop.corna.info>
References: <1440686436.25403.13.camel@chaos.site>
	<55D88078.5080006@kernel.org>
	<1440079909-1337-1-git-send-email-nicola@corna.info>
	<1440079909-1337-2-git-send-email-nicola@corna.info>
	<8bdb2c60fd1785b1d814277769881f08@rainloop.corna.info>
	<3d9e0164f7d0186d5c6385622dff7e4d@rainloop.corna.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Nicola,

On Fri, 28 Aug 2015 07:32:02 +0000, Nicola Corna wrote:
> August 27 2015 4:40 PM, "Jean Delvare" <jdelvare@suse.de> wrote:
> > There currently is no way for bus drivers to report whether they support
> > clock stretching or not. We could add a functionality flag for this,
> > like:
> > 
> > #define I2C_FUNC_NO_CLK_STRETCH 0x00000040 /* No check for SCL low */
> > 
> > For example i2c-algo-bit would set this flag if no getscl callback is
> > provided.
> 
> Something like this?

Yes.

> ---
>  drivers/i2c/algos/i2c-algo-bit.c | 5 ++++-
>  include/uapi/linux/i2c.h         | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
> index 899bede..618deb3 100644
> --- a/drivers/i2c/algos/i2c-algo-bit.c
> +++ b/drivers/i2c/algos/i2c-algo-bit.c
> @@ -605,7 +605,10 @@ static u32 bit_func(struct i2c_adapter *adap)
>  	return I2C_FUNC_I2C | I2C_FUNC_NOSTART | I2C_FUNC_SMBUS_EMUL |
>  	       I2C_FUNC_SMBUS_READ_BLOCK_DATA |
>  	       I2C_FUNC_SMBUS_BLOCK_PROC_CALL |
> -	       I2C_FUNC_10BIT_ADDR | I2C_FUNC_PROTOCOL_MANGLING;
> +	       I2C_FUNC_10BIT_ADDR | I2C_FUNC_PROTOCOL_MANGLING |
> +	       (((struct i2c_algo_bit_data *)adap->algo_data)->getscl ?
> +	       0 : I2C_FUNC_NO_CLK_STRETCH);
> +

No blank line at end of function please.

Also I think this would all be more readable if adap->algo_data was
stored in a local variable.

>  }
>  
>  
> diff --git a/include/uapi/linux/i2c.h b/include/uapi/linux/i2c.h
> index b0a7dd6..59e4b43 100644
> --- a/include/uapi/linux/i2c.h
> +++ b/include/uapi/linux/i2c.h
> @@ -88,6 +88,7 @@ struct i2c_msg {
>  #define I2C_FUNC_SMBUS_PEC		0x00000008
>  #define I2C_FUNC_NOSTART		0x00000010 /* I2C_M_NOSTART */
>  #define I2C_FUNC_SLAVE			0x00000020
> +#define I2C_FUNC_NO_CLK_STRETCH		0x00000040 /* No check for SCL low */
>  #define I2C_FUNC_SMBUS_BLOCK_PROC_CALL	0x00008000 /* SMBus 2.0 */
>  #define I2C_FUNC_SMBUS_QUICK		0x00010000
>  #define I2C_FUNC_SMBUS_READ_BYTE	0x00020000

This should be documented in Documentation/i2c/functionality too.

> -- 

Please do not include a signature separator ("-- ") in the middle of
messages, that makes replying to them more difficult.

> Why do we have to use a negative flag? Doesn't it make more sense to use a
> I2C_FUNC_CLK_STRETCH flag and add it to every device that supports it?

Two reasons:

1* Clock stretching support is a mandatory part of the I2C
specification, devices not supporting that are not compliant. It makes
sense to make this non-compliance visible.

2* Thankfully a vast majority of the ~150 i2c bus drivers in the kernel do
support clock stretching, and I'd rather add a flag to 5 drivers than
to 145.

> >> In some cases the No Hold mode is preferable, even if the clock stretching is
> >> supported and working.  
> > 
> > Got it. But something like I2C_FUNC_NO_CLK_STRETCH would let drivers
> > pick a sane default at least.  
> 
> I've looked for similar situations in the kernel code and I've found this module
> https://github.com/torvalds/linux/blob/master/Documentation/hwmon/shtc1
> The situation is identical, but here the developer used shtc1_platform_data to
> pass the parameter. This solution seems better to me (multiple instances can
> have different parameters),

Indeed. I wanted to comment on that previously but forgot. Module
parameters are theoretically inadequate for per-device settings, even
though in practice this tends to work out in most cases.

> but can a parameter in a platform_data be passed
> with a userspace instantiation?

No, it can't. You'd need a sysfs attribute, but non-standard sysfs
attributes need to be documented properly. Is that a big problem in
practice though? User-space instantiation of i2c devices was originally
meant for developers or for working around bugs, I did not expect this
interface to be heavily used (which is why it is so basic.)

-- 
Jean Delvare
SUSE L3 Support
