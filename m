Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48635 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419Ab3ITTEl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 20 Sep 2013 15:04:41 -0400
Message-ID: <523CAA6C.5000400@kernel.org>
Date: Fri, 20 Sep 2013 21:05:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 00/15] staging:iio:hmc5843 cleanup
References: <1379619360-8150-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1379619360-8150-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/19/13 20:35, Peter Meerwald wrote:
> updated v2 patch series of the hmc5843 cleanup, addressnig comments by 
> Jonathan Cameron
> 
All fine except for the outstanding question of why you need calibscale?
> patch 1: correctly dereferencing dev, fixed suspend/resume
> patch 7: checked CALIBSCALE, output is as follows
> 
>   # cat calibscale_available 
>   0.880000 1.300000 1.900000 2.500000 4.0 4.700000 5.600000 8.100000
>   # cat in_magn_calibscale 
>   1.300000
>   # cat in_magn_scale 
>   0.000009174
>   # cat in_magn_x_raw 
>   252
>   # echo 1.900000 > in_magn_calibscale
>   # cat in_magn_scale 
>   0.000012195
Whilst we do 'allow' for any attribute to result in a change in any other,
it is nice to avoid it if possible (and it is kind of assumed
that changes to calibscale and caliboffset are for tweaking miss
calibrate hardware, not gross changes like this), hence just have
echo 0.000012195 > in_magn_scale
rather than the
1.9 to > in_magn_calibscale

>   # cat in_magn_x_raw 
>   198
>   # echo 0.88 > in_magn_calibscale
>   # cat in_magn_scale 
>   0.000007299
>   # cat in_magn_x_raw
>   318
> 
>   calibscale adjusts the measurement range and scale is used to keep Gauss
>   reading the same
>   
> patch 9: buffer is now part of hmc5843_data, using IIO core demux as suggested
> 
> remaining patches should not have changed
> 
> Peter Meerwald (15):
>   staging:iio:hmc5843: Add pointer to i2c client to data struct
>   staging:iio:hmc5843: Rewrite init function
>   staging:iio:hmc5843: Use INFO_SAMP_FREQ
>   staging:iio:hmc5843: Remove unused LSB register #defines
>   staging:iio:hmc5843: Tighten comments
>   staging:iio:hmc5843: Introduce helper functions to show/check list of
>     int pairs
>   staging:iio:hmc5843: Use CALIBSCALE instead of magn_range
>   staging:iio:hmc5843: Always read all channels values otherwise no
>     updates
>   staging:iio:hmc5843: Add trigger handling
>   staging:iio:hmc5843: Remove ability to change operating mode
>   staging:iio:hmc5843: Rename _configure() to _set_mode()
>   staging:iio:hmc5843: Reorganize _set_meas_conf()
>   staging:iio:hmc5843: Rename _set_rate() to _set_samp_freq()
>   staging:iio:hmc5843: Introduce _set_range_gain()
>   staging:iio:hmc5843: Check initialization and chip identifier
> 
>  drivers/staging/iio/magnetometer/hmc5843.c | 612 ++++++++++++++---------------
>  1 file changed, 287 insertions(+), 325 deletions(-)
> 
