Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C333C27BF7D
	for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771345931; cv=pass; b=QPa8DHanB9ElMv8CzfYsMLz/fFrvZiYWIbktNnHIIS7xfQPNELecBE+I8oLs5iija+/vSirjZuCoz67JnOF7E343vWBLCLWhIumGdszrlYKCno8P6dZK8gx8dTtrt7AJsSzik3xDy6Ohb15LvruLH9Vu7NvEOFDkQ2T5UwrxQq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771345931; c=relaxed/simple;
	bh=X03QoXU85mjUaiUOlaEq1U2mY9Zj6t10qA6xUtZtLkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HwPgSvcRqNcN7E/sYiG1KdstzviA5VELCy8YC0OtKZ5BxrJJxRODbp+9M4mIsOkJlewkvOmif3lCOAwMLCZ4Qxh+bMDH3GT1UkeN9yaoPVk+KsWPb2Z51S9TNpUULO2djPU+5scNdXXPzYcTjOQBPLiGQUCVPxTzZGPwWk3ofpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxY8Dyyu; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxY8Dyyu"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-790992528f6so37121267b3.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 08:32:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771345930; cv=none;
        d=google.com; s=arc-20240605;
        b=Cds8OSh2THiVu3MlDx/R5tIYuGMZGSIey9UPHFbyexaLvpPVp3khndYUTFqdGecKZE
         zh5+Hpcs2Wpx4X/3exVB6ZATcDUI1/r/c+9iEJbp3+TKVkd7wl9U9tvmZJ6nMRJE9VmW
         K0swMQe8dJaMydMq8L4CsAE5UVSDL/fvn1eVGQ2qG4kNTWBxRKWTZJOZnWIbOZQKlc1a
         7camTo4OWofrIFVuUQsfujDkzz0I87h66zZ6YfeV3GyHlpIlEzDyVTg7W5gO8rdwwngl
         1SSeXNdUZrBSoM8lYforVaDO7WSspncLaQDRd3LBnyz5HFdlIu0QHarlOG2Kq3/uCZoK
         BrDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X03QoXU85mjUaiUOlaEq1U2mY9Zj6t10qA6xUtZtLkc=;
        fh=uVw5Hbm6Uc2WqPYKshhLmbf+/7SLipY2+K7j8Hz+gyM=;
        b=GuIKPenigngPsp8VLbCELRi0jfrVT7qlnfUaw3O9zeye/qvzPsAPwMPythaJLsNXTT
         W4wN8R8pTWAm8UID2P4HSHM/H6C6Rt20P01UDoyVFUCTKXFXpUyKcRJI3Ll2MM2PjTMa
         bAgDtK0woAAOUXu3CtsZTjSjb6HuFf7nsuhc8o68tWRSseZ4os1PSvE1qXynXOWuuFVX
         1ox3vgXSv7pFju/+HPP1kxxIl0zYoYLovxVvNdfRyq3m24XZpb7boSHw5ZIthYMFttSF
         AO5yERDClnRCIgPbgp8YyVBLkOCnBvZYgxQOpy/9zFvRTOzQy1uamXmWxwIi6pgoR/0R
         Vgjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771345930; x=1771950730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X03QoXU85mjUaiUOlaEq1U2mY9Zj6t10qA6xUtZtLkc=;
        b=UxY8DyyuAePkmfvdY3PATrxT44vhBp92magnOYFDdqyfR1hoMMavfGeTLmvVoOzAQt
         VmToxIRbgtZxLHXsXLuby1fHSHNLc9cRY7ph80IgIusolLV7kuY/o+Xro1XIr16taJMK
         uOpAywR3nx7hJ5RMDrzuDCGTqF82D/bWYL1qlqETvGj7DcEYUOm8sU009I/3WfAJ04TP
         bh+dI99zio05DLbbfuWOtOF+pTzPMpFpF/yLAi9baKFm6ryupO/75EMr3lmc2nGrGaWz
         6GnnTmh6voB+4/8G8oIFEdHH/T0SaSByKzGyvtnUv3uHvEf/KjLzzUU4i82BYFe1ddTO
         +fNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771345930; x=1771950730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X03QoXU85mjUaiUOlaEq1U2mY9Zj6t10qA6xUtZtLkc=;
        b=krbvE6nk0jwR3pJxF2Obe7Y5QZLCqnZtuHwFjkGJZ5qIZD2XVDNmzJ1IKJ5hd1SVtB
         0SrklaQPCx/MzI8yJo5O3wHxq6MrMpxSCXwrZbGaJOYNb0obV8mBMuGnjTTx+19QYkZt
         YCx7d2T4QaNFGSvcd7IiBxlg7XCJhctTvbL3SFKp5t5LDL07LzCqOJaTfKe2WPTjnE/J
         K0HCURIrlq/eEHqA/ouv+nK5zC8SFvFd88Q9NX8uol/+3zEVaNkhUv5W9y+ZnHSW0Vo7
         ZjOFJtKSWYf8yZsbO+etHN3hz3PL67TKsX53wdTuDlg34UPdp+lBFcqercHdE6ZtlpX7
         Xn7A==
X-Forwarded-Encrypted: i=1; AJvYcCWCP/IHufJeoyEL2a3zFsjFJvaTzF8teI6Va+XHyKUuz29foCmwoLLrFtcMdlUck9YCcK39vslvrjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiJhUWwYQ9nnJBX3CZPArrEjXK4xO6Jae9KRpxqJK4Yy8A4RKQ
	lGl7Nu4NL5ULotxgcphBSdDZHQWEvVerRbfW/72Nno2DX9b6jMnyGD1Km6bWg09UnptZW8eN7Om
	WzUca4JDKwj0NVhTkeXMi2v41pyfJRq0=
X-Gm-Gg: AZuq6aKctHRmuybQmB+bGxiTgc63TXz0kCCRkQ3N7LrNdcN2q7F9tO4BLwCX3cP9prF
	thgZnwTEXYo5UZyb2rk3mx1SF6kF48jQ+tI/q3QIieEiyhWoARbwywFyA1YZfvBcMKC3nDEr2rL
	+tEkL9kbqHeXpX3kVgsZq2x7PFbmYiv4z48aERAKLfBJNnSvkvHknmi+zo1kz6mj/thUrRktsUp
	wgcC6qar6SRnMCAXZP7deC9zFAsgaFdZDxTaJV1sD3TmamWG276KeNjhpK6I+0JlEBhgvcnZB5y
	17IwrKszHAduA1clRfRUj63DB5QlIzIBrzO3SDs=
X-Received: by 2002:a05:690c:c50e:b0:796:6d82:10bb with SMTP id
 00721157ae682-797a0cb6f6fmr95454897b3.41.1771345929739; Tue, 17 Feb 2026
 08:32:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122145633.14938-1-architanant5@gmail.com>
 <aXI-ZV4uAd5GyFLz@smile.fi.intel.com> <aXI_HnvDNbX68-lq@smile.fi.intel.com>
 <CADJHxWB3b+bH2+HBP+SG0jxhGNcozstBeWeDH_3dgS-4c2G-6g@mail.gmail.com>
 <aXJmYAZ-8KkXCFI9@smile.fi.intel.com> <CADJHxWDCer97pMNHV-69B9AEVY0NfimTcxo8k8yFBbstg0wMQw@mail.gmail.com>
 <aZQm4QH_svsQuaRp@smile.fi.intel.com>
In-Reply-To: <aZQm4QH_svsQuaRp@smile.fi.intel.com>
From: Archit Anant <architanant5@gmail.com>
Date: Tue, 17 Feb 2026 22:01:58 +0530
X-Gm-Features: AZwV_Qgq3Ix1Uj-7loRjO2lZwEdwLNMLUPre5wGnLYsyiLrazMIDmB3u0UatEIM
Message-ID: <CADJHxWCUB=emUTfBTwtU=oZp=PH8AC0+QTebo88akgfGOBBOnw@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: impedance-analyzer: ad5933: use div64_ul()
 instead of do_div()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 1:59=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Feb 16, 2026 at 09:22:32PM +0530, Archit Anant wrote:
> > Gentle ping on this.
> >
> > Has anyone from AD had a chance to confirm whether the original
> > truncation via (mclk / 4) was intentional?
> >
> > If there are no objections, I can prepare a v2 using the BIT_ULL(29)
> > form as suggested.
>
> Gentle ping on reading and understanding the given comments, please!
>
> > On Thu, Jan 22, 2026 at 11:33=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > >
> > > On Thu, Jan 22, 2026 at 10:27:52PM +0530, Archit Anant wrote:
> > > > (Resending to the list, apologies for the private reply earlier.)
> > >
> > > First of all, do no top post!
>
> ^^^ Have you understood this?

Yes, understood. I=E2=80=99ll avoid top posting going forward.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>

--=20
Sincerely,
Archit Anant
