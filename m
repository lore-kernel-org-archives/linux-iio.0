Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:62610 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756369AbcDELDU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 5 Apr 2016 07:03:20 -0400
Subject: Re: [PATCH 0/2] Add support for adc101c* and adc121c*
To: Drew Fustini <drew@beagleboard.org>
References: <cover.1459444547.git.leonard.crestez@intel.com>
 <CAPgEAj5bGwGXqgJQg1Qdu=rVsMFEGWKvUTKy7c17RjsawZN9Og@mail.gmail.com>
Cc: linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <57039B6F.6090908@intel.com>
Date: Tue, 5 Apr 2016 14:03:11 +0300
MIME-Version: 1.0
In-Reply-To: <CAPgEAj5bGwGXqgJQg1Qdu=rVsMFEGWKvUTKy7c17RjsawZN9Og@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/01/2016 07:38 PM, Drew Fustini wrote:
> On Thu, Mar 31, 2016 at 12:20 PM, Crestez Dan Leonard
> <leonard.crestez@intel.com> wrote:
>> This adds support for adc101c* and adc121c* using the ti-adc081c driver.
>
> Thanks for posting this.  I am eager to try it out on the BeagleBone
> Green for this SeeedStudio Grove I2C ADC module which uses ADC121C021:
> http://www.seeedstudio.com/wiki/Grove_-_I2C_ADC

It would be nice if somebody else confirmed that this driver used 
correctly, especially on another arch.

Please note that in order for the driver to correctly report actual 
voltage a "voltage regulator" needs to be configured somehow. These 
chips report voltage relative to I2C supply voltage (which can vary) and 
correctly calculating the input voltage requires fetching the current 
voltage from a regulator. If no regulator is available then reading 
in_voltage_raw will work but in_voltage_scale will fail.

The module you linked ensures that the chip input voltage is 3V no 
matter the i2c supply voltage. This is specific to that PCB not the 
actual ti adc chip.

The easiest way to handle this would be to create a fixed-regulator 
reporting a constant 3V in your device tree and pointing the adc's 
vref-supply to it.

Regards,
Leonard

