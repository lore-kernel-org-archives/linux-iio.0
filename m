Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40838 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbbJKL5E (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 11 Oct 2015 07:57:04 -0400
Subject: Re: [PATCH] iio:measurement specialties core: Fix endian sparse
 warnings.
To: linux-iio@vger.kernel.org
References: <1444564511-30310-1-git-send-email-jic23@kernel.org>
Cc: ludovic.tancerel@maplehightech.com, kbuild-all@01.org,
	fengguang.wu@intel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <561A4E8F.7020300@kernel.org>
Date: Sun, 11 Oct 2015 12:57:03 +0100
MIME-Version: 1.0
In-Reply-To: <1444564511-30310-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If anyone can take a quick look at this today (ideally Ludovic! but I appreciate it's a Sunday)
that would be great as this is stalling my sending pull request to Greg.

I 'might' apply it anyway on the basis it is straight forward but
nice to have a sanity check from someone!

Jonathan


On 11/10/15 12:55, Jonathan Cameron wrote:
> This patch changes various types to the appropriate endian specific
> versions.  Also introduces an additional local variable to avoid
> a single variable being used for both be and cpu endianness.
> 
> These aren't bugs as such, but clearing them up does make the code
> clearer.
> 
> Warning was:
> sparse warnings: (new ones prefixed by >>)
> 
>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:126:9: sparse: cast to restricted __be32
>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:126:9: sparse: cast to restricted __be32
>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:126:9: sparse: cast to restricted __be32
>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:126:9: sparse: cast to restricted __be32
>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:126:9: sparse: cast to restricted __be32
>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:126:9: sparse: cast to restricted __be32
>    drivers/iio/common/ms_sensors/ms_sensors_i2c.c:127:16: sparse: cast to restricted __be32
>    drivers/iio/common/ms_sensors/ms_sensors_i2c.c:127:16: sparse: cast to restricted __be32
>    drivers/iio/common/ms_sensors/ms_sensors_i2c.c:127:16: sparse: cast to restricted __be32
>    drivers/iio/common/ms_sensors/ms_sensors_i2c.c:127:16: sparse: cast to restricted __be32
>    drivers/iio/common/ms_sensors/ms_sensors_i2c.c:127:16: sparse: cast to restricted __be32
>    drivers/iio/common/ms_sensors/ms_sensors_i2c.c:127:16: sparse: cast to restricted __be32
>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:208:18: sparse: incorrect type in assignment (different base types)
>    drivers/iio/common/ms_sensors/ms_sensors_i2c.c:208:18:    expected unsigned short [unsigned] [addressable] [usertype] send_buf
>    drivers/iio/common/ms_sensors/ms_sensors_i2c.c:208:18:    got restricted __be16 [usertype] <noident>
>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:216:19: sparse: cast to restricted __be64
>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:216:19: sparse: cast to restricted __be64
>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:216:19: sparse: cast to restricted __be64
>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:216:19: sparse: cast to restricted __be64
>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:216:19: sparse: cast to restricted __be64
>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:216:19: sparse: cast to restricted __be64
>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:216:19: sparse: cast to restricted __be64
>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:216:19: sparse: cast to restricted __be64
>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:216:19: sparse: cast to restricted __be64
>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:216:19: sparse: cast to restricted __be64
>    drivers/iio/common/ms_sensors/ms_sensors_i2c.c:230:18: sparse: incorrect type in assignment (different base types)
>    drivers/iio/common/ms_sensors/ms_sensors_i2c.c:230:18:    expected unsigned short [unsigned] [addressable] [usertype] send_buf
>    drivers/iio/common/ms_sensors/ms_sensors_i2c.c:230:18:    got restricted __be16 [usertype] <noident>
>    drivers/iio/common/ms_sensors/ms_sensors_i2c.c:239:19: sparse: cast to restricted __be64
>    drivers/iio/common/ms_sensors/ms_sensors_i2c.c:239:19: sparse: cast to restricted __be64
>    drivers/iio/common/ms_sensors/ms_sensors_i2c.c:239:19: sparse: cast to restricted __be64
>    drivers/iio/common/ms_sensors/ms_sensors_i2c.c:239:19: sparse: cast to restricted __be64
>    drivers/iio/common/ms_sensors/ms_sensors_i2c.c:239:19: sparse: cast to restricted __be64
>    drivers/iio/common/ms_sensors/ms_sensors_i2c.c:239:19: sparse: cast to restricted __be64
>    drivers/iio/common/ms_sensors/ms_sensors_i2c.c:239:19: sparse: cast to restricted __be64
>    drivers/iio/common/ms_sensors/ms_sensors_i2c.c:239:19: sparse: cast to restricted __be64
>    drivers/iio/common/ms_sensors/ms_sensors_i2c.c:239:19: sparse: cast to restricted __be64
>    drivers/iio/common/ms_sensors/ms_sensors_i2c.c:239:19: sparse: cast to restricted __be64
> 
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c | 29 +++++++++++++-------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
> index 056c4f3bf497..669dc7c270f5 100644
> --- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
> +++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
> @@ -106,7 +106,7 @@ int ms_sensors_convert_and_read(void *cli, u8 conv, u8 rd,
>  				unsigned int delay, u32 *adc)
>  {
>  	int ret;
> -	u32 buf = 0;
> +        __be32 buf = 0;
>  	struct i2c_client *client = (struct i2c_client *)cli;
>  
>  	/* Trigger conversion */
> @@ -186,8 +186,9 @@ static bool ms_sensors_crc_valid(u32 value)
>  int ms_sensors_read_serial(struct i2c_client *client, u64 *sn)
>  {
>  	u8 i;
> -	u64 rcv_buf = 0;
> -	u16 send_buf;
> +	__be64 rcv_buf = 0;
> +	u64 rcv_val;
> +	__be16 send_buf;
>  	int ret;
>  
>  	struct i2c_msg msg[2] = {
> @@ -213,18 +214,18 @@ int ms_sensors_read_serial(struct i2c_client *client, u64 *sn)
>  		return ret;
>  	}
>  
> -	rcv_buf = be64_to_cpu(rcv_buf);
> -	dev_dbg(&client->dev, "Serial MSB raw : %llx\n", rcv_buf);
> +	rcv_val = be64_to_cpu(rcv_buf);
> +	dev_dbg(&client->dev, "Serial MSB raw : %llx\n", rcv_val);
>  
>  	for (i = 0; i < 64; i += 16) {
> -		if (!ms_sensors_crc_valid((rcv_buf >> i) & 0xFFFF))
> +		if (!ms_sensors_crc_valid((rcv_val >> i) & 0xFFFF))
>  			return -ENODEV;
>  	}
>  
> -	*sn = (((rcv_buf >> 32) & 0xFF000000) |
> -	       ((rcv_buf >> 24) & 0x00FF0000) |
> -	       ((rcv_buf >> 16) & 0x0000FF00) |
> -	       ((rcv_buf >> 8) & 0x000000FF)) << 16;
> +	*sn = (((rcv_val >> 32) & 0xFF000000) |
> +	       ((rcv_val >> 24) & 0x00FF0000) |
> +	       ((rcv_val >> 16) & 0x0000FF00) |
> +	       ((rcv_val >> 8) & 0x000000FF)) << 16;
>  
>  	/* Read LSB part of serial number */
>  	send_buf = cpu_to_be16(MS_SENSORS_SERIAL_READ_LSB);
> @@ -236,15 +237,15 @@ int ms_sensors_read_serial(struct i2c_client *client, u64 *sn)
>  		return ret;
>  	}
>  
> -	rcv_buf = be64_to_cpu(rcv_buf) >> 16;
> -	dev_dbg(&client->dev, "Serial MSB raw : %llx\n", rcv_buf);
> +	rcv_val = be64_to_cpu(rcv_buf) >> 16;
> +	dev_dbg(&client->dev, "Serial MSB raw : %llx\n", rcv_val);
>  
>  	for (i = 0; i < 48; i += 24) {
> -		if (!ms_sensors_crc_valid((rcv_buf >> i) & 0xFFFFFF))
> +		if (!ms_sensors_crc_valid((rcv_val >> i) & 0xFFFFFF))
>  			return -ENODEV;
>  	}
>  
> -	*sn |= (rcv_buf & 0xFFFF00) << 40 | (rcv_buf >> 32);
> +	*sn |= (rcv_val & 0xFFFF00) << 40 | (rcv_val >> 32);
>  
>  	return 0;
>  }
> 

