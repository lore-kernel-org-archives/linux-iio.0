Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852643D9DD8
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780054839; cv=none; b=kTLyZl6u6oQqUlxw2gwD5eUYl83+5WjJ4gD8oEB4uJl1QFqm+ifswdA7GVjBY4OCvycikRZ9/L6GHs8q1OjOfCYq1EnWBTn5tn9g/zjHLUZCmNZrByhpsH/sHH/KC8hs/XOPDooY0eWypwKETb2gy/zG/Qv0jaXKUnhfP9P/obg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780054839; c=relaxed/simple;
	bh=UdoH9v2264a88kp9dYn9Bs+q1THx8Q+a+wHVLI7diCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBAHLfHrUb94wVMvDJz8W542zwFlsG+zPSht7NXicYSQizBv/BK+5WVEgmgtnalJYDMgYW3cRLAy/iH2bF1VN51m1kXNmGbEWQArLgQdvB5GmPd15jFcN4L7FdvzY71iniEMej8b5u0IUuJYJP117OaJgOud2dhOAHCIthjf9+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=OMibXqXV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="OMibXqXV"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49039a8851fso82195905e9.2
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 04:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780054835; x=1780659635; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UdoH9v2264a88kp9dYn9Bs+q1THx8Q+a+wHVLI7diCc=;
        b=OMibXqXV5mEQCNRTJLjbmYObR13KYuljSFFP/FUsPgo+DIhHXf14qjCSauZjIyXMbB
         fxrI+mF3DBivpNWrFXS7mLA7FT9uinGHJ2MoJNBg0SLwZ04BYM5QpjUQZykFneaINvYI
         IbKsZ6zD+fbJESOtVo/RmvR29TkyL+bvC19zw/6OqFOG7JJ1EQqVU2rW/oG/5xdUKTfB
         nyVh///i+zk1BM2EQ6d5popMa0c+L+e2tEEN9ngzVvrm1mVuRsA+CC5GfsbQnEVsPfHO
         4nZtoZ55Y8abrD47an9QDrv79XXuTsMwOPA6/0PNwIizFv8x5OrH8rmxA/uzNcFa8CoG
         KWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780054835; x=1780659635;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UdoH9v2264a88kp9dYn9Bs+q1THx8Q+a+wHVLI7diCc=;
        b=ikRzcgPuExjdMjH5SBfSWnYjxgAMRG+kC5O8TzrpDvQsayiuBG02WAVxxqDwj5KkFS
         MjtbZ026nRW4uLvcg5tjr2Vjuv1PAai9fsTJSNo/fFlCDmP/HI7LQo0GIjew87ZPyZNH
         4WDDZA2FUd/8Ep77EoGIXq1P5rWyoNJ4u+DNNwWsKDDQAsvX0uLwAG8i7ebkEWkvNaPX
         2rKTor+3YzkraDFAVUiJmAF64HSkF4L8M74bgznRnhbzHKtzd/0e12RushvgkxrYV5Ki
         OsgiXnCugUD/7a2JiE9ZA0k7nbxAgFIxhnhkFK19inxyX70qQJAVk6RVImlouKa0ZD6x
         IlRg==
X-Forwarded-Encrypted: i=1; AFNElJ/Yo1yaPrXRTBMze/Wp5ey6tjipGCeNJSRxhZM2y73T3Tu/Rj3KMcr9/VbHacQZEEejFZntqNQK+TU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1C0ZsEVDHNTsJg9Ws4F5XobpGrbM/h3ivXO7Db7BHsCDWe/fs
	K+FosyhQkLFNuWxr4lIThDXjY1oVx5KaREAloOwCblFsQVPOK21kh4r+51vqgJDdqCg=
X-Gm-Gg: Acq92OEe/jATfBfL8R4SOHW3URo21i23KYzDER07+OoIr9HCzbo79qZ1I4HC/VglCTs
	Ei6hnj6Zqn778FaUU+/tD+quI2mnZkbg0rdK4UdrByiPvvNcLvsckWVy13YizjFu1CLN3rcgo90
	gvhgZ5DIZMtKqqIg31p+OMHZaWPoMyCthUh5oDtc2l4iIAocXTKMAdIbF3r9dYbxvNoNK2VDBEe
	Shl4smvvYUdf6uEz4Ywh7458dgJ4BNVZCykw8aAvtRYHA3MAFn4CMGYWSK3936LFikngt0HyIsz
	IzVsb95X6fhfa8CtsoGN98bRIrail3hJ+iMJcI/kteBsiiD4l/iRwW8PwbdJeEkpGovnvSBNhaX
	WbnZH11AQ6I12ZnaYhVYZI4ClUh6BPhhxtdftUVIcvaes/aXajnGdkLbGWK7oa9VvppRfnIJMYj
	JHyTbT+K2mKMnw+ZRG8MlWDOvkfumGmZOjYu9KGQkb/XNkOJlpCpLbTpXHHj/oX6wpASl91Yo0Y
	okexnbxrgeUlJNs4X0kkR5ZM084Q9Mm6Zp5zYg/dWwUyCcMElFcK8+d1B32uETga3epmaAFtKMR
	KlxetVSIU9tI3ngy/FE=
X-Received: by 2002:a05:600c:1d0f:b0:490:3d2e:b67d with SMTP id 5b1f17b1804b1-4909c0c598cmr48050845e9.30.1780054834629;
        Fri, 29 May 2026 04:40:34 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c6319ddsm41281115e9.0.2026.05.29.04.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 04:40:34 -0700 (PDT)
Date: Fri, 29 May 2026 12:40:32 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 5/6] video: backlight: lm3533_bl: Set initial mapping
 mode from DT
Message-ID: <ahl7MKBzUhmgdj8b@aspen.lan>
References: <20260528135123.103745-1-clamor95@gmail.com>
 <20260528135123.103745-6-clamor95@gmail.com>
 <ahl0La8OQHXAlV3m@aspen.lan>
 <CAPVz0n0kpYBACOo=YyNk31KGwBEoyrf+dii8V6QY4iRCGd2PNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n0kpYBACOo=YyNk31KGwBEoyrf+dii8V6QY4iRCGd2PNQ@mail.gmail.com>

On Fri, May 29, 2026 at 02:17:00PM +0300, Svyatoslav Ryhel wrote:
> пт, 29 трав. 2026 р. о 14:10 Daniel Thompson <daniel@riscstar.com> пише:
> >
> > On Thu, May 28, 2026 at 04:51:22PM +0300, Svyatoslav Ryhel wrote:
> > > Add support to obtain the initial mapping mode from DT instead of leaving
> > > it unconfigured. Additionally, update the linear sysfs code, which uses a
> > > similar coding pattern.
> >
> > Words like "additionally" in a patch description can be a sign the patch
> > should actually be two patches. In this case the patch would be a lot
> > easier to read if you cleaned up the linear sysfs code (patch N) and then
> > added the new DT logic (patch N+1).
> >
>
> I looked into this in reverse. My goal was to add DT logic I don't
> case how sysfs works. My code matched with what sysfs does I just
> included sysfs change as well. I might better drop sysfs changes
> entirely since with such pace this patchset will inflate from 6 to 15
> and beyond.

Not sure about that. The clean up is good and introducing the new
BIT(2 * n + 1) macro does need to be used pervasively or there's no
point in adding it.


Daniel.
