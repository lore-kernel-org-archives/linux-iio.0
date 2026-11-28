Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795855033;
	b=MjdZ7+3kSC/wUmKY3w2CW5Eq/0oCxnvNQBCM251BwvcSrcopzB0tZGilyfyF5wSzWJI7
	 iD0pHdMmq5nP8RmtkTnq5IEzOYSIkTw3qvSXOs1K/Lp7oH45LpwQYCGUrMfLd5/euYdEP
	 Grbws33usBoPiTeUTjRGAVQ5MYismiNwuU/4JdiFwQRWq5qPignFOIB+UzDK7w5a8tcbK
	 hevS3ZStBKxhC7NRykgT/rX+N8B2Cs5ozJaYRkfiQSzTM2tyhEr1+KQt/To2pWliXNM5H
	 3RBa7/l95Qv6vitAAt3SosczVbJr38kEG4owglTYGCklsoyu9HBVRYHxd2oL1RFveTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795855033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=M26H+8bofFBd9Z7cw5bx5pswgManSlVt4RQJzdEkUlc=;
	b=HHplbN0YCPhHkENbpYDDzOCh+FqcOeZ7tiGucDtiW7q/D1TTB4//rbjN/wwDufapkBj7
	 NA04fLxoLHOcjjpZ2Kkii5ipeg+aSkfoiUF5VRNzpdMJYONtmPvM33nfIlzgqRF5uuRFc
	 G486LNaq0+kKug9zZ3BqioWUwNHreygwL16bqZ4jO35ZOjzBd4DK/LhEGFswwNSj+gmon
	 JEUrC5/X4Y0vd7QsZqnXY2rm+eXaKvZatN+KnpLHN6+y6i6T/oGGc9d61VhlNTboP+T2y
	 eMTbLAZBqcQr5c+OS8k1mrvWbq1EeFUmx5WqptjJjkt17YBtrdFXDBZ7X/RBJUqMkLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=njmKpk6s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ABD606A31C
	for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 08:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95ABD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=njmKpk6s
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-945e6d9ceeaso757087285a.0
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 00:37:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795855031; cv=none;
        d=google.com; s=arc-20260327;
        b=WffSC6nIp8rpZjJetKKufWrgSG40a5jyrIUBpCYZUc1emgsuATJR62J9fT26ohJ1Z1
         TVb4q3G0nuiXIpn9URWCnrfpQyM/ghWidyQhiEeaX8OJBEdy4P6vAFD+6ZumlAg3svTw
         B6WVD+qdi+uS8l8uVA/7mXc+at2ZLI3snOpMTbxs0D77oimv5U+ktS/dG0/BBb99o1qD
         P9sTuFKkWirwKamTVx1z321FQLHPr3X5cSRWtCtf19bYyWuaoTpaSTgGP684QC48lYNa
         bo13VWgNNpw/352PmFwLTmVLCwZDSREx9BfDanlwgrCRbi/wFBeLGEbMoQ1N1m1LDMaB
         ngJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M26H+8bofFBd9Z7cw5bx5pswgManSlVt4RQJzdEkUlc=;
        fh=Rv+Kf9/I6rBjzr8O2QAIni3LTwqlBPMlJo0ljO2Xjx4=;
        b=Prxsu1P6Bcx9U5wE+nMPWliDaGArjQCE4JlDsahNPAOHA4bmu59siYaBOEbF3ONMZP
         RyVUS/fPBUpmW3ekPXmElC7EhOuQybl0P1f6zHhl/l5QTGOjeSUFIf8k4LiMBMWHJEQD
         PbetQWkd6RbCSqGssGIxSgYE4vnMJiIcBr2lO+zE+JQvg5i4oSDiyO7ElaWbikoGpHCd
         2gP19RX5YNTJvv+5ULpUoDMIGHvIVdRVXG4qMqRRfIKlmYd+berinK8+1OS9dEUqdBDb
         JGe0o1NBbRbwwfw8bYFtZWhNplBtHCj9BTeMBU52Cv9El2dRbhLiDjoQ1HlewuTlqq8p
         GcmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795855031; x=1796459831; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M26H+8bofFBd9Z7cw5bx5pswgManSlVt4RQJzdEkUlc=;
        b=njmKpk6s4qhe7O2iDTyobvug2dIjyGj0Fzx/KIqAXCbcol+CcEl/r2zk2wQSogfyBB
         lBYqFekerHln6fPqjCTUdKES+bLEoQAmyJCVQMq8C3eWLzb0kU3a6W85alNvnc34Brkr
         8DgDmg5relquPau2Pp2H+6RJaFkLPkoPblw9H36iP22lOKhGTpxw4R2wxrFo/iBJDwfE
         ISUpstdd7eVtTTgRLDYAFGmB5QpgVBEeFvb2552vkYFFWWHP7w+0YltpAbP/j3LCrIaE
         HtRn/Voi4V0yfLdc/uWQPk4jK/0V/zFRS7iitLKMvYuroBTCVRCDN+yIvsGfWWsieZZ1
         e3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795855031; x=1796459831;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M26H+8bofFBd9Z7cw5bx5pswgManSlVt4RQJzdEkUlc=;
        b=yHzkt/V+AGVnbKvtqzJ395Fke+vVbgLv5N7KY7tPrFcgjh3r1UG0g0HPMN/mo4EsAq
         sarfer2y9e3FNiua9oUJXIWKr31QDls5buWImaqfS8+4rdzbqGKXFzCqw1PoJmn3bsaI
         M45g2Csv4JLCoWfg03aCIlZKKaCsPZxHslVVWaetWFF80JFuw1+qn8a701acGNI3KjKC
         B0di5CnY5WvSC2WNj/+28Qh0XL22dHDNzvQ/3UYYZn2uVvnTqpvnooQ2JKZa6EVLCXfa
         0pn52x/ZdK6vy/SoB8aDQ7j/R/dNqE5GNH/5lHRYFOQoMzTJz02eodY1k35+VYsCMMa8
         YvdA==
X-Forwarded-Encrypted: i=1; AL+hErFJjf960ONm5VHZVJZDDsUhXhPatZ4CWIdxUdonDgWLr/yP9+ptWRFE7eiCvy3zQVdBCWWt6QmnINM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9TdrafDoF+yGu/N7GBYjgjMlQoKXtYFLNgIZ+sPZcKZbr2/DLn
	WeyxBQERo5O/fiemiU84ZdYwAZrYWvNXRG4FUASGcVlUjnxnWAffe2i9rWsGZhsgkFnGiMdD+ZE
	6NE1iB8jVQpR/2IhuTFV6mWnrZnDuCpQ764g1
X-Gm-Gg: AZFdTZfjMoRDGxZaZADPoh0z+uHsojw6rnw6YoXPLR8GlAlLi4P6SssblESu0VAZbxY
	5KsrTLR7JgWU0UoI8EYU9AHZRGOmkOZxIFH60229qTCQfhHmc7XjbA9EAN1GZObQnZB61pC0ZvU
	NJ8o2Zr6mUwTbFJn8oyGtzc6hNS1V2s+64Nhkafgdfbi7PCR+gEIyl1VRhM+vE4AM6aI+lA67OG
	mvEbTkDeuihBF8kOW93dYn0svRUdyReiFrG/5jltu4pdBj8WA8tG4d9Ziiq+jlHNli2/qIht790
	JsLwvDHI5NbGUbli72chHxjU6i77ltUrL1Cacez7OFCwl2iRGZTUWHoaejMrVgtqg5mtdArLJ6b
	c8ZfDIUb0nLDDAR2ZhdpNhkMYLQbaVEj2dldE8EJWRpvT9bCKgZgODP6QK+ZWXy1dphX8QdavWH
	HqBFIuIEI/A03OSc7yNq3BhVgNSqo=
X-Received: by 2002:a05:620a:460e:b0:93f:5677:9950 with SMTP id
 af79cd13be357-949ba9e7547mr4898012285a.53.1795855031620; Sat, 28 Nov 2026
 00:37:11 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126134826.46044-1-biju.das.au@gmail.com> <20261128034348.5e1de2c7@jic23-hlaptop>
In-Reply-To: <20261128034348.5e1de2c7@jic23-hlaptop>
From: Biju Das <biju.das.au@gmail.com>
Date: Sat, 28 Nov 2026 08:37:01 +0000
X-Gm-Features: Aa3M54rJNh1b-FgYgZIgDSaKNrHYIH8_ZoI7lbqqo6o6KYmRbeb2_ZWxai4GFk8
Message-ID: <CADT+UeBLU=8z+YoVSiW60gHPmpRJ1XHX+G1=pcB4+PkhTuEi+g@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: rzg2l_adc: Add fwnode_xlate() callback
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sat, Nov 28, 2026 at 3:43=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Thu, 26 Nov 2026 13:48:19 +0000
> Biju Das <biju.das.au@gmail.com> wrote:
>
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > On RZ/G3L ADC1, IIO channel indices don't map 1:1 to hardware channel
> > numbers. Add a fwnode_xlate() callback that finds the registered channe=
l
> > whose number matches the specifier argument and returns its index.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Sounds like a fix.  So why no fixes tag?  If it needs one then reply
> directly to this email with one and the tools will pick it up when I appl=
y.

Yes, it is a fix. I missed that.

Fixes: 39e16807997c ("iio: adc: rzg2l_adc: Add RZ/G3L ADC support for TSU")

Cheers,
Biju

>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/adc/rzg2l_adc.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> > index 340813f6f890..f00cfb897124 100644
> > --- a/drivers/iio/adc/rzg2l_adc.c
> > +++ b/drivers/iio/adc/rzg2l_adc.c
> > @@ -286,9 +286,23 @@ static int rzg2l_adc_read_label(struct iio_dev *ii=
o_dev,
> >       return sysfs_emit(label, "%s\n", rzg2l_adc_channels[chan->channel=
].name);
> >  }
> >
> > +static int rzg2l_adc_fwnode_xlate(struct iio_dev *indio_dev,
> > +                               const struct fwnode_reference_args *iio=
spec)
> > +{
> > +     if (iiospec->nargs !=3D 1)
> > +             return -EINVAL;
> > +
> > +     for (unsigned int i =3D 0; i < indio_dev->num_channels; i++)
> > +             if (indio_dev->channels[i].channel =3D=3D iiospec->args[0=
])
> > +                     return i;
> > +
> > +     return -EINVAL;
> > +}
> > +
> >  static const struct iio_info rzg2l_adc_iio_info =3D {
> >       .read_raw =3D rzg2l_adc_read_raw,
> >       .read_label =3D rzg2l_adc_read_label,
> > +     .fwnode_xlate =3D rzg2l_adc_fwnode_xlate,
> >  };
> >
> >  static irqreturn_t rzg2l_adc_isr(int irq, void *dev_id)
>
