Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36872 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbcDXQJI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Apr 2016 12:09:08 -0400
Subject: Re: [PATCH v3 0/2] iio: pressure: bmp280: add support for BMP180 and
 oversampling rate control
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-iio@vger.kernel.org,
	Vlad Dogaru <vlad.dogaru@intel.com>
References: <1461505931-21884-1-git-send-email-akinobu.mita@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <69f2f228-bf77-49d4-08b1-4ceda75fd050@kernel.org>
Date: Sun, 24 Apr 2016 17:09:02 +0100
MIME-Version: 1.0
In-Reply-To: <1461505931-21884-1-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/04/16 14:52, Akinobu Mita wrote:
> This series includes two patches: one that adds support for the BMP180
> chip, and the second which adds configuration for the oversampling ratio
> for both BMP180 and BMP280.
Both patches look good to me.  Will let them sit on the list until Vlad
has a chance to take another look and give an Ack / reviewed-by if he
is happy.

Thanks,

Jonathan
> 
> * v3
> - use single line comment style where possible suggested by Jonathan Cameron
> - remove double casts for calibration coefficients by using adequate data
>   types, suggested by Jonathan Cameron
> - fix oversampling register setting for bmp280, spotted by Vlad Dogaru
> 
> * v2
> - split into two patches
> - add error check for reading calibration data.
> - s/be16_to_cpu(0)/cpu_to_be16(0)/
> - default pressure oversampling ratio for bmp180 from x1 to x8
> - add kconfig dependency to not select if bmp085-i2c is enabled
> - create bmp280_chip_info includes all elements depending on the chip
> - add ACPI ids for bmp180
> 
> Akinobu Mita (2):
>   iio: pressure: bmp280: add support for BMP180
>   iio: pressure: bmp280: add ability to control oversampling rate
> 
>  drivers/iio/pressure/Kconfig  |   5 +-
>  drivers/iio/pressure/bmp280.c | 564 +++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 538 insertions(+), 31 deletions(-)
> 

