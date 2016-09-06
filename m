Return-Path: <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 06 Sep 2016 08:46:58 +0100
From: jic23@jic23.retrosnub.co.uk
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
 <pmeerw@pmeerw.net>, Teodora Baluta <teodora.baluta@intel.com>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mxc6255 add support for the mxc6225
In-Reply-To: <f6647059-bd19-144a-9c6a-2656df0fa52a@redhat.com>
References: <20160904173532.18994-1-hdegoede@redhat.com>
 <7b90317d-363d-d690-a8ac-61fbc3a0acf8@kernel.org>
 <f6647059-bd19-144a-9c6a-2656df0fa52a@redhat.com>
Message-ID: <c5ff41ca33eb2aa51060005222852cb8@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>

On 06.09.2016 08:44, Hans de Goede wrote:
> Hi,
> 
> On 05-09-16 22:19, Jonathan Cameron wrote:
>> On 04/09/16 18:35, Hans de Goede wrote:
>>> The mxc6225 is fully compatible with the existing mxc6255 driver,
>>> add support for it.
>>> 
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> Ah well. Can't find any docs on this on via google so I'll take
>> your word for it :)
> 
> I don't have docs either, but the android driver uses the same
> registers and in the same way as the existing mxc6255 driver;
> and I've also confirmed that this works on actual hardware.
> 
> Should I put something to this extend in the commit msg next
> time ?
Info like this is always helpful. So please do.
> 
> Regards,
> 
> Hans
> 
> 
>> 
>> Applied to the togreg branch of iio.git and pushed out as testing
>> for the autobuilders to play with it.
>> 
>> Thanks,
>> 
>> Jonathan
>>> ---
>>>  drivers/iio/accel/mxc6255.c | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/drivers/iio/accel/mxc6255.c 
>>> b/drivers/iio/accel/mxc6255.c
>>> index 97ccde7..50343a7 100644
>>> --- a/drivers/iio/accel/mxc6255.c
>>> +++ b/drivers/iio/accel/mxc6255.c
>>> @@ -26,6 +26,7 @@
>>>  #define MXC6255_REG_YOUT		0x01
>>>  #define MXC6255_REG_CHIP_ID		0x08
>>> 
>>> +#define MXC6225_CHIP_ID			0xe5
>>>  #define MXC6255_CHIP_ID			0x05
>>> 
>>>  /*
>>> @@ -154,7 +155,11 @@ static int mxc6255_probe(struct i2c_client 
>>> *client,
>>>  		return ret;
>>>  	}
>>> 
>>> -	if (chip_id != MXC6255_CHIP_ID) {
>>> +	switch (chip_id) {
>>> +	case MXC6225_CHIP_ID:
>>> +	case MXC6255_CHIP_ID:
>>> +		break;
>>> +	default:
>>>  		dev_err(&client->dev, "Invalid chip id %x\n", chip_id);
>>>  		return -ENODEV;
>>>  	}
>>> @@ -171,12 +176,14 @@ static int mxc6255_probe(struct i2c_client 
>>> *client,
>>>  }
>>> 
>>>  static const struct acpi_device_id mxc6255_acpi_match[] = {
>>> +	{"MXC6225",	0},
>>>  	{"MXC6255",	0},
>>>  	{ }
>>>  };
>>>  MODULE_DEVICE_TABLE(acpi, mxc6255_acpi_match);
>>> 
>>>  static const struct i2c_device_id mxc6255_id[] = {
>>> +	{"mxc6225",	0},
>>>  	{"mxc6255",	0},
>>>  	{ }
>>>  };
>>> 
>> 
