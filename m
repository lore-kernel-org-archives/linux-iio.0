Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33116 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbbFBUrk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jun 2015 16:47:40 -0400
Received: by wiwd19 with SMTP id d19so31506926wiw.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2015 13:47:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <555F6D4D.5060508@kernel.org>
References: <1430148841-30947-1-git-send-email-tiberiu.a.breana@intel.com>
	<1430148841-30947-3-git-send-email-tiberiu.a.breana@intel.com>
	<554B3F05.1010600@kernel.org>
	<CAE1zot+hMJAGr8xstZJTe_Doh=C+2Veruyo+S4Or7Y3n=gdbCQ@mail.gmail.com>
	<555F6D4D.5060508@kernel.org>
Date: Tue, 2 Jun 2015 23:47:39 +0300
Message-ID: <CAE1zot+-s9rmesdKu42=DxpbfQO2a4H0RgwD2xUyN1+DTZXPhw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: light: Add threshold interrupt support for STK3310
From: Octavian Purdila <octavian.purdila@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Tiberiu Breana <tiberiu.a.breana@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, May 22, 2015 at 8:54 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On 20/05/15 10:46, Octavian Purdila wrote:
> > On Thu, May 7, 2015 at 1:31 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> >>
> >> On 27/04/15 16:34, Tiberiu Breana wrote:
> >>> Added interrupt support for proximity threshold events
> >>> to the stk3310 driver.
> >> I've not objection to the split, but also wouldn't have minded having
> >> this in the original driver split (just in case you are doing it to make
> >> reviewing easier - in this sort of thing it makes little difference!)
> >>>
> >>> Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
> >> Again, nice patch.  My only comment below is about the fact I should
> >> find out what happened to the thoughts about moving the gpio/interrupt
> >> setup code into ACPI to avoid having the same 10 lines in every driver.
> >>
> >
> > Mika send another version of the patch set and it was accepted and
> > merged into the GPIO tree:
> >
> > https://lkml.org/lkml/2015/5/6/281
> Cool.  Once that has worked it's way through yets
> have a general cleanup of the cut and paste versions we have throughout
> IIO.  Anyone want to take this on?
>

I have the patches ready and I will send them once Mika's patches
makes it into iio-dev/testing.
