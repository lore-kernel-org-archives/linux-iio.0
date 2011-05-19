Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:46655 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756684Ab1ESIkC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 19 May 2011 04:40:02 -0400
Message-ID: <4DD4D809.5060308@cam.ac.uk>
Date: Thu, 19 May 2011 09:42:49 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Guenter Roeck <guenter.roeck@ericsson.com>
CC: "fabien.marteau@armadeus.com" <fabien.marteau@armadeus.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>
Subject: Re: [PATCH 2/2] staging:iio:adc:as1351 general cleanup and conversion
 to standard functions.
References: <1305733172-18519-1-git-send-email-jic23@cam.ac.uk> <1305735420-23293-3-git-send-email-jic23@cam.ac.uk> <20110518163508.GA11675@ericsson.com>
In-Reply-To: <20110518163508.GA11675@ericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/18/11 17:35, Guenter Roeck wrote:
> On Wed, May 18, 2011 at 12:17:00PM -0400, Jonathan Cameron wrote:
>> V2: Fix the precedence issue Guenter Roeck pointed out.
>>
> Should be below ---, unless you want it in the commit log.
> 
>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> 
> Nitpick below, otherwise
> 
> Reviewed-by: Guenter Roeck <guenter.roeck@ericsson.com>
Thanks,

Fixed up as suggested.  I'll wait for Fabien's test results
before doing any more with this driver.

