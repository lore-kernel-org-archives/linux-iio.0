Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46988 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbbHOM4q (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Aug 2015 08:56:46 -0400
Subject: Re: [PATCH v5 2/8] eeprom: at24: use
 i2c_smbus_read_i2c_block_data_or_emulated
To: Wolfram Sang <wsa@the-dreams.de>,
	Irina Tirdea <irina.tirdea@intel.com>
References: <1439389900-10108-1-git-send-email-irina.tirdea@intel.com>
 <1439389900-10108-3-git-send-email-irina.tirdea@intel.com>
 <20150814182404.GC1822@katana>
Cc: linux-iio@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55CF370A.2020006@kernel.org>
Date: Sat, 15 Aug 2015 13:56:42 +0100
MIME-Version: 1.0
In-Reply-To: <20150814182404.GC1822@katana>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/08/15 19:24, Wolfram Sang wrote:
> On Wed, Aug 12, 2015 at 05:31:34PM +0300, Irina Tirdea wrote:
>> For i2c busses that support only SMBUS extensions, the eeprom at24
>> driver reads data from the device using the SMBus block, word or byte
>> read protocols depending on availability.
>>
>> Replace the block read emulation from the driver with the
>> i2c_smbus_read_i2c_block_data_or_emulated call from i2c core.
>>
>> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> 
> Applied to for-next, thanks!
Cool.  These will presumably make it in during the coming
merge window.  I'll pick up the IIO ones next cycle
(IIO merge is probably now closed anyway as Linus is talking about
merge window opening next week I think).

Good work Irina,

Jonathan
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

