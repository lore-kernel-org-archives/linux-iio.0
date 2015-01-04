Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50061 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbbADROw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Jan 2015 12:14:52 -0500
Message-ID: <54A9750A.2090306@kernel.org>
Date: Sun, 04 Jan 2015 17:14:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: todd.e.brandt@linux.intel.com, linux-iio@vger.kernel.org
CC: lee.jones@linaro.org, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 0/2] axp20x fuel gauge support
References: <20141217210732.GA10978@linux.intel.com>
In-Reply-To: <20141217210732.GA10978@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/12/14 21:07, Todd E Brandt wrote:
> Add fuel gauge support to the axp20x driver
> 
> axp20x.c (1/2): change the battery cell name to fuel_gauge
> axp20x.h (2/2): add the register defs and platform struct for fuel gauge
> 
>  drivers/mfd/axp20x.c       | 10 +++++-----
>  include/linux/mfd/axp20x.h | 43 +++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 46 insertions(+), 7 deletions(-)
>
Hi Todd,

I'm a little confused by this series.  We have an ACPI name change
(dropping the original - which I'd imagine will causes regressions?)
Also we have some header elements that look to be getting ready for
some driver support.  But no driver?

Jonathan


