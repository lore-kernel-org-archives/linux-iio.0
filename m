Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0969639AD55
	for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 18:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778783742; cv=none; b=Rke+DG5fIHGYEGsXGvnv3zIT4GpeJ0iu0rCr8FqCEcjhqzUIZql5cGGxR5rztTqCcTcDbWk9H9HJw9qnmOPyUG548pHvYbz2Ko9Bv5x2UamyQV4RVRwRMoW/JScnJx1vGL7NaO8z4ois5yTvN1BeqWaaizRNpoo/Qx3db/sSCXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778783742; c=relaxed/simple;
	bh=UHLZrmkbalB21d3x+8akHIEbjFUQb+tufhtJvMP9eno=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References; b=cgTKjNxp5BDa3NHs4DYYtzbwgBFPtka5TnvYoOxjnLBxDl+luSO6riLnGPrLq34+Kb3J9Txq9LXMGAewfJNAkVN0RvATY7HOm8XPqSapzJIuWD/JBqhc+9y86kSQHPTS2ndn4zoB3ZGFq636RLSK0FNp8GwqJGy9nmtZ+6cRPWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sEmOLkhM; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEmOLkhM"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-393925cb1baso86265821fa.0
        for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 11:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778783739; x=1779388539; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHLZrmkbalB21d3x+8akHIEbjFUQb+tufhtJvMP9eno=;
        b=sEmOLkhMpT9TlxwU35rArQ67YdMfcipI/Uv7DmTvldynXL7A0cSHfUeFhlPglbMliG
         mwdfaRYFQHY44wyr6oC0MXVM7lw21m1z3H2ZyYCD0MqJWBAaV46wHzn0ZvPsu92V6OXZ
         rPPYegGEVq3uwnMYswZvtfvexdjPx5f+CB8CWu1mw3R1VYrNddV/otYm2bj6zjIp/LAK
         qxKXrvgatXaz1O3/wAMAI4vEYo8KoUtmDN9xqP2j/wC4tHvMaJMbYGgU2oQTf2He2pqv
         QNgrKQi1xRj4pX6kYphW1ewK+VDdaVVLB1SqzKkgiVhdWC6EuYdtFYhBzQVE+kvolNpE
         LiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778783739; x=1779388539;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UHLZrmkbalB21d3x+8akHIEbjFUQb+tufhtJvMP9eno=;
        b=dlvLdcjYR7Mo/w757yBYOCqmHIiRFqbFU6hrlBq8js387FAOjOwNczHfIe/1yiLhRl
         wP/jTRli+ldCc2tMcRNs8hwo6QW7hKjhXiMEMCfW5AmdH4QCi5dxk4r70IsF/N948FmG
         Ts9tGDdinUaFnlRuSXpaLugq4+ngfQyOpwpNSPfMw6jN8eyd3Nzk1Pzwl7+7lKDs01GP
         4TcOfQLDvUDoCOPQdsrmhH6H1mGnnTg0KOoo4T6l3DRR4uuhdn/3zTC5yRMo8YriB4Ns
         K3Fy36pDU3Xud/yvNLj7VkgsKevLJ3j3C3kpvm0zhtful42N1yvi1FZxad5Q/vwoX5rb
         YBng==
X-Forwarded-Encrypted: i=1; AFNElJ+w4w8zRfFHn+YKi6fgxtWiuxPue5m2fa5YvYjQG413RaV0bX4nLceIRrU1Soq1vVqJZgsMO6bYu+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7EuPgvwe4P+rsYDiuhBY+hYm+6XGcG8jnDgyiHkbIMhKKo0Mh
	tEr2mGwMY2zhltIQv9+gQtYoUQZVpW2u3PNaddb6vdCDnpF95yU3q97y
X-Gm-Gg: Acq92OH1wzg/1jgd9Qcv0jvqKMSFBiAjF7GsgJ2aHoowUomm1TkPPQHJXaHbIJcMH+N
	GsN2zCtim3fiuOZOQHhZED6VdCcjda0lLwHv6e1xcqE2O3vmgA4VNaaB8vPlYv1j4ckvl/xL5qY
	0Ln7+tKDkDm3To3zyt4RRbOU0OEpq2uQhCT1j68dOotgd7fQJ5TsuoXtXA5vDF7MOKP1TLVwW1v
	KUCHRM0AWsoshxphf5k5BQxb8tH7v9NQXsUVKsHDlyOOeD0YtTapoSlnZR5nraLm3WqKa6IwC49
	jg0K8ghVbaeLaES5CqwhnrzXapHFdUd7X3bE2rwq17TMSmr56wizHyE0Uk4OmXfCJq+iKHC0Apx
	JS1tl6F1syDzi5ygRd/AWRImO0zGQe4NIvxfjU6J0zJ2HwC1UfsuQ0yBoL0AA9ynOgvdiYWKM07
	PdriYb/mPpeUYurBCMoO58JOyb7cxLycs+JAWneqGgnV8aWw0zm1FHYdznunSz2m0qzw/n/ds4i
	icAJLkd2A==
X-Received: by 2002:a05:651c:e09:b0:393:a5dd:135b with SMTP id 38308e7fff4ca-39561d4c039mr653601fa.14.1778783738891;
        Thu, 14 May 2026 11:35:38 -0700 (PDT)
Received: from Shofiq.home (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3945c8dc7afsm8013021fa.14.2026.05.14.11.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 11:35:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: jic23@kernel.org
Cc: andy@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] iio: accel: adxl3xx: Add timestamps to FIFO data
Date: Thu, 14 May 2026 21:35:37 +0300
Message-ID: <177878373700.35036.18408837738235928455@gmail.com>
In-Reply-To: <20260510082556.3867-1-shofiqtest@gmail.com>
References: <20260510082556.3867-1-shofiqtest@gmail.com>

T24gTW9uLCAxMSBNYXkgMjAyNiwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToKPiBJdCBpcyBwb3Nz
aWJsZSB0byBhcHByb3hpbWF0ZSB0aGUgY29ycmVjdCB0aW1lc3RhbXBzIGJ1dCBpdCdzIGNvbXBs
ZXguCj4gWW91IGRlZmluaXRlbHkgZG9uJ3Qgd2FudCB0byB0cnkgZ2V0dGluZyB0aW1lc3RhbXBz
IHdvcmtpbmcgZm9yIGEgZmlmbwo+IGVxdWlwcGVkIHBhcnQgd2l0aG91dCByZWFsIGhhcmR3YXJl
IHNvIHlvdSBjYW4gcGxvdCB0aGVtIG92ZXIgdGltZSBhbmQKPiB2ZXJpZnkgdGhlcmUgYXJlIG5v
IGluY29uc2lzdGVuY2llcyBvciBidWdzIGluIHlvdXIgdGltZXN0YW1wCj4gYXBwcm94aW1hdGlv
biBhbGdvcml0aG0uCgpVbmRlcnN0b29kIC0tIHRoYW5rIHlvdSBmb3IgdGhlIGRldGFpbGVkIGV4
cGxhbmF0aW9uLiBJJ2xsIGRyb3AgdGhpcwpzZXJpZXMuIEkgZG9uJ3QgaGF2ZSBhY2Nlc3MgdG8g
YW55IG9mIHRoZSBBRFhMIGhhcmR3YXJlIHNvIEkgY2Fubm90CnZhbGlkYXRlIGEgcGVyLXNhbXBs
ZSB0aW1lc3RhbXAgYXBwcm94aW1hdGlvbiBhbGdvcml0aG0uIEknbGwgbGVhdmUKdGhpcyBmb3Ig
c29tZW9uZSB3aXRoIHJlYWwgZGV2aWNlcyB0byBwaWNrIHVwIHdoZW4gdGhleSBhcmUgcmVhZHkg
dG8KaW1wbGVtZW50IGl0IHByb3Blcmx5LCB3aXRoIHRoZSBjb3JyZWN0IHBlci1zYW1wbGUgYmFj
a2ZpbGxpbmcgZnJvbQp0aGUgRklGTyB3YXRlcm1hcmsgdGltZXN0YW1wLgoKVGhhbmtzLApTaG9m
aXEK
