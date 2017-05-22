Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:42836 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751113AbdEVGr2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 22 May 2017 02:47:28 -0400
Subject: Re: Accelometer data not changes
To: Arek Burdach <arek.burdach@gmail.com>, lorenzo.pieralisi@arm.com
References: <b9234130-1af6-738f-a174-379d441caedf@gmail.com>
 <eb2166ea-ba3a-635c-49bc-583ebc9cb4dd@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>,
        srinivas.pandruvada@intel.com, linux-iio@vger.kernel.org,
        ard.biesheuvel@linaro.org, wsa@the-dreams.de
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <18bd3103-c560-9a87-4df7-b1786ce91f8c@linux.intel.com>
Date: Mon, 22 May 2017 09:47:24 +0300
MIME-Version: 1.0
In-Reply-To: <eb2166ea-ba3a-635c-49bc-583ebc9cb4dd@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi

On 05/21/2017 07:06 PM, Arek Burdach wrote:
> Hi Lorenzo,
>
> I wanted to check if your newest fix
> 9d6408433019bfae15e2d0d5f4498c4ff70b86c0 resolved my problem but it
> looks like it breaks i2c devices on yoga 910 at all.
>
> One thing that I see in dmesg is:
> [    5.443582] i2c_designware i2c_designware.1: controller timed out
> [    5.443601] i2c_hid i2c-SYNA2B31:00: hid_descr_cmd failed
> [    6.595650] i2c_designware i2c_designware.2: controller timed out
> [    6.595673] i2c_hid i2c-ITE8186:00: hid_descr_cmd failed
>
> More details you can see in mentioned isssue.
> BTW maybe you have an idea what is the root of my problem. I've attached
> i2c_hid logs for previous version.
>
Commit 9d6408433019 ("i2c: designware: don't infer timings described by 
ACPI from clock rate") had issue with uninitialized variables that show 
up when ACPI platform doesn't provide timing parameters for the I2C but 
fortunately that was caught quickly.

Could you try does a patch from Jan Kiszka fix the issue you are seeing?

https://lkml.org/lkml/2017/5/22/24

-- 
Jarkko
