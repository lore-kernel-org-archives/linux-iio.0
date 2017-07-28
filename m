Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:59698 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752234AbdG1VoJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 28 Jul 2017 17:44:09 -0400
Subject: Re: [PATCH v1 2/2] iio: adc: ti-ads7950: Add OF device ID table
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20170726155909.14497-1-andriy.shevchenko@linux.intel.com>
 <20170726155909.14497-2-andriy.shevchenko@linux.intel.com>
From: David Lechner <david@lechnology.com>
Message-ID: <a75886ff-eb10-f346-689d-087cd72cfd6d@lechnology.com>
Date: Fri, 28 Jul 2017 15:54:17 -0500
MIME-Version: 1.0
In-Reply-To: <20170726155909.14497-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/26/2017 10:59 AM, Andy Shevchenko wrote:
> The driver doesn't have a struct of_device_id table but supported devices
> are registered via Device Trees. This is working on the assumption that a
> SPI device registered via OF will always match a legacy SPI device ID and
> that the MODALIAS reported will always be of the form spi:<device>.
> 
> There is an ACPI method to enumerate such devices via specific ACPI ID
> and use of compatible strings. It will not work for the drivers which
> have no OF match ID table present.
> 
> Besides this could change in the future so the correct approach is to
> have an OF device ID table if the devices are registered via OF.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Works for me.

Tested-by: David Lechner <david@lechnology.com>


