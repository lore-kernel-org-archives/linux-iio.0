Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:62783 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323Ab3BCRSq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Feb 2013 12:18:46 -0500
Date: Sun, 3 Feb 2013 09:18:52 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>
Subject: Re: [PATCH 1/4] iio: max1363: Use devm_ functions whereever possible
 to allocate resources
Message-ID: <20130203171852.GA29574@roeck-us.net>
References: <1359853180-5664-1-git-send-email-linux@roeck-us.net>
 <1359853180-5664-2-git-send-email-linux@roeck-us.net>
 <510E53B8.40803@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <510E53B8.40803@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Feb 03, 2013 at 12:10:32PM +0000, Jonathan Cameron wrote:
> On 02/03/2013 12:59 AM, Guenter Roeck wrote:
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Applied to togreg branch of iio.git.
> 
> Note I'll probably rebase the togreg branch if / when Greg has pulled
> last pull request (sent a few mins ago) so as to get a directly
> applied fix for this driver.
> 
No problem.

There is some dead code in the max1363 driver.

drivers/iio/adc/max1363.c:1492:12: warning: 'max1363_register_buffered_funcs_and_init' defined but not used [-Wunused-function]
drivers/iio/adc/max1363.c:1527:13: warning: 'max1363_buffer_cleanup' defined but not used [-Wunused-function]

I thought I had seen a note on the iio mailing list that you wanted to submit a patch for it,
but I didn't see it yet. Or maybe my memory is wrong, or you were talking about
something else.

Want me to submit a patch (assuming the fix is simply to remove the above functions) ?

Thanks,
Guenter
