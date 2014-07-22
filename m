Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, kgene.kim@samsung.com, pawel.moll@arm.com, t.figa@samsung.com, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, kyungmin.park@samsung.com, linux-samsung-soc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Ben Dooks <ben-linux@fluff.org>, galak@codeaurora.org, ch.naveen@samsung.com, linux-input <linux-input@vger.kernel.org>, heiko.stuebner@bq.com
Subject: Re: [PATCH v2] iio: exynos-adc: add experimental touchscreen support
Date: Tue, 22 Jul 2014 20:33:44 +0200
Message-ID: <5072247.HRN2kuegE2@wuerfel>
In-Reply-To: <20140722180904.GB5489@core.coreip.homeip.net>
References: <5068889.1KfVx3ksNo@wuerfel> <20140722180904.GB5489@core.coreip.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-iio@vger.kernel.org>

On Tuesday 22 July 2014 11:09:04 Dmitry Torokhov wrote:
> > @@ -565,6 +722,15 @@ static int exynos_adc_probe(struct platform_device *pdev)
> >       if (info->data->init_hw)
> >               info->data->init_hw(info);
> >  
> > +     /* leave out any TS related code if unreachable */
> > +     if (IS_BUILTIN(CONFIG_INPUT) ||
> > +         (IS_MODULE(CONFIG_INPUT) && config_enabled(MODULE)))
> 
> This is ugly... We need IS_SUBSYSTEM_AVAILABLE() wrapper for this...
> 
> Anyway,
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> 

I actually have a patch to introduce IS_REACHABLE() for this purpose,
but I haven't sent it out for review yet. The main user of this would
be drivers/media, which had the correct logic earlier until someone
tried to "simplify" it by replacing it all with IS_ENABLED()...

	Arnd
