Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34547 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbbJZRUs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 26 Oct 2015 13:20:48 -0400
Received: by padhk11 with SMTP id hk11so194193234pad.1
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2015 10:20:47 -0700 (PDT)
Date: Mon, 26 Oct 2015 10:20:46 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: outreachy-kernel@googlegroups.com, jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging: iio: dummy: clean up the define and usage of
 dummy_scan_elements
Message-ID: <20151026172045.GA18550@Ubuntu-D830>
References: <20151023165418.GA18718@Ubuntu-D830>
 <562DE019.3060807@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <562DE019.3060807@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Oct 26, 2015 at 10:11:05AM +0200, Daniel Baluta wrote:
> 
> 
> On 10/23/2015 07:54 PM, Alison Schofield wrote:
> >Cleanups related to the usage of dummy_scan_elements in the
> >iio dummy driver:
> >- change enum names to upper case INDEX_*
> >- use the enum for IIO_CHAN_SOFT_TIMESTAMP (rm hard coded value)
> >- comment edited to match changes & follow preferred kernel style
> >
> >Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> >---
> >  drivers/staging/iio/iio_simple_dummy.c        | 22 ++++++++++++----------
> >  drivers/staging/iio/iio_simple_dummy.h        | 20 +++++++++++---------
> >  drivers/staging/iio/iio_simple_dummy_buffer.c |  9 +++++----
> >  3 files changed, 28 insertions(+), 23 deletions(-)
> >
> >diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
> >index 381f90f..5e19068 100644
> >--- a/drivers/staging/iio/iio_simple_dummy.c
> >+++ b/drivers/staging/iio/iio_simple_dummy.c
> >@@ -1,4 +1,4 @@
> >-/**
> >+/*
> This change should be in the 3rd patch.
>
Thanks for the eagle eyes! I see this (and the other comment I edit'd
also.) It leads to another question. 

In these dummy files, there are 27 comment blocks that start with
/** instead of /* .  I touched 2 of them as a passerby, but now
that I'm looking.... should I change them all or is /** that an acceptable
variation.

alison


< snip >
