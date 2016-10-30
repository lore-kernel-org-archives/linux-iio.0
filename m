Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41778 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbcJ3Mv7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Oct 2016 08:51:59 -0400
Subject: Re: Question about submitting patch set against
 staging/iio/light/tsl2583
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <20161026173825.GA21767@basecamp.onstation.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <391f639d-2784-7b9d-46c2-a3570aee33e8@kernel.org>
Date: Sun, 30 Oct 2016 12:51:54 +0000
MIME-Version: 1.0
In-Reply-To: <20161026173825.GA21767@basecamp.onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/10/16 18:38, Brian Masney wrote:
> Part of the tsl2583 driver cleanup that I am working on involves adding
> device tree support to that driver. Based on the isl29018 driver cleanups
> that I did, I now know that the device tree maintainers should be CCed for
> any device tree changes. What is the appropriate way to submit my patch
> set that spans two different subsystems? Should I submit my lone device
> tree patch to linux-iio and CC the device tree maintainers? Then submit
> the rest of my patch set to just the linux-iio maintainers? Or should I
> CC the device tree maintainers with my entire patch set? I'm leaning
> towards the separate approach to reduce the amount of noise to the
> device tree list.
Kind of depends on the balance of device tree to other elements in the series.
Either way create a whole series with all changes, but then add a Cc: line to the
patch description for the device tree ones.  git send-email will then pick that
up and add CCs for those patches only as it sends them.

Sometimes it's easier just to CC the whole lot.  Kernel reviewers get very
good at rapidly ignoring patch emails that aren't of interest to them!

J
> 
> Brian
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

