Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33025 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932136AbaDHNMi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 8 Apr 2014 09:12:38 -0400
Subject: Re: [PATCH] iio: adc: Fix exynos_adc dependencies
From: Jean Delvare <jdelvare@suse.de>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>
In-Reply-To: <5343F2E3.2020809@metafoo.de>
References: <20140408145421.530243bf@endymion.delvare>
	 <5343F2E3.2020809@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 08 Apr 2014 15:12:35 +0200
Message-ID: <1396962755.32113.41.camel@chaos.site>
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Lars-Peter,

Le Tuesday 08 April 2014 à 15:00 +0200, Lars-Peter Clausen a écrit :
> On 04/08/2014 02:54 PM, Jean Delvare wrote:
> > --- linux-3.15-rc0.orig/drivers/iio/adc/Kconfig	2014-04-07 10:23:04.475166797 +0200
> > +++ linux-3.15-rc0/drivers/iio/adc/Kconfig	2014-04-08 14:49:16.205616632 +0200
> > @@ -107,7 +107,7 @@ config AT91_ADC
> >
> >   config EXYNOS_ADC
> >   	bool "Exynos ADC driver support"
> > -	depends on OF
> > +	depends on ARCH_EXYNOS
> 
> || COMPILE_TEST

Fair enough, I can do that. I'll send an updated patch in a minute.

-- 
Jean Delvare
SUSE L3 Support

