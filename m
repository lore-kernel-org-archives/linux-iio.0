Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF5543D515
	for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753884; cv=none; b=PFrYAeQC35qR9YBqOyYtncBNSJ/+D9Obv1iNvCLjF7d5fWVOogPQmdBVwimxX60ttc5SHHauzDf7GX/JM1lXoDtQzMfkjMmO497rhk2OGbN8WSYdfHdfwvxMw7UR/0Thn4ja5d2yMHmrT33RgFiN25SN2YdcuWFkxkGpsKJQthc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753884; c=relaxed/simple;
	bh=ZzxOJDqPylofYp3FrL29P1xnRxESrls3/fvfW5iZ6Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1AYUzSlbQICxp7EYdZrbcU9BOqMH7p2H9zNIWbYUf3K3z3Urm/pAb/ermUNVzT5x23Pt1Z5trvkzJF284dnrLWIP05vjsg55CBaUhxiy5XfsA+D6DkyOEmMnDBODBiPpErhRpQxLtG9qox03hGx1mNxvqv5Sspu6Dx88r/DXFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4WSJ0Et; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4WSJ0Et"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-13a97ffb312so376691c88.0
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 10:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782753882; x=1783358682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cAHgI8v/5iahDWqdzu4/MvO4nkjuwauBP+gsMYKfHv4=;
        b=V4WSJ0EthNcw7okvlNvM7rfEAnrSn/v9giK8zhB/vp7e1+7ewvh/cqgqnQhI5YwW6n
         GtG/P+24Wfcz++WJyvD8K8YjUY9o1UwgQI8D0H3epXJUMMS9KnkSiEBjtF59tZsKp1fO
         uE6HVmFN8tS/RfkOzaj0Le7fz5T3zESzVcQb2iTBMdgTyNTvJD4q5cvsQn+T8k3lrAAX
         hRCv6N/VWQx7VV+Cxj2iazwN++V82lcKng7bdhlNnhsGXb5KFpOAoXp6+jNnFUMW1CX5
         pc/gW12qyzxUsZO3txuRZ7rgVOh54zJjGcWZ7PC/2eBvwSUxAcWnGDMlNzrA2zn/MFya
         AagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782753882; x=1783358682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAHgI8v/5iahDWqdzu4/MvO4nkjuwauBP+gsMYKfHv4=;
        b=lMXHXtNL5YuHhUwS7infjvd4CfImfHahft1UILOg3XKBAmx1Bvv+Y6nsPz39TQlpwO
         e2L/haPxdoVdztZCkg1s7/DzRMfSdjPJD5qdcHbtx9PdiBWa9maMmDZnSgjHgjUVpUM+
         0vyossFpN0de6c4OT4ioOf2R5ddPkkdi1ZSGsIBZlHDJwAVO4779+ZornR1VwzFfFpsi
         YwiG+vhF/yowFCPPI0WOE4HW+tHEeUEG15UA022AFgQfR09Wq7Yscz7dVYf9+C1pOuzw
         SK1+eYT5u5BbfSIDxchQsPL6G724Umh52Fb+03UzFZvWrOfPz6CAJIyHsv+HLfE8KS+y
         fxPA==
X-Forwarded-Encrypted: i=1; AFNElJ+Q2sGJ7u+ytvCmE05IOxqIJXmPts3RPxFQS91KqVmrUW2nfRKUocwjqRjqLPv3iO3A8rsLN4LsMsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyejIFybhWT6KWDAkTQlEyfEVelEAyuMdgxnC5qjvk3Do3zmWtm
	UEJ/xJXWHzeoRQC2KEAxrYI4X3MreZrruOIsn7soo4v+QAhQaC6B8CEv
X-Gm-Gg: AfdE7cnO0Ghtw57dh0rmlyjDEpGFfZRXbtsMD97ytrFAj1jpcKUz+vICWDzLuwHUmbv
	ddmfYOZ5MUWZMoCHEZsSwOg3yrPqmuUF7VSgJhZg0u7vDw33Hv/rOIgS+Dsuaie9doIVKixGFvb
	4UgFnFluLIlOnnaeFeZSxwTxdP4xzOjVRSMPI/nY7dwFMj0AJf5gKcV68G6M+AFHBhAQlEUEnzb
	0bK5kGSi5EV+DrHj1villLwK1pNrwursc1J+YSDW74ygz7OWF9Ose+P6f4/ad7AMG/BBJ1XAhO0
	U3ZlUkk3+LjwHogmJoPYfiH+os8dvEag1rtQr+hBHpmLzgqLAMvHtW0vwpoY3O5HeYiRPdYUhcl
	IHBdi8vGMWpFOp7ZbD4RTz//KLTgD4nzk8+Er+83EIemVSPk8a4K9+M6VgVtcWaIbT774SnBPzw
	6cJtnsc2sTUbr8qRxdDlGejQ==
X-Received: by 2002:a05:7023:b16:b0:139:90ab:36bc with SMTP id a92af1059eb24-13b2a1dcbb5mr155645c88.38.1782753882083;
        Mon, 29 Jun 2026 10:24:42 -0700 (PDT)
Received: from localhost ([2804:30c:1618:8400:e838:86ad:21d4:de00])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d8f6acf9sm47567925c88.6.2026.06.29.10.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 10:24:41 -0700 (PDT)
Date: Mon, 29 Jun 2026 14:25:27 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, julianbraha@gmail.com
Subject: Re: [PATCH v4 3/4] iio: adc: ltc2378: Enable high-speed data capture
Message-ID: <akKqhwv4cbR-fL-g@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1782397418.git.marcelo.schmitt@analog.com>
 <7d91f48bb03a16e6876e7aeb05fe259e33ae625f.1782397418.git.marcelo.schmitt@analog.com>
 <akIHUgTtyZv44TWv@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akIHUgTtyZv44TWv@ashevche-desk.local>

> > +	/* Double check the minimum CNV high time is met */
> > +	if (cnv_wf.duty_length_ns < LTC2378_TCNV_HIGH_NS)
> > +		return -EIO;
> 
> Hmm... How is this IO issue?

Okay, what about EDOM for PWM setup failures? Any error code suggestion otherwise?
Will follow the other suggestions.

Thanks,
Marcelo
