Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:38640 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935479Ab1ETJik (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 20 May 2011 05:38:40 -0400
Message-ID: <4DD63749.9030202@cam.ac.uk>
Date: Fri, 20 May 2011 10:41:29 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: GENERIC_HARDIRQS does anyone have a platform that doesn't enable
 this?
References: <4DD62994.4080701@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D5917713AAF293210@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917713AAF293210@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/20/11 10:09, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2011-05-20:
>> Hi All,
>>
>> Just occurred to me whilst reading some other patches that technically
>> we now depend on CONFIG_GENERIC_HARDIRQS
>>
>> Just wondering if anyone knows of a platform to build tests on that
>> doesn't have this?
>>
>> Thanks,
>>
>> Jonathan
> 
> michael@mhenner-D03:~/devel/git/staging-2.6/arch$ grep -R HAVE_GENERIC_HARDIRQS */Kconfig
> alpha/Kconfig:  select HAVE_GENERIC_HARDIRQS
> arm/Kconfig:    select HAVE_GENERIC_HARDIRQS
> avr32/Kconfig:  select HAVE_GENERIC_HARDIRQS
> blackfin/Kconfig:       select HAVE_GENERIC_HARDIRQS
> cris/Kconfig:   select HAVE_GENERIC_HARDIRQS
> frv/Kconfig:    select HAVE_GENERIC_HARDIRQS
> h8300/Kconfig:  select HAVE_GENERIC_HARDIRQS
> ia64/Kconfig:   select HAVE_GENERIC_HARDIRQS
> m32r/Kconfig:   select HAVE_GENERIC_HARDIRQS
> m68k/Kconfig:   select HAVE_GENERIC_HARDIRQS if !MMU
> microblaze/Kconfig:     select HAVE_GENERIC_HARDIRQS
> mips/Kconfig:   select HAVE_GENERIC_HARDIRQS
> mn10300/Kconfig:        select HAVE_GENERIC_HARDIRQS
> parisc/Kconfig: select HAVE_GENERIC_HARDIRQS
> powerpc/Kconfig:        select HAVE_GENERIC_HARDIRQS
> score/Kconfig:       select HAVE_GENERIC_HARDIRQS
> sh/Kconfig:     select HAVE_GENERIC_HARDIRQS
> sparc/Kconfig:  select HAVE_GENERIC_HARDIRQS
> tile/Kconfig:   select HAVE_GENERIC_HARDIRQS
> unicore32/Kconfig:      select HAVE_GENERIC_HARDIRQS
> x86/Kconfig:    select HAVE_GENERIC_HARDIRQS
> xtensa/Kconfig: select HAVE_GENERIC_HARDIRQS
> 
> 
> michael@mhenner-D03:~/devel/git/staging-2.6/arch$ grep -R -L HAVE_GENERIC_HARDIRQS */Kconfig
> s390/Kconfig
Good point...  An s390 is blocked anyway in the Kconfig file so we are fine.

Thanks,
