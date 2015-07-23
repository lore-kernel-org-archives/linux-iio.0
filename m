Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53991 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247AbbGWOB3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2015 10:01:29 -0400
References: <1437590935.30706.106.camel@hadess.net>
            <20150723135953.77FEB431C5@saturn.retrosnub.co.uk>
In-Reply-To: <20150723135953.77FEB431C5@saturn.retrosnub.co.uk>
From: jic23@jic23.retrosnub.co.uk
To: jic23@jic23.retrosnub.co.uk
Cc: Bastien Nocera <hadess@hadess.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: bmc150_accel i2c-BMA250E:00: Invalid chip f8
Date: Thu, 23 Jul 2015 15:01:27 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Message-Id: <20150723140128.00DF9431C5@saturn.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

jic23@jic23.retrosnub.co.uk writes: 

> Bastien Nocera writes:  
> 
>> Hey,  
>> 
>> Running kernel 4.0.8 on a WinBook TW100 tablet, I get the error message
>> in the subject line when loading the bmc150_accel driver.  
>> 
>> The 2 items in udev about that device:
>> P: /devices/LNXSYSTM:00/LNXSYBUS:00/80860F41:04/BMA250E:00
>> E: DEVPATH=/devices/LNXSYSTM:00/LNXSYBUS:00/80860F41:04/BMA250E:00
>> E: MODALIAS=acpi:BMA250E:BMA250E:
>> E: SUBSYSTEM=acpi  
>> 
>> and:
>> P: /devices/platform/80860F41:04/i2c-12/i2c-BMA250E:00
>> E: DEVPATH=/devices/platform/80860F41:04/i2c-12/i2c-BMA250E:00
>> E: MODALIAS=acpi:BMA250E:BMA250E:
>> E: SUBSYSTEM=i2c  
>> 
>> And the DSDT for the device:
>> https://people.gnome.org/~hadess/Winbook%20TW100%20DSDT.dsl  
>> 
>> Any ideas what I should try (apart from a more recent kernel, I'm onto
>> that...)
> 
> Odd. The bma250e is documented as having an id of 0xf9 not 0xf8.
> http://ae-bst.resource.bosch.com/media/products/dokumente/bma250e/BST-BMA2 
> 50 E-DS004-05_published.pdf  
> 
> So all I can think of is that the chip is a bma222e (or something else
> with the 0xf8 chip id) or there are some bma250e's out there with
> the wrong ID...  
> 
> Someone changed a part on the device and thought no one would notice
> and hence didn't update the bios? (even if it has a totally different
> range)  
> 
> I guess if you frig the driver to load anyway we can see what value
> it is giving for g and that should give us more of a clue.  
> 
> Jonathan  
> 
Sorry, on webmail today and missed the existing follow ups! 

> 
>> 
>> Cheers
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
