Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60727 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084AbcDVT5I (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 22 Apr 2016 15:57:08 -0400
Date: Fri, 22 Apr 2016 14:57:02 -0500
From: Rob Herring <robh@kernel.org>
To: Gregor Boirie <gregor.boirie@parrot.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
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
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Peter Rosin <peda@axentia.se>,
	Leonard Crestez <leonard.crestez@intel.com>
Subject: Re: [PATCH v1 2/3] iio:ak8975: add mounting matrix support
Message-ID: <20160422195702.GA23956@rob-hp-laptop>
References: <cover.1461170293.git.gregor.boirie@parrot.com>
 <43de59ea1cc5ba93bebd721b761da4749956afa0.1461170293.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43de59ea1cc5ba93bebd721b761da4749956afa0.1461170293.git.gregor.boirie@parrot.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Apr 20, 2016 at 07:23:44PM +0200, Gregor Boirie wrote:
> Expose a rotation matrix to indicate userspace the chip orientation with
> respect to the overall hardware system.
> Matrix is retrieved from "in_mount_matrix". It is declared into ak8975 DTS
> entry as a "mount-matrix" property.
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
> ---
>  .../bindings/iio/magnetometer/ak8975.txt           | 10 +++++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/magnetometer/ak8975.c                  | 34 +++++++++++++++++++---
>  include/linux/iio/magnetometer/ak8975.h            | 16 ++++++++++
>  3 files changed, 56 insertions(+), 4 deletions(-)
>  create mode 100644 include/linux/iio/magnetometer/ak8975.h
