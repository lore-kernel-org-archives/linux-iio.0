Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:53612 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736Ab1KOKX6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Nov 2011 05:23:58 -0500
Message-ID: <4EC23DB6.1040503@free-electrons.com>
Date: Tue, 15 Nov 2011 11:23:50 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 2/3] ARM: AT91: IIO: Add AT91 ADC driver.
References: <1321291857-26277-1-git-send-email-maxime.ripard@free-electrons.com> <1321291857-26277-3-git-send-email-maxime.ripard@free-electrons.com> <4EC188D2.5080706@kernel.org>
In-Reply-To: <4EC188D2.5080706@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/11/2011 22:32, Jonathan Cameron wrote:
> Just one more query on the IIO_CHAN_INFO_SCALE read.
> Sorry, missed this last time.  Its late so I may be going
> mad but the units seem out by 1000.

Wow, you're right. Indeed, if you multiply the value returned by
read_raw and scale, you get a value in millivolts, not micro...

> Also mysterious short as return value type in read_raw.

I will resend a new patchset with these two fixes.

Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
