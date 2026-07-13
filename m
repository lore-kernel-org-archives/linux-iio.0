Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0E42D47FF
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951941; cv=none; b=X1RpACCsxnJd13T6FWdXSjbp0zZ/PLIqER8Ueluji/c2e2FGTXS+ydqraSruSITiQT4RUY3G11MYtW43fEtvjm/uXO7NHTDZCxOyc+qURVrdMwjEkxMuHABg/d+cWcwf+oyEsUjX6WcfmlBLa0x41PPotSK4acZUAdH4QdsaoRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951941; c=relaxed/simple;
	bh=bkfxEHVzEoYCowt9lwKhpqu6A9vt6KeYyyg5eW8TDQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IFRoSOeTFk5DdfsAgmn4S131P0jFuU1RftX7Wo/9g49ai88/B+HUr3L9haqYII4ivAs7kdw+HH8gPx9fwe3WHgxxPtArw1bO40W4WMbJ/FYiDAOSXE3VPgnWJRGEtEF18WVAxB/Bf+MJ9nyJ1K6RwWxFzB1vHGFwfEfuHsu0rj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2kO+TJq; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2kO+TJq"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-476a130c138so3851462f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 07:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783951938; x=1784556738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YO4iO+4RoSYMeteNu9nUAyD/efKBamp9eHyouwcTSY0=;
        b=X2kO+TJqZaXwvK5rbcew6R/B1kR6MikwWFfSxMbEJa7Zl2W67Mq4DUBpDDuKuHZRR2
         mBSpRl/w0jJv8i6eejXEKrjlh+McKHtJXLP6jpGKf46Ll97VaBaF9CE/9wXFFqLYQxyg
         7ejyWoGxeAs8ziLsyso/jl1oT/Z4NEVRiMHrMEgVI559a4n9Fz+Ln/xCWNH08dJxIACg
         EZj1ZRHcAi2raLVIa1z71zkQF9CnFg2CtLr1EQi1RRnU0hHHdWTH9jTCMe9OWXLtvw5E
         OEd01Bpqasifn0mDefpBHAySucrN5123LGUENne0eLSiFvoCxcr5MTk7fCZwjmedyPhm
         AO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783951938; x=1784556738;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YO4iO+4RoSYMeteNu9nUAyD/efKBamp9eHyouwcTSY0=;
        b=GWfd55ZEj3laoejWlVQvmWIOaevQpS9umeQtuPt8yOFnRxpDckfPqkJ6uydyh185n1
         UuZd5gkuWYvK0PqZd69uWFu8LkBMd19u464RR17XoYmXrcRmWtA6D5g5CWQj75MDX6Ed
         wN8YDUQf+QMl1eTNy28ra1blkrWFLRPo1bMmbCpTh99lDNje02do/mnSDvjcvG+VHDsT
         uBcOn2MWPjCMYah+clDmPpv9IK9JbXxvyK6dfNILlyJL5PljcSnmKhyCgzEUo80w2j28
         f0RlFaLWn9R1afhMkBn4sh2DuaAisXAWXuQRyyZ5thCU0OHrqkpY70IKahJ+PX+BfVba
         ewjQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro0425EFGmY2gn8+hx9CRWmzPdXbLn2dwWRgAzgiGdjteFrFisopsAI8R9Dd0sXREOXjHZ1qd2fjUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1MveN6FHqUx1Mi1QrOuW9iwA8rm7RAoHJu3fui6hjhzLnQe3u
	Mll5/f6X345fZZrWiwkHwBnsjOhSj2eTx/hO9LwZsh0s424rUwEjO4qV
X-Gm-Gg: AfdE7ckQphpDTew8s5EOUUnQOjQeYxqyyF1ItcCkpgF1x4XH1Exj4dKTUt7QZziwlwq
	ztbZRdECtRG4ywlR+xr0vZgsf/lI+WVgyi/3lkY0VsRZsmqWqzyxklT3/rtBA4wxtXrBjc2W1JZ
	WJ8tWh7KKLlTCWr4ftilHObKmMhcdYXKYFdEesR3CH0JAuo7/MT9J61m2BaUDWKRu/X/yQd+QJE
	50yIhVc4syfV69MvaD9OenK+IZnlFzC1cfoiNyVAmnorVekj9mUYqCp5BdpUEhzFwIvxaUrx2Dy
	mwxLxaLzASrJxYBWcvt1Mv1PizpXGUlu37ZVtALRz0aga1k/W22Ipux5jenDvqkzLGINc57El30
	IusM8iZqyhMAjm+VvK0wLtFNeOIvGvlVzir4+mElbjE76bLcGZ0fETh03o+pIzah+aQwW/j7aDL
	3AQu6KpOT177rDXPGmynPD0yjnkL6Ld4eXC69c7bYPhR48N0FtLxpl94kcJlz/ggOiSBtIEBIJm
	7dz4nnTaPglSuZL9TbAPnPcAmtudQe6BX17hSVR3D69jbYZ1OmeE1uzHHxyermhN+j34xKTfBeb
	s8Kz+F15rzQ1QninCTdnmClxTdUtV1zoku8G07RD63zorijubQulwExYoZI0t+ZhbM2uzw3oiTA
	PdG9WQ8f2Xw53Ewe5Fin2wsIQe8P3cbdyxw==
X-Received: by 2002:a05:6000:400a:b0:477:3d23:f920 with SMTP id ffacd0b85a97d-47f2dcec627mr10652902f8f.26.1783951938155;
        Mon, 13 Jul 2026 07:12:18 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f213e8sm84998163f8f.34.2026.07.13.07.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 07:12:18 -0700 (PDT)
Date: Mon, 13 Jul 2026 16:12:15 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Pan Chuang <panchuang@vivo.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, William Breathitt Gray
 <wbg@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Julien Panis <jpanis@baylibre.com>, David Lechner
 <david@lechnology.com>, linux-iio@vger.kernel.org (open list:COUNTER
 SUBSYSTEM), linux-stm32@st-md-mailman.stormreply.com (moderated
 list:ARM/STM32 ARCHITECTURE), linux-arm-kernel@lists.infradead.org
 (moderated list:ARM/STM32 ARCHITECTURE), linux-kernel@vger.kernel.org (open
 list), linux-omap@vger.kernel.org (open list:TI ENHANCED CAPTURE (eCAP)
 DRIVER)
Subject: Re: [PATCH] counter: Remove redundant dev_err()/dev_err_probe()
Message-ID: <20260713161215.00001cc3@gmail.com>
In-Reply-To: <20260713131005.306069-1-panchuang@vivo.com>
References: <20260713131005.306069-1-panchuang@vivo.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jul 2026 21:10:04 +0800
Pan Chuang <panchuang@vivo.com> wrote:

> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_irq() and devm_request_threaded_irq()
> automatically log detailed error messages on failure. Remove the
> now-redundant driver-specific dev_err() and dev_err_probe() calls.
> 
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---

I think you can drop the commit hash and title from the message.
Otherwise LGTM.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
