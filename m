Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56527 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473Ab3KMTa2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 Nov 2013 14:30:28 -0500
Message-ID: <5283E1A0.4050309@kernel.org>
Date: Wed, 13 Nov 2013 20:31:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: trivial trigger cleanups and RFC
References: <1384292987-6250-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1384292987-6250-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/12/13 21:49, Peter Meerwald wrote:
> two trivial cleanups and a question: the behaviour of 
> iio_trigger_write_current() currently is that all strings are 
> accepted -- if the string matches a trigger's name, a new trigger
> is set for the device (given the trigger passes validation); if the
> string doesn't match a trigger's name, then the current trigger
> is unset
> 
> so arbitrary garbage can be passed and is used to unset a trigger
> (I'd have expected -EINVAL for unknown trigger names and a defined 
> value such as "" to unset) -- is this what we want?

It's ABI now so even though what you suggest is sensible, we can't really
change it.


> 
> Peter Meerwald (2):
>   iio: Minor kerneldoc fix for iio_trigger_write_current()
>   iio: Remove redundant check that new trigger is different from old
> 
>  drivers/iio/industrialio-trigger.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
