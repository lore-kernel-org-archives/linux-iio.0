Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB98135DCE2
	for <linux-iio@vger.kernel.org>; Thu, 12 Feb 2026 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770914711; cv=pass; b=Zqy6kriiudAnNgC7cX/P4auiAS6/FZ8x3KfhqGoHGeVbUm0oPK43+MuYEj1Eg33awwB4pkAp5L10hn5HxpBfAlu6Fn5Zr+uFEQ6vflpsQtffWvHcIpkcWNevxtMz+dWgW+rw0LYdUWq6PTGHsMU0vI0ntv/KZI7bZYr4BFD+bts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770914711; c=relaxed/simple;
	bh=mVz8IS+qtYRUFdoEXlWVKM1ynn8gALHxW9se9wNJTwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahqSryzxwXY2ldYVyPcglw3ILxiV7MyI9wmfmlMX61Et8px6Ox3z6wv4bKZvmTsnU9JZa+NrZ5HDXwwiN/kXTJoYFRJ5bpCwRjVTelqtuYI+O1lg/nnfpkBtMcICjAKDpJ/ep+nnmUzWlcmCbg4pr7uI/lpGtSYAulPtiqG23yE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gy2dXe7o; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gy2dXe7o"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50146605f2cso28841cf.3
        for <linux-iio@vger.kernel.org>; Thu, 12 Feb 2026 08:45:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770914709; cv=none;
        d=google.com; s=arc-20240605;
        b=XHd7CvDQza2kWSOyIvGBycTHO061G778uKSxTgZP49+a29K+Ez04UoEvHQcSqdYtVl
         Cw4brmAW6jobulDs4Dj8I4IIVr9N9TIaHTVBrkd5JTqBidvHiA/uQmOMo8kIIoLDOTi0
         KDmdshjbQBE3JdQlhr4gM/Wtmx7lbHrcITePi7SpseODdmMZEe1wDAnRQvb6f7G/w4N+
         Jj8+6yvP/mNjZzYPEsxgL5fQj/FTsEHJfd0ztZCwtFPMa9NDDKdEsIzg6gEGITcqzgQb
         Gtc1niUTm/9jeH4Ki73moWpf7q+tMD17Gsa+oaeN6971BP7tnG+SBW4CcP4Jf6lwWhLV
         mAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gj7ggEui4cc7j68lFz5SKmVnl+iFUxBpJ//HV9UMauA=;
        fh=UgWxsEGGblIjwLqVWRurQoKDUgBrtV2SQeiHia6j68s=;
        b=ioRQgRpaJmfjOPWa6Yee3MMMM3FP5zwQJJY0kNCrAo6hOXF1Pg/zdLEEORUXLFztFp
         DgGU0KKSX/0dRmLLaF0WUKuQfQQzYdIOZ4fVhS8nQeVNR9sv7mmv8VOEemyB+Ac0Xotw
         iML3AiU+SHrPcNI6YMU0AVrSkvqHpyUpMRlFo7x+wFhigbnKmHdWcXAnyt0eyrLz579J
         PVKiw1V2ooe94Z6goKkuGC6SN7vxRJoA1UOfActr7qbyeAX5g+XFfknxe7hAIhdsTS9e
         LyVmR8A2LkbOfyOsSHJG9HSp5oi62oi9/0l3W5WuxeeUmx7dIbhsMcWaJrfmBqd4P7Bb
         lBsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770914709; x=1771519509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gj7ggEui4cc7j68lFz5SKmVnl+iFUxBpJ//HV9UMauA=;
        b=Gy2dXe7omhQnhlwBIDoj7YVO9fGjUCwXELoYSXvdiaI+CeiJc6D4GwEoOOyQeer66K
         1M03IVbQuwy/cGHMvLDvQdaMPS9v2rEsIcerAgtGr4Qce0CPqdFmUXYBe1wHbfP5toKn
         xWqCfesxHMJcR6lDjI9LLOlGWmLjEAPqAEFtg52tF0Ir3v6cPZoWeLBknHe3UfN2QXWG
         6MqotJThXzwgxoGQ+qI2TTNU2WGpNKf+L2zTgV0mZlX4MZwnHQhhI2lQcHrvonAhfqOO
         qN2073ytyHS//3p5Vr5HDsLI5QnQMfFDkWMHFKiSxl6idHl2nc6YAhnzXTwRyHl5tNaz
         3+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770914709; x=1771519509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gj7ggEui4cc7j68lFz5SKmVnl+iFUxBpJ//HV9UMauA=;
        b=ZhN4ppn9exw/Mf4ecqJM2K4lueDSjnJitcVC/GCjRUvgt/Pe45e8C4X6sq4rmzG0l3
         vCnPBZpmkTcKIEEujL3h+xXe0lXUhFCPq2ex5L26//wKzGEgLb5CFeHWtc/LmBM41pj3
         gwiGIelwIbzinWipTvmtE1z/kFEcHsLoDrhicNmrEnALp4jjWCJi2GRmVsw6MrGcWfeV
         Ef7FlsezHcyQqPpQO2cZQQNL2qmnRymEGhq7+A0hHl2VStBsE7/ZhWawaLz6r0D1BDnn
         CIj4liNE5YbNFYqWen6h0IKlF4F5tyCzNE6qDzNu74xvivpejKYGtdq6+/3vpHivK4dK
         rgaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzcQsRzQoRwsc6OXND23vaZd4ExQqt0H1hRXsvvBORP4n7+T/95c4q7xnJo77K4IBSARI166egKDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyldYKRw8vgC7d6c08hlu8rwP9TtFKBXyhj1ZnUF7TVGgYa7+q/
	mGZGU74wUcXCigvALCjOTtCWPW+pcy4M5fj+dcz4Ccz4b8NK1Lq60AyVWI2yZR20nFfNWmo8Mwb
	/aIL17/WTorcywB8X4XXq6xypav6QrAk=
X-Gm-Gg: AZuq6aIbKmbnTqOxQuIUYcrcChwr1K0dx0Coa5pEdCNmKH5MyqWmZUe06uD9Xk+jx3w
	q5wpPIpQK1JZjX335QcH7jPV8q1V3ZNO5XTZlhqImi7SVMlfemwV2BTsrZdoOxiIwNODxNLGvnb
	gHfcLIbqUw919Y6Plz7DoU3WpG+PboLHEyDpsxZE+SEC7JZT/hoAU/6I2itDRyQTTA31ojj6HH7
	xyhHmsQ+0NvmrLlSio0BXE8n4mwYuHXAVrltGcJzy503yC0GulkuL9tE1tOAkeFz7xM4VNCPyKj
	llIu23S5GaBprbhWoEh/NFoSF189n9bklukGD8KvVka7YvJJDrv1pHJyH7XqlAji0jt2flH0kbJ
	wzdzwh6E=
X-Received: by 2002:ac8:5f53:0:b0:4f1:dffa:7834 with SMTP id
 d75a77b69052e-506a3daf0cbmr1576121cf.7.1770914709532; Thu, 12 Feb 2026
 08:45:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212-upstream-20260219-v2-0-2b28fce5d09e@gmail.com>
 <20260212-upstream-20260219-v2-2-2b28fce5d09e@gmail.com> <aY2xveYRXEKIBV92@smile.fi.intel.com>
In-Reply-To: <aY2xveYRXEKIBV92@smile.fi.intel.com>
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Fri, 13 Feb 2026 00:44:57 +0800
X-Gm-Features: AZwV_QjHOnmm6-5h1DYEbnqx6tXX_BYSSafMUuswi91q9J0VBXGSzjrV23N4ftY
Message-ID: <CA+NOmzLMzWqnS0B9B96qJUU2EoYppDKO6_Rdu52_dPqWTSS+ig@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] iio: proximity: hx9023s: Protect against division
 by zero in set_samp_freq
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 6:56=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Feb 12, 2026 at 02:26:53PM +0800, Yasin Lee wrote:
> > Avoid division by zero when sampling frequency is unspecified by
> > falling back to a default 100ms sampling period.
>
> ...
>
> > -     period_ms =3D div_u64(NANO, (val * MEGA + val2));
> > +     if (val || val2)
> > +             period_ms =3D div_u64(NANO, (val * MEGA + val2));
>
> While at it, drop unneeded parentheses.
>
> > +     else
> > +             /* Fallback to a safe default sampling period */
> > +             period_ms =3D 100;
>
> Not sure about this. Perhaps we should rather do
>
>         if (!val || !val2)
>                 return -EINVAL;
>
> ?
>

Agreed. I will update this in v3 as below .
...
if (!val && !val2)
    return -EINVAL;

period_ms =3D div_u64(NANO, val * MEGA + val2);
...

> --
> With Best Regards,
> Andy Shevchenko
>
>
