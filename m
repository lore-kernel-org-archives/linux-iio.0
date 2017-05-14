Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46926 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751580AbdENP3f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 May 2017 11:29:35 -0400
Subject: Re: [PATCH v2 3/3] staging: iio: meter: Replace symbolic permissions
 with octal permissions.
To: Harinath Nampally <harinath922@gmail.com>, lars@metafoo.de
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20170509074617.x6bdqs7innxhrude@mwanda>
 <cover.1494370925.git.harinath922@gmail.com>
 <5f6a26eefe013534d892c98f3d502fb985fd4629.1494370925.git.harinath922@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <326ada08-efba-5330-f9af-e23693839b6c@kernel.org>
Date: Sun, 14 May 2017 16:29:33 +0100
MIME-Version: 1.0
In-Reply-To: <5f6a26eefe013534d892c98f3d502fb985fd4629.1494370925.git.harinath922@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/05/17 00:41, Harinath Nampally wrote:
> This patch fixes below kind of warnings:
> WARNING: Symbolic permissions 'S_IXXX | S_IXXX' are not preferred.
> 
> Below errors are false positives:
> ade7753.c:382: ERROR: Use 4 digit octal (0777) not decimal permissions
> ade7753.c:386: ERROR: Use 4 digit octal (0777) not decimal permissions
> 
> Signed-off-by: Harinath Nampally <harinath922@gmail.com>
I've already taken a patch for this.

For IIO patches (including for drivers in staging) please also
check the iio.git tree and in particularly base the on the togreg branch
of that unless you know something you need is in the testing branch
(usually more recent) in which case use that.  This stuff all gets
batched up every few weeks and sent as a pull request to Greg.
Right now we have just ended a merge window so it's the longest gap
that typically occurs in these going to Greg.

Thanks,

Jonathan
> ---
> Changes in v2:
>   - None because only [PATCH v2 1/3] has improvement
> 
>   drivers/staging/iio/meter/ade7753.c | 46 ++++++++++++++++++-------------------
>   1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
> index 5d45a68..2534bd0 100644
> --- a/drivers/staging/iio/meter/ade7753.c
> +++ b/drivers/staging/iio/meter/ade7753.c
> @@ -298,92 +298,92 @@ static IIO_DEV_ATTR_AENERGY(ade7753_read_24bit, ADE7753_AENERGY);
>   static IIO_DEV_ATTR_LAENERGY(ade7753_read_24bit, ADE7753_LAENERGY);
>   static IIO_DEV_ATTR_VAENERGY(ade7753_read_24bit, ADE7753_VAENERGY);
>   static IIO_DEV_ATTR_LVAENERGY(ade7753_read_24bit, ADE7753_LVAENERGY);
> -static IIO_DEV_ATTR_CFDEN(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_CFDEN(0644,
>   		ade7753_read_16bit,
>   		ade7753_write_16bit,
>   		ADE7753_CFDEN);
> -static IIO_DEV_ATTR_CFNUM(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_CFNUM(0644,
>   		ade7753_read_8bit,
>   		ade7753_write_8bit,
>   		ADE7753_CFNUM);
>   static IIO_DEV_ATTR_CHKSUM(ade7753_read_8bit, ADE7753_CHKSUM);
> -static IIO_DEV_ATTR_PHCAL(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_PHCAL(0644,
>   		ade7753_read_16bit,
>   		ade7753_write_16bit,
>   		ADE7753_PHCAL);
> -static IIO_DEV_ATTR_APOS(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_APOS(0644,
>   		ade7753_read_16bit,
>   		ade7753_write_16bit,
>   		ADE7753_APOS);
> -static IIO_DEV_ATTR_SAGCYC(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_SAGCYC(0644,
>   		ade7753_read_8bit,
>   		ade7753_write_8bit,
>   		ADE7753_SAGCYC);
> -static IIO_DEV_ATTR_SAGLVL(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_SAGLVL(0644,
>   		ade7753_read_8bit,
>   		ade7753_write_8bit,
>   		ADE7753_SAGLVL);
> -static IIO_DEV_ATTR_LINECYC(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_LINECYC(0644,
>   		ade7753_read_8bit,
>   		ade7753_write_8bit,
>   		ADE7753_LINECYC);
> -static IIO_DEV_ATTR_WDIV(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_WDIV(0644,
>   		ade7753_read_8bit,
>   		ade7753_write_8bit,
>   		ADE7753_WDIV);
> -static IIO_DEV_ATTR_IRMS(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_IRMS(0644,
>   		ade7753_read_24bit,
>   		NULL,
>   		ADE7753_IRMS);
> -static IIO_DEV_ATTR_VRMS(S_IRUGO,
> +static IIO_DEV_ATTR_VRMS(0444,
>   		ade7753_read_24bit,
>   		NULL,
>   		ADE7753_VRMS);
> -static IIO_DEV_ATTR_IRMSOS(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_IRMSOS(0644,
>   		ade7753_read_16bit,
>   		ade7753_write_16bit,
>   		ADE7753_IRMSOS);
> -static IIO_DEV_ATTR_VRMSOS(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_VRMSOS(0644,
>   		ade7753_read_16bit,
>   		ade7753_write_16bit,
>   		ADE7753_VRMSOS);
> -static IIO_DEV_ATTR_WGAIN(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_WGAIN(0644,
>   		ade7753_read_16bit,
>   		ade7753_write_16bit,
>   		ADE7753_WGAIN);
> -static IIO_DEV_ATTR_VAGAIN(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_VAGAIN(0644,
>   		ade7753_read_16bit,
>   		ade7753_write_16bit,
>   		ADE7753_VAGAIN);
> -static IIO_DEV_ATTR_PGA_GAIN(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_PGA_GAIN(0644,
>   		ade7753_read_16bit,
>   		ade7753_write_16bit,
>   		ADE7753_GAIN);
> -static IIO_DEV_ATTR_IPKLVL(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_IPKLVL(0644,
>   		ade7753_read_8bit,
>   		ade7753_write_8bit,
>   		ADE7753_IPKLVL);
> -static IIO_DEV_ATTR_VPKLVL(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_VPKLVL(0644,
>   		ade7753_read_8bit,
>   		ade7753_write_8bit,
>   		ADE7753_VPKLVL);
> -static IIO_DEV_ATTR_IPEAK(S_IRUGO,
> +static IIO_DEV_ATTR_IPEAK(0444,
>   		ade7753_read_24bit,
>   		NULL,
>   		ADE7753_IPEAK);
> -static IIO_DEV_ATTR_VPEAK(S_IRUGO,
> +static IIO_DEV_ATTR_VPEAK(0444,
>   		ade7753_read_24bit,
>   		NULL,
>   		ADE7753_VPEAK);
> -static IIO_DEV_ATTR_VPERIOD(S_IRUGO,
> +static IIO_DEV_ATTR_VPERIOD(0444,
>   		ade7753_read_16bit,
>   		NULL,
>   		ADE7753_PERIOD);
> -static IIO_DEV_ATTR_CH_OFF(1, S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_CH_OFF(1, 0644,
>   		ade7753_read_8bit,
>   		ade7753_write_8bit,
>   		ADE7753_CH1OS);
> -static IIO_DEV_ATTR_CH_OFF(2, S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_CH_OFF(2, 0644,
>   		ade7753_read_8bit,
>   		ade7753_write_8bit,
>   		ADE7753_CH2OS);
> @@ -514,7 +514,7 @@ static IIO_DEV_ATTR_TEMP_RAW(ade7753_read_8bit);
>   static IIO_CONST_ATTR(in_temp_offset, "-25 C");
>   static IIO_CONST_ATTR(in_temp_scale, "0.67 C");
>   
> -static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
> +static IIO_DEV_ATTR_SAMP_FREQ(0644,
>   		ade7753_read_frequency,
>   		ade7753_write_frequency);
>   
> 

