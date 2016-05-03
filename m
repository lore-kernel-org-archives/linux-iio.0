Return-Path: <leonard.crestez@intel.com>
Subject: Re: [RFC 0/7] iio: inv_mpu6050: Support i2c master and external
 readings
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>
References: <cover.1461953982.git.leonard.crestez@intel.com>
 <f22534df-13b5-0889-66d7-e4fb7f480f00@kernel.org>
 <20160502152328.GG6292@sirena.org.uk>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Daniel Baluta <daniel.baluta@intel.com>, Ge Gao <GGao@invensense.com>,
 Peter Rosin <peda@axentia.se>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <572889C4.40806@intel.com>
Date: Tue, 3 May 2016 14:21:40 +0300
MIME-Version: 1.0
In-Reply-To: <20160502152328.GG6292@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 05/02/2016 06:23 PM, Mark Brown wrote:
> On Sun, May 01, 2016 at 06:04:08PM +0100, Jonathan Cameron wrote:
> 
>> If you were to break these registers up into regmap fields it might solve 
>> this..  Regmap writes always go through whatever - whether they match the
>> existing state of the cache or not.  If fields are involved the write will get
>> built up from whatever field you change and whatever the cache has for other
>> elements.  I guess it only works if they volatile bits are contiguous though.
>> Maybe hand rolling it is cleaner here.
> 
>> Mark, any clever thoughts on this?
> 
> I don't have enough context here to be sure what the problem you're
> trying to solve is, sorry.
> 
This is worth explaining:

I have a device which has several registers with bits that are a mix of
"cacheable" and "volatile". For example for register SLV4_CTRL:

- Bit 7 (I2C_SLV4_EN) triggers a transaction with slave 4 when a "1" is
written. The bit is cleared when the transaction is done.
- Bits 0-4 (I2C_MST_DLY) configures the reduced access rate of I2C
slaves relative to the device sample rate. This applies to slaves 0-3 as
well.

If I2C_MST_DLY was a separate register it could be easily cached by
regmap. Because it's part of a volatile register I have to add a
private_data field caching the value and always write it when triggering
a SLV4 transfer.

Jonathan was wondering if regmap can still be used somehow instead of
custom caching.

-- 
Regards,
Leonard
