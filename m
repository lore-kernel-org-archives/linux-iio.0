Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0289C2D3727
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 21:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781472923; cv=none; b=fo38JIjblu0hgyYkiDrGUHFMnkNr+hqVk6lgVwIFUmzD2VLPOLuagZwAkqJmRetIiFbFCm+bA072ApBJ63V7rqMwxFUgipGHGH4yAeLEk44WxTfgk1gYrlLViDPnY9RkgwxPcpEPxupgZ0UW8kc1csPHvRbE5pGj13Npxp+/Jig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781472923; c=relaxed/simple;
	bh=uq5dAQBgUlv4fuqbOf8/PJcw7d2cLX4l7Buv5XYVS24=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0ieJyO7/vrNZ1QgeCyu6REWVgyQjsq7X6H2t0+UmQJcwpzwxswe6BvGX/iOa1LhuA42mEXWN3im2Xn0uvaMnd/OBbsOCywc9AGi/Uw5/xhyRAGPFa+0d3zv9M86gR7ahyUl5RVMvaEzwjWA6nC/dPW3SiU9RYc/FIEEnVHyezw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORnl8K5m; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORnl8K5m"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-48611ccd5aeso1732719b6e.2
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 14:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781472921; x=1782077721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvgAYyCQGx+STgxeSTHJf5dS9VjipJF2G2cnTNc8eVo=;
        b=ORnl8K5mkHKs8eDLA+R3WqECgc46k7N/AP8JXO9lOkn6pqQf1jBgyOpvC3Ih6vRHlO
         dglUtn8A2ZVdOWljq61+cHMluJunmW2GT4t6M5TH6zkHfBY+axAoTLererJSWAW0Lgcv
         jzVnSdsygVt1sXWYCjMuGveAvua+Wyz0Nne6RFWuerp+HNRpR8uqsrP5Whc3Bvbv8TL0
         mnAYcqnOwPpyiVkibFb+/DyDr5HTPA0msHgMH8t1LfXg73T8rUxPI3+NxnHmmEl4OfiA
         wBWyq/WOqViuSkrZWiTlQqqyXeTEpa1gN4xRWWFRcMhKEm7deTMmZumw9TtMZwuBm1M1
         rFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781472921; x=1782077721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bvgAYyCQGx+STgxeSTHJf5dS9VjipJF2G2cnTNc8eVo=;
        b=fnPxvRGY1XHFD2hh5RU3A6Q3kZ0WI3I648KtK5+H6IoFCUEOEFVBda4wzc1b4ihY4W
         8OLYuI/ncBi0WV2GnvQ9OkQqFMFlKkK2pdUxpjetWPecl/xDuhvQSgMZhrCLi5lh8VqD
         +v4/xSJMBHt49Hx+wdll+vx/34Z+1NvhvqbVozVgoMOLnYRoL6gmHZI692ZCIM3T2B25
         RqFeo+0Ce3p+fKNYXHKlc63B8N0i0/0Td+ttK/H5xnMxOW9H22l4GfhxTNf3+pKlT3NE
         LUfp1FXwTmS8YzWYZWE4DpjfIO/nAG33Fv3CcBQnXGwwxT6NmQrVz9C804iwmH60drYy
         t2Rg==
X-Forwarded-Encrypted: i=1; AFNElJ/xzFxlCEY6h/nl3m0USF0pcvBx/aujsO4aYrwSMgPzzPuzC4XxGAWm4yOUUph+RPrkOo4DsVI5BLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV8LJ2aikbfL8MK9GD762xEY3gak4UjUUvcAQvGBqtHYOcyv+f
	dxoxOhFBG6cl4mYeaBrQVYSZAJ5OrxmbVNltafBZIAY4qNljwy6UMqMf
X-Gm-Gg: Acq92OE9YXqm62ncFXmICPXJ0FcIo5f3EQxuCTiiRQET1UMGuYM9p4YF+Wd40nftPLn
	Cfs7zTeuxoCXfqfrTbPi6EC5Iq4BdNU4uN9GvwurwpS05GTMXRX6Y+sC5xG17fr4OrKFqRNThVK
	jmGrkHVkXZM8fNo+AsuVz2XoYAcESdc3PGTIcEmyiun8iqNRssDqWiQ/95DOBeBdZOQLye3dwkG
	xg6UylzepTxnxDEJ/mBAkOMGBUhuVX1ilKj9DeT1Wu8btKmMEVcZoalZYZm4M/mIP8mzwP+W6Ye
	mfeij1ja2MWisyj1/o8m6B87esukNOXzeCyZNkHWDIy1ttoWE0vguLb7+/KLtNjonBq+OM7Xo2s
	pePa076v61wgj3IAUoGc5RGzp8+wBErWMjMllaDIw+TA1GfLbbeIoCk/9jmMnwtrYAy+0dXlMIc
	bOVY9Ydbw3wgWCPfyrKmpJ59bsm4SLLJSEMQa/flvAhg/lEpRblKTg
X-Received: by 2002:a05:6808:c1e3:b0:486:498d:f500 with SMTP id 5614622812f47-4872f380b4dmr8274028b6e.18.1781472921015;
        Sun, 14 Jun 2026 14:35:21 -0700 (PDT)
Received: from linuxescape (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875dfe4a89sm1628361b6e.18.2026.06.14.14.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 14:35:20 -0700 (PDT)
Date: Sun, 14 Jun 2026 16:35:18 -0500
From: Maxwell Doose <m32285159@gmail.com>
To: Shuangpeng <shuangpeng.kernel@gmail.com>
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
 bentiss@kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [BUG] KASAN: slab-use-after-free in _raw_spin_lock_irqsave from
 hid-sensor-custom
Message-ID: <20260614163518.2a265172@linuxescape>
In-Reply-To: <C79160E7-5244-407D-81E7-2A1B14231B22@gmail.com>
References: <178144969601.60470.12928355382146160896@gmail.com>
	<20260614160213.085e1efc@linuxescape>
	<C79160E7-5244-407D-81E7-2A1B14231B22@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Jun 2026 17:24:12 -0400
Shuangpeng <shuangpeng.kernel@gmail.com> wrote:

> > On Jun 14, 2026, at 17:02, Maxwell Doose <m32285159@gmail.com> wrote:
> > 
> > Hi Shuangpeng,
> > 
> > On Sun, 14 Jun 2026 15:19:21 -0400
> > Shuangpeng Bai <shuangpeng.kernel@gmail.com> wrote:
> >   
> >> I hit the following report while testing current upstream kernel:
> >> 
> >> KASAN: slab-use-after-free in _raw_spin_lock_irqsave from
> >> hid-sensor-custom
> >> 
> >> on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)
> >>   
> > 
> > Is this correct? It seems to point to changes in HPFS.
> >   
> 
> That commit was the linux.git HEAD where I reproduced the crash. I did not mean 
> to imply that the HPFS merge introduced the issue.
> 

If you have (a lot of) time, it may be worth trying git bisect to get
the exact commit. No worries if you don't of course, but it would be
incredibly helpful to the HID folks.

-- 
best regards,
max



> >> 
> >> The reproducer and .config files are here.
> >> https://gist.github.com/shuangpengbai/d82ac0d19fda016e81d7fa1ab028d967
> >> 
> >> I'm happy to test debug patches or provide additional information.
> >> 
> >> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> >>   
> > 
> > This bug report also seems to have nothing to do with IIO after
> > investigating the call trace, seems more like for the HID/input folks
> > than iio. HID folks, seems like it was caused here:
> > 
> > [   73.163547][ T8356]  hid_sensor_custom_poll (include/linux/poll.h:45 drivers/hid/hid-sensor-custom.c:706)
> > 
> > before _raw_spin_lock_irqsave() gets called and KASAN triggers the slab-use-after-free.
> >   
> 
> Thanks for checking.
> 
> I agree that this does not look like an IIO-specific issue from the trace. The crash
> is reported from hid_sensor_custom_poll() in drivers/hid/hid-sensor-custom.c.
> 




