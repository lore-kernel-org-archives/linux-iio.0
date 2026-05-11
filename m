Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9903ECBF1
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507423; cv=pass; b=LwveGntidd7TNekYDWMNNZ6usKa2VmRXQJEYpx088FhVt+raFaHk2LuS6WDfXxlEE2pR2dPJCJ8eGV+7jWuVYgpPdt7NTFzrj7Dd3/MlrKYR2BdfuNrLiGNxUZZfc9UAB5m7rTkg9iWEV6NRpWOs4YXHb3/yfi9YGXXmbPfOwDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507423; c=relaxed/simple;
	bh=9YG3YiuSsjojmW6A3ugXZPxI9/qnUbBiyh2KgjsRZ3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2XnUGheQpLoZEiYcuP9Y4rj/n8FTj2K7fHPNbkX6c5jInwNHFaTr2RVq2ClSkVPu+40ZfaQCF/ia/ze7X1cCMF0ti4dkI1jCIb5rTqhW7SH5/VBTPbusQ1zxN1tPchs08s9KzDOAbsVVWlvYf4qCvEY8rdnk4xyBNcSxjGtY9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0XrlNNW; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0XrlNNW"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39397d63804so50022471fa.2
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 06:50:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778507419; cv=none;
        d=google.com; s=arc-20240605;
        b=DuPv8XJvE1rRp7Rp6GhBIqTIqwHWkH9HZpyFsMt2oPN3ELarpHZSqHDxKRFqQB+gn/
         5oINWaQtfXJi8btgkTBT9zYVldmJTBvRfBDLDSW6l416y/DddZ1KZDfpXOmehO/DYnzd
         i3VadlLOCHSNrhJEZV/DC67ThIYuK9+tiDXyOEk4JSDAjCwSkxkqAdxNu5qP23DugTkA
         KHd88ofvXIObVnjwzpGX/clOYx2EtceOCcohePM/jvrf3zwluujqgAMnGAcPMUaudWRM
         W4CDDaEcIqmeji/zFiPW3n1jwcLOQ2BzFvDvBpiNYS6obH1d2ZxeaMYY7qHl41t2DKk9
         W0EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7zC1RYg8tYp3lEqo6W4RmkrRDKh6czAweS7OgGTtxuw=;
        fh=S5hMecZU7np3uubMJmgO4M+3EimyWbo1nGUOudGv/M0=;
        b=NGZOnRaZQju36kCd9aPmtwKhRq0hhnJET97Df9xM+K0fhjZqSGRxqKn79Qb94Uo0UB
         tvUZrG5Hj+jRB0oNfb6q+BkG/tcccMKi97W5uKTCrRld3ZSGg7DEkGL1tvEFHoTYY/Es
         SCXxP0fdE/6Rz/bYif7T/0IN0+CceOgbVi1wlxs6Wu+UGZT8oXx4HFpz/cMDFH+5kXxw
         pymrfiuxbtHIWbG2IYhCiEfGML+qul5D6Nf4WDhMHtCyTQIt0daL26Gq1YPK2bkWp8xg
         1236yopX9zyj67uQ5fsVsLDDDnYNyEvWjKfr4fR9m7T3qrRLH8zGJW+ZKkDKl5eeRgFg
         g+vA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778507419; x=1779112219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zC1RYg8tYp3lEqo6W4RmkrRDKh6czAweS7OgGTtxuw=;
        b=j0XrlNNWo2qcZki7gxrPpErKiRUNBamLSKTdVqr7s0B/7wq5X+EHcn8p4ZiKlcInCx
         OdwDlKCtB5HHcuUPeeYYCuqU2YrgVTM8gZe5He0j3+45Tc5q9WQb0cWZCmQFviSLFlwj
         Ph7OJ7qQ3oVcGqUnM/InkR61QNGqUeoxFFsy7pXS/HEkmxvuDetCqRlHS+3VnaOfnYJ7
         3zXGgqwbHIGN3HArOFnJXn9NIK+NRqTbtEthwELANTJQVva3KY8hC0wvAf/N37iY0QYE
         iYlAF9k6gAi1qhPGgHQuitqhrlgdgAJpqJItHnU2TQLlW9PLsOqrnDMLfP5hX3KbqIKb
         xreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778507419; x=1779112219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7zC1RYg8tYp3lEqo6W4RmkrRDKh6czAweS7OgGTtxuw=;
        b=Aus/QDhlGICaDsFDuB6iff3g2xugjqpDg9hT/cmcHNKb64npyqg0npPQvNm6+QeJSS
         0iLs7QosXoj9DX0Z5YsL5qO3Kn9LOCl5dm2HRE4tmxfC3vDC2PuN2VJgcWjebI/TDn4o
         aIfYK7rkPI7GlYUOO9rz/dvO8l1Py1ZnM5rEq34eMFqZg8/dZ+lCG3FuADv3S9ObBpOK
         b1AJ/zFReXB9FXM6dOL26w6KaSOhAD483wbqmGDdkTK7meEC3zSOUBYtJ3d0uX1N6zse
         GLUYpiKy+RqYN+AtTQSsRQfSOzn8BroGoqf9SUbXEERNzT+atA1lr0hKNFEyw6DuefOK
         g77w==
X-Forwarded-Encrypted: i=1; AFNElJ8Ff4khGWPFRdV0kiRgHOQ5mWWNlF2z/Q0ua8xYueL4mmgRksQEyMp1FgAoHISw6uLT8m46NomTEtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMiSiGZIat/weNBAheGanVHG6Cr12EVzk1fYZ8zU3qmLkQZ4vm
	wr1jLQt14mJSA1nMQ++ayTdMWk1JSnfrD/wbpoR28rpnIGAjR2mwAKj2i3kZK41KveV52aVpb5r
	nvyRBkr4GnaIc1Qx0Ns7L9g4UHakBwwc=
X-Gm-Gg: Acq92OHxi8p68Igb5wT9se8Bfe1MlHURozbXIQab7NmRR3/XtLSzoQfuA+6dwH3AC+f
	QFqbyI4apLxQk9x0BQk5bAvxM4ObDqaqEunmp1scylhzbGWuGaDhVWSP2vOzf3ypo5uHR9LgWmg
	ksa6AouyjCAyZVq42u3hFehDN9PrUzdll+0oYhuvFa3zO+HVThhPDys6MulMFvGWGYQ0B8mdbFq
	eE9+GNMbnMChq0a85VDtvpMqyYZTyofxM6DXFFrZ1iNt24EvSK3fA/mVIUfkrUJr0Tzhx3xrCUc
	KatfKFTM8PVTImdojlnPEGqBylL9xoxeHA8dqGvue59cMr6+AA==
X-Received: by 2002:a05:651c:503:b0:38f:f8f3:6c58 with SMTP id
 38308e7fff4ca-393f4d1cb99mr44752051fa.11.1778507419262; Mon, 11 May 2026
 06:50:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510194947.31997-1-piyushpatle228@gmail.com>
 <20260510202657.38326-1-piyushpatle228@gmail.com> <agG9FAXXiTKDIEDf@ashevche-desk.local>
In-Reply-To: <agG9FAXXiTKDIEDf@ashevche-desk.local>
From: Piyush Patle <piyushpatle228@gmail.com>
Date: Mon, 11 May 2026 19:19:40 +0530
X-Gm-Features: AVHnY4KoDwq8UL37IRCHA4MrolOptuT28ZabDwx-aMaHdYGg1AJuTbAKe7sUm-Y
Message-ID: <CAMB+xkZ4MjhR3jU_L3=a=2+ubJ3oeL=x18dypEbRDa9My=LAzw@mail.gmail.com>
Subject: Re: [PATCH v7 11/11] iio: adc: hx711: add support for HX710B
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 4:57=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, May 11, 2026 at 01:56:55AM +0530, Piyush Patle wrote:
> > Add support for the AVIA HX710B ADC, which shares the HX711 GPIO
> > interface but uses trailing PD_SCK pulses to select the active mode.
> >
> > Model the HX710B with variant-specific channel tables and IIO info,
> > track the active channel across conversions, and use the fixed gain
> > value when computing scale.
> >
> > Also update the adjacent Kconfig text, file header, and module
> > description so the driver text matches the newly supported variant.
>
> ...
>
> >  #include <linux/slab.h>
> >  #include <linux/sched.h>
>
> >  #include <linux/delay.h>
> > +#include <linux/types.h>
>
> Seems wrong order.
>
> And here + blank line to make linux/iio/* to be a separate group.
will fix the include ordering and grouping if a v8 is needed.

>
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> >  #include <linux/iio/buffer.h>
>
> ...
>
> >       /*
> >        * triggered buffer
> > -      * 2x32-bit channel + 64-bit naturally aligned timestamp
> > +      * up to 3x32-bit channels + 64-bit naturally aligned timestamp
> > +      *
> > +      * aligned_s64 satisfies the 8-byte alignment requirement for the
> > +      * timestamp. For HX711 (at most 2 active channels), iio_push_to_
> > +      * buffers_with_timestamp() places the timestamp at offset 8
> > +      * (scan_bytes=3D8, already 8-byte aligned), identical to the ori=
ginal
> > +      * 2-channel layout. The extra channel slot for HX710B does not a=
ffect
> > +      * the HX711 ABI.
> >        */
> >       struct {
> > -             u32 channel[2];
> > +             u32 channel[3];
> >               aligned_s64 timestamp;
> >       } buffer;
>
> Why can't we used a recently introduced macro for this?
> IIO_DECLARE_BUFFER_WITH_TS().
Yes, this macro can be used here, I will use the
IIO_DECLARE_BUFFER_WITH_TS() if a v8 is needed.
Also when should I proceed to make v8? Is it needed?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
