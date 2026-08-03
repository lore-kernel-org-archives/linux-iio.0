Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872DE30DEA9
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 08:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785744435; cv=pass; b=HMUL0IT+/QDaBegoY0unS1EV1g9qmkP6nJkt2mw4wPevG4cCX6xPMA3aA0Oi2a81gMngcta+UnlzqilO12L2PoepHBX6m870zUPwUnhvdFQc1Ib3drmoAjcRQBECvCsRUHp19pysB7OFMaJsBdMhD9GbqjwVpcubUX9uV9TTkL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785744435; c=relaxed/simple;
	bh=CfjC2DgaSxdq9CwTBVQ+CQRbZiNezEc5R3GNUfzDETE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8oEysv2l/YLTEcnLeJps7sEr0Dl0/GByj06tQsD3fT/EwFU5vRn8W+0dkG/0NHdUTNe10jWbp/71MSC+uY6pkHgyRYcFcpx75HhbCHx3wZ5BleDtynFiOvGwYD0U3MwTKqFKSefWzVqzw+RNrUYOY407AcqKbvcoYD57X8tazw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKbgZsYE; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKbgZsYE"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b2aab18795so2613168e87.2
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2026 01:07:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785744432; cv=none;
        d=google.com; s=arc-20260327;
        b=jlJV0Rexj+XyQjRQd28IOIvrdihlSjV492j3+ZEiFsxcoB9BDhKBhIq1mEmAUYNRmJ
         Com1XYkR8cupFq7avBFTZCPzGaOridt1ZSmNqte6QUG7z9OZ4pLwbyLJGuEo5vSxWmk8
         fOLiEzy//Waa+HgqRG/pR6RMisJTzfvAaULkYah1em43ibqJtFQB3OjPosWr4Nlq865C
         ObEl+TGGsfSPkxwtv2rP0KTY6meFaMDs6rfL0EMbSUrngJ903L5qUChCriCfkQBXK207
         rJHg4mDAPHY1AJRBK61OLquum4GAlUo7GrlgfmT64f3mDuMw+wRDLlJQoHu61DyRiTo0
         SATg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nSI9zqKop7etuUO6synP3KpeHcLdKVytIDMS9A4Kh4s=;
        fh=Aw85eQpv+9siij5r7K2wGh01IIyAy55vwRSwf4vYizc=;
        b=aL+8puVud6yqLhyYkSSXDv1ewTSmrlPXU2wd6QTrgulyF0QsZUoINyR1e5tdDPeJ+I
         UBARzEv2jvHIyXGsIqkDKgdyXdZAnsG7LNGqkkR5MmCoE9lbzqg5xxJS+aTuo3HOtUDI
         vqu2nbwpYVsQ+2kPerGx9FHRC1ECGdWJ4aoM0nn6/jzkwDu46mgua/v3XGBQ5dQlWE3B
         poIrPml/lQrEoX+ECh1it/1NS9A85LIul1y3gB4UP2+5mauh91N1TSGBis0fUQ5jZgUB
         YmCBdvZoP+kXMk/dsofoBHrcuOhVRAewhS2yQajyy19UeOFUQJ/+kPWgcHW13/kVvlGO
         bODA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785744432; x=1786349232; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nSI9zqKop7etuUO6synP3KpeHcLdKVytIDMS9A4Kh4s=;
        b=hKbgZsYEEv1DUC+BaphLWKnsJhwqhtwEwk8Xy+GLylNhaS+PAt8CdyURnumgPOxJWu
         zo34t10j3/OxeXTZUbm7B4ewGuyixKGSIdhra80b3O3Q8EQu5TrKlZsZP+7NCLfnxTB0
         g8m9KgPmpEGyazeWgNo6yOP9lAcGiXgnzg3GCheqqm1MB9Z6aRZBe6qlpcoCBe90PgJw
         7+ABzFBjRbSISUxct6uUIfnfYuNsXmoFFezva7jboicZc/WmjEsmDoUvibZFnI6VAMDH
         r7jbAmox5BYtNvP3byEFG/6mHP7X0F7X64D/m+lOQcedIYaf050pcjKV0A06aHnFDlvR
         5bUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785744432; x=1786349232;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nSI9zqKop7etuUO6synP3KpeHcLdKVytIDMS9A4Kh4s=;
        b=l2UpT/swEvomg+8RRw6WX21S++sFAY1+wU4ArMO/lcWq6iUgXIH/2TEpBZbcEIxo8t
         OlzlIBj9wHuXbm/XSTsXVIBSnuym8BMTn88RvKcfG3oru5MFenvtsTdO4GlRz5NtQaP7
         FnrHH1+4i4OaWvQhjQ6rHjYzL5yxJqmdzkSsAfUJiaqH87pP+NOq4qsamBEl9Nu23ViQ
         9WzG9hNC0zTaUOlMwpj3JGR77jv4mt9MctSY/+EBSByCgkglLHi0W2yStDIc/LZb/42x
         smGAlul9rwusHKZhSPCPy8Qob6kMuz5o1qVbzj9Xlow/vFV7B3kqXQSe/Pd+RfDTTUXb
         0yHQ==
X-Forwarded-Encrypted: i=1; AHgh+RodG8HrCU4RZeP3+jsx/07BO+wKAG4sVojIk1dduUj7whkviqgn3Yq6Q2KwMJzi/by+/8krR60rq3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeCsuPIukmdjntEIg3d2FhkO5e4MZa/QE9xsGDwqx+ItqGskFg
	SbVjAq/2w7m+L0rm/5ek2mHgj9Qy+O5iY6homs2LeO5A+Pb9ckfo77cSKN8TRRwyY8NkSTFAV8Z
	jRcZgtya0pIMUczO2dbLv7gc2S3BdqAU=
X-Gm-Gg: AR+sD10wTxl4wIM7rH138/z6z0ko3MXxCSxLGyXx4UK9iE+2Ki+71pVeOe+DJ+qMKzt
	3OxiD5eBzTtOjP42OdwopjRSfmB4gzQSuCZB/RjqbyhI2JjmghwZNlMTLLGMMLcdKk5j/vPFQmg
	rTw06BOhqos9pCva31WSm/L/S8L+vNJCAeaE75VuHGGw60ncofnSm9NxEQqoYBVwkuccnUuEhHn
	+hu+PSfzA3kBu2SzRXqapRuM5bHTCHJbf1bj0e3CV4uzITJnXyS23eciTlHijSWo07VExRXaww3
	xZTDED3jhtM3utba3Pi9Rxqf1NJib4IHXey9wOT5uPQaZw==
X-Received: by 2002:a05:6512:3b88:b0:5b1:59de:8987 with SMTP id
 2adb3069b0e04-5b2e4f33084mr1761260e87.16.1785744431485; Mon, 03 Aug 2026
 01:07:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731-ti-ads112c04-driver-v2-0-aab0168c3c01@gmail.com>
 <20260731-ti-ads112c04-driver-v2-2-aab0168c3c01@gmail.com>
 <20260731112750.00002c37@gmail.com> <20260801235920.434c7cf9@jic23-huawei>
In-Reply-To: <20260801235920.434c7cf9@jic23-huawei>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Mon, 3 Aug 2026 16:09:02 +0800
X-Gm-Features: AUfX_mw5S-VZqLxsa5VDJFVOvLA1M6MFIvvqTdPT3jio-nOTJlAQnbpEnmBLP8E
Message-ID: <CAF7HswP-dyPmeDavygUy3f8i-xth0rgDFh63eHaGa5gcxaLr1Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads112c04: Add support for TI ADS112C04
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,
Thank you for stepping in and providing the perspective!

On Sun, Aug 2, 2026 at 6:59=E2=80=AFAM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Fri, 31 Jul 2026 11:27:50 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>
> > On Fri, 31 Jul 2026 10:58:25 +0800
> > Kyle Hsieh <kylehsieh1995@gmail.com> wrote:
> > > diff --git a/drivers/iio/adc/ti-ads112c04.c b/drivers/iio/adc/ti-ads1=
12c04.c
> > > new file mode 100644
> > > index 000000000000..28d3be81934f
> > > --- /dev/null
> > > +++ b/drivers/iio/adc/ti-ads112c04.c
> >
> > Hi Kyle, quick review from me, comments inline. Additionally, please
> > check Sashiko's review as there are some move severe issues (mostly
> > I2C stuff), see it here:
> > https://sashiko.dev/#/patchset/20260731-ti-ads112c04-driver-v2-0-aab016=
8c3c01%40gmail.com
> Be careful with these.   Some may be misleading or the correct
> response may be in a very different place to sashiko suggests.
> For example we wouldn't typically bother to defend against nonsense
> interrupt types from DT, so if level isn't a plausible type then
> state what is as a comment in the DT.
Point well taken. I have reverted the IRQ flags parameter back to `0`
in the `devm_request_irq()`
call to let the driver naturally inherit the trigger type from the
device tree, rather than hardcoding
`IRQF_TRIGGER_FALLING` just to appease the bot's edge-case warning.
I've also made sure the expected edge-falling behavior is clearly
documented in the DT binding example.
>
> Also, multi master doesn't seems like something we should worry
> too much about.  That's not to say there isn't a better way to handle tha=
t
> transaction.
>
> > > +static int ads112c04_read_reg(struct i2c_client *client, u8 reg, u8 =
*val)
> > > +{
> > > +   u8 cmd =3D ADS112C04_CMD_RREG(reg);
> > > +   int ret;
> > > +
> > > +   ret =3D i2c_master_send(client, &cmd, 1);
> >
> > i2c_master_send returns either the amount of bytes sent or an error
> > code. If the device NACKs, the function will return 0 (zero bytes sent)
> > but this will be interpreted as success.
>
> This one is fun and not necessarily that simple. (I used to assume it was=
!)
> Mostly nacks will result in error codes, but there are other obscure
> reasons it might return 0.
>
> Anyhow, whatever the reason, agreed we annoyingly have to check these to =
see if
> they are not 0.
>
> Or, better, as per David's comment use the smbus command if that is possi=
ble.
Taking both your and David's advice, I have completely replaced the
raw `i2c_master_send/recv`
transfers with `i2c_smbus_read_byte_data`, `i2c_smbus_write_byte_data`, and
`i2c_smbus_read_word_data`.

This elegantly handles the transactions and completely side-steps the
headache of parsing
those obscure `0` return values from `i2c_master_send`.

Thanks again for the guidance!

Best regards,
Kyle Hsieh
> >
> > > +   if (ret < 0)
> > > +           return ret;
> > > +
> > > +   ret =3D i2c_master_recv(client, val, 1);
> > > +   return ret < 0 ? ret : 0;
> > > +}
