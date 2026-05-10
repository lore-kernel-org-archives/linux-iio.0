Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278601DF248
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 01:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778377049; cv=pass; b=HCBNh+pjCrl4Ob+hCgtKjY2RFWcbLCOiYxUVTadk+Ga6ou53eeaHKO0MiyHBOJeUSA6hWt5D41K1Ixf7Pw545k0s2tPMh/iUrzZzjEBA+bhffU594cIPJlVhuyRygS6CS4iTDTOU5F3oIQDqiR5JkItdSpWIF5OUusDzNk8L8PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778377049; c=relaxed/simple;
	bh=+dm3X3AxAH1CzBT9u3abmQDU7H/A0h7PeHVEJ7QCLcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okNj2z6C8KJLJx3+K6EHCmTK05BnYcktd1i/u8WXDYs5hDFETmm9GRXk0dFzuZ7sJb49HfAWSw/9kVHLZkRgnWYXrE1bHixcOu0RYl69OR8PwZJq4sQCeggI9jp1J+/qFYerO1pC3Fji4s9BxHG5/VKdrFiodY/nUxBjP6eJ/A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2I8Et+e; arc=pass smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2I8Et+e"
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-5a8738c178dso2174736e87.1
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 18:37:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778377046; cv=none;
        d=google.com; s=arc-20240605;
        b=jwMpnecubAZza4DIE0bunV27CTgneNi2SEZUr1SUEvy2sjXY91f17IGsyNRoqW9B43
         KaDHCCFKePBWLDA9gKtdxboHHGxrHuAvEL1VJ5pm10QTbOrOYoxsFrpoMerdUBhv9Ygb
         TxTasAmA6IFnWUGfimG7M2g+SyeCXUrTPPEh4VXFnL64IDt9h1DutX6pYFaRGZyriCej
         AHXS/qt99aJzYD44ScIH4BO01c/qeA2ZC1JEf9dvUdosl9o1LKSkryziju+h5s/7Qgn6
         J3hkfs4SfgtFB/Ea2qJhP1wu2ryxdud+S06EB6mQyhIrHoQxedo5R+rQdu3ehbLu13da
         lKgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+dm3X3AxAH1CzBT9u3abmQDU7H/A0h7PeHVEJ7QCLcc=;
        fh=1eVL5haqw8RP+oZ654BTbcea8HxG0ZJvTfpjvhSewHA=;
        b=kyVEmNA8Vx48jfnNDdCZ8N7jivGUDBQKRbqsUvt8pmS2kRip1+/1Z02nCt2mk69S0g
         e8wLU6DhOZRyjyLGB4YCpfsDmgfX6LVdG5JV8amo4v/v1YfBMzC9wpHvy6o3P9Iei2oW
         bcEgpkEgiBDRR4f2FXg54Iv2/VtKaYv9jiZmpOdZhoABTSfgVrlhOjPgpwlaEAxVYvIG
         rDS2dCXj2vCbkiE+pK4rYFSveBHqb6QCmeno9L9oKCAxZ+8P8sgUqCJx54TvaFtiBELc
         NC7YYsgLKm7AqkSjItDtLXKSe02URYVCZTHRnOrvz4h/93PIVCJgFLBWoLWaAkflJGb7
         SaOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778377046; x=1778981846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dm3X3AxAH1CzBT9u3abmQDU7H/A0h7PeHVEJ7QCLcc=;
        b=N2I8Et+eVZW5Ar2PLI0f3pweur6sqzQslIevxzmVuQqc0vuBTMRw2RqfovL2MJTFoe
         NL5wywEcrJ9xuuUjTmeGyRHntVljIqVWvU2u0uLy0dCsKEGSC9lBDZSla2/BnMWAs6Oj
         Ues0w0tyrVLwkttINlzyqNCKx36gS0pd3U2nbnlGf376jhsFC74JnZK+3/8cC+PpDi7P
         QY3eIYXy1ZD/jmvWNjyEye1BUS+Ezvw4XP/WumZLheozjDreytG8CVud5ujs0UMQI+Ma
         BGsO5fQG899Uus0anca4D2C3aX5x7DgVNG9Nxl0dPKY1DYlu1XtJXL7elQjaAfV1iyT/
         Emgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778377046; x=1778981846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+dm3X3AxAH1CzBT9u3abmQDU7H/A0h7PeHVEJ7QCLcc=;
        b=Lbmq5ELFDR2G0ZucnS6fh+nMA+SqBGVd6T7K3zdPLg+RIaqGTcyD5rtvRmy2f9Wi6t
         Jkp1sPbh4pHbRLOjoRBkjS2a8Ov4nDj9xr1kJgzoY5CM6CDynJnE7NNDh0myBhEFto/B
         Suzqe7A2TRhm/IFC1GKwh0dcErj9CQX2iKRXrFyhUTONxLsenWQY4AoHG+hW6WWZW4zK
         DylTLwYrZUNjdJZAWnMhha0G+v82NMvfAQrSe3KhawvsTMkqcpB4VKjCHEHRrOyTQ9wg
         Ke1LR1N2ET46xYYght82dL/crUfio2NxdGlGO3YW0745F5uSyHWWuTj1iD4XHT4l4i3h
         YdjA==
X-Forwarded-Encrypted: i=1; AFNElJ/WqVVDsLEjGx/1CVteG/r8+pJL6mUdELGjOz+FysccIPB3ggswb4V/vmwB/snKBpEMpsvL4Uq+OTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIds3MwIhudWB727p2r44sHZ8ngNF5+ZiDKH/lFfsuyutOoCGt
	1HJKs1P1ESbJ2RbUMu9VTIxBcvlF36knxoqY15cVFEiFSRDglk4wHQpXC+tgjlI61Vp88a1R9Zj
	qn66t8mZSqMG7q+s4hcjP2hvL9exPbcc=
X-Gm-Gg: Acq92OEWHwkNmryhfUw4847A0B5BrdNtKIlqnzbPOiQe25LxDEzuDxA74eoYFOV4Zx5
	mwwhOKoI2M10Qvf9plXKgpOZANBdaMD3/23ocV6JUM5Vv1osLZSUZ2RbKerNqq/KMrQWS5CVMLX
	O8aOkgZFSwaBl+ICFUIijSKKxQuerbwOVunombFszgIbT/s3Ys8GHJ8MwTeVBJoup70ZgHKTrHD
	m/5xn5l/ERsXQr+3u6s6496fXTBDCXGjxUfUPjRoyxTfiFLKX1JPVTCpJH5MPWaxv//kbGcCMQM
	4wDhXYc++TEnYY+sV8ZhArDxUZVrbOgtvbWiXb3e1w==
X-Received: by 2002:a05:6512:1587:b0:5a4:1672:59d0 with SMTP id
 2adb3069b0e04-5a887cdf1e9mr6037401e87.19.1778377046045; Sat, 09 May 2026
 18:37:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509022718.82957-1-dennylin0707@gmail.com>
 <20260509022718.82957-2-dennylin0707@gmail.com> <f6e2a4de-4c1d-46ef-b383-db62091fd0f4@baylibre.com>
In-Reply-To: <f6e2a4de-4c1d-46ef-b383-db62091fd0f4@baylibre.com>
From: Denny Lin <dennylin0707@gmail.com>
Date: Sat, 9 May 2026 18:37:14 -0700
X-Gm-Features: AVHnY4ICXEJPO9AIPLuyZ2gn1SDEAJLed5IGd-wpenxd8q9TNAgPUllmcOqkbtI
Message-ID: <CAGEkeHfeZWi99TMvkXHhMSrUS8PshuekqjszBXaS39VsLUZ4eA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] dt-bindings: iio: adc: add AD7816/AD7817/AD7818 binding
To: David Lechner <dlechner@baylibre.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

> Why are we adding bindings without a driver to use them?

There is already a driver for these devices in
drivers/staging/iio/adc/ad7816.c, which includes OF match entries
for "adi,ad7816", "adi,ad7817", and "adi,ad7818".

This binding is intended to document the existing DT interface.

Thanks,
Hungyu

On Sat, May 9, 2026 at 3:13=E2=80=AFPM David Lechner <dlechner@baylibre.com=
> wrote:
>
> On 5/8/26 9:27 PM, Hungyu Lin wrote:
> > Add Device Tree binding documentation for the Analog Devices
> > AD7816, AD7817 and AD7818 SPI ADC devices.
> >
> Why are we adding bindings without a driver to use them?
