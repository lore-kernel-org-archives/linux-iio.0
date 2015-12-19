Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55997 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932957AbbLSQJf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 19 Dec 2015 11:09:35 -0500
Subject: Re: Correctness of acpi-als channel mask
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>,
	linux-iio@vger.kernel.org, Marek Vasut <marex@denx.de>,
	=?UTF-8?Q?Martin_Li=c5=a1ka?= <marxin.liska@gmail.com>
References: <CABFtUbQw0nH5LXf_+D5_mSBqEdAsKEbbLCmrD=VDfgosqcWq1w@mail.gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5675813D.9040808@kernel.org>
Date: Sat, 19 Dec 2015 16:09:33 +0000
MIME-Version: 1.0
In-Reply-To: <CABFtUbQw0nH5LXf_+D5_mSBqEdAsKEbbLCmrD=VDfgosqcWq1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/12/15 20:32, Gabriele Mazzotta wrote:
> Hi,
> 
> I have a question regarding the acpi-als driver.
> 
> Currently acpi-als uses IIO_CHAN_INFO_RAW to report the data coming
> from the sensor. However, as per the ACPI specification [1] (section
> 9.2.2), these values represent the ambient light illuminance expressed
> in lux. Wouldn't IIO_CHAN_INFO_PROCESSED be more appropriate in this
> case as the data are in theory pre-processed by the firmware of the
> platform?
Looks like it to me as well.  Cc'd Marek and Martin.
> 
> [1] http://www.acpi.info/DOWNLOADS/ACPIspec50.pdf
> 
> Regards,
> Gabriele
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

