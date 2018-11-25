Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42449 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeKYVys (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Nov 2018 16:54:48 -0500
Date: Sun, 25 Nov 2018 16:33:50 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Stephan Gerhold <stephan@gerhold.net>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] iio: accel: kxcjk-1013: Add the "KXJ2109" ACPI HID
Message-ID: <20181125110350.GB19309@himanshu-Vostro-3559>
References: <20181124162220.8523-1-stephan@gerhold.net>
 <20181125090930.0086a021@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181125090930.0086a021@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

[Cc acpi list]

On Sun, Nov 25, 2018 at 09:09:30AM +0000, Jonathan Cameron wrote:
> On Sat, 24 Nov 2018 17:22:20 +0100
> Stephan Gerhold <stephan@gerhold.net> wrote:
> 
> > This HID is used on the ASUS MeMO Pad 7 (ME176C) tablet.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> Other than a distinct temptation to rant about formats
> of ACPI IDs (4 characters the a number), looks good.
> 
> For reference (I was waiting for a build so decided to dig
> it out ;)
> ACPI 6.2 spec. 6.5.1
> 
> "A valid ACPI ID must be of the form "NNNN####" where N is an uppercase letter or a
> digit ('0'-'9') and # is a hex digit." is the text about a manufacturer defined
> ID.

I think it is a PNP ID(KXJ) instead.

PNP ID: PNP Vendor IDs consist of 3 characters, each character 
	being an uppercase letter (A-Z).

+ four-characters(2109) as the Product Identifier.

But didn't find anything on the forum:
http://www.uefi.org/PNP_ID_List?search=KXJ

Neither "KXTJ":
http://www.uefi.org/ACPI_ID_List?search=KXTJ

Sorry for nagging about this again, but I don't really
understand the purpose of acpi spec.

And I remember your point[1]:

".. spec is governed by developers who put the tables in the BIOS
and really by the spec"

[1] https://marc.info/?l=linux-iio&m=154077000428250&w=2

> If anyone has a contact at ASUS who I can rant at do pass it on!
> 
> Applied to the togreg branch of iio.git and pushed out as
> testing for the autobuilders to play with it.
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
> > index af53a1084ee5..cc5b2beb1328 100644
> > --- a/drivers/iio/accel/kxcjk-1013.c
> > +++ b/drivers/iio/accel/kxcjk-1013.c
> > @@ -1491,6 +1491,7 @@ static const struct acpi_device_id kx_acpi_match[] = {
> >  	{"KXCJ9000", KXCJ91008},
> >  	{"KIOX000A", KXCJ91008},
> >  	{"KXTJ1009", KXTJ21009},
> > +	{"KXJ2109",  KXTJ21009},
> >  	{"SMO8500",  KXCJ91008},
> >  	{ },
> >  };
> 

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
