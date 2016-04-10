Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43674 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbcDJMyM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2016 08:54:12 -0400
Subject: Re: [RFC PATCH v1 0/3] iio sensor mounting matrix support
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1460113510.git.gregor.boirie@parrot.com>
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Matt Ranostay <mranostay@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
	Martin Fuzzey <mfuzzey@parkeon.com>,
	Cristina Opriceana <cristina.opriceana@gmail.com>,
	Varka Bhadram <varkabhadram@gmail.com>,
	Adriana Reus <adriana.reus@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <570A4CEF.5060005@kernel.org>
Date: Sun, 10 Apr 2016 13:54:07 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1460113510.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/04/16 15:12, Gregor Boirie wrote:
> This RFC patch series follows up on Rob Herring and Jonathan Cameron comments
> about ak8975 magnetometer mounting matrix support. Thread starts here:
> http://www.spinics.net/lists/linux-iio/msg23505.html
> 
> As a recall, we want to expose a rotation matrix to indicate userspace the chip
> placement with respect to the overall hardware system. This allows an
> application to adjust coordinates sampled from a sensor chip when its position
> deviates from the main hardware system.
> Rob mentionned that the interface could be appropriate for other sensors such as
> gyro, accelero, etc... This would prevent from "ending up with a bunch of
> similar yet different interfaces".
> 
> Requirements:
> 1. delegate computation to userspace ;
> 2. floating point arithmetics support ;
> 3. per sample type matrix ;
> 4. remain compliant with legacy interface (mpu6050).
> 
> Point 1. above allows application to perform arbitrary transformations in
> addition to sensor alignment handling.
> Point 2. is required for flexible chip positioning.
> Point 3. comes from the fact that chips, such as ADIS16407, may implement
> different axis direction references for each measurement space.
> See http://www.analog.com/media/en/technical-documentation/data-sheets/ADIS16407.pdf
> 
> Firs patch attached raise several questions for which I'd like to hear your
> suggestions.
> 
> From point 3. above, we should end up with something like the following for a
> a magneto + gyro + accelero chip :
> iio:deviceX/in_anglvel_mount_matrix, applicable to all 3 gyro channels
> iio:deviceX/in_accel_mount_matrix, applicable to all 3 accelero channels
> iio:deviceX/in_magn_mount_matrix, applicable to all 3 magneto channels
> 
> Do we need to ensure proper naming consistency for sysfs attributes ? How ?
How about doing this through the ext_info element of iio_chan_spec?  That is
intended to handle this exact case.   Also, if in a convoluted way, it does
allow access to the mount matrix from client drivers within the kernel.  I
can conceive that the equivalent matrix might want to be exposed through an
input bridge driver at some point for example.  I'm slowly trying to kill off
usage of device_attributes like you add here precisely because they aren't
accessible via our inkernel interfaces.

That interface allows you to create arbitary form sysfs attributes, but using
the same concepts of shared_by_type etc as we have for info_mask elements.
> Reuse iio_chan_type_name_spec array ?
With the ext_info stuff you get this for free.
> 
> Should we limit matrix sysfs attribute instantiation to a subset of sensor
> types ? Which ones ? Or should we leave this to driver writers choice ?
Leave it up to the writer I think.  Chances are we'll end up with something
we haven't thought of in the future if we start limiting the coverage.
We can rely on documentation to make people think about it before using the
interface.
> 
> Last patch relates to mpu6050 mounting matrix evolutions : legacy attribute was
> extracted from platform_data. For sake of simplicity and as platform data
> mechanism is becoming more and more "obsolete", I implemented new mounting
> matrix API support for device-tree nodes only. Good enought ?
Good enough for now.  If anyone needs platform_data support then they can
add it.  No need for it to be your problem!

Other than the above suggestion of using ext_info the patch set looks good
to me.

Jonathan
> 
> Best regards,
> gregor.
> 
> Gregor Boirie (3):
>   iio:core: mounting matrix support
>   iio:ak8975: add mounting matrix support
>   iio:imu:mpu6050: enhance mounting matrix support
> 
>  Documentation/ABI/testing/sysfs-bus-iio            | 51 ++++++++++++++
>  .../devicetree/bindings/iio/imu/inv_mpu6050.txt    | 13 ++++
>  .../bindings/iio/magnetometer/ak8975.txt           | 10 +++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 56 +++++++++++++--
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  4 +-
>  drivers/iio/industrialio-core.c                    | 81 ++++++++++++++++++++++
>  drivers/iio/magnetometer/ak8975.c                  | 40 ++++++++++-
>  include/linux/iio/magnetometer/ak8975.h            | 16 +++++
>  include/linux/iio/sysfs.h                          | 25 +++++++
>  include/linux/platform_data/invensense_mpu6050.h   |  5 +-
>  10 files changed, 293 insertions(+), 8 deletions(-)
>  create mode 100644 include/linux/iio/magnetometer/ak8975.h
> 

