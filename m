Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F333F41C71;
	Thu,  2 Jul 2026 00:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782951518; cv=none; b=lrhueJuMqy0YevK/IJ4zVuXsU8olWSSnOpRNsEiP0zep4RXp6ME5OZMsaWWR7bFfMRGT2n5MnX/hTA1BS+1amr6wqajQLtfL6hlMKdL+xyuGCArD0+Fze25uljToSOXhOKHmciF7NKu3+E+MXybCmPguZaCLNZlLD7HFZh8vQ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782951518; c=relaxed/simple;
	bh=PwGjMVknP9ikGb29cHmCE16JW0Zq8w7WLU6lRrDnFcM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fiLsgp8UrgmSP3hJajtzQjr2daxQat8hUHlT/CzTwngN39wyHaiOZlUpQ1j2zhUOGo7MYlcgDrSJfdD5Tf5NYedTQdoMwkIDWwJJE45PxS+sf1BmRwfSTTXI2TSyu/1PiNUkgPoJI8tIwN0Iq2VvK5qdApOIGNZ033YyMOGJ+n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6rV4+39; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6rV4+39"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3781F000E9;
	Thu,  2 Jul 2026 00:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782951516;
	bh=x9TA3MLKkEiKIuE5tqoaPp7fOV4pnY3t0YTH2Qgt+mA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=O6rV4+395/IlPSbbTvCDzhLKTgsoipmWvpXAGOSVqpiwecZcU1P9SqqJ5VVYtf23q
	 quxogPPXJpf4DoQhitcnuqORokWNN2hd1z9pvAhUpgICf6kjeRe6ERFJ94B4dmIPoJ
	 S6pXciUoAoMsUupsEreqkO7Nz/QuSJpuVLQ9iCux6DC1C9CF8TUpBIR+8IRG1oArWp
	 J4PKHiuPkAMaFW5/Ve67eBSa9GTODVtWyUW+TgCgPOoditg04lxktzfzsfDBzGNtEI
	 gJvyfG0gX+55yedQEobMpv8khsLW2Azwb83Of+6YaVxTpMMukWeor5iMwWFw1pq4yT
	 cVuqXsANYY0Iw==
Date: Thu, 2 Jul 2026 01:18:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Xiaofeng Yuan <xiaofengmian@163.com>
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: frequency: reorder dds.h macro parameters
 to match IIO convention
Message-ID: <20260702011831.6b014318@jic23-huawei>
In-Reply-To: <20260624021612.23808-1-xiaofengmian@163.com>
References: <20260624021612.23808-1-xiaofengmian@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jun 2026 02:16:12 +0000
Xiaofeng Yuan <xiaofengmian@163.com> wrote:

> The IIO subsystem convention requires that the file permission
> (_mode) parameter be the first argument of IIO_DEV_ATTR_* macros.
> The dds.h macros had _mode after _channel, causing checkpatch to
> misinterpret the channel number as a permission value.
> 
> Reorder the parameters so _mode is first, matching the convention
> established by IIO_DEV_ATTR_SAMP_FREQ in include/linux/iio/sysfs.h.
> 
> Update all callers in ad9834.c and ad9832.c accordingly.
> 
> Compile tested.
> 
> Signed-off-by: Xiaofeng Yuan <xiaofengmian@163.com>

Hi. 

Much more substantial surgery needs doing to these and the result
of that is many (probably all!) of these macros will go away. 
Hence marginal value but given it is staging and so churn isn't
as much of an issue, fair enough.

One thing that this does need to mention in the commit description
is the WAVETYPE gaining a mode parameter when it was always
0200 hard coded before. I'll add that whilst applying.

Applied to the testing branch of iio.git


Jonathan

> ---
>  drivers/staging/iio/frequency/ad9832.c | 20 ++++++++++----------
>  drivers/staging/iio/frequency/ad9834.c | 22 +++++++++++-----------
>  drivers/staging/iio/frequency/dds.h    | 24 ++++++++++++------------
>  3 files changed, 33 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 659821a1e..2dfdd0d28 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -253,22 +253,22 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
>   * see dds.h for further information
>   */
>  
> -static IIO_DEV_ATTR_FREQ(0, 0, 0200, NULL, ad9832_write, AD9832_FREQ0HM);
> -static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9832_write, AD9832_FREQ1HM);
> -static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9832_write, AD9832_FREQ_SYM);
> +static IIO_DEV_ATTR_FREQ(0200, 0, 0, NULL, ad9832_write, AD9832_FREQ0HM);
> +static IIO_DEV_ATTR_FREQ(0200, 0, 1, NULL, ad9832_write, AD9832_FREQ1HM);
> +static IIO_DEV_ATTR_FREQSYMBOL(0200, 0, NULL, ad9832_write, AD9832_FREQ_SYM);
>  static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
>  
> -static IIO_DEV_ATTR_PHASE(0, 0, 0200, NULL, ad9832_write, AD9832_PHASE0H);
> -static IIO_DEV_ATTR_PHASE(0, 1, 0200, NULL, ad9832_write, AD9832_PHASE1H);
> -static IIO_DEV_ATTR_PHASE(0, 2, 0200, NULL, ad9832_write, AD9832_PHASE2H);
> -static IIO_DEV_ATTR_PHASE(0, 3, 0200, NULL, ad9832_write, AD9832_PHASE3H);
> -static IIO_DEV_ATTR_PHASESYMBOL(0, 0200, NULL,
> +static IIO_DEV_ATTR_PHASE(0200, 0, 0, NULL, ad9832_write, AD9832_PHASE0H);
> +static IIO_DEV_ATTR_PHASE(0200, 0, 1, NULL, ad9832_write, AD9832_PHASE1H);
> +static IIO_DEV_ATTR_PHASE(0200, 0, 2, NULL, ad9832_write, AD9832_PHASE2H);
> +static IIO_DEV_ATTR_PHASE(0200, 0, 3, NULL, ad9832_write, AD9832_PHASE3H);
> +static IIO_DEV_ATTR_PHASESYMBOL(0200, 0, NULL,
>  				ad9832_write, AD9832_PHASE_SYM);
>  static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/
>  
> -static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL,
> +static IIO_DEV_ATTR_PINCONTROL_EN(0200, 0, NULL,
>  				ad9832_write, AD9832_PINCTRL_EN);
> -static IIO_DEV_ATTR_OUT_ENABLE(0, 0200, NULL,
> +static IIO_DEV_ATTR_OUT_ENABLE(0200, 0, NULL,
>  				ad9832_write, AD9832_OUTPUT_EN);
>  
>  static struct attribute *ad9832_attributes[] = {
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index 4359b358e..b232cb4a7 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -315,21 +315,21 @@ static IIO_DEVICE_ATTR(out_altvoltage0_out1_wavetype_available, 0444,
>   * see dds.h for further information
>   */
>  
> -static IIO_DEV_ATTR_FREQ(0, 0, 0200, NULL, ad9834_write, AD9834_REG_FREQ0);
> -static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9834_write, AD9834_REG_FREQ1);
> -static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9834_write, AD9834_FSEL);
> +static IIO_DEV_ATTR_FREQ(0200, 0, 0, NULL, ad9834_write, AD9834_REG_FREQ0);
> +static IIO_DEV_ATTR_FREQ(0200, 0, 1, NULL, ad9834_write, AD9834_REG_FREQ1);
> +static IIO_DEV_ATTR_FREQSYMBOL(0200, 0, NULL, ad9834_write, AD9834_FSEL);
>  static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
>  
> -static IIO_DEV_ATTR_PHASE(0, 0, 0200, NULL, ad9834_write, AD9834_REG_PHASE0);
> -static IIO_DEV_ATTR_PHASE(0, 1, 0200, NULL, ad9834_write, AD9834_REG_PHASE1);
> -static IIO_DEV_ATTR_PHASESYMBOL(0, 0200, NULL, ad9834_write, AD9834_PSEL);
> +static IIO_DEV_ATTR_PHASE(0200, 0, 0, NULL, ad9834_write, AD9834_REG_PHASE0);
> +static IIO_DEV_ATTR_PHASE(0200, 0, 1, NULL, ad9834_write, AD9834_REG_PHASE1);
> +static IIO_DEV_ATTR_PHASESYMBOL(0200, 0, NULL, ad9834_write, AD9834_PSEL);
>  static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/
>  
> -static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL, ad9834_write, AD9834_PIN_SW);
> -static IIO_DEV_ATTR_OUT_ENABLE(0, 0200, NULL, ad9834_write, AD9834_RESET);
> -static IIO_DEV_ATTR_OUTY_ENABLE(0, 1, 0200, NULL, ad9834_write, AD9834_OPBITEN);
> -static IIO_DEV_ATTR_OUT_WAVETYPE(0, 0, ad9834_store_wavetype, 0);
> -static IIO_DEV_ATTR_OUT_WAVETYPE(0, 1, ad9834_store_wavetype, 1);
> +static IIO_DEV_ATTR_PINCONTROL_EN(0200, 0, NULL, ad9834_write, AD9834_PIN_SW);
> +static IIO_DEV_ATTR_OUT_ENABLE(0200, 0, NULL, ad9834_write, AD9834_RESET);
> +static IIO_DEV_ATTR_OUTY_ENABLE(0200, 0, 1, NULL, ad9834_write, AD9834_OPBITEN);
> +static IIO_DEV_ATTR_OUT_WAVETYPE(0200, 0, 0, ad9834_store_wavetype, 0);
> +static IIO_DEV_ATTR_OUT_WAVETYPE(0200, 0, 1, ad9834_store_wavetype, 1);
>  
>  static struct attribute *ad9834_attributes[] = {
>  	&iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,
> diff --git a/drivers/staging/iio/frequency/dds.h b/drivers/staging/iio/frequency/dds.h
> index 2ebe68eb7..b2ca8bb97 100644
> --- a/drivers/staging/iio/frequency/dds.h
> +++ b/drivers/staging/iio/frequency/dds.h
> @@ -11,7 +11,7 @@
>   * /sys/bus/iio/devices/.../out_altvoltageX_frequencyY
>   */
>  
> -#define IIO_DEV_ATTR_FREQ(_channel, _num, _mode, _show, _store, _addr)	\
> +#define IIO_DEV_ATTR_FREQ(_mode, _channel, _num, _show, _store, _addr)	\
>  	IIO_DEVICE_ATTR(out_altvoltage##_channel##_frequency##_num,	\
>  			_mode, _show, _store, _addr)
>  
> @@ -26,7 +26,7 @@
>   * /sys/bus/iio/devices/.../out_altvoltageX_frequencysymbol
>   */
>  
> -#define IIO_DEV_ATTR_FREQSYMBOL(_channel, _mode, _show, _store, _addr)	\
> +#define IIO_DEV_ATTR_FREQSYMBOL(_mode, _channel, _show, _store, _addr)	\
>  	IIO_DEVICE_ATTR(out_altvoltage##_channel##_frequencysymbol,	\
>  			_mode, _show, _store, _addr)
>  
> @@ -34,7 +34,7 @@
>   * /sys/bus/iio/devices/.../out_altvoltageX_phaseY
>   */
>  
> -#define IIO_DEV_ATTR_PHASE(_channel, _num, _mode, _show, _store, _addr)	\
> +#define IIO_DEV_ATTR_PHASE(_mode, _channel, _num, _show, _store, _addr)	\
>  	IIO_DEVICE_ATTR(out_altvoltage##_channel##_phase##_num,		\
>  			_mode, _show, _store, _addr)
>  
> @@ -49,7 +49,7 @@
>   * /sys/bus/iio/devices/.../out_altvoltageX_phasesymbol
>   */
>  
> -#define IIO_DEV_ATTR_PHASESYMBOL(_channel, _mode, _show, _store, _addr)	\
> +#define IIO_DEV_ATTR_PHASESYMBOL(_mode, _channel, _show, _store, _addr)	\
>  	IIO_DEVICE_ATTR(out_altvoltage##_channel##_phasesymbol,		\
>  			_mode, _show, _store, _addr)
>  
> @@ -57,7 +57,7 @@
>   * /sys/bus/iio/devices/.../out_altvoltageX_pincontrol_en
>   */
>  
> -#define IIO_DEV_ATTR_PINCONTROL_EN(_channel, _mode, _show, _store, _addr)\
> +#define IIO_DEV_ATTR_PINCONTROL_EN(_mode, _channel, _show, _store, _addr)\
>  	IIO_DEVICE_ATTR(out_altvoltage##_channel##_pincontrol_en,	\
>  			_mode, _show, _store, _addr)
>  
> @@ -65,7 +65,7 @@
>   * /sys/bus/iio/devices/.../out_altvoltageX_pincontrol_frequency_en
>   */
>  
> -#define IIO_DEV_ATTR_PINCONTROL_FREQ_EN(_channel, _mode, _show, _store, _addr)\
> +#define IIO_DEV_ATTR_PINCONTROL_FREQ_EN(_mode, _channel, _show, _store, _addr)\
>  	IIO_DEVICE_ATTR(out_altvoltage##_channel##_pincontrol_frequency_en,\
>  			_mode, _show, _store, _addr)
>  
> @@ -73,7 +73,7 @@
>   * /sys/bus/iio/devices/.../out_altvoltageX_pincontrol_phase_en
>   */
>  
> -#define IIO_DEV_ATTR_PINCONTROL_PHASE_EN(_channel, _mode, _show, _store, _addr)\
> +#define IIO_DEV_ATTR_PINCONTROL_PHASE_EN(_mode, _channel, _show, _store, _addr)\
>  	IIO_DEVICE_ATTR(out_altvoltage##_channel##_pincontrol_phase_en,	\
>  			_mode, _show, _store, _addr)
>  
> @@ -81,7 +81,7 @@
>   * /sys/bus/iio/devices/.../out_altvoltageX_out_enable
>   */
>  
> -#define IIO_DEV_ATTR_OUT_ENABLE(_channel, _mode, _show, _store, _addr)	\
> +#define IIO_DEV_ATTR_OUT_ENABLE(_mode, _channel, _show, _store, _addr)	\
>  	IIO_DEVICE_ATTR(out_altvoltage##_channel##_out_enable,		\
>  			_mode, _show, _store, _addr)
>  
> @@ -89,8 +89,8 @@
>   * /sys/bus/iio/devices/.../out_altvoltageX_outY_enable
>   */
>  
> -#define IIO_DEV_ATTR_OUTY_ENABLE(_channel, _output,			\
> -			_mode, _show, _store, _addr)			\
> +#define IIO_DEV_ATTR_OUTY_ENABLE(_mode, _channel, _output,		\
> +			_show, _store, _addr)				\
>  	IIO_DEVICE_ATTR(out_altvoltage##_channel##_out##_output##_enable,\
>  			_mode, _show, _store, _addr)
>  
> @@ -98,9 +98,9 @@
>   * /sys/bus/iio/devices/.../out_altvoltageX_outY_wavetype
>   */
>  
> -#define IIO_DEV_ATTR_OUT_WAVETYPE(_channel, _output, _store, _addr)	\
> +#define IIO_DEV_ATTR_OUT_WAVETYPE(_mode, _channel, _output, _store, _addr)\
>  	IIO_DEVICE_ATTR(out_altvoltage##_channel##_out##_output##_wavetype,\
> -			0200, NULL, _store, _addr)
> +			_mode, NULL, _store, _addr)
>  
>  /**
>   * /sys/bus/iio/devices/.../out_altvoltageX_outY_wavetype_available

