Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60923 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031AbcDWVQg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Apr 2016 17:16:36 -0400
Subject: Re: [PATCH v1 3/3] iio:imu:mpu6050: enhance mounting matrix support
To: Rob Herring <robh@kernel.org>,
	Gregor Boirie <gregor.boirie@parrot.com>
References: <cover.1461170293.git.gregor.boirie@parrot.com>
 <09429500c3879ba07731ce170d0a2242a0399422.1461170293.git.gregor.boirie@parrot.com>
 <20160422200508.GA28036@rob-hp-laptop>
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
Message-ID: <34a1dcf9-ce32-17f7-30ed-4168c6be6c4f@kernel.org>
Date: Sat, 23 Apr 2016 22:16:33 +0100
MIME-Version: 1.0
In-Reply-To: <20160422200508.GA28036@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/04/16 21:05, Rob Herring wrote:
> On Wed, Apr 20, 2016 at 07:23:45PM +0200, Gregor Boirie wrote:
>> Add a new rotation matrix sysfs attribute compliant with IIO core
>> mounting matrix API.
>> Matrix is retrieved from "in_anglvel_mount_matrix" and
>> "in_accel_mount_matrix" sysfs attributes. It is declared into mpu6050 DTS
>> entry as a "mount-matrix" property.
>>
>> Old interface is kept for backward userspace compatibility and may be
>> retrieved from legacy platform_data mechanism only.
>>
>> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
>> ---
>>  Documentation/ABI/testing/sysfs-bus-iio            |  2 ++
>>  .../devicetree/bindings/iio/imu/inv_mpu6050.txt    | 13 ++++++++
>>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 36 ++++++++++++++++++++--
>>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  4 ++-
>>  include/linux/platform_data/invensense_mpu6050.h   |  5 ++-
>>  5 files changed, 55 insertions(+), 5 deletions(-)
> 
> Acked-by: Rob Herring <robh@kernel.org>
Applied, thanks,

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

