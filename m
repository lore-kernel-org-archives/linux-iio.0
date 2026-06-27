Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87EB282F3C
	for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 17:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782581703; cv=none; b=eo62BEC2eTrQsC2K7HSluj9u6qy7Qe9iiEDNvBstQ+ri98FmlQk5EyjSEPuuRk4x4Ylzv71AdxLja7fm2gs6b49vSUMJI3eNtaKukesQ9wgU9vH3pWlmwLvLGV4uBAT1tzlg4oMzP6dFOl0A1f8dvmgQOPUlVIlOpNfZsPwcRx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782581703; c=relaxed/simple;
	bh=N8wxmCIjvlJ3zUG1rQaPHh+WcHdYjnX1CWEv2VZvOgo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DxPqq3LPoo+zUsyNYVuU7W0sn01fLiH3P8jBVBnTn/9ZWPnbfdy32CyV/zEgFkwcqceqttueIRSHTQudhPdo8gFpHKNto7wD4LofahPObcKlRzDJ0ReWfLIvFmFmJ2aFRQFTTnrzP+9kzpFXR90qGjHXGR2cfEM2WyqLEPKFGIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4UGAsMN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4UGAsMN"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4926f8e02e8so9730615e9.0
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 10:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782581700; x=1783186500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hU4a3CgQpybCHt4vRCqKDTGHLwD2MEH8qFbMIiWE3Ik=;
        b=T4UGAsMNdWINq7iOC6uQoZCoEO0LHnmM7NRsCwYW92GPbtPqBBNgkv1E+L3sqif57v
         f47DzeL6ro+Da+cBaal6sYxEAy+F8EosXrLaP3stuEikAbIgYKd3Ss3tPvcP5RlS83BA
         zTRKsXguQBQ64o9O3I6BDLla9ci2vt3NJ9NzH8FZ1oa0Lqlc4BTsIeRenWxLGp6ib88V
         jVGh810fkDRMFKNQXUxqt0tiJMbB1OTBhpcEc3uo0r/cvHR3JF1ivrYLk25KyD8dKbpm
         67vKSp6P7O79IEAEmcC/30YfnWd0cwxVJqEBEyAlRxHd8I/vsV978q7MNzrJ4AaPYf4d
         hdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782581700; x=1783186500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hU4a3CgQpybCHt4vRCqKDTGHLwD2MEH8qFbMIiWE3Ik=;
        b=INmYPEgFkCm8KkOF6+Lb4NtsOEc9N+8wQNUShRLEtCDKh+JaWjpcQFKHBOh5itnWUe
         XvYITafKx39IaXewMtZ3JUYA9DuO9fkc5+T8fQm4EKL9tXC+1DintfLTyd8FmVkEe1sE
         rBbbMx/WuiCGOQvhBpso57OhtHWSkh3NyhUvbe4VI7ecXX4GtFlViKdcSOtfazNBnpS7
         FAESri40/w16S/YJJ0VtzMWMy2J+gLLWsGAXohuar/08l8Osolp1+MKnyTB1U5D6Zh2i
         vWKOnw2NtqD+Jgk32Y0NX42ShBaqgLwmMIBtooAM/7qc/JcmDILTMaZNVfmkJj7O/5Nm
         fbew==
X-Forwarded-Encrypted: i=1; AFNElJ9o3qYPuR52D87BciBWOULMSw4KunqFBhPqG4uUSQDBUJrfLMqbz6ZsBWjKy7slKLw0PslG/lkpxRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcwMGA7KDyzblDzePb8Zi3tDOocQj9ZXbsaH71t+aBd1tP9iuP
	dHRx9Ck2CYvGag7dnwpIu0gGGIcZh3ew6pScFzE8soCC1NLxQXtCIIvF
X-Gm-Gg: AfdE7clBLxui15WCX3MWzIkNHSpiVhzph/5R/9+Dq0fEg4wZID843wvP3QuUbZA8SdZ
	heEBYtEWNZYvS5Be1EEauXqz44yqad7GXhBCFkpqv9gnP4z4+LR6DRhau15tS/19+hLFdP8p+R8
	/bx6WzsCuyLu+rVKf4Xj89x1qgIDD2KO/aUzv2A6ZNr/e5yQsxf9MN1miyRtTGwbCFreF6Hqy/v
	VY8qQ2vYrI0JO5TQUBBJJoYxgwLd08DUaBcpodl/fy3CkgN37l1CwLH7TyVeZok9/37AlcCyIah
	5Ea51AYS0TM6hp6CPAD9bN7lhv3D24HGvXFbG8zlqMtXgs0aTnS9Sxvu76MhW26U+XWOSFtQdHx
	lykYyt6koDn39/HXgdMkYlBreb/8TygX0304AQ9HcMErhmWcSHyKoPwP8AsZiZ0AAitHomFoF2h
	AqsPixsaUeGjS+G644Q+hwvEzTzofJQAKYFwscT1hiGL7l3aa3AZa9xj4FCkfu4C0tE9PcBjYll
	lwFxgyAouxrf90o1aZA42IftavbtKGBNq+eldBE5kBMimENwxlDEmf3DkYyijHfaVoj/ZosUoEh
	1TB4ZQ==
X-Received: by 2002:a05:600c:a00f:b0:492:43d2:9e6e with SMTP id 5b1f17b1804b1-49266847786mr147140715e9.9.1782581700269;
        Sat, 27 Jun 2026 10:35:00 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4728072188fsm1020409f8f.29.2026.06.27.10.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 10:35:00 -0700 (PDT)
Date: Sat, 27 Jun 2026 19:34:58 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Erick Henrique <erick.henrique.rodrigues@usp.br>
Cc: jic23@kernel.org, andriy.shevchenko@intel.com, andy@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 1/3] iio: dac: m62332: Sort header includes
 alphabetically
Message-ID: <20260627193458.63846d11@systembl0wer>
In-Reply-To: <20260627132530.96680-2-erick.henrique.rodrigues@usp.br>
References: <20260627132530.96680-1-erick.henrique.rodrigues@usp.br>
	<20260627132530.96680-2-erick.henrique.rodrigues@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jun 2026 10:25:28 -0300
Erick Henrique <erick.henrique.rodrigues@usp.br> wrote:

> Sort the existing header includes alphabetically within their groups.
> No headers are added or removed; this only reorders them so the
> following include cleanup is easier to review.
> 
> Signed-off-by: Erick Henrique <erick.henrique.rodrigues@usp.br>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
