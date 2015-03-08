Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34974 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860AbbCHL1W (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Mar 2015 07:27:22 -0400
Message-ID: <54FC3211.2020501@kernel.org>
Date: Sun, 08 Mar 2015 11:27:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sebastian Reichel <sre@kernel.org>,
	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC: Lee Jones <lee.jones@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Grant Likely <grant.likely@linaro.org>,
	devicetree@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
	support.opensource@diasemi.com
Subject: Re: [PATCH v7 0/7] Add initial support for DA9150 Charger & Fuel-Gauge
 IC
References: <cover.1424267009.git.Adam.Thomson.Opensource@diasemi.com> <20150225203307.GC13695@earth>
In-Reply-To: <20150225203307.GC13695@earth>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/02/15 20:33, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Feb 18, 2015 at 02:08:19PM +0000, Adam Thomson wrote:
>> This patch set adds initial support for the Dialog DA9150 Integrated Charger &
>> Fuel-Gauge IC. The device also provides GPIO and GPADC functionality.
>>
>> In this patch set the following is provided:
>>  - MFD Core support and DT bindings documentation.
>>  - IIO GPADC support and DT bindings documentation.
>>  - Power Supply Charger support and DT bindings documentation.
>>  - Update to MAINTAINERS file to add DA9150 files to Dialog support list.
>>
>> To keep patch submission from being too large, support for GPIO and Fuel-Gauge
>> will come after initial support patches are accepted.
>>
>> This patch set is baselined against the v3.19 kernel version.
> 
> I pulled in patches 3-7 into battery-2.6.git (patch 1 was already
> applied by Lee in 4.0-rc1 and patch 2 can simply be pulled in by
> Lee).
> 
> Jonathan: I have prepared an immutable branch "da9150-charger-fuelgauge"
> based on 4.0-rc1, which contains the IIO bits, so that you can pull them
> in, too:
> 
> git://git.infradead.org/battery-2.6.git da9150-charger-fuelgauge
I'll grab these only if I get patches on top of them in this cycle. 
Things get a little fiddly otherwise with my pull requests to Greg
and I'm lazy ;)

Thanks for sorting this Sebastian.

Good to see this series all sorted out at last!

Jonathan
> 
> --Sebastian
> 

