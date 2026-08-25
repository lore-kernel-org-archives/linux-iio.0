Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7674964F
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 03:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787628144; cv=none; b=JMdqlNbXRi9NkeUgi2Zd7h9e/AcMRRzmSq0hNcZLE9HN6vGhUDg+ZSQHEnAupf/DqexzLhA9r4TsgtChloAQbcEAZx7/K476ZkFB2jtiW9WFr3cjW4BOPYQ7sJm6whKV+glVoaePvNNPv2FiU8O8kL5CTP/bk1IHLIpIrIHCXII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787628144; c=relaxed/simple;
	bh=c/dP8fSq+fJ4vk9t+6Oy//xE3tuRe686RF7qdma6lQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HW62OY+zn2UcGW4vabRNHpO5rzFPl9DozMF+8cdvAaYOA/mxHAAIuzjuHi7N3mNiC+RsdxVlhXTWAy2zNeYDTKARJPdacAyDOFtwEY/ZnV2Z5pkJwzpeN+df3ea0b+R+rl4QvWHKPqOopbOXSlFtGdFxT6pksGa4+nu2nBI28UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0z5ihpH; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0z5ihpH"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so51265205ad.0
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 20:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787628142; x=1788232942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yUjpxw8jaXO6xHW35u2c9GeSegB5FH1o9dfJXtFGBdE=;
        b=W0z5ihpHW64IrVxy7r8J20HpGFtlB6iXLZZ40dNKWxOJ8LrxiiwuPECGMfqZNoO4Yt
         TqVjGn3tSerAb11GSVHE5fVyp6Y4gkchaCIyz6Mh3hygSoEkp4KlXMW149fc5DnUKbkx
         97wIY4xGqUnu3fs8HZmqWmFfpgGSTS1Z2H4WNyKXJCVu6QKwZcYMVyI3SWXzfvOdTqAM
         iE//0t44ArlX+jPPZzOHebt2vUhoyNleWMFm6hbryT6ECRKg81kmaeD1HXNvN2OYl8vP
         NCVTGWOV4VkG6Lm8li0TpsgIPLAPSZxMWdLoS5SUCTLcgPOj5SuY8fU5D8RGDSWHWmop
         r8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787628142; x=1788232942;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yUjpxw8jaXO6xHW35u2c9GeSegB5FH1o9dfJXtFGBdE=;
        b=fBVoGiScsug+OriXxQBzSgGqWs4E+hxS2buqkVm53NtNaqGvEcaffoRsKkXHFy/JpZ
         5GTTsQaH5DAQyRpiQGAro1g7FGyfRJT4HwOZEzoE8b5oKo9YlhMcPQTk/nDXEaL+yGsB
         JirEnpOJDmILebdgfJvzUbwYCMRa2lEvuqCn4KmdDF1st8ZHWLb+iL+pSK+CcIGaHToQ
         ycV9lSMBn9HjWJ4q7hosOAsKB9dz7bEQVrHEes2SGPP/fGbrlCW9HAvL+G4dvisOUAbv
         RzAJiWcHkzst42vmHXQzp8GBwP6BK+/2DkpgGyM018NNBwyDWnkwbxH/hXKpuKcyeQe6
         2u1w==
X-Forwarded-Encrypted: i=1; AHgh+RpkH8nUuYYjTWaGjbH44ExUTn3eKErtT2WY07csHRCKHlqF1PXD98RirsV/PRcJPL/tPD7AlwnAFUc=@vger.kernel.org
X-Gm-Message-State: AFuF++mO4Gcv2ppHzBcEGMB/6+EtqC1qeLrBgXmFZ3LrEgs2pgSVbLcn
	tEAoBXCZ+hG8xl0K0xx4RYMw70ec3A5SP/3ahcn9xzd+XaiGIbsKmFp4
X-Gm-Gg: AR+sD12uQuKzUl70nXFlBE7i9fXAQHdr+QedsqtzAgd8JNOQfIR+oYiyXoZ1LDRizbR
	9UkrKtkXR0HBEybJ8c2T3heIRqHqSZuT4dB9Djl0h5j9i3KfltJsZO5KVVRT4AO6avR2ocKD9bw
	l7XrwhQRLBVzU+RX7VRFEcq2wIK27wltsJXGizhZEvl8jWXfmmikcbT1hJJfOOZd+V5EcdibhO9
	yO7v8jvFc3daFJ7ycjzJVv91maaYBRTEk6tjZA8NyJFmIduz2eRiCmFcWTsX0weUGE+LQK0VAo/
	MZHzIK6oaYGda/sXUfa7u4KU9Dwm0WT2ld52qjByUwwWUo5sZkzfvlA2yqMdNSiab+gliWIBAr0
	deHVjctJSFNwWLMXWVdqWrV4owjHNJhqIkFSXrP0aom1ctxtNGTFppTxqFC+wVEpWcOHMHVa2Gi
	6ie4Ot8XFyB5bBgC/S1/EeM9Wz40zt9TSry7sIqJQLel5AvSsG1ldj5Fa+LTR+xc8=
X-Received: by 2002:a17:903:b0c:b0:2ca:4f33:e86f with SMTP id d9443c01a7336-2d6dccc2aacmr73091975ad.12.1787628142180;
        Mon, 24 Aug 2026 20:22:22 -0700 (PDT)
Received: from localhost ([115.70.157.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6768e9ebbsm23291575ad.80.2026.08.24.20.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 20:22:21 -0700 (PDT)
Date: Tue, 25 Aug 2026 13:22:13 +1000
From: Tsz Shan Chan <tsz.chan.dev@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tsz Shan Chan <tchan@jacques.com.au>
Subject: Re: [PATCH v2 2/2] iio: light: vcnl4000: add shared IRQ support
Message-ID: <ao0FKRhOyiIqhvr-@fedora-1>
References: <20260814-vcnl4000-v2-0-9b771290cc1d@jacques.com.au>
 <20260814-vcnl4000-v2-2-9b771290cc1d@jacques.com.au>
 <20260822032550.31a0fa9e@jic23-huawei>
 <aov_uhPCcno0YJTe@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aov_uhPCcno0YJTe@ashevche-desk.local>

On Mon, Aug 24, 2026 at 11:24:26AM +0300, Andy Shevchenko wrote:
> On Sat, Aug 22, 2026 at 03:25:50AM +0100, Jonathan Cameron wrote:
> > On Fri, 14 Aug 2026 14:30:43 +1000
> > Tsz Shan Chan <tsz.chan.dev@gmail.com> wrote:
> 
> > > The INT output of vcnl4010/4020 and vcnl4040/4200 is open drain active
> > > low which can be shared with other devices.
> > > Add IRQF_SHARED and switch the trigger type from IRQF_TRIGGER_FALLING to
> > > IRQF_TRIGGER_LOW. Edge triggering can miss interrupts on a shared line.
> > Fairly low risk change but I guess we'll see.
> > 
> > It used to be annoyingly common for interrupt controllers to support
> > only edge based interrupts, but hopefully that silliness is a thing
> > of the past.
> > 
> > So crossed fingers, I'll apply this and see if we get anyone shouting.
> > I think we'll get away with it
> 
> In another thread somebody mentioned a type of the signal that HW generates.
> Having OD output doesn't prevent HW to behave like it does edge interrupts,
> id est generating a pulse instead of keeping the level until it gets acked.
> With that being said, I would ask the datasheet citation to clarify the case.
> 

vcnl4010/4020 datasheet, Page 11 Table 15 Notes:
  "Once an interrupt is generated the corresponding status bit goes to 1
  and stays there unless it is cleared by writing a 1 in the
  corresponding bit. The int pad will be pulled down while at least one
  of the status bit is 1."

vcnl4040/4200 datasheet, Page 13 Section Interrupt Flag:
  "INT_Flag represents all of the interrupt trigger statuses for ALS and
  PS. If any of these flags trigger from "0" to "1", the INT pin will be
  pulled low. Once the host reads INT_Flag register, all the flags are
  cleared (reset to "0"), and the INT pin is reset to high."

The interrupt is latched. The line stays low until the driver clears it.
