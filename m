Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39011 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbbJZRc4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 26 Oct 2015 13:32:56 -0400
In-Reply-To: <20151026172045.GA18550@Ubuntu-D830>
References: <20151023165418.GA18718@Ubuntu-D830> <562DE019.3060807@intel.com> <20151026172045.GA18550@Ubuntu-D830>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] staging: iio: dummy: clean up the define and usage of dummy_scan_elements
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Mon, 26 Oct 2015 17:32:28 +0000
To: Alison Schofield <amsfield22@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>
CC: outreachy-kernel@googlegroups.com, jic23@kernel.org,
	linux-iio@vger.kernel.org
Message-ID: <9193A9A6-70AB-4D99-B8A9-97B570FA4B96@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 26 October 2015 17:20:46 GMT+00:00, Alison Schofield <amsfield22@gmail.com> wrote:
>On Mon, Oct 26, 2015 at 10:11:05AM +0200, Daniel Baluta wrote:
>> 
>> 
>> On 10/23/2015 07:54 PM, Alison Schofield wrote:
>> >Cleanups related to the usage of dummy_scan_elements in the
>> >iio dummy driver:
>> >- change enum names to upper case INDEX_*
>> >- use the enum for IIO_CHAN_SOFT_TIMESTAMP (rm hard coded value)
>> >- comment edited to match changes & follow preferred kernel style
>> >
>> >Signed-off-by: Alison Schofield <amsfield22@gmail.com>
>> >---
>> >  drivers/staging/iio/iio_simple_dummy.c        | 22
>++++++++++++----------
>> >  drivers/staging/iio/iio_simple_dummy.h        | 20
>+++++++++++---------
>> >  drivers/staging/iio/iio_simple_dummy_buffer.c |  9 +++++----
>> >  3 files changed, 28 insertions(+), 23 deletions(-)
>> >
>> >diff --git a/drivers/staging/iio/iio_simple_dummy.c
>b/drivers/staging/iio/iio_simple_dummy.c
>> >index 381f90f..5e19068 100644
>> >--- a/drivers/staging/iio/iio_simple_dummy.c
>> >+++ b/drivers/staging/iio/iio_simple_dummy.c
>> >@@ -1,4 +1,4 @@
>> >-/**
>> >+/*
>> This change should be in the 3rd patch.
>>
>Thanks for the eagle eyes! I see this (and the other comment I edit'd
>also.) It leads to another question. 
>
>In these dummy files, there are 27 comment blocks that start with
>/** instead of /* .  I touched 2 of them as a passerby, but now
>that I'm looking.... should I change them all or is /** that an
>acceptable
>variation.
>
>alison
>
>
>< snip >

Good thing you raised this as one instance in the patch was an incorrect 
change away from **
Basically it should have two stars if kernel-doc (formal kernel documentation)
and one star if a straightforward inline
 comment. See Documentation/kernel-doc-nano-howto.txt

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
