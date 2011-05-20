Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:41909
	"EHLO CH1EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S935380Ab1ETJJS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 20 May 2011 05:09:18 -0400
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Fri, 20 May 2011 10:09:10 +0100
Subject: RE: GENERIC_HARDIRQS does anyone have a platform that doesn't
 enable this?
Message-ID: <544AC56F16B56944AEC3BD4E3D5917713AAF293210@LIMKCMBX1.ad.analog.com>
References: <4DD62994.4080701@cam.ac.uk>
In-Reply-To: <4DD62994.4080701@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron wrote on 2011-05-20:
> Hi All,
>
> Just occurred to me whilst reading some other patches that technically
> we now depend on CONFIG_GENERIC_HARDIRQS
>
> Just wondering if anyone knows of a platform to build tests on that
> doesn't have this?
>
> Thanks,
>
> Jonathan

michael@mhenner-D03:~/devel/git/staging-2.6/arch$ grep -R HAVE_GENERIC_HARDIRQS */Kconfig
alpha/Kconfig:  select HAVE_GENERIC_HARDIRQS
arm/Kconfig:    select HAVE_GENERIC_HARDIRQS
avr32/Kconfig:  select HAVE_GENERIC_HARDIRQS
blackfin/Kconfig:       select HAVE_GENERIC_HARDIRQS
cris/Kconfig:   select HAVE_GENERIC_HARDIRQS
frv/Kconfig:    select HAVE_GENERIC_HARDIRQS
h8300/Kconfig:  select HAVE_GENERIC_HARDIRQS
ia64/Kconfig:   select HAVE_GENERIC_HARDIRQS
m32r/Kconfig:   select HAVE_GENERIC_HARDIRQS
m68k/Kconfig:   select HAVE_GENERIC_HARDIRQS if !MMU
microblaze/Kconfig:     select HAVE_GENERIC_HARDIRQS
mips/Kconfig:   select HAVE_GENERIC_HARDIRQS
mn10300/Kconfig:        select HAVE_GENERIC_HARDIRQS
parisc/Kconfig: select HAVE_GENERIC_HARDIRQS
powerpc/Kconfig:        select HAVE_GENERIC_HARDIRQS
score/Kconfig:       select HAVE_GENERIC_HARDIRQS
sh/Kconfig:     select HAVE_GENERIC_HARDIRQS
sparc/Kconfig:  select HAVE_GENERIC_HARDIRQS
tile/Kconfig:   select HAVE_GENERIC_HARDIRQS
unicore32/Kconfig:      select HAVE_GENERIC_HARDIRQS
x86/Kconfig:    select HAVE_GENERIC_HARDIRQS
xtensa/Kconfig: select HAVE_GENERIC_HARDIRQS


michael@mhenner-D03:~/devel/git/staging-2.6/arch$ grep -R -L HAVE_GENERIC_HARDIRQS */Kconfig
s390/Kconfig

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif



