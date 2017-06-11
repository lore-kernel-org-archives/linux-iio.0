Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751779AbdFKODm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Jun 2017 10:03:42 -0400
Date: Sun, 11 Jun 2017 15:03:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Azael Avalos <coproscefalo@gmail.com>
Cc: linux-iio@vger.kernel.org,
        "platform-driver-x86@vger.kernel.org"
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH 37/38] platform/x86: toshiba_acpi: drop assignment of
 iio_info.driver_module
Message-ID: <20170611150338.62de672b@kernel.org>
In-Reply-To: <CAGdLNWGf4+5zJUe2dREadjs92Vg_SHbANjG1kz6f4JsTGL-TPQ@mail.gmail.com>
References: <20170529155154.22580-1-jic23@kernel.org>
        <20170529155154.22580-38-jic23@kernel.org>
        <CAGdLNWGf4+5zJUe2dREadjs92Vg_SHbANjG1kz6f4JsTGL-TPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 7 Jun 2017 08:53:09 -0600
Azael Avalos <coproscefalo@gmail.com> wrote:

> Sorry for being this late, been a bit busy.
That's fine, I'm still waiting for reviews on the two core patches
at the start of the series :(  

Trying to avoid playing the maintainer game and applying loads
of my own patches without review!

Thanks,

Jonathan
> 
> 2017-05-29 9:51 GMT-06:00 Jonathan Cameron <jic23@kernel.org>:
> > This is now handled by use of a macro for device registration.  The field
> > in iio_info will be going away shortly as it is no longer used.
> >
> > Cc: Azael Avalos <coproscefalo@gmail.com>
> > Cc: <platform-driver-x86@vger.kernel.org>  
> 
> Acked-by: Azael Avalos <coproscefalo@gmail.com>
> 
> > Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> > ---
> >  drivers/platform/x86/toshiba_acpi.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> > index d0daf75cbed1..ef4301f41727 100644
> > --- a/drivers/platform/x86/toshiba_acpi.c
> > +++ b/drivers/platform/x86/toshiba_acpi.c
> > @@ -2515,7 +2515,6 @@ static const struct iio_chan_spec toshiba_iio_accel_channels[] = {
> >  };
> >
> >  static const struct iio_info toshiba_iio_accel_info = {
> > -       .driver_module = THIS_MODULE,
> >         .read_raw = &toshiba_iio_accel_read_raw,
> >  };
> >
> > --
> > 2.13.0
> >  
> 
> 
> 

