Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35406 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbcDAQi0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Apr 2016 12:38:26 -0400
Received: by mail-lf0-f68.google.com with SMTP id c62so11363501lfc.2
        for <linux-iio@vger.kernel.org>; Fri, 01 Apr 2016 09:38:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1459444547.git.leonard.crestez@intel.com>
References: <cover.1459444547.git.leonard.crestez@intel.com>
Date: Fri, 1 Apr 2016 11:38:24 -0500
Message-ID: <CAPgEAj5bGwGXqgJQg1Qdu=rVsMFEGWKvUTKy7c17RjsawZN9Og@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add support for adc101c* and adc121c*
From: Drew Fustini <drew@beagleboard.org>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Mar 31, 2016 at 12:20 PM, Crestez Dan Leonard
<leonard.crestez@intel.com> wrote:
> This adds support for adc101c* and adc121c* using the ti-adc081c driver.

Thanks for posting this.  I am eager to try it out on the BeagleBone
Green for this SeeedStudio Grove I2C ADC module which uses ADC121C021:
http://www.seeedstudio.com/wiki/Grove_-_I2C_ADC

The only kernel driver I could find previously was this ADC121C021 I2C
Battery Monitor Driver in an Android repo:
https://android.googlesource.com/kernel/bcm/+/android-bcm-tetra-3.10-lollipop-wear-release/drivers/power/adc121c021_driver.c


cheers,
drew
