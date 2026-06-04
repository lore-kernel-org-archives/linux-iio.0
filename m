Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40063CC9E8
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 07:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559145; cv=none; b=NOLqVleiI49AxAiOQmfR29n6NeoFw4XSTX8R/+31px4uedQzvK/0Q6fFBPWsuDb9UOfyCbEmO5I9kCp7m6+OGgJRmq5NsbrHSKB+TF6+9FzSPEi8lOWZ2J9yUGA10ibL+lMG6vZ0Y1yXaIaPDHbaZfjwqo7ZDtqyTTQ1nwo7ESI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559145; c=relaxed/simple;
	bh=Dvt4W+Qy7EAGh0/2wIo3vsZYTtfKVjQbzzmSzWu1jsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tS0Dgpqpi7wzS52YitF2NvdWjb3mVndPCRMSh9t6XHWlF0sAibbEYPN1JVIW0JT9Xzi7PSQnMlJgfZwMrM0YsmI85M3RQxxPbOo5FJs9M5NuQRXS2SOrfdWG2Hs1ArOuqdrWT2gPtOT4G3f1R9WUPczgufN80zLQFypa/UcvkzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAgspFg+; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAgspFg+"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9159f631656so34857985a.1
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 00:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780559143; x=1781163943; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kLeYQqRXlh1qJ/lyjnFUyj/UDElKHE/qIYm+8ZoOG5E=;
        b=CAgspFg+mqJL2ubJwFPUAhGcHpHcMNEjz8m3kWH6q7daXlPAbGkmoRNg/MXFU7vrVn
         P8KH5RtGSCJxWo8Q9Yus6dAE6ZBDz37jOHjiVNdQ4SyR7OzlDGk/baEfxP5qTJ7suR/s
         LAZ4eYSR2wSYkJE+rJ4Q8P8G7gFXvh9Glo5i0lB7vIZhwfvKMiX31Wg/1274RneIrzVD
         wl50l8diKtIrNYVwVrLE0l4kYNvmrNV3RxHebrBYeszYka5TenUp4u2gU+X6dXM/yf2A
         vKegx8MSSuvRMCOjm5+A6F3c30PuIbOfPWXSITWshde50j4+RD79tecBCkU6RgaIqBwG
         nmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780559143; x=1781163943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kLeYQqRXlh1qJ/lyjnFUyj/UDElKHE/qIYm+8ZoOG5E=;
        b=ktHog5WWBpNosm64SgfQD0zScSefwfCZW2Z8whp+ey7hFJUqyptCwP72bMlOd6M3ng
         HoT9lkJ3+AztE6yX21wOwvs2zWQ6lsztAd50SIYBsd5YAh57e9PIm3lZV4Lzx6OyjnKS
         BMBrtUHPnl2v16CHMin2Nczhj9CHINjsOFJI/UzmM+uOEjK8+e+myPCOJp5BBjTXV3pg
         Md0/kw2eUWguNEL819twhe+EY4XRoBq1NSV7FCaS3G5xbv/S+0MbJ+CxCCpFNXgotinx
         wUjIVo1xltWyAVyvHjC8nDJWFgIGFgPfoMk7stHw37HZaWP7ZMedBkLp34L1Et77rdpo
         zbKQ==
X-Forwarded-Encrypted: i=1; AFNElJ8UuJsYHtoRFab73n54FLttkquadyqA8kjv+FMz7d7bVbeXuybLURb1CVejgV3I5CbyqRiPEjeDWrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqVjCyDS9AKlwOaEacIlcdlqTY0XpVZC/2iKAhhtZ+VkoppbYa
	LyT7XcxsmZs8X0wwXfP3SHp65nlIYLjiO6HglswmnoGbA+7yGt0XEnIjEhQqs6Qk
X-Gm-Gg: Acq92OHG2SSVJSXVhazox1B+fKKti9bkswLJhDCbW2dZwK+/Kk+dGgcc1hInP+xel0+
	VFxGoNc1bLFuAgmQmdJeVdNavZ8RRbSp0Lck6GUiyVfu5k7BmwBcAHGBRyfI2vowjVrbnrSjIog
	WgAFQwTEBuOnyw782cHc4bK8FlaamF3t24xQ6x3iYtXE2q0MgHvVwMCiEHK8MW32JK513pM6U81
	/+gPvpHc0jJyHowxW8y704bOcqNBYVhVHgyEW41cHiMeneM3ntxZkwzonZF2luuUN+3GHcWrWWQ
	yk+6a5WGtSd4jKCcnuBOLeoyJej+wpNB3tg87MnuFkCQRL8xwaDL73O+bBd0CLiAcfX3EK/phG+
	6C1iyWCNtaIyLKNvO5giyDFvv6a+18xSUIj+zNMPVq0LFiKdC9/tE8oDWjUwa0UCUf0SDuiR74x
	VPQ2LgNL3MROxAFeD2DIuzGDFLMPk=
X-Received: by 2002:a05:620a:3727:b0:8cf:bad7:20c5 with SMTP id af79cd13be357-9159af5890cmr400348585a.25.1780559142818;
        Thu, 04 Jun 2026 00:45:42 -0700 (PDT)
Received: from localhost ([149.40.50.195])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a37c4e6sm505365785a.26.2026.06.04.00.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 00:45:42 -0700 (PDT)
Date: Thu, 4 Jun 2026 10:45:36 +0300
From: Dan Carpenter <error27@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: backend: fix uninitialized data in debugfs
Message-ID: <aiEtIGOFhF8AfUCT@stanley.mountain>
References: <ahP3O2tQdu4dNx_c@stanley.mountain>
 <CAKqfh0En4pHqSfxfd2FHSDTxfWx6BfJLfeQ3xup4bwfLSTrZRA@mail.gmail.com>
 <20260526191946.409160c8@jic23-huawei>
 <aiEpmqKwFuIMRfdl@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiEpmqKwFuIMRfdl@ashevche-desk.local>

On Thu, Jun 04, 2026 at 10:30:34AM +0300, Andy Shevchenko wrote:
> On Tue, May 26, 2026 at 07:19:46PM +0100, Jonathan Cameron wrote:
> > On Mon, 25 May 2026 08:20:31 -0500
> > Maxwell Doose <m32285159@gmail.com> wrote:
> > > On Mon, May 25, 2026 at 2:17 AM Dan Carpenter <error27@gmail.com> wrote:
> > > >
> > > > If the *ppos value is non-zero then simple_write_to_buffer() will not
> > > > initialize the start of the buf[] buffer.  Non-zero ppos values aren't
> > > > going to work at all.  Check for that at the start of the function and
> > > > return -EINVAL.
> > > 
> > > Commit message is incorrect, it looks like you're returning -ENOSPC here...
> > Tweaked and applied to the fixes-togreg branch of iio.git + marked for stable.
> 
> I was stumbled over these patches by Dan. Since the file_operations for the code
> in question do not define .llseek, the seek is not supported and will return
> -ESPIPE. I'm not sure why we have these patches to begin with. Dan, can you
> elaborate on the case where the *ppos is not 0, please?

The simple_write_to_buffer() will update *ppos so partial writes are
supported in that way.

regards,
dan carpenter

