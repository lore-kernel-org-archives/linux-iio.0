Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60903 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031AbcDWVPS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Apr 2016 17:15:18 -0400
Subject: Re: [PATCH v1 2/3] iio:ak8975: add mounting matrix support
To: Rob Herring <robh@kernel.org>,
	Gregor Boirie <gregor.boirie@parrot.com>
References: <cover.1461170293.git.gregor.boirie@parrot.com>
 <43de59ea1cc5ba93bebd721b761da4749956afa0.1461170293.git.gregor.boirie@parrot.com>
 <20160422195702.GA23956@rob-hp-laptop>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Matt Ranostay <mranostay@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
	Martin Fuzzey <mfuzzey@parkeon.com>,
	Cristina Opriceana <cristina.opriceana@gmail.com>,
	Varka Bhadram <varkabhadram@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Peter Rosin <peda@axentia.se>,
	Leonard Crestez <leonard.crestez@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <143a4c67-de0a-6d9d-0a7d-a116e742d406@kernel.org>
Date: Sat, 23 Apr 2016 22:15:15 +0100
MIME-Version: 1.0
In-Reply-To: <20160422195702.GA23956@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/04/16 20:57, Rob Herring wrote:
> On Wed, Apr 20, 2016 at 07:23:44PM +0200, Gregor Boirie wrote:
>> Expose a rotation matrix to indicate userspace the chip orientation with
>> respect to the overall hardware system.
>> Matrix is retrieved from "in_mount_matrix". It is declared into ak8975 DTS
>> entry as a "mount-matrix" property.
>>
>> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
>> ---
>>  .../bindings/iio/magnetometer/ak8975.txt           | 10 +++++++
> 
> Acked-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git - initially pushed out as testing.
Thanks!

Jonathan
> 
>>  drivers/iio/magnetometer/ak8975.c                  | 34 +++++++++++++++++++---
>>  include/linux/iio/magnetometer/ak8975.h            | 16 ++++++++++
>>  3 files changed, 56 insertions(+), 4 deletions(-)
>>  create mode 100644 include/linux/iio/magnetometer/ak8975.h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

