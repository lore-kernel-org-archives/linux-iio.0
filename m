Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD783769EB
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 19:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780083363; cv=none; b=VOsXipfI92FgLVJ+9lCkHsBBvP3V1Fg1QV+3labqavnFbdNfK50xtbkaXekx+9k6Ymuc+bdkOggBIggeNbtLeWHSwOZQIWYXV77Bc9+M0EjOykXtJ9zR+kDklq8Bq9gv8gqFaKYE2Save7lDJpzsiZTIsHquBVmDUXYXVLytEoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780083363; c=relaxed/simple;
	bh=n9h0MjhuSTHJx0ps9EQSx+ZsByKpqYFFUGQ2CiW+e4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHjG0ebkQ6KhXOKfVj64v3Yl7FXVTmhVXRBUBzL0zRKZmXH9AOfzrnlAeuF45uIZxWjCNVLifNSV1DEa14QW8LZA/7zwDLflsOtkAhrzb2AOmT2QrzcBAyaaPlVogPyYGC0aH3pOw+QIAdGMMcdBEZDiyoKaHw/c0djVg2BLNvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sp/Yv47v; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sp/Yv47v"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-68bd9fce347so2128406a12.2
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 12:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780083360; x=1780688160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4KTjjREkFr8HWH1QHpFZ/ConaYsx8lnYSzAqiNOAtQ=;
        b=Sp/Yv47vdtQoBsi8OShahiTwd8gMmCK1iTi1PnTwQxm9c67RILnujnD1k/kpA9a+Yd
         0S28q2pvJGsc9FzI9nHsmx7EGhbaU3i5+hyfvAb0Oj2uAkEaMjn60c55MKhUDRPiOeGZ
         3XxaJIcxhSo7/d+IVem8u2RqO92lZGg9yQkXaYEoCefs6fFo8jto3MPiTLMdbjQPjWLQ
         KFkG0QUqkNjn8BIpJ42Is8tDCwoat+p8Kcw1RH75+H5ts/iywk9gG9k2v+BETQtdg9E6
         DFGFcKpk+IHX9PCp3eM3v06Rw+UXrc6HrBDo1U8/WApMB2XKiQeNYsKH4LbbVe2+slcx
         xd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780083360; x=1780688160;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4KTjjREkFr8HWH1QHpFZ/ConaYsx8lnYSzAqiNOAtQ=;
        b=jZBrKJ6a8fgOm897CrYnOQvr3dSDh1LH8kE+l/VYoqHhOkFlLpJfWFtFSjT7lgSUnd
         PWImcSbygh/vAFzdN6p8dZFmfmGgxO2HbdQhAe0mOtWOGQYsxagb3SLVTVSdUxmAD5Z+
         F5pJy6MA86y7X8WyUCEZe8u0izQ+M8LUC9HraNsYTV+BQKc/4AUMj4IvXZey6O8ubCsA
         ViDg8yXfsy5dyWDuFNQtjWxn3tDQPS6nCB7F8uNU9pjFCW9ZpoAdsnjZOwkELviOCkmJ
         JKn02Q5NBVa0OWsMhZEusXSBXfEYoat7m9sxTyDx6xSoVG2wsf65DxxLwiQEb00c89mz
         DI1Q==
X-Forwarded-Encrypted: i=1; AFNElJ963tSLRNPJDPsRvU4XEYeUvvBiIdqrQRt4eo+9YK5z5CIdMrcPD1NgpF2KT4uGQDH+z8TpEwt8CxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyYXCmSzDoFMbZvE1UIcGMpUzVJJJ12/0Pf0AiefVlnhjALIJP
	+agCPZUPoHaFz65OBAosNK1JV7A3b4UR+ODlQAyYLeJUjWFEg6kjl5HH
X-Gm-Gg: Acq92OG60MPvlrPHXRzjWNVUxbIelZZQANuF34EqetSNJW/r2ioX/hkc8v3hgJe6dVU
	KRDa/fkFQQrgmYOfz6QxYymBNz2xjsQAwR9cBpGlsWEnYRktB1z8Mf0D9sE9J/IYbI07msnt4Bu
	XHQHWgGLEv8J/CF4YIWQ9kzmwzwKLOkeqNcpoDpDA0Qgv9tlZGHCUkyD5D/TaudI/fzGTxxo9Ck
	rfke4lFRbJy4OS5Y+dzHQETYeKI+5VvUo8vI6jRlSidib0XQnGiidCH75nWyP83niE/iiYDdTmD
	9fYxmroNZsLS8wxnkv5HxQlZ9oV4NrOsb4MIFH8AnCUwDhC3G54gqRANhirwKZmNuT6oYNf8R70
	H9uDW+W4Sltj9PjXySPa8L0VpecW/4Phm/M72yA0z9s9IhN54fNJEFJQA5Hi+4Fh+9CNv2OkDRz
	CIq/cmVf6PmSTuE6eOBOlP0N6n6vlcJb+AIDrn4zQ0zylR
X-Received: by 2002:a17:907:9495:b0:bd9:a6ab:a245 with SMTP id a640c23a62f3a-beab344183dmr50261466b.41.1780083359132;
        Fri, 29 May 2026 12:35:59 -0700 (PDT)
Received: from localhost ([2a05:3580:f312:6c00:1b49:dfce:283c:7307])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-be9d27f4782sm95518766b.5.2026.05.29.12.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 12:35:58 -0700 (PDT)
Date: Fri, 29 May 2026 22:35:57 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
	Brian Masney <masneyb@onstation.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/3] iio: imu: inv_mpu6050: fix unbalanced
 regulator_disable calls, when probe fails
Message-ID: <ahnqnXLp5E-zMmQv@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
	Brian Masney <masneyb@onstation.org>, Rob Herring <robh@kernel.org>
References: <20260426112334.3938774-1-andrej.skvortzov@gmail.com>
 <20260426112334.3938774-2-andrej.skvortzov@gmail.com>
 <20260426154330.0a29236e@jic23-huawei>
 <ae50xlJfXiVax6c_@skv.local>
 <20260427100441.68b6a986@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260427100441.68b6a986@jic23-huawei>

On 26-04-27 10:04, Jonathan Cameron wrote:
> On Sun, 26 Apr 2026 23:25:42 +0300
> Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:
> 
> > On 26-04-26 15:43, Jonathan Cameron wrote:
> > > On Sun, 26 Apr 2026 14:23:32 +0300
> > > Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:
> > >   
> > > > During a probe functions after all regulators are enabled, runtime pm
> > > > is enabled. Before probe function finishes, runtime pm triggers and
> > > > disables vddio regulator. When probe function fails after that,
> > > > inv_mpu_core_disable_regulator_action tries to disable already
> > > > disabled by runtime pm vddio regulator causing following backtrace:
> > > > 
> > > >   inv-mpu6050-i2c 1-0068: trigger probe fail -19
> > > >   WARNING: drivers/regulator/core.c:3244 at _regulator_disable+0x2ac/0x600
> > > >   Call trace:
> > > >    _regulator_disable+0x2ac/0x600 (P)
> > > >    regulator_disable+0xac/0x148
> > > >    inv_mpu_core_disable_regulator_vddio_action+0x3c/0xb0 [inv_mpu6050]
> > > >    devm_action_release+0x4c/0x88
> > > >    release_nodes+0xd8/0x178
> > > >    devres_release_group+0x214/0x3c8
> > > >    i2c_device_probe+0x6fc/0x9b0
> > > >   ...
> > > >   inv-mpu6050-i2c 1-0068: Failed to disable vddio regulator: -5
> > > > 
> > > > vddio state is handled in two places: pm_runtime and
> > > > inv_mpu_core_disable_regulator_vddio_action devm action.
> > > > inv_mpu_core_disable_regulator_vddio_action has to check, whether
> > > > regulator is disabled by pm_runtime already. But this information is
> > > > available only after pm_runtime state is initialized by
> > > > pm_runtime_set_active during a probe. So
> > > > inv_mpu_core_disable_regulator_vddio_action has to be called only
> > > > after pm_runtime is properly initialized. To handle cases, when probe
> > > > fails before pm_runtime is enabled, explicitly disable regulators
> > > > in error paths.  
> > > Why not drag pm_runtime_set_active() earlier?  
> > 
> > Do you mean something like proposed in v2? [1]
> > 
> > 1. https://lore.kernel.org/linux-iio/20260401082737.781018-4-andrej.skvortzov@gmail.com/#t
> Ah yes. Sorry, I missed that discussion.
> 
> To me moving this earlier is less hacky.  We are brining the runtime
> state inline with what we have set the power to at the point of doing
> so.
For me moving pm_runtime_set_active earlier looks better as well. Then
I'll change this back to the previous version in the next patchset version,
if nobody has something against that.

> 
> Nuno, having seen the complexity that moving that state change late
> causes, I don't suppose you are convinced that v2 solution is the way
> to go?
> 
> Thanks,
> 
> Jonathan

-- 
Best regards,
Andrey Skvortsov
