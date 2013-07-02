Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:59036 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753459Ab3GBLG5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 2 Jul 2013 07:06:57 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-iio@m.gmane.org>)
	id 1UtyQ8-0006IH-3d
	for linux-iio@vger.kernel.org; Tue, 02 Jul 2013 13:06:52 +0200
Received: from 217-67-201-162.itsa.net.pl ([217.67.201.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2013 13:06:52 +0200
Received: from j.anaszewski by 217-67-201-162.itsa.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2013 13:06:52 +0200
To: linux-iio@vger.kernel.org
From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH 0/2] Fix erroneous pressure scaling for the lps331ap driver
Date: Tue, 02 Jul 2013 13:06:36 +0200
Message-ID: <51D2B43C.90701@samsung.com>
References: <1372760003-32090-1-git-send-email-j.anaszewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <1372760003-32090-1-git-send-email-j.anaszewski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Adding Denis.

On 07/02/2013 12:13 PM, Jacek Anaszewski wrote:
> This series fixes pressure scale value calculation and modifies the
> way how the temperature scale value is calculated, for clarity
> and consistency reasons. Below the detailed explanation
> for the fix is provided.
>
> Because of the IIO_VAL_INT_PLUS_NANO value returned by the
> read_raw callback for the IIO_CHAN_INFO_SCALE mask case
> the returned scale value has to be expressed in nanopascal
> units. The scale value is used then for obtaining pressure
> value in kilopascal units. Currently this value is 2441410,
> whereas it should be 24414.
>
> 1. Scaling of exemplary read_raw value:
>
> exemplary read raw result: 4067471
> buggy_scale: 0.002441410 =>  2441410 * 10^-9
> buggy_pressure: 4067471 * 0.002441410 =
> 9930.4
> According to the documentation file
> Documentation/ABI/testing/sysfs-bus-iio the scaled pressure
> value is expressed in kilopascals, so the result should
> be interpreted as 9930.4 kPa
>
> 2. Scaling of the device output value according to the data sheet
>
> In order to get the result in mbars according to the device
> data sheet the output value has to be divided by 4096 (LSB/mbar)
>
> pressure [mbar] = 4067471 / 4096 = 993.0349
>
> Given that 1 bar = 10^5 Pa the result in pascal units is
> 993.0349 * 10^-3 * 10^5 Pa = 993.0349 * 10^2 Pa = 993 hPa =>
> 99.3 kPa
>
> whereas 4067471 * 0.002441410 (the buggy_scale value) = 9930.4,
> which when considered as a result in kilopascals is not true
> according to the above reasoning.
>
> 3. Proposed fix
>
> The proposed fix introduces following constants:
>
> ST_PRESS_LSB_PER_MBAR (4096.0) - LSB/mbar
>
> ST_PRESS_KPASCAL_NANO_SCALE (100000000 / ST_PRESS_LSB_PER_MBAR) -
> actual scale factor to be returned by in_pressure_scale which after
> performing division gives the value 24414.
> in_pressure_scale returns 0.000024414 after applying nano scale.
>
> The final result in kilopascal units can be obtained as follows:
>
> in_pressure_raw * in_pressure_scale =
> = 4067471 * 24414 * 10^-9 = 4.067471 * 10^6 * 2.4414 * 10^4 * 10^-9 =
> = 9.930 * 10^1 = 99.3 kPa =>  993 hPa (same as the pressure result
> obtained in the paragraph 2.)
>
> Summarizing, the bug was in the ST_PRESS_MBAR_TO_KPASCAL macro
> which performed multiplication instead of division.
>
> The second patch applies similar operations for the temperature scale
> calculaton. Previous implementation was correct but the modification
> is made for consistency and clarity.
>
> Thanks,
> Jacek
>
> Jacek Anaszewski (2):
>    iio: lps331ap: Fix wrong in_pressure_scale output value
>    iio: lps331ap: Modify in_temp_scale calculation way
>
>   drivers/iio/pressure/st_pressure_core.c |   11 ++++++++---
>   1 files changed, 8 insertions(+), 3 deletions(-)
>


