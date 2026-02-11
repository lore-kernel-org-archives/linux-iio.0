Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5810834DCE0
	for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770831554; cv=pass; b=rS9R0R/s6pVKNMvjEOjAqvLQgBuanL2oQ7dViXdgGJf1F9RS95g5sZCP8zsZarQ2YPUazy6vrWGJyEnmRDq82Cv+H785Ha3pZRBU3KLyARXyFEnpfWTGNBlPhffzgs90IAWXIstlrHYbKOq8OsGgjApg+ULyf2DbfqEQv/L0sIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770831554; c=relaxed/simple;
	bh=txoFtShxYqv5nevDGaa/KJbgyBUsQAmKHKBVp8/44ZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPObNwaH70D2vI5znqUJ/8CeHTlFCRGS36C18Lnm5VYpVt1LogRrzoNNQctY/6V2DxETCXvoaUfIZgA47hbXlnIMsdqHJfj4uanyY1TMZStBpSAuhUGVlIrYGkpK3y8Vgoz1K1L84aM13Lhe8HPZs4G/lnfIEhPv1MhSf+9VT2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJmxJyAe; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJmxJyAe"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8e9f89a8e3so772953366b.1
        for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 09:39:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770831552; cv=none;
        d=google.com; s=arc-20240605;
        b=c1ciKz2RkD9/FVouqFhYlvB7Kf8fsGX00CS/7fveMd683RfssY4fSv4pU+rgjviLTH
         PFLZ4AI6SbURZF8TMD2ajHYHJgyqw6e2u4/ydh31w4/PG9fOGmJ9SscyWmxcmyp+q2aZ
         nydP1tiHuozPvFU9mOZMNjSTyno6co6g2TZ4FSn89A/vEMU/hzcAYJ8wk4ii7qAtbR8U
         5ZONDvjwDY+w+nrSvQW8QzxbCuXIhhoZ03q8omLuA/qJ6HHbKJoUGuc9VuFles3Gvhfq
         FSa9T8Jd2jh2GmGNJHrEnwDIsfMNN4C4LnVeKVkvuc1JMp1sAAsY6h44Ydi9PS0VoMlJ
         0eCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=txoFtShxYqv5nevDGaa/KJbgyBUsQAmKHKBVp8/44ZA=;
        fh=SofPH2xzy1IUU1dTOGJLFMrgacLNGY36lkvCc4eBXKA=;
        b=LfYaIMU1bTmhTaoQ003Gnb4Toi6c9KMsPetkkXfXLhAVWl+Vca8/ufCDgQte1VD08e
         aLv/6lbRxgv2dtc73pq+gC1GxhyoaE1kaWCjDtqd/akud5tPjqyQOoTJ1g1VpcRBFB0/
         EPTCZeZ1xgssfrnzGDhruS/ZYjwYYRqxLBMBiqvZGuA/81CJG/Ce1Zt5o4NXlnlM/Kbh
         ZABGCkUXTadi2cCB6LxysosOg0ptAzFfuS5o5a7is2TbQcxRo2LZkpK6LG3jjiDLCMGl
         qeloxwIxJ2rHabeiEMfdi//YCmJ3tHE7yeiaZjCnlgtkj/rGXclM/g5vKyZ7GW9YJzX4
         bhaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770831552; x=1771436352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txoFtShxYqv5nevDGaa/KJbgyBUsQAmKHKBVp8/44ZA=;
        b=eJmxJyAeBii5BEdww+pv0x2xEij+O+0+VPRw8i1A1iyD6gTY2VAB7ui5XGa8UKwWXp
         WaBq4BPAG+51hkDjoibIYgarZevTHMrbDRLE2wgT8bqD7+64JaplGYSnwiA26RC1yeWd
         OHnW3TVnQxHrhYU/CqN3epkrO75CS/BqF/4/qAEoWvNJeCLMGbXkO+WVh4eeM6TSlJXW
         aSUTk1sXz3b+94dme6fnhpl0fN/RaXhlNatgfD4+o2Nb3l5cHgbTiGy7K8/F0tV1Un6S
         4zCprNQv/y0UxTMcyVjBK/8afnR2s1y1xO6HUHu8In25YKmSNLOVJfB/eBY24phxbxpW
         d0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770831552; x=1771436352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=txoFtShxYqv5nevDGaa/KJbgyBUsQAmKHKBVp8/44ZA=;
        b=BfKcdq30p/yVl76c8U8QAWoa3LVE92clae7ZCEkM8FHu52BXHXTy7rkecexXwFC+ai
         j/Ld4H6/LbpsK4XsNAT3nDjmjvN7NpiHMtKBk1BQDBkjAaMJzIZ4pZfSHH+0UJXvHErH
         Qso60q3HIMEORjlDGGNLVLMhpjyGPE4JllLL4EW5dR8uvwtQpq/fEkS1uI+uexX6m6xd
         5/qudCIPpp4kzgkiOKvKV52lZ+GcImsk64fdciRu//njnyFKztMgkBp2/hATUw3qgD2i
         e0lO1s1M7prYiQT1kntYnelnrC25ZZWElXoZW9aNYCC1olEcb3mge9gD8kJwKJG8lJtp
         HCNA==
X-Forwarded-Encrypted: i=1; AJvYcCUvh+ZHGkeE8yo+kpqrXTsaSyq2MX5uBpFb/y3ktWmjrV9zqQvE7ePK4lO10GfMrfYruXZIkHeq5g8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5mIqb5cf7w0l+kNNiSwT1TAM4S03rL88tjIRPmyVgT8Spv9CN
	HqrdCRRkmUCPUCrGopWkH0dp6zUK7arWx3hQPgDnYs/Y4s0l1BmlstNwDMSqu2bhl0SsHpsRZNo
	Fz1MBGHvjMhiIs40Jg9O1IHGLLDz1u50=
X-Gm-Gg: AZuq6aJYZX5kFUXVIz69Ns9ozzNsQY+VBluZtSCJJOsI8RfDy+1rfxO9aKeyI4JbNik
	x8sWBlarn9xEDMDjxTU5nASITKPekwdSG/rxbjr9aOjf9MKbppltatwcD2VYaDJfjWWgKTb4J4z
	4fxzRxZsPl0T2NU9w7rc3Xv4rRkYBd+1C9EzFgdHTKcPN9RCoiGoM65+i/fQ5KbLPV6ipTsQDcm
	lEdbhFGAz+eaXIdt78lvVoUQFmMXgbFPCPbXbOfp5pCW87wrUt3Mcz6+ebpQboi4HCL9jiKYgr7
	OnorrmdJGnp5dGVwhuiSPQkcOCI9KC/b17h46ITH8zRFrZAdUz4y/dr32MUYXx54KzUsFkw935g
	iYvwpgsA=
X-Received: by 2002:a17:907:728a:b0:b87:115:a714 with SMTP id
 a640c23a62f3a-b8f545d776cmr408238666b.30.1770831551374; Wed, 11 Feb 2026
 09:39:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211171007.143527-1-antoniu.miclaus@analog.com>
In-Reply-To: <20260211171007.143527-1-antoniu.miclaus@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 11 Feb 2026 19:38:33 +0200
X-Gm-Features: AZwV_QjWLt7KrpEQPeW-H0mml65-ony8jEGhmWKEefZCzIDq1H8Nj5TlMkV8g0c
Message-ID: <CAHp75VeiWPrXi_-yP7We8V99GbpC2s+D66gfXZd=ojHxxH9EZA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: pac1934: Return -ENOMEM on memory allocation failure
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Marius Cristea <marius.cristea@microchip.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 7:10=E2=80=AFPM Antoniu Miclaus
<antoniu.miclaus@analog.com> wrote:
>
> devm_kzalloc() returns NULL on allocation failure. The appropriate error
> code for this condition is -ENOMEM, not -EINVAL.

Right, and the memory allocator dumps enough info if it happens.
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
