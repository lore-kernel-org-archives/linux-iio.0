Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFFE29E11A;
	Sat, 30 May 2026 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780151875; cv=none; b=P59UGzqJasbzZLaZQS1+bm8Y3WCB5PLcur5apxqvoQo6vGLz82FlicjgjBeHYaTaQIOdzzmPCq/lY3g/XhSQM3o1LBdhjYmuDYkW3SXRzQVo+CzRDyZEH4yFtHuAi4/hjm8fcBeonuT7JCu+cIrfOaeIaHRcRVChR4VE6jApnLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780151875; c=relaxed/simple;
	bh=8J9DxXs1T71CGG83HJhn3H2Zp8tDfVF76AzxudwcgFw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=riLSmrEE5GR0f806K4A4+TA4BwgXC6Jtk9uTCPMZoULw+FRqH/s0h8spQxxfMfq25/S6/++GoIJt9n3SL2fW9QiFoziI6ih2DEnkH1laBP+rWQ3sXZYXgNGfIrW63DwxDTR9wpmUyCplc1oHkYioziGnIx4dfJNWh6N7QTDuSiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eci7JBmm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eci7JBmm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59791F00893;
	Sat, 30 May 2026 14:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780151873;
	bh=xFR7BdrPZnwRH2ZgOvUm1xEzh0vhD/WsVvyCyy/3hVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eci7JBmml/kIE1fEr5bSX2PYWFs1eIbZljWm5xTFc7g/68iBAqPTVfmrd7zY9cYIp
	 dyN4Fkit/Uu0d5rZLnxiMmCM9vu/WAwmkdDbAMlIhkzV8SleyFzFAMukwIz/k4m410
	 5e6dtBeBrTb+4J1kAOBFOLMuvx6ZB6/LHwqvFcSi1haO43kpTUTvN7hGAxgCsPvsZT
	 r35RADQ4VbC2fKD2NJeOKCerBdHiseyw5EEcEwHgw1UtqDxY/GD9y2FC3fNV1Mf9Hk
	 bDDVRCiI4gfSvs9OZIoHe9cLKMhCM7vS18LRsxMQ0+HAItsZyocWHuYnC+/Rzb2gli
	 mhroXLt0+7xgQ==
Date: Sat, 30 May 2026 15:37:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
 oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org
Subject: Re: [jic23-iio:testing 240/253]
 drivers/iio/light/apds9999.c:201:undefined reference to `__umoddi3'
Message-ID: <20260530153746.22c155d8@jic23-huawei>
In-Reply-To: <202605301225.6MQ3YOMu-lkp@intel.com>
References: <202605301225.6MQ3YOMu-lkp@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 May 2026 12:38:47 +0800
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
> head:   7b84b1e9dd850a5c9b55e27daa4ecdc2dd5b3431
> commit: a67c818e7a5ce49e141f0d73f8330026e82bcc31 [240/253] iio: light: add support for APDS9999 sensor
> config: i386-randconfig-r071-20260529 (https://download.01.org/0day-ci/archive/20260530/202605301225.6MQ3YOMu-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> smatch: v0.5.0-9185-gbcc58b9c
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260530/202605301225.6MQ3YOMu-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202605301225.6MQ3YOMu-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    ld: drivers/iio/light/apds9999.o: in function `apds9999_read_raw':
> >> drivers/iio/light/apds9999.c:201:(.text+0x1cf): undefined reference to `__umoddi3'  
> 
> 
I was clearly half asleep whilst trying previous fix and failed to notice
the line after was bad as well.  Anyhow, trying again.  Squashing this on top.

diff --git a/drivers/iio/light/apds9999.c b/drivers/iio/light/apds9999.c
index 5285d148fbb5..7a0df5252078 100644
--- a/drivers/iio/light/apds9999.c
+++ b/drivers/iio/light/apds9999.c
@@ -182,7 +182,9 @@ static int apds9999_read_raw(struct iio_dev *indio_dev,
                *val = (int)counts;
                return IIO_VAL_INT;
 
-       case IIO_CHAN_INFO_SCALE:
+       case IIO_CHAN_INFO_SCALE: {
+               u32 remainder;
+
                /*
                 * Scale (lux per count) = 54 / (gain * integration_time_ms)
                 *
@@ -197,10 +199,10 @@ static int apds9999_read_raw(struct iio_dev *indio_dev,
 
                /* scale_nano = 54 * 1e12 / (gain * itime_us) nano-lux/count */
                scale_nano = div_u64(54ULL * NSEC_PER_SEC * USEC_PER_MSEC, (u32)(gain * itime_us));
-               *val = (int)div_u64(scale_nano, NSEC_PER_SEC);
-               *val2 = (int)(scale_nano % NSEC_PER_SEC);
+               *val = (int)div_u64_rem(scale_nano, NSEC_PER_SEC, &remainder);
+               *val2 = (int)remainder;
                return IIO_VAL_INT_PLUS_NANO;
-
+       }
        case IIO_CHAN_INFO_INT_TIME:
                *val = 0;
                *val2 = apds9999_itimes_us[data->als_res];



> vim +201 drivers/iio/light/apds9999.c
> 
>    166	
>    167	static int apds9999_read_raw(struct iio_dev *indio_dev,
>    168				     struct iio_chan_spec const *chan,
>    169				     int *val, int *val2, long mask)
>    170	{
>    171		struct apds9999_data *data = iio_priv(indio_dev);
>    172		int gain, itime_us;
>    173		u64 scale_nano;
>    174		u32 counts;
>    175		int ret;
>    176	
>    177		switch (mask) {
>    178		case IIO_CHAN_INFO_RAW:
>    179			ret = apds9999_read_channel(data, chan->address, &counts);
>    180			if (ret)
>    181				return ret;
>    182			*val = (int)counts;
>    183			return IIO_VAL_INT;
>    184	
>    185		case IIO_CHAN_INFO_SCALE:
>    186			/*
>    187			 * Scale (lux per count) = 54 / (gain * integration_time_ms)
>    188			 *
>    189			 * The constant 54 is derived from the datasheet table:
>    190			 *   at gain = 3x, itime = 100 ms -> 0.180 lux/count
>    191			 *   -> C = 0.180 * 3 * 100 = 54
>    192			 *
>    193			 * Expressed as IIO_VAL_INT_PLUS_NANO.
>    194			 */
>    195			gain = apds9999_gains[data->als_gain_idx];
>    196			itime_us = apds9999_itimes_us[data->als_res];
>    197	
>    198			/* scale_nano = 54 * 1e12 / (gain * itime_us) nano-lux/count */
>    199			scale_nano = div_u64(54ULL * NSEC_PER_SEC * USEC_PER_MSEC, (u32)(gain * itime_us));
>    200			*val = (int)div_u64(scale_nano, NSEC_PER_SEC);
>  > 201			*val2 = (int)(scale_nano % NSEC_PER_SEC);  
>    202			return IIO_VAL_INT_PLUS_NANO;
>    203	
>    204		case IIO_CHAN_INFO_INT_TIME:
>    205			*val = 0;
>    206			*val2 = apds9999_itimes_us[data->als_res];
>    207			return IIO_VAL_INT_PLUS_MICRO;
>    208	
>    209		default:
>    210			return -EINVAL;
>    211		}
>    212	}
>    213	
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

