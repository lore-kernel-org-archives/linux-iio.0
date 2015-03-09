Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44897 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434AbbCIRCh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2015 13:02:37 -0400
Message-ID: <54FDD227.6020605@kernel.org>
Date: Mon, 09 Mar 2015 17:02:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Wolfram Sang <wsa@the-dreams.de>
CC: =?UTF-8?B?Vmlhbm5leSBsZSBDbMOpbWVudCBkZSBTYWludC1NYXJjcQ==?=
	<vianney.leclement@essensium.com>, linux-iio@vger.kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: Re: [PATCH 5/7] iio: mlx90614: Allow tuning EEPROM configuration
References: <1424879712-28304-1-git-send-email-vianney.leclement@essensium.com> <1424879712-28304-6-git-send-email-vianney.leclement@essensium.com> <54FDBDCC.50204@kernel.org> <54FDBF2A.6010402@kernel.org> <20150309164536.GB2320@katana>
In-Reply-To: <20150309164536.GB2320@katana>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/03/15 16:45, Wolfram Sang wrote:
> On Mon, Mar 09, 2015 at 03:41:30PM +0000, Jonathan Cameron wrote:
>> On 09/03/15 15:35, Jonathan Cameron wrote:
>>> On 25/02/15 15:55, Vianney le Clément de Saint-Marcq wrote:
>>>> Add device attributes for getting/setting emissivity, IIR, and FIR
>>>> coefficients, and getting the gain (which should not be modified in
>>>> order to keep factory calibration).
>>>>
>>>> The attributes provide raw values whose meaning is described in the
>>>> datasheet [1].
>>>>
>>>> Writing to EEPROM requires an explicit erase by writing zero.  In
>>>> addition, it takes 20ms for the erase/write to complete.  During this
>>>> time no EEPROM register should be accessed.  Therefore, two msleep()s
>>>> are added to the write function and a mutex protects against concurrent
>>>> access.
>>>>
>>>> Since it is not expected to be updated frequently, the configuration
>>>> register is read before modifying it rather than caching it.
>>>>
>>>> [1] http://melexis.com/Assets/IR-sensor-thermometer-MLX90614-Datasheet-5152.aspx
>>>>
>>>> Signed-off-by: Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
>>>> Cc: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>
>>> Wolfram, bit of odd i2c usage inline I'd like you to take quick look at.
> 
> What do you mean? The direct calls to i2c_smbus_xfer? Was there any
> reason given to use it directly?
Apparently the returned PEC is present but wrong.  However it requires
a correct PEC to be transmitted to it.  Genious
> 
>> Sorry, this would work better if I cleared Wolfram's old email addresses out of
>> my address book at somepoint!
> 
> How about: right now? ;)
Did so earlier - was hiding in several different places.
> 
>>
>>>> ---
>>>>  drivers/iio/temperature/mlx90614.c | 164 ++++++++++++++++++++++++++++++++++++-
>>>>  1 file changed, 163 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
>>>> index 0b36746..ab98fb6 100644
>>>> --- a/drivers/iio/temperature/mlx90614.c
>>>> +++ b/drivers/iio/temperature/mlx90614.c
>>>> @@ -12,14 +12,16 @@
>>>>   *
>>>>   * (7-bit I2C slave address 0x5a, 100KHz bus speed only!)
>>>>   *
>>>> - * TODO: sleep mode, configuration EEPROM
>>>> + * TODO: sleep mode
>>>>   */
>>>>  
>>>>  #include <linux/err.h>
>>>>  #include <linux/i2c.h>
>>>>  #include <linux/module.h>
>>>> +#include <linux/delay.h>
>>>>  
>>>>  #include <linux/iio/iio.h>
>>>> +#include <linux/iio/sysfs.h>
>>>>  
>>>>  #define MLX90614_OP_RAM		0x00
>>>>  #define MLX90614_OP_EEPROM	0x20
>>>> @@ -53,8 +55,47 @@
>>>>  
>>>>  struct mlx90614_data {
>>>>  	struct i2c_client *client;
>>>> +	struct mutex lock; /* for EEPROM access only */
>>>>  };
>>>>  
>>>> +/*
>>>> + * Erase an address and write word.
>>>> + * The mutex must be locked before calling.
>>>> + */
>>>> +static s32 mlx90614_write_word(const struct i2c_client *client, u8 command,
>>>> +			       u16 value)
>>>> +{
>>>> +	/*
>>>> +	 * Note: The mlx90614 requires a PEC on writing but does not send us a
>>>> +	 * valid PEC on reading.  Hence, we cannot set I2C_CLIENT_PEC in
>>>> +	 * i2c_client.flags.  As a workaround, we use i2c_smbus_xfer here.
>>>> +	 */
>>> That's particularly hideous and someone should shout at whoever implemented that!
>>> Ah well, such is life.  I want a go ahead on doing this from Wolfram however.
>>> It's the sort of thing that might well get randomly broken in the future.
>>> Alternative is to add another flag that indicates to the i2c core that the PEC
>>> that comes back will be wrong.
>>>  
>>>> +	union i2c_smbus_data data;
>>>> +	s32 ret;
>>>> +
>>>> +	dev_dbg(&client->dev, "Writing 0x%x to address 0x%x", value, command);
>>>> +
>>>> +	data.word = 0x0000; /* erase command */
>>>> +	ret = i2c_smbus_xfer(client->adapter, client->addr,
>>>> +			     client->flags | I2C_CLIENT_PEC,
>>>> +			     I2C_SMBUS_WRITE, command,
>>>> +			     I2C_SMBUS_WORD_DATA, &data);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	msleep(MLX90614_TIMING_EEPROM);
>>>> +
>>>> +	data.word = value; /* actual write */
>>>> +	ret = i2c_smbus_xfer(client->adapter, client->addr,
>>>> +			     client->flags | I2C_CLIENT_PEC,
>>>> +			     I2C_SMBUS_WRITE, command,
>>>> +			     I2C_SMBUS_WORD_DATA, &data);
>>>> +
>>>> +	msleep(MLX90614_TIMING_EEPROM);
>>>> +
>>>> +	return ret;
>>>> +}

