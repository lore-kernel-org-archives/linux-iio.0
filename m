Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:46921 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751743Ab1LKMA4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 11 Dec 2011 07:00:56 -0500
Message-ID: <4EE49B5A.2000500@metafoo.de>
Date: Sun, 11 Dec 2011 13:00:26 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, Michael.Hennerich@analog.com
Subject: Re: [PATCH 0/2] staging:iio: trigger owner field confusion cleanup.
References: <1323531588-23293-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1323531588-23293-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/10/2011 04:39 PM, Jonathan Cameron wrote:
> This issue came to my attention whilst reviewing Maximes at91 patches.
> Anyhow, we have iio_trigger->owner and iio_trigger->ops->owner.
> 
> The first was meant to have gone away.
> A couple of drivers don't provide iio_trigger->ops causing nastiness
> to happen when the trigger get or put occurs. Not seen in the wild
> as I don't have either of the two devices in question.
> 
> Simple fix.  Add the struture where missing and get rid of the owner field
> from the iio_trigger structure.
> 
> Any comments?
> 
> Jonathan

Looks good to me.

Both patches
Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> 
> Jonathan Cameron (2):
>   staging:iio: Make sure all triggers have a trigger_ops for the owner
>     field.
>   staging:iio: iio_trigger contains defunct owner field. Remove it.
> 
>  drivers/staging/iio/adc/ad7192.c                   |    7 +++++--
>  drivers/staging/iio/adc/ad7793.c                   |    6 +++++-
>  drivers/staging/iio/trigger.h                      |    2 --
>  .../staging/iio/trigger/iio-trig-periodic-rtc.c    |    1 -
>  4 files changed, 10 insertions(+), 6 deletions(-)
> 

