Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A0E3DE430
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782840199; cv=none; b=t1oVzz7XY8AEsDXq3DNA4WVIXwQtToBBvmQ25brbhHDomVxxL6GLc15EO9rNke7cf5HYycHZDmrsJkTuzATQfjKZhBglbmXRiDvN+UlY3ordTyBjs6Gg8IEba0hAT+vNatVjvVzwk+kOEsGNIL9DXHWsx3kjLkpf+YcFADRb5GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782840199; c=relaxed/simple;
	bh=dEPMYOHWcuj/X4YUDH7n5obSn7J2evTceRVwN62/sP0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hWEACuqqXyeBdQHyBV29ldJYlVcc9geqsxgp6bBHhnKIB+mQHCvPn3MjTR30CP4WV+4vy80Y7kW/OdPZNfDvWoMpfyYmIvcYNB3EXWbrh0PNyXhKRDLw1Bjc/rv2N85VsR1jnMIQm4stykSjEz3ZlZf2SAZ8bZ0HZ5Cdrn+pG2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JY8Te4TD; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JY8Te4TD"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5bdbd631a6aso414058e0c.1
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782840194; x=1783444994; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSKzFIqWkpqoxJ8SgMjBQdt3/hhUssH132wtiVGeZxQ=;
        b=JY8Te4TDwqQATLUaHKwlfx00qijydEZKTXJBoAkn/+JXySDXG1AToz3uxiiOVL1G+s
         lLlw58pMsiSvJ13mzla+PQi6uqRuyYmt/CUJBLc8b/ZSzchR9SdlLV+3wirmh/5rn2uH
         tIWhHvXZhss7Z/oEPad+MsQvaDD8pMElht3gCiNNS1DV6rwNB0tDjgNEWXdlGVTBvyCh
         gC02FRpraMpgvHjsuO57rdKsSXDsxhyAD3zlZ1QNLVNtGuOVd06EIyFYULoi9IQHKA/o
         f2ibjdOxOI9dTkohmIfY1MRREXUNWYM2a9dM3fuTV0jV4tYogGRpd9RzqWzT9d6yD8po
         liNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782840194; x=1783444994;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rSKzFIqWkpqoxJ8SgMjBQdt3/hhUssH132wtiVGeZxQ=;
        b=a2ZEG2ltij2TnvdokllclbAbfNy/tWud7JOL382D9tqzJ3mnWmiSf5HGOFFWZdN22c
         pLzWel9irM6IV2aNd37dshlv/jGzN/3kEVhUpriPWOsXIGIW/W6dMTsJoLqNHtkQ7yA6
         6nbAC2eiBDE635Fqr3DmIEbpfWd4JlVIc8y74S4Mt2ZT8ZS8Xy0c87cYvbV5C5ntX/cT
         ZZftw8nst5i2bLU+53YdC/3EAwV8cyQ/oSdhmnA2CPL6GccFv1M/pe3iznjBn04WLamt
         N5U2Zs27mGrzP8xElbIVYCvjCBvoBxh/bq1JZJT1KU6aDNYpMzQ4jRO0G0e5vDW3DSMT
         FwVA==
X-Forwarded-Encrypted: i=1; AHgh+Rr6aredf2UsQz0H6u3KUEv/JfSFpcHip1KteAAHG0bEfbsBspLp+wmPqL5EFCu1pfIJ1U2rBNxd0Ks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3INmjqC2Uax7X2bbX0O43rJyeSquF37EtSTqs8eyHe6wzlg39
	6YH5ctJN1glTT/5mRopYXqFFDXM7oIVDY+ArPSgal5GI26YQUuK7gCcM
X-Gm-Gg: AfdE7cnbCsWn9Kn6vnVXv+LkvzSb/l0hl9LImgo88B27VlvidLPf+yrcI647p+/SreW
	2J8bF6rqu7shbN8KwJGgVl0Z8S4x4UTGkzc+JBB4hGOV3jWh+jkaVE0beyvbX9oSdLf/WDKtvk6
	O9+fi2eMKyuo+PqG+JtaHtsQmVJk8xC7H3AUzh6SvzUjbteJv9Bq6oR0yNzMMEpcCv/B2NbvNVs
	FuWJfKUIuRvvQXyXJU4I7ErvpjFRPK4ma5Q2zvAcajtSx5/C8501jTyeD7cBl+7psc+SlXq1zFU
	/JmZ4w8svivOBfF012D+2A/B7RVJ5Oqa6oYKV+PdXB9Qcr2RFWGKZyMG+9E1Q18qxPJAtGqGXKN
	rcnT7Pgigcc/L62PXUkRBf1weFYmolM/jixq5ogzb9xmXAUMRKZtECuyg98lQHj00/44RDrYUX2
	xyfm4=
X-Received: by 2002:a05:6122:e46:b0:5bd:ba7e:ccf5 with SMTP id 71dfb90a1353d-5bdc953104amr653300e0c.7.1782840194600;
        Tue, 30 Jun 2026 10:23:14 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96966904ec6sm1200685241.13.2026.06.30.10.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 10:23:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 12:23:07 -0500
Message-Id: <DJMK3NCDCHL8.1EHG93D5O7ROZ@gmail.com>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/7] iio: adc: ti-ads1262: Add conversion delay
 support
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260628-ads126x-v2-0-4b1b231325ba@gmail.com>
 <20260628-ads126x-v2-5-4b1b231325ba@gmail.com>
 <20260630015027.3afdfc3a@jic23-huawei>
In-Reply-To: <20260630015027.3afdfc3a@jic23-huawei>

On Mon Jun 29, 2026 at 7:50 PM -05, Jonathan Cameron wrote:
> On Sun, 28 Jun 2026 00:36:06 -0500
> Kurt Borja <kuurtb@gmail.com> wrote:
>
>> Expose the programmable conversion start delay as a per-channel
>> IIO_CHAN_INFO_CONVDELAY attribute.
> Coversion delay was always a somewhere weird bit of ABI.
> What are the delays relative to in this case?
> Is this a device that does simultaneous sampling?  Pictures
> suggest otherwise, and convdelay is currently only defined
> in that case.  We might be able to extend it but it needs
> some thought.

The chip has a configurable internal conversion delay to allow for
external settling effects. See datasheet section 9.4.3 if you'd like a
bit more details.

But you're right, I should at least also edit the ABI description of
this attribute. We can postpone this discussion for a future series.

>
> Jonathan

--=20
Thanks,
 ~ Kurt
