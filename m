Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59216 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755763AbbGEL6f (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 5 Jul 2015 07:58:35 -0400
Message-ID: <55991BE7.6050705@kernel.org>
Date: Sun, 05 Jul 2015 12:58:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>,
	Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org
CC: linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 1/8] i2c: core: Add support for best effort block read
 emulation
References: <1435916017-12859-1-git-send-email-irina.tirdea@intel.com> <1435916017-12859-2-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1435916017-12859-2-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/07/15 10:33, Irina Tirdea wrote:
> There are devices that need to handle block transactions
> regardless of the capabilities exported by the adapter.
> For performance reasons, they need to use i2c read blocks
> if available, otherwise emulate the block transaction with word
> or byte transactions.
> 
> Add support for a helper function that would read a data block
> using the best transfer available: I2C_FUNC_SMBUS_READ_I2C_BLOCK,
> I2C_FUNC_SMBUS_READ_WORD_DATA or I2C_FUNC_SMBUS_READ_BYTE_DATA.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Looks good to me - I vaguely wondered if it would make sense to use
an endian conversion in the word case, but as we have possible odd
numbers of bytes that gets fiddly.

I wonder what devices do if you do a word read beyond their end address?
Perhaps in odd cases we should always fall back to byte reads?

> ---
>  drivers/i2c/i2c-core.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c.h    |  3 +++
>  2 files changed, 63 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 96771ea..55a3455 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -2914,6 +2914,66 @@ trace:
>  }
>  EXPORT_SYMBOL(i2c_smbus_xfer);
>  
> +/**
> + * i2c_smbus_read_i2c_block_data_or_emulated - read block or emulate
> + * @client: Handle to slave device
> + * @command: Byte interpreted by slave
> + * @length: Size of data block; SMBus allows at most 32 bytes
> + * @values: Byte array into which data will be read; big enough to hold
> + *	the data returned by the slave.  SMBus allows at most 32 bytes.
> + *
> + * This executes the SMBus "block read" protocol if supported by the adapter.
> + * If block read is not supported, it emulates it using either word or byte
> + * read protocols depending on availability.
> + *
> + * Before using this function you must double-check if the I2C slave does
> + * support exchanging a block transfer with a byte transfer.
Add something here about addressing assumptions.  You get odd devices which
will give bulk reads of addresses not mapped to a nice linear region when
you do byte reads.
> + */
> +s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
> +					      u8 command, u8 length, u8 *values)
> +{
> +	u8 i;
> +	int status;
> +
> +	if (length > I2C_SMBUS_BLOCK_MAX)
> +		length = I2C_SMBUS_BLOCK_MAX;
> +
> +	if (i2c_check_functionality(client->adapter,
> +				    I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
> +		return i2c_smbus_read_i2c_block_data(client, command,
> +						     length, values);
> +	} else if (i2c_check_functionality(client->adapter,
> +					   I2C_FUNC_SMBUS_READ_WORD_DATA)) {
> +		for (i = 0; i < length; i += 2) {
> +			status = i2c_smbus_read_word_data(client, command + i);
> +			if (status < 0)
> +				return status;
> +			values[i] = status & 0xff;
> +			if ((i + 1) < length)
> +				values[i + 1] = status >> 8;
> +		}
> +		if (i > length)
> +			return length;
> +		return i;
> +	} else if (i2c_check_functionality(client->adapter,
> +					   I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
> +		for (i = 0; i < length; i++) {
> +			status = i2c_smbus_read_byte_data(client, command + i);
> +			if (status < 0)
> +				return status;
> +			values[i] = status;
> +		}
> +		return i;
> +	}
> +
> +	dev_err(&client->adapter->dev, "Unsupported transactions: %d,%d,%d\n",
> +		I2C_SMBUS_I2C_BLOCK_DATA, I2C_SMBUS_WORD_DATA,
> +		I2C_SMBUS_BYTE_DATA);
> +
> +	return -EOPNOTSUPP;
> +}
> +EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data_or_emulated);
> +
>  #if IS_ENABLED(CONFIG_I2C_SLAVE)
>  int i2c_slave_register(struct i2c_client *client, i2c_slave_cb_t slave_cb)
>  {
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index e83a738..faf518d 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -121,6 +121,9 @@ extern s32 i2c_smbus_read_i2c_block_data(const struct i2c_client *client,
>  extern s32 i2c_smbus_write_i2c_block_data(const struct i2c_client *client,
>  					  u8 command, u8 length,
>  					  const u8 *values);
> +extern s32
> +i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
> +					  u8 command, u8 length, u8 *values);
>  #endif /* I2C */
>  
>  /**
> 

