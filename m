Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35221 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbbETJqV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2015 05:46:21 -0400
Received: by wgfl8 with SMTP id l8so46632912wgf.2
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2015 02:46:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <554B3F05.1010600@kernel.org>
References: <1430148841-30947-1-git-send-email-tiberiu.a.breana@intel.com>
	<1430148841-30947-3-git-send-email-tiberiu.a.breana@intel.com>
	<554B3F05.1010600@kernel.org>
Date: Wed, 20 May 2015 12:46:19 +0300
Message-ID: <CAE1zot+hMJAGr8xstZJTe_Doh=C+2Veruyo+S4Or7Y3n=gdbCQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: light: Add threshold interrupt support for STK3310
From: Octavian Purdila <octavian.purdila@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Tiberiu Breana <tiberiu.a.breana@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, May 7, 2015 at 1:31 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On 27/04/15 16:34, Tiberiu Breana wrote:
> > Added interrupt support for proximity threshold events
> > to the stk3310 driver.
> I've not objection to the split, but also wouldn't have minded having
> this in the original driver split (just in case you are doing it to make
> reviewing easier - in this sort of thing it makes little difference!)
> >
> > Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
> Again, nice patch.  My only comment below is about the fact I should
> find out what happened to the thoughts about moving the gpio/interrupt
> setup code into ACPI to avoid having the same 10 lines in every driver.
>

Mika send another version of the patch set and it was accepted and
merged into the GPIO tree:

https://lkml.org/lkml/2015/5/6/281
