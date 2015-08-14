Return-Path: <wsa@the-dreams.de>
Date: Fri, 14 Aug 2015 20:24:14 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v5 2/8] eeprom: at24: use
 i2c_smbus_read_i2c_block_data_or_emulated
Message-ID: <20150814182404.GC1822@katana>
References: <1439389900-10108-1-git-send-email-irina.tirdea@intel.com>
 <1439389900-10108-3-git-send-email-irina.tirdea@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1439389900-10108-3-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Aug 12, 2015 at 05:31:34PM +0300, Irina Tirdea wrote:
> For i2c busses that support only SMBUS extensions, the eeprom at24
> driver reads data from the device using the SMBus block, word or byte
> read protocols depending on availability.
> 
> Replace the block read emulation from the driver with the
> i2c_smbus_read_i2c_block_data_or_emulated call from i2c core.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>

Applied to for-next, thanks!
