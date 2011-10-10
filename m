Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-092.synserver.de ([212.40.185.92]:1025 "EHLO
	smtp-out-092.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372Ab1JJOja (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 10 Oct 2011 10:39:30 -0400
Message-ID: <4E93039A.7010401@metafoo.de>
Date: Mon, 10 Oct 2011 16:39:22 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] staging:iio:dac Add AD5064 driver
References: <1317985694-12670-1-git-send-email-lars@metafoo.de> <4E8EEF99.2080502@cam.ac.uk> <4E8F507A.9040905@metafoo.de> <4E92AFC6.4060108@cam.ac.uk>
In-Reply-To: <4E92AFC6.4060108@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/10/2011 10:41 AM, Jonathan Cameron wrote:
> On 10/07/11 20:18, Lars-Peter Clausen wrote:
>> I wanted to use the bulk regulator API at first but decided against it, so we
>> can support the case where only some, but not all, of the channels are used and
>> some channels don't have a supply for their vref.
> That would be fair enough if you were actually supporting the ability to do that
> in the driver.  You aren't, so please use the bulk apis.
> If this is added later, then that is the time to hand roll a custom version of this.
Well, the idea was to be consistent with other DAC drivers, which simply
report a
scale value of 0 if no vref was specified. But I'll change it to use the
bulk
regulator API and let probe fail in case a vref regulator is missing.

- Lars
