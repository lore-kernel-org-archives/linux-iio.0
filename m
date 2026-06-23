Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02EB3438B1
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206999; cv=none; b=tEukS/R8yChf6NlMiFJiGAWwpG8aWbme1au/a8d+voGSHgkqnqm3Gn2kvRbBeVeE1OPOdOBk5hq3OPSsKtIA8ijb62R8pXjdVBgOL7RQ1pxc+7ROZa8l2b/leLAqROnVms5ZaWHlwtYlewQWCtHT2AXUIKwCFacDooTjDc6IFm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206999; c=relaxed/simple;
	bh=6kIH1ANk3srlp8dDNIH1duVV9MTpe+sd+seqU3mPp5A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kfTOVMX+vYtx+IyIanFUAmdX/MkCjteJk4n9zp4dzQfzeXQcrXZ6tZXtO7YJP896ZEAS8cBoNHvAicVNPMVIEEaOGNHVr7cxXTuG5q0cABMDFYjtHrCNMsoV/y4DYKjhL/EZGPOxw7yfg6rujWtPYWfGXdrmUFT23ej0DUguvQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9YazmGV; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9YazmGV"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4631679f204so388221f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 02:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782206996; x=1782811796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAhVKTcglJuremrfImjaywPyVqu4aubOLdy7WaNPAJg=;
        b=Y9YazmGVEeLykjxhAkWcKLh/UnR7+AJyOVHELYjY7Kp4Lnl/GlA8ievUF57F0UjvW2
         FcVcyc3X4n6nFUcfNNflcBUJ6FXQEIUjIBwGEMRgcM9mCvLrYcjfwhpQVK1R50pya/Nw
         zl2iTT4TjFA/SDv39iCdAh4kUvo7JuqERKiRsbEsnETvDmG126gjpjQbFB54d2YO5g8i
         JkOrgHK8OuODCq+/cWB/t66Z1AeQz4uy1Fonlbc/VsMLkE2mTUmczBjLv78dR13wcZpU
         iSFBBNfIFD+4ZGNz+zqLIeaZj0AgXqpTa5LMTZGaUv/JutcEe6hAnwe1Q3w/iIDH/Mzb
         cjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782206996; x=1782811796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OAhVKTcglJuremrfImjaywPyVqu4aubOLdy7WaNPAJg=;
        b=ITt64AoMkZrFDqE7rGSfOrI9Gx6cpppSWzTJerTPvtyIRk4jt2EPWpLSSlF/vpA5OY
         zp3w9K7ORfxKrJ3gKOlrYQLswo3au3OKrNvSz1JYz55XCpSZXZY4sgMqC2K1o7H6m6eu
         aeTR5yLGlXSGBj2DP3ZmKTOm3M6/SUSecmlAoyk27xaU4kfB4QDvGlUf4Xxz34Gw8KqQ
         2tewvyYvsVqqFQ5EskAFftfJEmklM/jWUQButsY69TCZZCJykJt12kd/DCWSvZvPbKQi
         /2e2qGLauHsBxTNxIF8peWVKvGVSE0F4voSk8RE/BVDMfGFP3dS356AKINRp709fZSEf
         r0BQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp2SxdcpEnv8cCA+nlBv4Z4Y2FWRcUp/zOA5RGTp8/h3QfjJPwD7l8Sx58hTQUxup9IWK+dY0KQfTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMg707/kv6kgIInkHjx4SROO9kMpccEqB7nI0OnmhiFSaQ+dom
	uW1HKXrHjrtBgmG+4ZOUT93ldAMPhcQhEuutVxpo4c1yPP87l2Ixu9x+
X-Gm-Gg: AfdE7cm/G/GUvjK26S3gYMwoddWb80O/33RdFRC7HdS8uyjCJDD3FXALwuPqKxRxD7Q
	9b/TrvpNeZvY7B91dYcFOoj50L+B08DN46PUpICKhj8BUOBW8mka7rwzBK+RcBCBa8z2grnKBS6
	OyWc5J6AWiNJiNaVZGkg5ye7/57khYRtFRSxi2pZWLzQzd+DlpTBnc04JrS0vV0B//CNTvFJ68V
	0OV6ElNI3aBu6PMpTL807MRHmCpgjzWmGqYET/k/91wsa3gXT/ZBFHxDYl7+tcGjNQWlHlftMXU
	81ZlaElRQpJau7OgAh6b2IqgTGkUfvna8tXym4pkcQPa6VD3q1Ke313Bak5qPL5I5KIxzoK229c
	uzrdes/ljRbgbNQa2j5N2XuDBtUK4MYkHECCvK2I5USRB4/bcll+RjxwUf5NaRjfoZN4uGw4J4o
	+xh41DAQwXP4t4tr5paw1Sxde91bH+xd0DMAQ1e4sNV2z4wyDdmI2VyB5Qr3tVJ++Cfn1eUu4J/
	pADLvVjdd0SVsmsYY1yUrSbZlXCGdSRGzywN9feCpMaEXxPZ8PpBimDOD4kYL1sMoHo4L2c8bTL
	i8M0EBP54K6NZ7mpmDbXmjm8uSFHgSvz4aHRHuXffgO4yPk7BPqjc5k=
X-Received: by 2002:a05:6000:2489:b0:461:a15a:4160 with SMTP id ffacd0b85a97d-46a7fd24e47mr4547391f8f.13.1782206996068;
        Tue, 23 Jun 2026 02:29:56 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666c57a0esm31850073f8f.27.2026.06.23.02.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 02:29:55 -0700 (PDT)
Date: Tue, 23 Jun 2026 11:29:53 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org,
 andy@kernel.org, antoniu.miclaus@analog.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, duje@dujemihanovic.xyz,
 jic23@kernel.org, jishnu.prakash@oss.qualcomm.com,
 jorge.marques@analog.com, krzk+dt@kernel.org, linusw@kernel.org,
 linux-kernel@vger.kernel.org, marcelo.schmitt@analog.com,
 mazziesaccount@gmail.com, mike.looijmans@topic.nl, nuno.sa@analog.com,
 robh@kernel.org, sakari.ailus@linux.intel.com, wens@kernel.org
Subject: Re: [PATCH v4 1/3] iio: adc: Fix incorrect reading when datarate
 changed in single mode
Message-ID: <20260623112953.000066cc@gmail.com>
In-Reply-To: <ajpO9zaZbIl3x1uC@ashevche-desk.local>
References: <20260622221550.374235-1-jakubszczudlo40@gmail.com>
	<20260622221550.374235-2-jakubszczudlo40@gmail.com>
	<ajpO9zaZbIl3x1uC@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 12:16:39 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> > +	return read_poll_timeout(ads1100_new_data_not_ready, data_ready,
> > +				 !data_ready, wait_time,

I'd actually be all for using `data_ready != 0`, to make the condition more
readable.

...

> > +		PM_RUNTIME_ACQUIRE_AUTOSUSPEND(&data->client->dev, pm);  
> 
> > +  
> 
> This blank line is not needed as they are coupled, but I don't know if we have
> an agreed style in IIO for this.

I'd be surprised if there was an agreed style, as there aren't any IIO drivers
that use this specific macro (not in mainline at least). Additionally, might I
suggest using `PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND` as it is more generic?

-- 
Kind regards

CJD
