Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48816 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784AbcEAV0R (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 1 May 2016 17:26:17 -0400
Subject: Re: [PATCH 0/3] Add available sampling frequency and scale attributes
To: Daniel Baluta <daniel.baluta@intel.com>
References: <1461930155-13871-1-git-send-email-daniel.baluta@intel.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3ebd9505-1340-23f5-664a-81d3e300230d@kernel.org>
Date: Sun, 1 May 2016 19:57:02 +0100
MIME-Version: 1.0
In-Reply-To: <1461930155-13871-1-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/04/16 12:42, Daniel Baluta wrote:
> First two patches are bugfixes related to sampling frequency and the last
> one is adding support for exporting available sampling frequency and scale.
> 
> Daniel Baluta (3):
>   iio: bmi160: Fix output data rate for accel
>   iio: bmi160: Fix ODR setting
>   imu: bmi160: Add avail frequency and scale attributes
> 
>  drivers/iio/imu/bmi160/bmi160_core.c | 43 +++++++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 8 deletions(-)
> 
*cough* Daniel, a part name might be nice in the cover letter title!

J

