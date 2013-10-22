Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH -next] staging/iio/adc: MXS_LRADC depends on INPUT
Date: Tue, 22 Oct 2013 06:51:03 +0200
Cc: Jim Davis <jim.epost@gmail.com>,
 linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 jic23@kernel.org,
 gregkh@linuxfoundation.org,
 linux-iio@vger.kernel.org
References: <CA+r1Zhjo08EEoHsWkeDDKoc8Le6eDq4fZxZaa1Jc8cfOLsLsMg@mail.gmail.com> <526603EB.3060504@infradead.org>
In-Reply-To: <526603EB.3060504@infradead.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201310220651.03499.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Randy Dunlap,

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> mxs-lradc.c uses many input_() functions so it should
> depend on INPUT to fix build errors.
> 
> drivers/built-in.o: In function `mxs_lradc_ts_unregister':
> drivers/staging/iio/adc/mxs-lradc.c:905: undefined reference to
> `input_unregister_device' drivers/staging/iio/adc/mxs-lradc.c:905:
> undefined reference to `input_unregister_device' drivers/built-in.o: In
> function `input_report_abs':
> include/linux/input.h:399: undefined reference to `input_event'
> include/linux/input.h:399: undefined reference to `input_event'
> include/linux/input.h:399: undefined reference to `input_event'
> drivers/built-in.o: In function `input_report_key':
> include/linux/input.h:389: undefined reference to `input_event'
> drivers/built-in.o: In function `input_sync':
> include/linux/input.h:414: undefined reference to `input_event'
> drivers/built-in.o:include/linux/input.h:389: more undefined references to
> `input_event' follow
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Marek Vasut <marex@denx.de>

Thanks!

Best regards,
Marek Vasut
