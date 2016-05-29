Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33076 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932265AbcE2PGg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 11:06:36 -0400
Subject: Re: [RFC PATCH v1 8/9] iio:st_sensors: emulate SMBus block read if
 needed
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1461056711.git.gregor.boirie@parrot.com>
 <fa302cda642b6fe11163bfa497e4ba7fd451f255.1461056711.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Denis Ciocca <denis.ciocca@st.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Giuseppe Barba <giuseppe.barba@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6ad7d1cf-d923-b788-608d-8aa8ffe7e9ac@kernel.org>
Date: Sun, 29 May 2016 16:06:28 +0100
MIME-Version: 1.0
In-Reply-To: <fa302cda642b6fe11163bfa497e4ba7fd451f255.1461056711.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/04/16 10:18, Gregor Boirie wrote:
> Use SMBus "block read" protocol only when supported by adapter.
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
Applied to the togreg branch of iio.git.

We will need to be a little careful with this if we start reading fifo
buffers in these drivers as suddenly emulation is going to read different
things.

Right now I don't believe we are using that hardware but worth keeping in mind.

Thanks,

Jonathan
> ---
>  drivers/iio/common/st_sensors/st_sensors_i2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> index 98cfee29..b43aa36 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> @@ -48,8 +48,8 @@ static int st_sensors_i2c_read_multiple_byte(
>  	if (multiread_bit)
>  		reg_addr |= ST_SENSORS_I2C_MULTIREAD;
>  
> -	return i2c_smbus_read_i2c_block_data(to_i2c_client(dev),
> -							reg_addr, len, data);
> +	return i2c_smbus_read_i2c_block_data_or_emulated(to_i2c_client(dev),
> +							 reg_addr, len, data);
>  }
>  
>  static int st_sensors_i2c_write_byte(struct st_sensor_transfer_buffer *tb,
> 

