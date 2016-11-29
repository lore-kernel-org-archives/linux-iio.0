Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35318 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754162AbcK2E1e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Nov 2016 23:27:34 -0500
Received: by mail-pg0-f46.google.com with SMTP id p66so64749314pga.2
        for <linux-iio@vger.kernel.org>; Mon, 28 Nov 2016 20:27:34 -0800 (PST)
Message-ID: <1480393651.3233.7.camel@canonical.com>
Subject: Re: [PATCH 2/3] iio: st_accel: Support sensor i2c probe using acpi
From: Shrirang Bagul <shrirang.bagul@canonical.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Tue, 29 Nov 2016 12:27:31 +0800
In-Reply-To: <fbc223ef-46e8-9fb2-92e7-a0d8b4cd04e3@kernel.org>
References: <20161124053345.11254-1-shrirang.bagul@canonical.com>
         <20161124053345.11254-3-shrirang.bagul@canonical.com>
         <CACRpkdazkanxGsQ6G=NrHc0duR46FLhA81BkZF4HpdxJECWHaw@mail.gmail.com>
         <fbc223ef-46e8-9fb2-92e7-a0d8b4cd04e3@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 2016-11-27 at 11:14 +0000, Jonathan Cameron wrote:
> On 24/11/16 14:26, Linus Walleij wrote:
> > On Thu, Nov 24, 2016 at 6:33 AM, Shrirang Bagul
> > <shrirang.bagul@canonical.com> wrote:
> > 
> > > Add support to probe st_accel sensors on i2c bus using ACPI. Compatible
> > > strings are not avaialable on ACPI based systems.
> > > 
> > > Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
> > 
> > (...)
> > 
> > > +#ifdef CONFIG_ACPI
> > > +static const struct acpi_device_id st_accel_acpi_match[] = {
> > > +       {"SMO8A90", LNG2DM},
> > > +       { },
> > > +};
> > 
> > Why is ACPI only supporting one out of 14 devices?
> > 
> > Surely there are some out-of-tree ACPI platforms using one
> > or more of the others?
> > 
> > Apart from that it looks nice.
> 
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.
> 
> Anyone know where the ACPI names come from? Is there some big
> list somewhere to prevent clashes?
> 
> Jonathan
I'll take a look at the HW in our lab and send patches to identify more st_accel
sensors used mostly on Dell laptops.

Shrirang
> > 
> > Yours,
> > Linus Walleij
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
