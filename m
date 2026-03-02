Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB96F36309D
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772452741; cv=pass; b=qFpOJHRTllUe5Wjk14gkRdvD0PRfu/Pm45xOgxLRelCjwB6IdpaesKmigykakOYB58+BZu5guSKKUVPGfamLzDDttanQMK1MXNONFikXetUKiktiEYe3uqdWkRGubl7h+aVD8PDbddBkd7+jrVZNKWd9RuYEp7M1obVr7XYOj7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772452741; c=relaxed/simple;
	bh=N1GVbONaYBmxbfdzHqPHL1qsRjsCCeoytFn0xLYBEWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tAX51toX6FH6KUHJE/2xzJFAQebF2nNbYe8aDYIbFIRT0ioJUdft45QPpj85v2h5Mr/JCAOCxSVbCNiK/RnORGNcZEf3A8/46OsHCeZbVhOHeR1aAKuPoFEY7++HRzCwQf/Jd3q+nLZFVcHZXJc7dtZg7jRJZSgi1OQYs18xKrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=MmvvjHK9; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MmvvjHK9"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ae4988e039so7903995ad.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 03:58:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772452738; cv=none;
        d=google.com; s=arc-20240605;
        b=DuxEgV6//BN2ua1Gpl+z0apkqx0+CoDoVWHZvS9ygdgok2BybDyRXVV3qt5JU/bg0D
         nkP+HwI5w9JY5qkHOlC8qXlAql+rbbGXpCV+npEY71LZO1sxoa5daXN3yQfYiUrwSoXQ
         r6jBi6ETnY0x1aE5bsrPG2Z1LaVbdgTW06GP+oe82G/WtdGJikvC0Y5pJ7tanpCmyU8N
         jlTmfOeAzKLhnfMJKeScSlJyWUJeHzUePaFTyZxV7/FajdyAF4N+qc+bPKBAfBIS+gbj
         x2XnVEyNiW2wwuwYjUE1tMUBEaq98BvUWfd9F+OFkSXW324azboo4oIakI7fZpWPmPKn
         TB5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cn6EW3SsdY/4N0vlnXwNpj8zo6nlR0XbllYn3nMAaMQ=;
        fh=f7oHLfJwFPp/FlhrLBkl099EHG58EEFPsDmJvHihU00=;
        b=E2dPEtA1sb8xWiWHa9UF/4Q3PrQsaJI6B2sV25a/4V8ziZjqqaEDz0ai5DcIOvXmje
         QpV6OtvlOAfPKl3WZD4orsDYtmUHeDal7ygZAPJw0pgZaWupQz4vLHWOk85P1XUaHVx/
         2H1PSY9Y9lDWj+IQW2BpiJwWFLQQz8gTJEB/la5/IswPuEA6cFuyMMbha2ks8BPumgFs
         N/nEgs9ukLdkwoWb1+p6W+8zKKW3iJZQLNPLym7bCZXSb3kkLWkbhD6urOqh+ucz0Orr
         jhxHTP2hI5UxElE/v0vF+HppNWh3F9Ak9WscHmqPMsWNv63lTKIoQC2kaNuRK3UxioYt
         uDGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772452738; x=1773057538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cn6EW3SsdY/4N0vlnXwNpj8zo6nlR0XbllYn3nMAaMQ=;
        b=MmvvjHK9tCbIuHaDgL7IBPidPb26fPn5Frll++tLdHODvwQa+70QM2dPU1BNpoljqQ
         4SLnb7phSZwpvdEGFszYnuQ2Uu6X4lOA6uDNbntVcM2km04lnYqbUHbB91mclJKzTxAk
         UY9pL5RaurkdmQ0JDXp7K8OaweBKlKQMTpqtIOBW6N2hBWAS6DWpCstBM0BC6FQaIcax
         pv0gAbOt986N4llBWjB+wwC1LY6+LljGRxEaFiOzULWUzCT/GAsZHcZvvifsrnKMDRyZ
         CugvWfoxC5SuivHljo6Blp5IaqubUNq+M4/VoK28sFme0lQZK+C/LdveKEqQsDjXJw6P
         p/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772452738; x=1773057538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cn6EW3SsdY/4N0vlnXwNpj8zo6nlR0XbllYn3nMAaMQ=;
        b=DiLhViUg+WnGdTLDFw48kRHVUFNeXyx2AIeC5TlaYVBup7xOG/oN8OzjwYUKFJrhxO
         xjEeYOABpfhklycy/UtiG62lwJCkvFGqAr2KIf+2bMhzmHxjnDpGu86N0HvKmtHaRT8L
         /iVZ+XiR97MjwiXnMgYBMwdETNy43PySKcdoLzK9HhBssh8Wt0dMTKwAckre0hqPUa6I
         fjePiD9csvhk7dcVbn3eweY4KTMSoJndzNaGBXJkEUmMycTCe1UkLkYyQwFurqzCMr0e
         p8XyjeufJT5LqllVCAnilFxE9r/6yX5SokyOBleenYFF+sHB67AvTrrkuqeQWJoC1KMK
         rmrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBlj3Zz3evbOwxmxa2JrbvSL/02dCF4qmccAmwWvb22qOCHkMzHmiZ0tYwx7TVgipccOVzLOcX7SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbwLN1G8OVSpM2mxk2oN7iC1qS9xHjCYhTYM1UF9jr5IWzBhXj
	j4iPcuKPYODTJli365ClqpLMHFtpZ1EegAbUBSaaYvGCfryLbOljTdi31QpQcxztWpLHfsw+pjp
	EnXi0NsgEKrXxyMTDAl38SBn3huZeWw0=
X-Gm-Gg: ATEYQzxja068Ggr91KUZ6LgFs71KvsKBKO1zAo2nASMiuVbPEgey2Gfl8oK9pUWGA7s
	lTr9ec1owy3PO8HHrpXb/nVrjm/oaZIpF/8Mp/Bsohq7c4p9Q/n7xO3/Lb2/gnN4SkLrQN7rk7d
	YrfMqehdC6ID7DH5ZH+DFuZ6AqPf4z4tPDrei4FnbPW37v5n7DrxJFSNaEflIJLXlRAlUBhmoFp
	Ljdfn+H25FeYZY1HvPBew6iH6oWfk1lTuHJEZrtrw9KobJrhG5iBYHg+OLEN1ZVR3Q4v9KO45x5
	5rSrUnrTu7Ac+sTE05zz1BJbj+kKCCEwH9JlnUut
X-Received: by 2002:a17:902:e950:b0:2ae:5a44:ea80 with SMTP id
 d9443c01a7336-2ae5a44fdbamr8590715ad.17.1772452738264; Mon, 02 Mar 2026
 03:58:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228065840.702651-1-nick@khadas.com> <20260228065840.702651-2-nick@khadas.com>
 <20260228-quirky-lemon-reindeer-1045f6@quoll>
In-Reply-To: <20260228-quirky-lemon-reindeer-1045f6@quoll>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 2 Mar 2026 12:58:47 +0100
X-Gm-Features: AaiRm50A5ixOEMCu9AMwpKXYw0q-1sXvRrgscdrkIScH0FsjWH2GNDFERRZkqCE
Message-ID: <CAFBinCAkxO4HoN0Cw0Fc2B3KRLLJqso1p5+qjNN_E0c26VOf2g@mail.gmail.com>
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

On Sat, Feb 28, 2026 at 12:18=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On Sat, Feb 28, 2026 at 02:58:37PM +0800, Nick Xie wrote:
> > Add the compatible string for the SARADC (Successive Approximation
> > Register ADC) IP block found in the Amlogic Meson S4 SoC.
>
> ... which is fully compatible with g12a?
>
> Write proper explanations.
Would you be fine with:
"There are no known differences between the SARADC on S4 and the one
on G12A. In the past differences between SARADC on the different SoCs
generations have been uncovered late, meaning that a dedicated
compatible string has proven to be useful."

Do you also require Nick to add amlogic,meson-g12a-saradc as fallback
compatible string for amlogic,meson-s4-saradc?

> >
> > Signed-off-by: Nick Xie <nick@khadas.com>
> > ---
> >  .../devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml        | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-sa=
radc.yaml b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.=
yaml
> > index bb9825e7346dd..5496a0dc714aa 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.ya=
ml
> > +++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.ya=
ml
> > @@ -27,6 +27,7 @@ properties:
> >                - amlogic,meson-gxm-saradc
> >                - amlogic,meson-axg-saradc
> >                - amlogic,meson-g12a-saradc
> > +              - amlogic,meson-s4-saradc
>
> If this is compatible with other device, you need proper fallback.
>
> >            - const: amlogic,meson-saradc
>
> And this one is now kind of fake - how does this device use it?
As you have noticed later, it is currently not used.
Can you please confirm that my understanding of the next steps is correct:
- you're expecting Nick to omit the amlogic,meson-saradc fallback
compatible string for amlogic,meson-s4-saradc
- and you would like to see amlogic,meson-saradc removed (from the
bindings and .dts files that are already upstream) - I will take care
of this once S4 support lands upstream


Best regards,
Martin
