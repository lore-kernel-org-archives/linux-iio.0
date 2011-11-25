Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-169.synserver.de ([212.40.185.169]:1113 "EHLO
	smtp-out-169.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788Ab1KYMeW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 25 Nov 2011 07:34:22 -0500
Message-ID: <4ECF8B77.2070304@metafoo.de>
Date: Fri, 25 Nov 2011 13:35:03 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Andy Whitcroft <apw@canonical.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@suse.de>,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: iio_event_getfd -- fix ev_int build failure
References: <1322218582-4271-1-git-send-email-apw@canonical.com>
In-Reply-To: <1322218582-4271-1-git-send-email-apw@canonical.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/25/2011 11:56 AM, Andy Whitcroft wrote:
> Fix build failure in staging iio driver:
> 
> .../drivers/staging/iio/industrialio-core.c: In function 'iio_event_getfd':
> .../drivers/staging/iio/industrialio-core.c:262:32: error:
> 			'ev_int' undeclared (first use in this function)
> 
> Also convert the rest of the function to use the new variable.
> 
> Signed-off-by: Andy Whitcroft <apw@canonical.com>

Hi Andy,

I think your patch is number 6 for this bug. A fix should already be on it's
way.


Thanks,
- Lars
