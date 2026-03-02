Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B401A680B
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 21:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772485448; cv=pass; b=fkxeiGsJ6PF3lVzhy8qZAPIo/dKAmbWUzdfrM1tO1tNbbP0J2S7ON3N4PgLIR80wNXaZ59PQDFsbGKDUuX7HQItjxLRbU26vrA+v4qRXlLg0yT2jwsDPU9N0vQmfPD8H+zvwzlcVcQ8uZIfD+I42Zj2LSGT1U968sTdMiI4KvDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772485448; c=relaxed/simple;
	bh=CWJKF9SpIjh9pmmYfzTqY7v0sHyXHPNvu82TC+RYFA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VEW3hkiM3FglVW7x7jnk9iSbCDT+Pr3xGTSc3NlSS6TgRlOLgcr8rJF1QPpuH6h0Bpv2FEIybcrOZKPgIQSGW1FKtPBC5d86nGBu56bDRexplHdNGyrIAV6WY3m48AjIOyeNV3fS5vJOxM88UUnWfvv4r0h0GxYUf39+aoC9Zxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=bDoDU96Q; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bDoDU96Q"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c7350fd4efdso756734a12.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 13:04:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772485447; cv=none;
        d=google.com; s=arc-20240605;
        b=fO4uOh0kAvqmo/lqiMTVdxmyF+MrKxkuf/yxgnSEVUkOmGmDiOXvohypQxrLIOSJtD
         vYeAUsmunV3QWoz+sAeRMbnqnZElsj6VHTEQDdqkn+SvuRTXrVptgnuBrg7+r8QWjo6d
         qiVGzbSsHWWNpZ6s/hrOklKEdbHHoETOp/3zP1P57X0Uxy5dqng7+MWb8gk8mbZa8hrC
         BPeZxYVc7IvWeYW1PwKgoljf65I+cfUo6x/WWc2opoQomGPGH9eX8z2x5U65c8iarhqj
         /TJCnHUtDCmDAZTm4fq0o7tZ8i/tB+G0XfDW/F13/1eUYKDPggoCzeJX77OrQtTbzN2v
         YTJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S0B/W9oEfTx3Mdx8y1qNKPKD50lO55YEDov361/4WoA=;
        fh=LCP5mvCF69lpHnkqYC4ZrVgGYPcLc7iy9o4Gwt87Pjk=;
        b=NXwojgx8Rx4gJsjJ5eCrI03k5oVq3dITd1mgTsMXIJRol8GAsrcup6eToFe58Qh5iO
         gGb7yWfklTliXUxO7jvesKy3vamvC0FD2c7ELlTaia9vBJAsMQXG3SZzixdkzs4+KJxW
         mS3UoEwCDaJhcThcVeqqw3AuziIeNoUQ3/Qvvc21RefcMhYSflOec5rYr3bCntFsguLt
         bq1yWpqUlQX1ijvN/ECO9IrqWC7V3yL9uActvEmHntqV2+PZd9Oq2aMUQKL6aTDs+efo
         4pZ5y3zaMKHpEOjZYWyEGjAH7nsHmYBxsgbHSGOd/a1pbT9dENYl7E5jU1sGqpQyA51b
         7TfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772485447; x=1773090247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0B/W9oEfTx3Mdx8y1qNKPKD50lO55YEDov361/4WoA=;
        b=bDoDU96Qj8MJyBOdnA6aQbCDVdDQyoEAqiI7jUOaTPmVDu50AXsPvM44QnliDfct/F
         PG2WrxT4QoDeUnsqom0DRKYnMj4e65xMxXuayfD2zZ5cNSCT+p/yp2kZdXM7JPFSBoOm
         JG4Jsh7IeAdXw+lhAubeNGo6lXndVwDSha+xCtB1Px9XY1nzpI7f9ltkmq74lmc+bdFr
         ebsIvTW86xfRrYb2264HuVYQ/yq0d1Fmtwtk7Syu6nW6D9u2J2KrB4PEyqiIY76QYX1J
         bMg7WprCJtyncRk03/7UBK3McoHZFDJ1UZYUela9u7l42sqDNcTxVDF5bvIuFxzhLtPm
         i8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772485447; x=1773090247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S0B/W9oEfTx3Mdx8y1qNKPKD50lO55YEDov361/4WoA=;
        b=XVTCccBeaLFX7NocA9pf4oP+eGL4uoLs+Y3qpymUcUlTQPoUHxfbrR97glfTC11yV/
         u7nA3s7qwIu/9whr/fhj+NeXVBSEP0kNjyF38nm7JKO5iVbynpCmJw0kkB0+lmJGBlXJ
         Yf0aszcLDHp6gBX/ddsUmWy7o9WBjk7JPsq7L/bytxy+z2e1BZtQK/iXLsOFeRkUUNaW
         zOtqzEw9vZDlqitMVKaZYzEy/RPMOXCoT15BESD+Utvh/YeZQv9KeikQ7H6a7szsZyHo
         fedfdIRAoz2FrshpS7H2RwAV/tekWm/9g/DCjFhZHfyhvmhe5MAQWOjktdOhtEBNsBgb
         B0ig==
X-Forwarded-Encrypted: i=1; AJvYcCV8ASxZPIJk+bpiVWOdJNnAo+Tv0cxSY4ZNizHP8xRJUoJqbgyzn7eDHm8ygqNf0OafQ8k+JTZZFzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnpvHnJbBAZFtLJjaX8fDZnd047LtDwqlD7vVeL9SNo7zsAa7D
	l9lDYGTzpl0N53aOTr+LhbsM6nK/S0X3nDSIcmSVUXim9g6ANzqBkK4IrFUhI4Nyr5LAYm7vExp
	3JT8jh5sZ4UKrK+fxI4kKBQpGCKRpXrg=
X-Gm-Gg: ATEYQzzbezYmvzP4rsNIOdtYQPHXixL8p+y+PpXXUBT3dOQoWI3HCYKweiMthnDXq3K
	I/8KLDY2VTCv54VdF0cP3pClwQmv1DSJlpkdgDB5uLEWKfphaocx0LFKZS/rPg/2akTwplUxurc
	OJn6PHBJo5Lhmcff2etz2E1E8oNDLJJeJm05vGXoWQmflNP8o5G2EEKT2hNO0JCosePfPcVCCLx
	RGiXPFiRNbG5yu5win8/N9qIFSqFBLXfOGBG9rIz1pgbsuFnWGpWNxmIItEmVxcRbwmwEiLgK+e
	uiM1Y3p2LcDWLQ2Z+kVqkYE4Tv0KDjCtHk6MVdPe
X-Received: by 2002:a17:902:ccc8:b0:2ae:5628:a170 with SMTP id
 d9443c01a7336-2ae5628afe4mr43796855ad.46.1772485446798; Mon, 02 Mar 2026
 13:04:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228065840.702651-1-nick@khadas.com> <20260228065840.702651-2-nick@khadas.com>
 <20260228-quirky-lemon-reindeer-1045f6@quoll> <CAFBinCAkxO4HoN0Cw0Fc2B3KRLLJqso1p5+qjNN_E0c26VOf2g@mail.gmail.com>
 <49b3a87d-7ea0-4da1-871e-35ddf5d5b454@kernel.org>
In-Reply-To: <49b3a87d-7ea0-4da1-871e-35ddf5d5b454@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 2 Mar 2026 22:03:54 +0100
X-Gm-Features: AaiRm50TpdWh3Y_pvxvTMNOeIVTyBRxIzdF8SrzpLj8ML0Xjz_0wayl9w2nZ3rY
Message-ID: <CAFBinCDyhvzWO3gOL=GtnH56Guh2fkZyhmSjn2k3iJdhtmTdBA@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] dt-bindings: iio: adc: amlogic,meson-saradc: add
 S4 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Nick Xie <nick@khadas.com>, neil.armstrong@linaro.org, khilman@baylibre.com, 
	jbrunet@baylibre.com, krzk+dt@kernel.org, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, xieqinick@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Mon, Mar 2, 2026 at 2:59=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 02/03/2026 12:58, Martin Blumenstingl wrote:
> > Hi Krzysztof,
> >
> > On Sat, Feb 28, 2026 at 12:18=E2=80=AFPM Krzysztof Kozlowski <krzk@kern=
el.org> wrote:
> >>
> >> On Sat, Feb 28, 2026 at 02:58:37PM +0800, Nick Xie wrote:
> >>> Add the compatible string for the SARADC (Successive Approximation
> >>> Register ADC) IP block found in the Amlogic Meson S4 SoC.
> >>
> >> ... which is fully compatible with g12a?
> >>
> >> Write proper explanations.
> > Would you be fine with:
> > "There are no known differences between the SARADC on S4 and the one
> > on G12A. In the past differences between SARADC on the different SoCs
> > generations have been uncovered late, meaning that a dedicated
> > compatible string has proven to be useful."
>
> No, last sentence is redundant. You do not need to explain in the commit
> msg rules of bindings, because they are obvious/known. You need to
> explain the hardware, e.g. in this case the compatibility between devices=
.
Understood, thanks.

> >
> > Do you also require Nick to add amlogic,meson-g12a-saradc as fallback
> > compatible string for amlogic,meson-s4-saradc?
> >
> >>>
> >>> Signed-off-by: Nick Xie <nick@khadas.com>
> >>> ---
> >>>  .../devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml        | 1=
 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-=
saradc.yaml b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-sarad=
c.yaml
> >>> index bb9825e7346dd..5496a0dc714aa 100644
> >>> --- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.=
yaml
> >>> +++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.=
yaml
> >>> @@ -27,6 +27,7 @@ properties:
> >>>                - amlogic,meson-gxm-saradc
> >>>                - amlogic,meson-axg-saradc
> >>>                - amlogic,meson-g12a-saradc
> >>> +              - amlogic,meson-s4-saradc
> >>
> >> If this is compatible with other device, you need proper fallback.
> >>
> >>>            - const: amlogic,meson-saradc
> >>
> >> And this one is now kind of fake - how does this device use it?
> > As you have noticed later, it is currently not used.
> > Can you please confirm that my understanding of the next steps is corre=
ct:
> > - you're expecting Nick to omit the amlogic,meson-saradc fallback
> > compatible string for amlogic,meson-s4-saradc
>
> Not omit but replace with proper fallback to specific compatible.
So in this case we need to end up with:
compatible =3D "amlogic,meson-s4-saradc", "amlogic,meson-g12a-saradc"
Stating that the S4 SARADC IP is compatible with the G12A SARADC IP.
Any S4 specific quirks that we need (in case we ever find something)
can then be managed in the driver.

> > - and you would like to see amlogic,meson-saradc removed (from the
> > bindings and .dts files that are already upstream) - I will take care
> > of this once S4 support lands upstream
>
> This no. It's an ABI, you cannot change it. Not worth it, either.
You suggested adding a comment stating that future bindings must not
use the "amlogic,meson-saradc" compatible string anymore.
Since it's part of ABI we need to keep it. So adding a comment is all I'll =
do.


Best regards,
Martin
