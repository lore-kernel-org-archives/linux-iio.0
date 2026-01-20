Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6220C3EF0A7
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 11:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768908307; cv=pass; b=qtx2tzOort4jbUZHKAlZlyAyePDtAEXIBq7desdrqw5R8GpSGbyUCUP9zbgZH/FE/qQVOsX3vvmRWjsksjv4IewKpBv3KfIAZzR3ibHIKX4kj5prpBuqkPCJfTWgunTErW5E3aLT/0dlUFXYnw1Gr0iA879yML1ZRZXT9E6t9Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768908307; c=relaxed/simple;
	bh=NRnrSD0zAFPtVaS5sTi5Ar8t18WLmEhSZ6lKcGsCMmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKjTlbYI+r/cLRENNisQYvq7x8Br40D5h3Q8Q7Y4G7jT9jj/8GT2XgqCExXopRSzrbabPnFnTmNwfcmAREGOy36Fc89p2F+jWxGcGx9VRlv8qbXZTqkD5UqNhSkIhusVLWHi2Ri8lC+PQ5WoXDS//xcS+KHiojWY+HckyPZAung=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fF4bTY6c; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fF4bTY6c"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b872cf905d3so861902466b.2
        for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 03:25:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768908303; cv=none;
        d=google.com; s=arc-20240605;
        b=Jyo1DdfcNG33NPabkuDtiQ1Zhog1QD+0A2PwwvjyM2g6+luUbCCUUDuAioRdaW2lnL
         23LIzSNiy5Mr9ukXCoSv2AkW+LcHGDFa+8e3ZY2ZLCo6RB0MGK9h8bvEXEet+2etXB9p
         QP+A4vhE5xqAtc2y4o6Fjfh9AmUoQwUFWB6hVuCs+Clld/5aDCog6FBZyYmvswiBP8xE
         OHFwCIs6FC3ExaniYNrA7DfmIREPBx6QzNYkViLhFbrbyI9KQJAmLiqJVMlxQpE8CxtT
         /Avtjrecb6iezoG3ERBpFI+Vr8Zc/+4lR48rLYvGUPZvVhTOkHtD5WymU9/hdfG6bDgd
         rDmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NRnrSD0zAFPtVaS5sTi5Ar8t18WLmEhSZ6lKcGsCMmg=;
        fh=Sk6OF+P6CSZnIiSCOe1PLrlLmcngB4duk6IvKRXVnjE=;
        b=VdnKffTCmQly7dPqwHRFOaZVFHVnHQyVJAYZfiYOwk5Vu3QUKRPzBFtjlZxSFEHJsP
         dacpQFEur1Wj46aohItX373R8N+KWfjcBDI0L9C/QHK8QUOae0S42p5kjEoYC1RiAjIu
         lymTkKCir4Bb9aIWkAeiqYLpw+B11lJOrU0XvtJNlJ0QQPit7fZzr7JZjky9/pc/5LJf
         ZLFRX4CO+6VvTLQxiGZZwk39+VWzDTk7VDcKSZju/+rJXiFTeY9ySteP1PqwgZaFJipB
         fgSU+HSGBVMEctBP7gfAAUNZPmPVp0uVYhGCovsJ+snodXmsG4iBNVk3WZikCyTfLmsF
         x34A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768908303; x=1769513103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRnrSD0zAFPtVaS5sTi5Ar8t18WLmEhSZ6lKcGsCMmg=;
        b=fF4bTY6c3MbHOeQ/jKWah88aHsRPIwdCzy1n+76DzcN+krplIKkOg8JnbBr8qdeUMZ
         XLIHNPiSeBkYa0qAKsaCHGaHVzrIhEMeJh+CtaPE/t4PRy+y8+f10o2y5z5IB8oZ78Jm
         JfNzahHCQWQ5Wjo46/bNmVjJ4An2XmEnHbQAK/Pyautkqw47mw1dDp8Du70Dl9ZAtgz+
         GXkVYjbaTWJer0qL0flmGqRtOOSfxPWvaDOCAxRX+9AMmZqdfK58u+x3BAq7h4a+p44p
         0P/vp3R/Tmit/BIC5wkN7p274WeglzgE8vqaTCoKUXeRXwRo69w1TYzn4JVu2Ak1V6Ck
         Z/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768908303; x=1769513103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NRnrSD0zAFPtVaS5sTi5Ar8t18WLmEhSZ6lKcGsCMmg=;
        b=FiPp6uUadaILPlDhZSaxx+PcKeKZ78UweLUAbni8nT+TRfQcNBAuBkaRGabj0kq28J
         HqKkd/p4V84btSKL9PMKxqgkCrFwmtGqg+U8sxXo4XzW2d8qCQDIVC098hV694wuY7yv
         B5+WAdTrAqGNUAt+wQJvhswQzrJ9fpYvMVFol/s9Gz4FubRc0RsqaDUJLSKTRRaIKGy4
         tyiSAQNffFOWFD0zSLyCQkoM2jIkOmQIWMMRu0a4FJIRrG+lhJzwpqheD5JTx2xzF9U0
         lRM+ID7QIpa7CV0e5W8kflw7s7cNT15RygoxHqSHBhlsjl9swPb5pS2F7KCRai9Jx0CY
         ribg==
X-Forwarded-Encrypted: i=1; AJvYcCWVb/fJQCoZhfvuICgmoHZXdhibZh1i1ESuhHPLiV2WfwjpUsRPSQDXtqWC0b+hQ3tWluiUzVPIKdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPuI9jGym/bnzgf3/HrnVy9zW26P+eplR9lLXheuADn1NxQdtk
	qZFRvdagSzP/ij1yxYUyKvMMjHdu+g/YGbtUsBwXiWDPxsfTwQnE/J7/a5bbeoeaX0xwkvz4V42
	jfFpm31exmHQxGMOUhyO8bWxxnZo0NGc=
X-Gm-Gg: AY/fxX4uyDoNZDqyD9FkU4XAWE53Vwjlel6NFui10lR3CBXln0rcapZUiGixzoJNh5o
	Hdn1UAolq5yb8VmGNj5WDd8YDPY9gF17sKHvw4DbDQAyH2IgnRywGnw2nmibs/ovbkmsiLocYiw
	Bt9ru6IDX+2sxe3697Ewawwk9uIm9u39/z9w7ejVF36yThqMjqwUC+fYxzR8YscmZzYn+eYOguy
	3Tg0sZPR+jWIamjmQV0H1fzQOLiArofBA8FNwJGkWHvxrr4YyJ1LEfL/xLRvfoHlQbLWWWeZjbv
	i/9f0BWilmv73L0ubbjpwlgP4A+U8BEnz8gIwaKd+iuUj3sNQU3LMU80L/GmF8BKTe6IVtg=
X-Received: by 2002:a17:907:7212:b0:b86:edaf:5553 with SMTP id
 a640c23a62f3a-b8796bb20f6mr1347007566b.59.1768908303287; Tue, 20 Jan 2026
 03:25:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116-adf41513-iio-driver-v4-0-dbb7d6782217@analog.com>
 <20260116-adf41513-iio-driver-v4-3-dbb7d6782217@analog.com>
 <aW3dxuelYDM67pqZ@smile.fi.intel.com> <texwv5s2tvcy34bwr4iruj5xofmea663pwletmpqpuh66zulmv@m7qvjgqbhalv>
 <aW40ylvMwVhqNQMw@smile.fi.intel.com> <hgy3bcrqqsvt7pobhnzuvwzhb2taetpxltkaxpigmmlvmlirod@v6anhmrsvv2r>
 <aW5kk6K30Izckvg5@smile.fi.intel.com> <e5lcg5kkey3c6u2l4rlzzpolp7qkudhcofyzcx5s2tjbh2iwkg@js3fisv23zyj>
In-Reply-To: <e5lcg5kkey3c6u2l4rlzzpolp7qkudhcofyzcx5s2tjbh2iwkg@js3fisv23zyj>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 20 Jan 2026 13:24:26 +0200
X-Gm-Features: AZwV_QiT_7RWmWfYlrbsFcBlA4d2Dt_jON90l4jrfax3VAFOpLzCvwj49Sjh5L4
Message-ID: <CAHp75VepcSZo_E4_UxhKRfHrMFDd7huJg14m8=6zVo4ENKFXkA@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] iio: frequency: adf41513: driver implementation
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, rodrigo.alencar@analog.com, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 12:43=E2=80=AFPM Rodrigo Alencar
<455.rodrigo.alencar@gmail.com> wrote:
> On 26/01/19 07:07PM, Andy Shevchenko wrote:
> > On Mon, Jan 19, 2026 at 04:37:09PM +0000, Rodrigo Alencar wrote:
> > > On 26/01/19 03:42PM, Andy Shevchenko wrote:
> > > > On Mon, Jan 19, 2026 at 11:21:59AM +0000, Rodrigo Alencar wrote:
> > > > > On 26/01/19 09:31AM, Andy Shevchenko wrote:
> > > > > > On Fri, Jan 16, 2026 at 02:32:22PM +0000, Rodrigo Alencar via B=
4 Relay wrote:

...

> > > > > The current implementation is kind of a stripped version of
> > > > > __iio_str_to_fixpoint(). Would you prefer something like this, th=
en?:
> > > >
> > > > Do they have most of the parts in common? If so, why can't we use
> > > > __iio_str_to_fixpoint() directly? Or why can't we slightly refactor
> > > > that to give us the results we need here?
> > >
> > > __iio_str_to_fixpoint() only parses "int" chunks, adf41513_parse_uhz
> > > was modified to accomodate the u64 parsing removing unnecessary stuff=
.
> >
> > But why? The fractional part most likely will be kept int (it's up to 1=
0=E2=81=BB=E2=81=B9).
> > The integer can be bigger than 10=E2=81=B9?
> >
>
> Correct, integer part of the frequency value goes up to 26.5 GHz
> (uint_max is approx 4.3 GHz). Also, with the dual modulus, the PLL can
> achieve micro Hz resolution.

=C2=B5Hz is not a problem since it's up to nHz.
So, the difference so far is the integer part that can be 64-bit.
Again, can we factor out something to be used for this and for the
__iio_str_to_fixpoint() cases?


--=20
With Best Regards,
Andy Shevchenko
