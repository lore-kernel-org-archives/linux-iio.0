Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0108.outbound.protection.outlook.com ([104.47.2.108]:30592
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750998AbcKOQfg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 15 Nov 2016 11:35:36 -0500
Subject: Re: [PATCH v4 0/8] IIO wrapper drivers, dpot-dac and
 envelope-detector
To: Jonathan Cameron <jic23@kernel.org>, <linux-kernel@vger.kernel.org>
References: <1478606339-31253-1-git-send-email-peda@axentia.se>
 <9d0ddee1-6f50-0fe9-2efa-a31f1e239aa6@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <1794590b-73ab-5cc8-e03e-4474b88c3472@axentia.se>
Date: Tue, 15 Nov 2016 15:03:17 +0100
MIME-Version: 1.0
In-Reply-To: <9d0ddee1-6f50-0fe9-2efa-a31f1e239aa6@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2016-11-12 18:15, Jonathan Cameron wrote:
> On 08/11/16 11:58, Peter Rosin wrote:
>> I also wonder if the "new" *_available ABI should perhaps be documented
>> for all variants directly in sysfs-bus-iio instead of doing it in a driver
>> specific maner that I did? But that can be fixed later by someone more
>> capable than me :-)
> You doubt yourself too much ;)  Some one with fewer inhibitions you mean!

Maybe so, I just find that file long and confusing. I do not have a mental
picture of what fits where...

> Anyhow, just thought I'd add that I like this series very much.
> It's a nice interesting use of the infrastructures.  Good to see people
> are getting more adventurous all the time.

Thanks for the confidence boost! And also thanks for taking care of the
bot fallout...

Cheers,
Peter

