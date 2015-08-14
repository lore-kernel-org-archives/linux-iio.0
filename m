Return-Path: <wsa@the-dreams.de>
Date: Fri, 14 Aug 2015 20:23:10 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v5 1/8] i2c: core: Add support for best effort block read
 emulation
Message-ID: <20150814182305.GB1822@katana>
References: <1439389900-10108-1-git-send-email-irina.tirdea@intel.com>
 <1439389900-10108-2-git-send-email-irina.tirdea@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1439389900-10108-2-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Aug 12, 2015 at 05:31:33PM +0300, Irina Tirdea wrote:
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

This looks concise, thanks for the rework

Applied to for-next, thanks!
