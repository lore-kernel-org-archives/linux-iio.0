Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49272 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751257AbeA1JkZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Jan 2018 04:40:25 -0500
Date: Sun, 28 Jan 2018 09:40:21 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Jeremy Cline <jeremy@jcline.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Lars Kellogg-Stedman <lars@oddbit.com>,
        Steven Presser <steve@pressers.name>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: bmc150: Check for a second ACPI device
 for BOSC0200
Message-ID: <20180128094021.572ab366@archlinux>
In-Reply-To: <20180114104330.2aa7c1fd@archlinux>
References: <010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com>
        <20171210182152.70ad8fbf@archlinux>
        <01000160dccefcb4-25edfd89-56f3-486f-88a4-cb8c07253974-000000@email.amazonses.com>
        <20180114104330.2aa7c1fd@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 14 Jan 2018 10:43:30 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 9 Jan 2018 21:24:01 +0000
> Jeremy Cline <jeremy@jcline.org> wrote:
> 
> > On 12/10/2017 12:21 PM, Jonathan Cameron wrote:  
> > > On Wed, 6 Dec 2017 17:52:34 +0000
> > > Jeremy Cline <jeremy@jcline.org> wrote:
> > >     
> > >> Some BOSC0200 acpi_device-s describe two accelerometers in a single ACPI
> > >> device. Check for a companion device and handle a second i2c_client
> > >> if it is present.
> > >>
> > >> Signed-off-by: Jeremy Cline <jeremy@jcline.org>    
> > > The requirement for this is still horrible, but you have done a nice
> > > clean job on implementing it.
> > > 
> > > I'll let this sit for a few more days though before applying it.
> > > Probably next weekend if we don't get any feedback before then.    
> > 
> > Hey,
> > 
> > I didn't see this land anywhere (I was looking in
> > git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git, maybe that's not
> > the right place?) and I just wanted to make sure this didn't get lost in
> > the holiday shuffle.  
> It did indeed get lost - thanks for the reminder.  Now applied to the
> togreg branch of iio.git.  However, unfortunately we may be too near
> to the merge window opening for it to make it.  Depends on what Linus
> says later today when rc8 comes out.

I've added some #ifdef CONFIG_ACPI defenses against the case
of no ACPI support being compiled in.  Alternative would be to add
stubs for those functions that don't have them...

probably just acpi_device_hid.

But that would take much longer.  Feel free to propose it and a patch
removing the ifdef fun if you like!

Jonathan

> 
> Jonathan
> 
> > 
> > Regards,
> > Jeremy
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

