Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50859 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949AbbHLODG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 10:03:06 -0400
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Wolfram Sang <wsa@the-dreams.de>
CC: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: RE: [PATCH v4 1/8] i2c: core: Add support for best effort block
 read emulation
Date: Wed, 12 Aug 2015 14:01:52 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F0B0B8C@irsmsx105.ger.corp.intel.com>
References: <1438697056-2946-1-git-send-email-irina.tirdea@intel.com>
 <1438697056-2946-2-git-send-email-irina.tirdea@intel.com>
 <20150809073135.GB1526@katana>
In-Reply-To: <20150809073135.GB1526@katana>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Wolfram Sang [mailto:wsa@the-dreams.de]
> Sent: 09 August, 2015 10:32
> To: Tirdea, Irina
> Cc: Jonathan Cameron; linux-iio@vger.kernel.org; linux-i2c@vger.kernel.org; linux-kernel@vger.kernel.org; Pandruvada, Srinivas;
> Peter Meerwald
> Subject: Re: [PATCH v4 1/8] i2c: core: Add support for best effort block read emulation
> 
> On Tue, Aug 04, 2015 at 05:04:09PM +0300, Irina Tirdea wrote:
> > There are devices that need to handle block transactions
> > regardless of the capabilities exported by the adapter.
> > For performance reasons, they need to use i2c read blocks
> > if available, otherwise emulate the block transaction with word
> > or byte transactions.
> >
> > Add support for a helper function that would read a data block
> > using the best transfer available: I2C_FUNC_SMBUS_READ_I2C_BLOCK,
> > I2C_FUNC_SMBUS_READ_WORD_DATA or I2C_FUNC_SMBUS_READ_BYTE_DATA.
> >
> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> 
> We are close, but I think there is one optimization left to do.
> 
> > +/**
> > + * i2c_smbus_read_i2c_block_data_or_emulated - read block or emulate
> > + * @client: Handle to slave device
> > + * @command: Byte interpreted by slave
> > + * @length: Size of data block; SMBus allows at most 32 bytes
> 
> Please refer to I2C_SMBUS_BLOCK_MAX instead of 32. The new SMBus specs
> increased this amount to 256. (Yes, we don't support that yet.)
> 

Sure, I'll use I2C_SMBUS_BLOCK_MAX instead to be compatible with these changes.

> > + * @values: Byte array into which data will be read; big enough to hold
> > + *	the data returned by the slave.  SMBus allows at most 32 bytes.
> > + *
> > + * This executes the SMBus "block read" protocol if supported by the adapter.
> > + * If block read is not supported, it emulates it using either word or byte
> > + * read protocols depending on availability.
> > + *
> > + * The addresses of the I2C slave device that are accessed with this function
> > + * must be mapped to a linear region, so that a block read will have the same
> > + * effect as a byte read. Before using this function you must double-check
> > + * if the I2C slave does support exchanging a block transfer with a byte
> > + * transfer.
> > + */
> > +s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
> > +					      u8 command, u8 length, u8 *values)
> > +{
> > +	u8 i;
> > +	int status;
> > +
> > +	if (length > I2C_SMBUS_BLOCK_MAX)
> > +		length = I2C_SMBUS_BLOCK_MAX;
> > +
> > +	if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_I2C_BLOCK))
> > +		return i2c_smbus_read_i2c_block_data(client, command, length, values);
> > +
> > +	if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_WORD_DATA |
> > +				    I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
> > +		for (i = 0; (i + 2) <= length; i += 2) {
> > +			status = i2c_smbus_read_word_data(client, command + i);
> > +			if (status < 0)
> > +				return status;
> > +			values[i] = status & 0xff;
> > +			values[i + 1] = status >> 8;
> > +		}
> > +		if (i < length) {
> > +			status = i2c_smbus_read_byte_data(client, command + i);
> > +			if (status < 0)
> > +				return status;
> > +			values[i] = status;
> > +			i++;
> > +		}
> > +		return i;
> > +	}
> > +
> > +	if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
> > +		for (i = 0; i < length; i++) {
> > +			status = i2c_smbus_read_byte_data(client, command + i);
> > +			if (status < 0)
> > +				return status;
> > +			values[i] = status;
> > +		}
> > +		return i;
> > +	}
> 
> We have two very similar blocks for transferring READ_BYTE_DATA now.
> What about this pseudo code:
> 
> 	if (check_func(I2C_BLOCK))
> 		return i2c_smbus_read_i2c_block_data(...);
> 
> 	if (!check_func(I2C_READ_BYTE_DATA)
> 		return -EOPNOTSUPP;
> 
> 	if (check_func(I2C_READ_WORD_DATA)
> 		read_as_many_words_as_possible;
> 
> 	read_all_the_remaining_bytes;
> 

This looks better, so I will change the code following the pseudo code above.

> 
> > +	dev_err(&client->adapter->dev, "Unsupported transactions\n");
> 
> Again, if you want to keep this one, it should be the client device
> reporting the error.
> 

Sorry,  I misread your previous comment on the device reporting the error.
I thought you'd prefer the code that calls i2c_smbus_read_i2c_block_data_or_emulated
to print any error messages, but I was not sure. Anyway, I think I'll drop the error
message entirely and leave error handling to the calling code.

Thanks,
Irina

> Thanks,
> 
>    Wolfram

