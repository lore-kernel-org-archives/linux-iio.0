Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:57834 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeJMU5V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Oct 2018 16:57:21 -0400
Date: Sat, 13 Oct 2018 14:20:09 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: kxcjk1013: Add KIOX0009 ACPI Hardware-ID
Message-ID: <20181013142009.2d343d2c@archlinux>
In-Reply-To: <20181013141938.3ed08ad6@archlinux>
References: <20181012101750.29333-1-hdegoede@redhat.com>
        <20181013141938.3ed08ad6@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 13 Oct 2018 14:19:38 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 12 Oct 2018 12:17:50 +0200
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
> > Add KIOX0009 ACPI HID, this is used e.g. on the Acer One 10.
> > 
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>  
> Applied to the togreg branch of iio.git and pushed out as staging
> for the autobuilders to largely ignore.
Pushed out as 'testing' that is... oops.
> 
> Unfortunately it's missed the coming merge window so will
> have to wait for the next one.
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/accel/kxcjk-1013.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> > index af53a1084ee5..8600e4be88ad 100644
> > --- a/drivers/iio/accel/kxcjk-1013.c
> > +++ b/drivers/iio/accel/kxcjk-1013.c
> > @@ -1489,6 +1489,7 @@ static const struct acpi_device_id kx_acpi_match[] = {
> >  	{"KXCJ1013", KXCJK1013},
> >  	{"KXCJ1008", KXCJ91008},
> >  	{"KXCJ9000", KXCJ91008},
> > +	{"KIOX0009", KXTJ21009},
> >  	{"KIOX000A", KXCJ91008},
> >  	{"KXTJ1009", KXTJ21009},
> >  	{"SMO8500",  KXCJ91008},  
> 
