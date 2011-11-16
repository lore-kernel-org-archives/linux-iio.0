Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50014 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217Ab1KPRLu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Nov 2011 12:11:50 -0500
MIME-Version: 1.0
In-Reply-To: <1321434819-23678-2-git-send-email-lars@metafoo.de>
References: <1321434819-23678-1-git-send-email-lars@metafoo.de> <1321434819-23678-2-git-send-email-lars@metafoo.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 16 Nov 2011 10:11:27 -0700
Message-ID: <CACxGe6twCU9Nb+b00ei83jxaz0YnVa6nT0ra6Kp0c4PO7hjT6Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] drivercore: Generalize module_platform_driver
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>,
	Jean Delvare <khali@linux-fr.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org, spi-devel-general@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Nov 16, 2011 at 2:13 AM, Lars-Peter Clausen <lars@metafoo.de> w=
rote:
> This patch generalizes the module_platform_driver macro and introduce=
s a new
> module_driver macro. The module_driver macro takes a driver name, a r=
egister
> and a unregister function for this driver type. Using these it constr=
uct the
> module init and exit sections which register and unregister the drive=
r. Since
> such init/exit sections are commonly found in drivers this macro can =
be used
> to eliminate a lot of boilerplate code.
>
> The macro is not intended to be used by driver modules directly, inst=
ead it
> should be used to generate bus specific macros for registering driver=
s like
> the module_platform_driver macro.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0include/linux/init.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 21 +++++++++++++=
++++++++
> =A0include/linux/platform_device.h | =A0 12 ++----------
> =A02 files changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/init.h b/include/linux/init.h
> index 9146f39..3e2d238 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -346,4 +346,25 @@ void __init parse_early_options(char *cmdline);
> =A0#define __exit_p(x) NULL
> =A0#endif
>
> +/**
> + * module_driver() - Helper macro for drivers that don't do anything
> + * special in module init/exit. This eliminates a lot of boilerplate=
=2E
> + * Each module may only use this macro once, and calling it replaces
> + * module_init() and module_exit().
> + * Use this macro to construct bus specific macros for registering
> + * drivers.
> + */
> +#define module_driver(__driver, __register, __unregister) \
> +static int __init __driver##_init(void) \
> +{ \
> + =A0 =A0 =A0 return __register(&(__driver)); \
> +} \
> +module_init(__driver##_init); \
> +static void __exit __driver##_exit(void) \
> +{ \
> + =A0 =A0 =A0 __unregister(&(__driver)); \
> +} \
> +module_exit(__driver##_exit);
> +
> =A0#endif /* _LINUX_INIT_H */
> +
> diff --git a/include/linux/platform_device.h b/include/linux/platform=
_device.h
> index 2a23f7d..165a8d1 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -196,16 +196,8 @@ static inline void platform_set_drvdata(struct p=
latform_device *pdev, void *data
> =A0* calling it replaces module_init() and module_exit()
> =A0*/
> =A0#define module_platform_driver(__platform_driver) \
> -static int __init __platform_driver##_init(void) \
> -{ \
> - =A0 =A0 =A0 return platform_driver_register(&(__platform_driver)); =
\
> -} \
> -module_init(__platform_driver##_init); \
> -static void __exit __platform_driver##_exit(void) \
> -{ \
> - =A0 =A0 =A0 platform_driver_unregister(&(__platform_driver)); \
> -} \
> -module_exit(__platform_driver##_exit);
> + =A0 =A0 =A0 module_driver(__platform_driver, platform_driver_regist=
er, \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform_driver_unregis=
ter)
>
> =A0extern struct platform_device *platform_create_bundle(struct platf=
orm_driver *driver,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0int (*probe)(struct platform_device *),
> --
> 1.7.7.1
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
