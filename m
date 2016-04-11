Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:23385 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753398AbcDKVog (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 11 Apr 2016 17:44:36 -0400
Date: Mon, 11 Apr 2016 23:44:28 +0200
From: Gregor Boirie <gregor.boirie@parrot.com>
To: Rob Herring <robh@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
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
Subject: Re: [RFC PATCH v1 3/3] iio:imu:mpu6050: enhance mounting matrix
 support
Message-ID: <20160411214428.GB1997@geburah.sephiroth>
References: <cover.1460113510.git.gregor.boirie@parrot.com>
 <594bc2f45d1894c9c3308509062b991e4a5fcc7e.1460113510.git.gregor.boirie@parrot.com>
 <20160411191212.GA30801@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <20160411191212.GA30801@rob-hp-laptop>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Apr 11, 2016 at 02:12:12PM -0500, Rob Herring wrote:
> On Fri, Apr 08, 2016 at 04:12:05PM +0200, Gregor Boirie wrote:
> > Add a new rotation matrix sysfs attribute compliant with IIO core
> > mounting matrix API.
> > Matrix is retrieved from "in_anglvel_mount_matrix" and
> > "in_accel_mount_matrix" sysfs attributes. It is declared into mpu6050 DTS
> > entry as a "mount-matrix" property.
> 
> We have a common DT property, but can't have common sysfs interface?
Agreed. Original driver was structured that way. In fact, a single matrix is
enought for this sensor: AFAIK, reference frames are the same for gyro and
accelero.
I suppose that having a DTS and sysfs attribute per type of sample /
"sub-device" ensure better userspace API consistency across drivers.
Jonathan ?

> 
> BTW, sysfs interfaces also have to be documented.
Ok

> 
> > 
> > Old interface is kept for backward userspace compatibility and may be
> > retrieved from legacy platform_data mechanism only.
> > 
> > Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
> > ---
> >  .../devicetree/bindings/iio/imu/inv_mpu6050.txt    | 13 +++++
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 56 ++++++++++++++++++++--
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  4 +-
> >  include/linux/platform_data/invensense_mpu6050.h   |  5 +-
> >  4 files changed, 72 insertions(+), 6 deletions(-)
