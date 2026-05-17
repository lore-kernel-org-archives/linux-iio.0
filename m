Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0488B3043C8
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 20:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779048584; cv=none; b=IsK9fnE/ZJrlcfrmWVBCa6z2HzOXpKdWnh8z90idxj35ThDUZhJwZw7BWRLNYM9hBdBOHfXbLXDytTyl4s7oLxZoKaUxrSD57Fpom3pU1/eeZKZm13jX25L7COm/CdWlD/VyvT3MsfQ4FtBvZh7e982EnXvaHqTArjdhH34MwGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779048584; c=relaxed/simple;
	bh=KTipVWBZ1vlWoeq+rUWIZFfKne6qza67HGveewURak4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uA/NgdFrZ2gWiR/DIM+Saw4Lj60zlQ1ST6QKGmYUSQoFhodM0RhatyTiOVWCdpCfwPxNkNwzifsoSVpo7tYsj/ykPAAeYOGkiR6qxgqbM/3cIjI9gcGy6R8lg8fVn239d1t5kWbasgUDujc8EoKXh6l4QdNFKZp6w7fI4WHtY/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHQ9WPXA; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHQ9WPXA"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8383fb7143aso625684b3a.3
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 13:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779048582; x=1779653382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w+5lXcHVq1Eqh6SdtRuIC5uuCQrXCwv21uMjbsUUpDc=;
        b=XHQ9WPXAByNS0V0+iZa19uvmLfSXqyUlEXGpQZcFo5KHVZUehroYL/AIw0A9xwJY9o
         vfDP3mJhd87eicUOVmwyB917VXljGJwBZCq8Bzmul6YjKt45aODoMxCiUnU22Df9bZK+
         0Yw+cp9pnz6RxGZ18XHpog9GhVg8qHR8WnvVL6YLpZBoHmQmk200F5lJQ+uU5qiYJSH0
         Ab6UOdSnu4WJF1eHFjSx7HPTXCQZJFox1NPf8l2OLmyXs44oIK3N1N+vx3ui95RIbFa9
         +Bp41mISsAO3p2+fScbuPYrKA0kFslbgPVdpG/DP4yJYdBYBXB5WHt0a6m5SP70JBcnM
         Tysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779048582; x=1779653382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+5lXcHVq1Eqh6SdtRuIC5uuCQrXCwv21uMjbsUUpDc=;
        b=hMcV0zNu1DqPprxAUqR7q+89xTwvmqIN/EIbUbuTDOql5W16X2euFiFZBEgRSoEnvP
         cRLuQrX/6RYSE6jwPQm01hodaAKS1venDSD2rYkqKUMCV4NPER+PpgRDV0HTxsvdme3W
         HOscaR8JrgujVNoRn339y9j+h5wtEvW+6tsK5vKH5k+QLVHAKezwbW9HaWp4dIeC+Uwx
         rcqy05uAMfTH3BeK4QbInLJWpQQJV5otYxq8XVKwoyuQ0r7N8KzzjfWR2SQh0mX5Z/v5
         L+OoK7cJMtryyeNccD3/EtwQIedCbUavJI1FsOx99BSy+NswVudNFrZbimJPY12+qOYg
         p2hA==
X-Forwarded-Encrypted: i=1; AFNElJ+WwHALJuf4XkuGXldODX+jDEyeuhvwc5Ov+efkgo/0UaQIe14U+HOUuOieGRBqIhw82+qCEMIjtIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Q9QsIvrz6NTMdl3ZE3hWDdSWKosLcDWVOtdVg6SrPNQNdab3
	vezC6I+rw+mZxf0Mw73qgycdzsO6KpkoPO5UBLLvF+0DNldz3vOoDvIz
X-Gm-Gg: Acq92OEKPj2IcIgcxxc1UDDDgv3h8DFtuSfmGsfpay7Qhje6+Mzh6bIIBPsQaIcZ0Za
	rcRgLTF6y4D9HBhau8F9Z3eBc+VUI48o3KqsGj2C2/1GLMMkjFdilR6B7E4Iy6RLnlwEM0oJtQd
	az8a36JEhh7EnFdTZnqZLMbDfJdVF7s34l+jjn7NlBqU8Ly60kCXnW2IWHnnYEdbsgyCchE7Nz3
	GanCY7Y27nLLdkNoUKK0HVbF6sD4N5OQ9/USBKpheTOx1UvbELS3D0d8+jHOepz7gqj8WvBfCmP
	yYBZ5apUkKsc2aFmKZhRp6GsxxdYj1s8Vau0FuWz8XiaH5BQuEV+32quIsksJqC/Z7RGcHC5Fip
	Og5VXp+XlML0e3V4yBhQs7/lypd+O6HbkyiT3JDEzAu455kONIEB+zaoUkzyBRhpnav6l4U5S8s
	0hbvmmx3WpXQ3jwwfOttESASRS4SuHswVm/8ZTWZlYilTjGqF4pHE=
X-Received: by 2002:a05:6a00:39a0:b0:82c:d7c4:4c56 with SMTP id d2e1a72fcca58-83f33c43997mr12269745b3a.15.1779048582194;
        Sun, 17 May 2026 13:09:42 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19f7ccc7sm14261704b3a.58.2026.05.17.13.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 13:09:41 -0700 (PDT)
Date: Mon, 18 May 2026 01:39:35 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	sakari.ailus@linux.intel.com,
	christoph.muellner@theobroma-systems.com, martink@posteo.de,
	mfuzzey@parkeon.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] iio: accel: mma8452: improve coding style, pm
 and resource cleanup
Message-ID: <agogfypMDl6dS9D6@hu-ckantibh-hyd.qualcomm.com>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505174640.3998281-1-sanjayembedded@gmail.com>

On Tue, May 05, 2026 at 11:16:30PM +0530, Sanjay Chitroda wrote:
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Hi all,
> 
> This series contains a small fixes, cleanup and improvements to use
> modern kernel helper API and coding style for mma8452 accel driver.
> 
> The changes modernize mutex with guard(), dev_err_probe usage,
> resolve checkpatch CHECKS and pm_ptr macro usage.
> 
> Changes in v3:
> - Following input from Andy and Jonathan added new changes as following
>   0001: handle return value to have proper error propagation
>   0002: use non-devm API to maintain resource management LIFO order
>   0006: convert individual regulator using bulk regulator API
>   0009: use IIO cleanup helper for DIRECT_MODE
> - Address kernel coding stype specific review comment
> - Reorder local struct device and dev_err_probe change
> v2 series -> https://lore.kernel.org/all/20260422165643.2148195-1-sanjayembedded@gmail.com/
> Changes in v2:
> - 0005: address review comment from Andy and Geert
>   and use DEFINE_RUNTIME_DEV_PM_OPS macro
> - Added new cleanup channges in mma8452 driver
> 
> No functional behavior changes are intended.
> 
> Testing:
>   - Compiled with W=1
>   - Build-tested on QEMU x86_64
> 
> Feedback and reviews are very welcome.
> 
> Thanks,
> Sanjay Chitroda
> 
> Sanjay Chitroda (10):
>   iio: accel: mma8452: handle I2C read error(s) in mma8452_read()
>   iio: accel: mma8452: switch to non-devm request_threaded_irq()
>   iio: accel: mma8452: cleanup codestyle warning
>   iio: accel: mma8452: sort headers alphabetically
>   iio: accel: mma8452: Use dev_err_probe()
>   iio: accel: mma8452: convert to bulk regulator usage
>   iio: accel: mma8452: use local struct device
>   iio: accel: mma8452: use pm_ptr() and direct runtime PM calls
>   iio: accel: mma8452: Use IIO cleanup helpers
>   iio: accel: mma8452: use guard() to release mutexes

Hi Jonathan,

It's been about two weeks since the latest posting, and it looks like
there haven't been any major comments so far atleast on initial changes
of series. I also don't see any progress on the iio/tesing branch yet.

Could you please guide me on how you'd like me to take this series forward?
I'm happy to rework/resend partial/full if needed or wait further.

Thanks, Sanjay

> 
>  drivers/iio/accel/mma8452.c | 278 +++++++++++++++---------------------
>  1 file changed, 116 insertions(+), 162 deletions(-)
> 
> 
> base-commit: 39b80c5c9830d12d2d6531059001301c4265322a
> -- 
> 2.34.1
> 
