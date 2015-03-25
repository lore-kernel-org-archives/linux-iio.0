Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-202.synserver.de ([212.40.185.202]:1053 "EHLO
	smtp-out-200.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751238AbbCYSI4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Mar 2015 14:08:56 -0400
Message-ID: <5512F9B7.2030101@metafoo.de>
Date: Wed, 25 Mar 2015 19:08:55 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: sathyanarayanan.kuppuswamy@linux.intel.com,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>
CC: Robert Dolca <robert.dolca@gmail.com>,
	Robert Dolca <robert.dolca@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Denis CIOCCA <denis.ciocca@st.com>
Subject: Re: [PATCH] IIO: Adds ACPI support for ST gyroscopes
References: <1427118025-4380-1-git-send-email-robert.dolca@intel.com> <551155C3.2030403@metafoo.de> <CAFPB+YdwrPoob1CPdUfSt2uBJWPi=6_0-d0NChj2agD6-z-8qw@mail.gmail.com> <551168F0.1090901@metafoo.de> <CACRpkdaOQ-onkgQJSyoVEQNtkZ9nF_4z=9jNdU-tug-TwvAAkQ@mail.gmail.com> <20150324150630.GP1878@lahna.fi.intel.com> <CACRpkdYmN5YnH5rcA13NerPKdx62TpQVi5Hwr1vchu13QUcaOw@mail.gmail.com> <20150325094327.GW1878@lahna.fi.intel.com> <20150325122505.GX1878@lahna.fi.intel.com> <20150325132116.GY1878@lahna.fi.intel.com> <5512F8EA.2040506@linux.intel.com>
In-Reply-To: <5512F8EA.2040506@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/25/2015 07:05 PM, sathyanarayanan kuppuswamy wrote:
>>   static acpi_status
>>   acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
>>                   u32 bits, u64 *value, void *handler_context,
>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> index edf274cabe81..c12a3f24ada4 100644
>> --- a/drivers/i2c/i2c-core.c
>> +++ b/drivers/i2c/i2c-core.c
>> @@ -629,8 +629,13 @@ static int i2c_device_probe(struct device *dev)
>>       if (!client)
>>           return 0;
>> -    if (!client->irq && dev->of_node) {
>> -        int irq = of_irq_get(dev->of_node, 0);
>> +    if (client->irq <= 0) {
> Isn't irq 0 a valid interrupt number ? Shouldn't it be client->irq < 0 ?

0 is a invalid interrupt number these days, and is typically used to 
indicate no IRQ.

