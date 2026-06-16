Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ED742EEC7
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607680; cv=none; b=fCAjLVZnPxhyncGhlTRjyW7dLtj0gbJrBGcio5otTeonO+codoZGAaCpFmdI0O8dYXDA3Jx96vo6gN61EtuKDZf1ibUubLsLQohNSUgzrdPU75341aFQzRTzZRBTbAa5c4fUtWC/h2n6A7YOf+TIYC+BWLG6dnkrokv/Ir/vDOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607680; c=relaxed/simple;
	bh=vapRSSgjKgpucYV/YQNBaE52QhXakTyOK6JOBlOCMm8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMXimXaYO4mJGLML0pTi8asOQ39aRKKw3yQSWJyyy6rTTJHG47OBRddPUmC8nTPcPuSLY63kocf++xRXNe2Q3xkHXgWB/b0UQkkBLCHepGrWxou2WUew7i/XzI843WPOImDIh2UZJSBQ+k0SWFrvm6RraErZ1rtWltO+Vly0e3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnVRe2VG; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnVRe2VG"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-460166910e6so2322983f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 04:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781607678; x=1782212478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6r+E+bnqD7lkr9osmWZzqrT/Q+dlZe8ew9RwaM2N57Q=;
        b=PnVRe2VGDcyn1pJwUn0wsfvU9Z8EvNqAJl+Vg7N4kjeN/2tFueLaWIQc6K6B4BI8wD
         ahka17NvqGxblXgQY4joHJHfA1gFgHRuNdTOjSf/ze+KHO5fMfRqWXGinhweKycfeTth
         LQFGoAlfyW3i5eKKgb+j/t+m8zG02Uyi7aMcxMwPx1RCprOAQp2Phv9m9LlgKSu20SyO
         MX2ErpCzj27KfO/M+Hy3sitFw5ZqXiRH8JqOiaNpOc09fgGr8T3hWCdfYfztNKs9b/Cw
         I8/nqhYCgOfwGti6iOaMFSJnGL0F2X7tXopCM3oc6jqFfbpzkCe9Gj/dsPIGsDdpQr3O
         DW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781607678; x=1782212478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6r+E+bnqD7lkr9osmWZzqrT/Q+dlZe8ew9RwaM2N57Q=;
        b=Kezw5FW9kkDcum+L/5made43749MJqPGo5i1HDq14ljeH8Y9onLXiFCugPyy/Zlisl
         facBD+x8JlTe+4aF17e73ih0bLG5I2Z3b3nX0FIbFLzdnLxX0phclJDxslJAtNN4OdPW
         9j96Wo7ilamiNdW02eCvxryNPgcRKNiyBvWDrBQp+nJ2ExkPjWzRDcRU6HAd+FGj47H+
         VVeulHGRpANX9XcNd4vE98mOUDQmWnXPb1alqn+DW3Oip3wcIAaQ4Vw+6gRVvEVo01LY
         JGWIl2TMpNfzPp113ykFT+THchaRqRd9cZPrJKwCRgbCCQGd9bt2QMsV+klVF4o3c+Af
         nsyQ==
X-Forwarded-Encrypted: i=1; AFNElJ9BhVpZSxTZdDCSptV9jHU+nnxgy1N9WXqY/qIb8lvOa9qaoJdECuqXVaSS7Sel8kur6CcYJCo4jMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhK4fwqKOugWWR583kCdk0suS2qhBTfzuK5IHKsRlftYT+cAlO
	60Crs1MBrxJkhO63a+HKiO/qS5GHrt2mffchY984/uWEnpjxHOGddvZf
X-Gm-Gg: Acq92OEIhuPVOboUzEJ/ZJlXsu01lsDtS7keao5r4khLJS2Dv5zNG6c0R+qjOBGpI3N
	LpVbJPih3p5CcWOsGInFQ5huyf+HOxRvEFwI8nCiAfJgsH/btG7cVHgOu1F81Xki1X1kGYzEGm2
	bE424NxTEecsnmiiuYDul3zFNVnmSvxL8upJMRyu/0rL4AKc+jLPWOmNrOPh2BdMQpuwsBGrLI3
	APmAO1p8hIdd5vnFxoSxZI2lc/WdF6f+OxEUvwLL1is1TC39g50XKlSA7ovxZxPXU8FNU4uvFhi
	hocqGGMhNbD2LwUl8XRft0s3Kl83rDHrYWGdPMD/dbMPI9cLMU01RHun737iw/7WGrsW4t52W6q
	trR80/lF27r+hX6iub0Yal5qq9exy2F145hJ8c/fKU+SOmaBz9v/lPZLFH1XdfLQqtzo8afQkqs
	EELEdzryF5nHv71XOPZyepxwq9x3Qa3zDtRmAODgpsKo8QPdUyvyh+m3stJG3vPBqsJ5gJitHOn
	JKP9x/ejcnbaHiuO+kMhb2wygJGJ95mAjWRcmLHMqW8b2BExlGxs4lq4rPyPKPso8j912QvM6pC
	/tfIdqjmXlsZrPE0mHQd6AQZnIoQBJ0c9MCrJuu0w/5XxtcZQCV19SgbdNruqUO4Ww==
X-Received: by 2002:a05:6000:4201:b0:460:5022:8a76 with SMTP id ffacd0b85a97d-46077f2bed3mr20985676f8f.31.1781607677690;
        Tue, 16 Jun 2026 04:01:17 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c3782sm38824083f8f.25.2026.06.16.04.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 04:01:17 -0700 (PDT)
Date: Tue, 16 Jun 2026 13:01:14 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, Srinivas
 Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org
Subject: Re: [PATCH 08/11] iio: hid-sensor-magn-3d: use ! instead of
 explicit NULL check
Message-ID: <20260616130114.00004d27@gmail.com>
In-Reply-To: <20260616-15-jun-hid-iio-alignment-v1-8-0cd544286575@gmail.com>
References: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
	<20260616-15-jun-hid-iio-alignment-v1-8-0cd544286575@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 15:56:13 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Replace 'if (indio_dev == NULL)' with 'if (!indio_dev)' in to follow
> the preferred kernel style.
> 
> No functional change.
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---

Couldn't all of these null check patches be squashed into one,
considering these are all the same logical change and affect
HID drivers? Surely this is code churn a bit.

Same goes for the parentheses alignment patches.

--
Kind regards

CJD
