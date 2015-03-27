Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:35731 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876AbbC0WKY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2015 18:10:24 -0400
Received: by wgdm6 with SMTP id m6so113494407wgd.2
        for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2015 15:10:23 -0700 (PDT)
Date: Sat, 28 Mar 2015 01:10:18 +0300
From: Haneen <hamohammed.sa@gmail.com>
To: jic23@kernel.org, daniel.baluta@intel.com
Cc: linux-iio@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH] iio: Add ABI documentation for out_voltage scan_elements
Message-ID: <20150327221018.GA3568@haneen-vb>
References: <1426588609-24683-1-git-send-email-hamohammed.sa@gmail.com>
 <550D5D41.7070606@kernel.org>
 <551158E0.7040401@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <551158E0.7040401@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Mar 24, 2015 at 01:30:24PM +0100, Lars-Peter Clausen wrote:
> On 03/21/2015 01:00 PM, Jonathan Cameron wrote:
> >On 17/03/15 10:36, Haneen Mohammed wrote:
> >>This patch adds ABI documentation entries for out_voltageY_en,
> >>out_voltageY_type, and out_voltageY_index.
> >>At least one user for these is preset:
> >>AD8366 SPI Dual-Digital VGA.
> >>
> >>Signed-off-by: Haneen Mohammed <hamohammed.sa@gmail.com>
> >These aren't used in the mainline driver.  We don't have buffered support
> >for output channels yet.  Looking at Analog's tree I don't think they have
> >support for this driver doing buffered output either (I think they may have
> >some internal support or maybe it's just a plan on how to do it!)
> 
> We do have support for output buffers in our tree, but obviously not
> for a VGA. I think we should add the upstream documentation for
> these attributes at the same time we add the infrastructure support.
> 
> - Lars

Sorry my bad. I used the iio dummy to check that out, and I didn't
know I had to specify no buffer support through the scan_index since
the driver I checked didn't have that. I will be more carefull next
time!

Haneen
