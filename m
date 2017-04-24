Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from david.siemens.de ([192.35.17.14]:36036 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S976472AbdDXUhL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 24 Apr 2017 16:37:11 -0400
Subject: Re: [PATCH] iio: adc: Add support for TI ADC1x8s102
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
References: <6e0f0b52-27a1-0ce5-c217-3aa941babe63@siemens.com>
 <1493064330.24567.180.camel@linux.intel.com>
 <1493064617.24567.182.camel@linux.intel.com>
Cc: linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <dfb3ca7c-1faf-7a8a-4243-e3cad118dee6@siemens.com>
Date: Mon, 24 Apr 2017 22:37:03 +0200
MIME-Version: 1.0
In-Reply-To: <1493064617.24567.182.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-04-24 22:10, Andy Shevchenko wrote:
> On Mon, 2017-04-24 at 23:05 +0300, Andy Shevchenko wrote:
>> On Mon, 2017-04-24 at 21:28 +0200, Jan Kiszka wrote:
>>> This is an upstream port of an IIO driver for the TI ADC108S102 and
>>> ADC128S102. The former can be found on the Intel Galileo Gen2 and
>>> the
>>> Siemens SIMATIC IOT2000. For those boards, ACPI-based enumeration is
>>> included.
> 
>>> +static const struct acpi_device_id adc1x8s102_acpi_ids[] = {
>>> +	{ "INT3495",  (kernel_ulong_t)&adc1x8s102_setup_int3495 },
>>> +	{ }
>>> +};
>>> +MODULE_DEVICE_TABLE(acpi, adc1x8s102_acpi_ids);
> 
> One more thing, please provide an excerpt from real DSDT that describes
> this device.

If I didn't mess things up here, this should be what the Galileo Gen2
reports:

                Device (ADC2)
                {
                    Name (_HID, "INT3495")  // _HID: Hardware ID
                    Name (_CID, "INT3495")  // _CID: Compatible ID
                    Name (RBUF, ResourceTemplate ()
                    {
                        SpiSerialBus (0x0000, PolarityLow, FourWireMode, 0x10,
                            ControllerInitiated, 0x00FE5178, ClockPolarityHigh,
                            ClockPhaseSecond, "\\_SB.PCI0.SPI0",
                            0x00, ResourceConsumer, ,
                            )
                        GpioIo (Shared, PullDefault, 0x0000, 0x0000, IoRestrictionNone,
                            "\\_SB.PCI0.GIP0.GPO_", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0008
                            }
                    })
                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        Return (RBUF)
                    }

                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (LNotEqual (PTYP, 0x08))
                        {
                            Return (Zero)
                        }

                        Return (0x0F)
                    }
                }


> 
> And just in case one question, is that DSDT carved in stone?
> 

Yes, for the existing devices: The Galieo is shipped for years with this
DSDT, the IOT2000 for about half a year.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
