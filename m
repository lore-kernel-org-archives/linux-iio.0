Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3B93C5DC3
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 08:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103002; cv=none; b=bIS2WUy4HQa/eKylfzpv9Mf3IwFMduHoAFhjrV2LqXhjPbcTQnPNCvpumnJHvxgb2q13Q/hQNAhQXlgrvK6PUrz9dC/6xvE6Rgy4UWqAE3pftwSLIhf/AjwkvjrvSKWCkrdXKfRws1j4kdvNV0whFI312em8cZoaZroVjKrCm+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103002; c=relaxed/simple;
	bh=hPRNYd/wHYOBqfZ0XEK7i21Zam/Mk++bMOTaJccVRsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcs+3C82uDKeElAyihksC2PFlKdvbUHiF4JORz7OoEK9cI/Q0kJj5FZEdIsDkB1tLsvtxUqDBlwpF2VfjQfM4uqNHweiwXhQyfTwKjM+Ev8TSlrWFDgheWxDvPOVv6FstwTfcbMc7WE2/oE8T4aRbuL3VYVzmZHFX0yEVrXjE/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnAdGbDO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnAdGbDO"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493f140ca8eso30880035e9.1
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 01:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784102999; x=1784707799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VXTUbhc4/2+6BBrpwPWy5jO4ogbjXWG+tcivgR76rdU=;
        b=OnAdGbDO4iO8WiHWdXcpwgUmHS5kAtVfS3EClnKBGYchhJ7TCTQ6xD0dreqk3ZpN7J
         3NM+M5Faz06tYIIgUoYtVdAsnsPmK2EukdhWixTkN5Z9lXi45bxqqir16FRIhcVsCaEU
         QkiQBi2rJtNyndyK7BvqTDCydBDem9KLebm/cnPEj1fmjT5ZykKEw0Du/FezZIBW/6BQ
         JVdNGFmQAZezmUgrkUUVLW0x+F6COYmWrnf28OPd08PeTPgo1kkt6EtLuV4HzLE9AJP9
         RRFZy2PyW1hEIA52JnFd3TEt1Jh1KRkt1QG4vnWwFHqcOZwxYWQZ2k15vHGSaxe4phwx
         9HDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784102999; x=1784707799;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VXTUbhc4/2+6BBrpwPWy5jO4ogbjXWG+tcivgR76rdU=;
        b=Ug01C9go4P8FrBGqFLktnw1qoBD2Q5mu8qRXytBnWTdDRqah9xC+wg27uokvPhC3Uh
         zTc7uUozxzNR/gAIj/vFxBzbWj93b3IXT+SNx94c1yYeo53icDlwo9O8U6+6xLNMoufa
         3Wfky3FQYVIh7OXH7EKfftn/GLv3oW8JYiJJxJ3r/HffNK2X6zibBUXtJYhTfEmWNfNi
         XomZuA4JsBT9ccarT23q6fGHkziPIU6wZ2a0v0WHm9ycHtTiTYD08WmZMnZJVeQMAQn0
         fOd48k3BD3/CHGfrZiCJqLyovpMhu8P9HztB/XzhxJXV0oFVhK4E5QjYqPVtUsqRt9jP
         LMWg==
X-Forwarded-Encrypted: i=1; AHgh+RpNjHM6JZHV23M9MgcUJb+D/aROAACs/m8Xi9U0d/kFd9ACyPeXx97fuv50KUXwrk3ss6LJ/NVFjPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq3wZ+YBw9Ujar1A0XrydqY8/S7ofNA6156afbmipWuSiXYapo
	O27W6gRozdtdOmA/TGUVxOP+xiseZkQAP9bLFReaV79y/TB9afTAthg7
X-Gm-Gg: AfdE7clVbDegA4/Nso8DCXyE4CLOJHZz01ULspzuve9D3qfdxHHwzSE29eYYQsBCV3B
	+LBwOU645LKDvudXzZ5gwIDaISsuHW6JL79u3I51cTrAI/HpLBsLUp/EMmGAldf9NciEf9MB5t/
	A8oX4iwtvin1Nci4OHwaoWGhJsCibeHNPJHimy0l6OboDWPHxYEl9nbonlkEVRXwJlCFtKTAj1j
	2bg/cBWzR0dhcnU1R7UGuEZnJT7ALSM+MogkSNI0s1DCF0UkzYLdkoHWgaYZkcPFFAwTrFj+w1E
	LdBqWwHkn8hYBQej/p8/QXQ30g1yDKyO+YigRGK5PcOzS6zTYCNzApW6luvG57TXTX4LM3vJsyd
	VY2JQakcHucOdzBvGHK+Z+e9kdL7wbb7K8+FbRDRBfoKkO2blGmInsSTIg6csv8bYA+u0eThefp
	EGlohnJh/Mm7xw05IWLtas78nLQs+Dit3WMESh7r/2UHbmOEXLJykKnPFYnQJNaNF2e/2jTZLwD
	NQicO0EFpXzggYPpZaWh/LZulroV3/R2oyJkjTAsEGdxVLYtHW7tP3DQusjRWW8IZfTeYdh5EXa
	cumlHWGO8sIhZfwbmm3nQtGJSL2IoSjwcxr5b+jzve4hTGs0gg/J9RS995JHwFgnGws1b3ILaxA
	6mg/8BEA3sNBhkaV7w+sREG8=
X-Received: by 2002:a05:600c:4f90:b0:493:af56:8e64 with SMTP id 5b1f17b1804b1-49538a1755cmr57000575e9.32.1784102998757;
        Wed, 15 Jul 2026 01:09:58 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953f643acdsm916755e9.3.2026.07.15.01.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:09:58 -0700 (PDT)
Date: Wed, 15 Jul 2026 10:09:58 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: light: opt3001: split opt3001_get_processed()
 logic
Message-ID: <20260715100958.000046d9@gmail.com>
In-Reply-To: <alZsCghbqDBF6X0d@ashevche-desk.local>
References: <20260714-opt3001-unwind-cleanup-v4-1-7ebea805bfac@gmail.com>
	<alZsCghbqDBF6X0d@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jul 2026 20:04:10 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > -	if (ret < 0) {
> > +	if (ret < 0)  
> 
> At some point consider dropping ' < 0' pieces for the i2c_smbus_write_*() cases.
> Read cases are different, of course.
> 
> >  		dev_err(dev, "failed to write register %02x\n",
> >  			OPT3001_CONFIGURATION);
> > +
> > +	return ret;  
> 

Even after an 8-part patch set, this driver still needs cleaning up!

-- 
Kind regards

CJD
