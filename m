Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:50847 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932552AbdDGT15 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Apr 2017 15:27:57 -0400
Date: Fri, 7 Apr 2017 21:27:27 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Vlad Dogaru <ddvlad@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
        Aniroop Mathur <a.mathur@samsung.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IIO: bmp280-core.c: fix error in humidity calculation
Message-ID: <20170407192727.GA4205@project>
References: <20170327100646.GA8128@project>
 <2bec8c26-f33c-d331-aa97-047871b4cc57@kernel.org>
 <CACRpkdb06PcUwC_zRThLXcw=haiDzuqP-gsVjchNnSWkootT0Q@mail.gmail.com>
 <20170402172949.GA1479@project>
 <CAJCx=g=E-4i=S+a0euYa8zJd=A2+zH8DgvngQPCF5vydzs+Cww@mail.gmail.com>
 <CAJCx=gnBZ3QbqftmuMOKuPKJ5+QBUjq41MireL4_8E0PM3LXiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJCx=gnBZ3QbqftmuMOKuPKJ5+QBUjq41MireL4_8E0PM3LXiA@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Matt,

i've extracted the error condition in a small userspace application for
demonstration. Just compile and see that in this case the variable H3 is zero
but the whole term evaluates differently if treated as unsigned or signed.

The whole example including the values of the variables are taken from the real
driver.

Andreas


Now the example:

---

/*
 * humidity.c
 * this test program is just for demonstrating the difference in the
 * calculation of humidity compensation with BME280 sensor
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 */

#include <stdio.h>
#include <stdlib.h>

int main(int argn, char* argv[])
{
	int adc_humidity = 28275;
	int t_fine = 50623;
	unsigned int H1 = 75, H3 = 0;
	int H2 = 360, H4 = 324, H5 = 0, H6 = 30;
	int var;

	var = -26177;
	/* extracted errornous term with cast */
	printf("with cast:    %d\n", (((var * H6) >> 10) * (((var * (int)H3) >> 11) 
							+ (int)32768)) >> 10);
	/* extracted errornous term now without a cast */
	printf("without cast: %d\n", (((var * H6) >> 10) * (((var * H3) >> 11) 
							+ 32768)) >> 10);

	printf("\n");
	printf("t_fine: %d; humidity: %d\nH: %d; %d; %d; %d; %d; %d\n", 
			t_fine, adc_humidity, H1, H2, H3, H4, H5, H6);
	printf("\n");

	/* the whole example taken from the driver */
	/* with the cast as proposed by the documentation */
	var = ((int)t_fine) - (int)76800;
	var = ((((adc_humidity << 14) - (H4 << 20) - (H5 * var))
		+ (int)16384) >> 15) * (((((((var * H6) >> 10)
		* (((var * (int)H3) >> 11) + (int)32768)) >> 10)
		+ (int)2097152) * H2 + 8192) >> 14);
	var -= ((((var >> 15) * (var >> 15)) >> 7) * (int)H1) >> 4;

	printf("with cast:    var: %d\n", var>>12);
	printf("\n");

	/* now the same calculation without the cast */
	var = (t_fine) - 76800;
	var = ((((adc_humidity << 14) - (H4 << 20) - (H5 * var))
		+ 16384) >> 15) * (((((((var * H6) >> 10)
		* (((var * H3) >> 11) + 32768)) >> 10)
		+ 2097152) * H2 + 8192) >> 14);
	var -= ((((var >> 15) * (var >> 15)) >> 7) * H1) >> 4;

	printf("without cast: var: %d\n", var>>12);

	return 0;
}

---

Output:

with cast:    -24544
without cast: 4169760

t_fine: 50623; humidity: 28275
H: 75; 360; 0; 324; 0; 30

with cast:    var: 41671

without cast: var: 124497

---

Matt Ranostay <matt.ranostay@konsulko.com> schrieb am Thu, 06. Apr 23:13:
> On Mon, Apr 3, 2017 at 11:16 PM, Matt Ranostay
> <matt.ranostay@konsulko.com> wrote:
> > On Sun, Apr 2, 2017 at 10:29 AM, Andreas Klinger <ak@it-klinger.de> wrote:
> >> Linus Walleij <linus.walleij@linaro.org> schrieb am Sun, 02. Apr 16:56:
> >>> On Sun, Apr 2, 2017 at 11:32 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> >>> > On 27/03/17 11:06, Andreas Klinger wrote:
> >>> >> While calculating the compensation of the humidity there are negative
> >>> >> values interpreted as unsigned because of unsigned variables used.
> >>> >> These values need to be casted to signed as indicated by the documentation
> >>> >> of the sensor.
> >>> >>
> >>> >> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> >>> >
> >>> > Looks superficially right to me, but would like an Ack from Linus Walleij.
> >>>
> >>> I didn't work on these calculations, only infrastructure for the driver
> >>> but FWIW:
> >>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >>>
> >>> Matt Ranostay @Intel is the person you probably want to ACK it though,
> >>> he added the humidity calculations :)
> >>
> >> It just turned out that there must be another error in the calculation. I'll fix
> >> and test it first.
> >>
> >> When i'm done i'll send a new version of the patch.
> >>
> >
> > Ok will hold off till review till the next patchset... BTW this
> > datasheet's calculations made my eyes bleed so it is quiet likely it
> > has bugs...
> 
> Hmm the datatypes you are casting to s32 are already signed
> integers...  Interested in what you found on what the actual bug is.
> 
> >
> > Thanks,
> >
> > Matt
> >
> >> Andreas
> >>
> >>>
> >>> Yours,
> >>> Linus Walleij
> >>
> >> --
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
