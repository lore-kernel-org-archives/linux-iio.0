Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39526 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481Ab3KFR0o (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 6 Nov 2013 12:26:44 -0500
In-Reply-To: <0423FED8EB79934F939F077EAF96DBD717DB65DA@HASMSX105.ger.corp.intel.com>
References: <0423FED8EB79934F939F077EAF96DBD717DB65DA@HASMSX105.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: IIO devices flexibility
From: Jonathan Cameron <jic23@kernel.org>
Date: Wed, 06 Nov 2013 17:26:39 +0000
To: "Yuniverg, Michael" <michael.yuniverg@intel.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "Drubin, Daniel" <daniel.drubin@intel.com>,
	"Haimovich, Yoav" <yoav.haimovich@intel.com>
Message-ID: <107c4dbf-5ad0-4a33-8307-818979ebe49f@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



"Yuniverg, Michael" <michael.yuniverg@intel.com> wrote:
>Hello Jonathan, guys
>
>We are using iio now for 4 standard sensors and we are rather satisfied
>with its execution and robustness.
>Now implementing new sensors we came across a limitation - 
>
>--
>static const char * const iio_chan_type_name_spec[] = {
> [IIO_VOLTAGE] = "voltage",
> [IIO_CURRENT] = "current",
> [IIO_POWER] = "power",
> [IIO_ACCEL] = "accel",
> [IIO_ANGL_VEL] = "anglvel",
> [IIO_MAGN] = "magn",
> [IIO_LIGHT] = "illuminance",
> [IIO_INTENSITY] = "intensity",
> [IIO_PROXIMITY] = "proximity",
> [IIO_TEMP] = "temp",
> [IIO_INCLI] = "incli",
> [IIO_ROT] = "rot",
> [IIO_ANGL] = "angl",
> [IIO_TIMESTAMP] = "timestamp",
> [IIO_CAPACITANCE] = "capacitance",
> [IIO_ALTVOLTAGE] = "altvoltage",
> [IIO_CCT] = "cct",
> [IIO_PRESSURE] = "pressure",
>--
>
>To our understanding, that means these are only data channels we have.
>We need however new channels and even more - custom/generic channels
>including some proprietary info
>Does that fit your vision of IIO?

These channel types get added whenever a new device needs one.

Hence feel free to propose additions to the list above along with an example device that needs it. There are a couple more under review at the moment. One of these is particularly interesting in that it presents a quaternion which will need some additional core support.

As for proprietary info and custom/generic channels... Could you give some examples of what you have in mind?

Thanks

Jonathan
>
>Thanks, Michael
>---------------------------------------------------------------------
>Intel Israel (74) Limited
>
>This e-mail and any attachments may contain confidential material for
>the sole use of the intended recipient(s). Any review or distribution
>by others is strictly prohibited. If you are not the intended
>recipient, please contact the sender and delete all copies.

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
