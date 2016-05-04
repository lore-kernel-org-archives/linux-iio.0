Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35945 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934AbcEDOkv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2016 10:40:51 -0400
Subject: Re: [PATCH v2 0/3] Introduce support for creating IIO devices via
 configfs
To: Daniel Baluta <daniel.baluta@intel.com>
References: <1461590153-22308-1-git-send-email-daniel.baluta@intel.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6640c85c-da1f-80cb-9187-ed078fd96bdb@kernel.org>
Date: Wed, 4 May 2016 11:45:14 +0100
MIME-Version: 1.0
In-Reply-To: <1461590153-22308-1-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/04/16 14:15, Daniel Baluta wrote:
> For testing purposes is nice to have a quick way of creating IIO devices.
> This patch series introduces support for creating IIO devices via configs
> (patch 1), allowing users to register "device types". For the moment we
> support "dummy" device type (patch 2).
> 
> Patch 3 introduces configfs entries documentation for easier review.

I guess that this is similar enough to the trigger stuff that already had
all the debate about interfaces that no one has any issues with this.

All applied to the togreg branch of iio.git - they'll sit there for a few
weeks anyway (in testing for most of that) so if anyone does have any issues
I can back them out.

Jonathan
> 
> Changes since v1:
> 	* dropped the RFC tag
> 	* fix coding style issues as per Jonathan suggestion
> 	* fix configfs path in Documentation as per Lars observation (patch 3)
> 	* allocate memory for indio_dev->name (patch 1)
> 	* make iio_simple_dummy depend on SW_DEVICE config option in order to avoid
> 	compilation errors reported by kbuild robot.
> 
> Daniel Baluta (3):
>   iio: Add support for creating IIO devices via configfs
>   iio: dummy: Convert IIO dummy to configfs
>   Documentation: iio: Add IIO software devices docs
> 
>  Documentation/ABI/testing/configfs-iio |  13 +++
>  drivers/iio/Kconfig                    |   8 ++
>  drivers/iio/Makefile                   |   1 +
>  drivers/iio/dummy/Kconfig              |   1 +
>  drivers/iio/dummy/iio_simple_dummy.c   | 102 +++++++-----------
>  drivers/iio/industrialio-sw-device.c   | 182 +++++++++++++++++++++++++++++++++
>  include/linux/iio/sw_device.h          |  70 +++++++++++++
>  7 files changed, 312 insertions(+), 65 deletions(-)
>  create mode 100644 drivers/iio/industrialio-sw-device.c
>  create mode 100644 include/linux/iio/sw_device.h
> 

