Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3053 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933018AbbDUR03 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 21 Apr 2015 13:26:29 -0400
Message-ID: <53886.10.252.135.106.1429637160.squirrel@linux.intel.com>
In-Reply-To: <55367A8B.3050907@intel.com>
References: <1429632660-8716-1-git-send-email-daniel.baluta@intel.com>
    <1429632660-8716-3-git-send-email-daniel.baluta@intel.com>
    <50554.10.252.192.198.1429633391.squirrel@linux.intel.com>
    <55367A8B.3050907@intel.com>
Date: Tue, 21 Apr 2015 10:26:00 -0700 (PDT)
Subject: Re: [PATCH v8 2/2] iio: ltr501: Add support for ltr301 chip
From: "Kuppuswamy Sathyanarayanan"
	<sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Daniel Baluta" <daniel.baluta@intel.com>
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, jic23@kernel.org,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


>
>
> On 04/21/2015 07:23 PM, Kuppuswamy Sathyanarayanan wrote:
>> Hi Jonathan,
>>
>> Please don't push this patchset until I test it. I will let you know
>> once
>> I am done.
>>
>
> Hi Sathya,
>
> Do you use ACPI, device tree or i2c-sysfs for device discovery?
>
> In particular how do you specify client->irq?

I use ACPI for device enumartion. In ACPI, you can use use either
interrupt resource or GPIOInt resource to specificy client->irq, which is
decided based on whether INT pin is connected to direct IRQ or GPIO pin in
the board.

>
> thanks,
> Daniel.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Sathyanarayanan Kuppuswamy
