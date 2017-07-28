Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:59684 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752234AbdG1VoC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 28 Jul 2017 17:44:02 -0400
Subject: Re: [PATCH v1 1/2] iio: adc: ti-ads7951: Allow to use on ACPI
 platforms
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20170726155909.14497-1-andriy.shevchenko@linux.intel.com>
From: David Lechner <david@lechnology.com>
Message-ID: <9e1b33ff-565c-5a6a-bd42-0bf34c1bf7c7@lechnology.com>
Date: Fri, 28 Jul 2017 15:55:57 -0500
MIME-Version: 1.0
In-Reply-To: <20170726155909.14497-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/26/2017 10:59 AM, Andy Shevchenko wrote:
> ACPI enabled platforms do not have a mean of regulators. Instead we use
> hard coded voltage value for reference pin. When value is 0 (default) we
> fall back to request a regulator.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I can't test the ACPI stuff, but I made sure this doesn't break me.

Tested-By: David Lechner <david@lechnology.com>



