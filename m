Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtprelay0188.hostedemail.com ([216.40.44.188]:54529 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727006AbeJQCIa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Oct 2018 22:08:30 -0400
Message-ID: <928f615f2a25f821e785f2db96f90df009d2fa34.camel@perches.com>
Subject: Re: [PATCH] staging: iio: adc: Add comments to prevent checks
 corrections
From: Joe Perches <joe@perches.com>
To: Slawomir Stepien <sst@poczta.fm>,
        Gabriel Capella <gabriel@capella.pro>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        apw@canonical.com
Date: Tue, 16 Oct 2018 11:16:46 -0700
In-Reply-To: <20181016180631.GA6085@x220.localdomain>
References: <20181015212521.GA24512@mantaray>
         <20181016180631.GA6085@x220.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 2018-10-16 at 20:06 +0200, Slawomir Stepien wrote:
> On paź 15, 2018 18:25, Gabriel Capella wrote:
> > This patch adds 3 comments in 2 different files.
> > These comments warn to don't correct the checks of type:
> > "CHECK: spaces preferred around that '-'"
> > 
> > Signed-off-by: Gabriel Capella <gabriel@capella.pro>
> > ---
> >  drivers/staging/iio/adc/ad7192.c  | 1 +
> >  drivers/staging/iio/adc/ad7280a.c | 2 ++
> >  2 files changed, 3 insertions(+)
> 
> I have this simpler solution...let's focus our efforts on moving the two drivers
> out of staging. This will prevent the CHK to appear:
> 
> Cut from checkpatch.pl:
> 
> if ($realfile =~ m@^(?:drivers/net/|net/|drivers/staging/)@) {
> 	$check = 1;
> 
> Existing driver out of staging, with this "problem":
> $ ./scripts/checkpatch.pl --types SPACING --file drivers/iio/adc/ad7793.c        
> total: 0 errors, 0 warnings, 827 lines checked
> 
> drivers/iio/adc/ad7793.c has no obvious style problems and is ready for submission.
> 
> NOTE: Used message types: SPACING
> 
> In my opinion it would stop this incorrect patches. -
> 
> I have also this changes to checkpatch.pl:
> https://github.com/s-stepien/linux-1/commit/c976a31b392393fb417f2d9e2ec9639bc226ad0b
> and usage:
> https://github.com/s-stepien/linux-1/commit/1adc0428b496f44f6a931637084bb619ddd9992d
> but I'm not that sure it is the best way to go.
> 
> What do you all think?

I think the suggested form is somewhat cryptic

	/* checkpatch-<foo> */

and the new checkpatch code is somewhat balky.

It also allows only a single type to ignore per line.
