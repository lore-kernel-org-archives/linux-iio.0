Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37251 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034683AbdEAABN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Apr 2017 20:01:13 -0400
Subject: Re: Fix permissions warning from check-patch for tsl2x7x
To: Quentin Swain <dudebrobro179@gmail.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        apw@canonical.com, joe@perches.com
References: <20170430231702.377-1-dudebrobro179@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <fdc792d3-1b60-bde3-e48c-9e25c3c663e8@kernel.org>
Date: Mon, 1 May 2017 01:01:09 +0100
MIME-Version: 1.0
In-Reply-To: <20170430231702.377-1-dudebrobro179@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/05/17 00:16, Quentin Swain wrote:
> Replace the use of symbolic permissions macros, S_IRUGO and S_IWUSR,
> with octal permissons to resolve errors reported by checkpatch.pl.
> checkpatch.pl still reports errors for use of decimal permissions in a
> handful of cases where the macros were replaced with the octal in
> ad9834 and ade7753. It seemed like those reports may be false positives
> since this happens for a fraction of the changes that were made in those
> files.
> 
This cover letter should have had a better title!

Doesn't matter when it comes to the patches of course, but it briefly
confused me ;)

Jonathan
> Thanks,
> Quentin
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

