Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237AD2F1FEC
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 12:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181115; cv=pass; b=XvfEfKOXpFAeu/XQI2AUp37EkZofQzqXcHkk9R+bBIgwtfqfGrQ/a/cE1NDr+0KoTAXOU9xUS1TKVAfw+uBUR5f9PC1zfreGFAOyqW3GPC8l9sIQ4YxgScP37XUNh8YmGSb9tw4dNe4g4AEg8B9UTWDE/Oa43XxZQVCvmUokCc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181115; c=relaxed/simple;
	bh=N9w8AQ/izAnL6SZkvE0t7Zg95S0t93+i10d7C13tBDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OiOrWSWf02pnG7jpDIp+gCkHr7ma5bGzFbSrDsFWLCbT+6s7Z6ysiwW70kHXmqZrZKeg8IXYj2tvmM46YSi0ARhYP4eBlGAHAFnCq5dY15HGYx/8DK3ePsYNCAttm9sOPCjeT9gEtsbPoxoVGuoBEJOLk+grn6t+7yBV0TbhptU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMrjbGU/; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMrjbGU/"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-304e83724bfso10055550eec.0
        for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 05:31:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781181113; cv=none;
        d=google.com; s=arc-20240605;
        b=Ms29YuuQfSG3QSK68yk2lFm4ndR3KCvJAN2NAObOes8Vx58odmf60E51wShHAT6ASS
         JscZG4Ay5QNFQvh+0YoHg2E1Ly9yLMMwG9bzE/YrLRpZ5CwZxyNHBTMWRy741+KnJSSZ
         mk9BW+HKfIz7/kvhtkBRdyK/VrAZneGqlqsknDuK8LN2txHpuJDUxSaH/9d66RBS4HTG
         pBbXTh3JAgZLei6Q+VSz4+sY5TMlIG1Pd+fTZtdfYndoEe5+JVdTqr7sx9ZKXbldCRe5
         J3ABKiUFbHgbiCy+gYHZj0xV2sZDdeJS8om3YDbFJlapU1my7nYzNBDkMZYtaVaHNpza
         UEwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w4CyzohY6NxCIsHAPrysIwJ2ZeDEULVaTSdexi5v2m4=;
        fh=wpdmWPMCo9YOzpsFXAJ34O5Au3eDZiVmwlk579LlPyE=;
        b=MRF4AHEahFTpjz60jmKOQk9nvKurCScTzF8HyabmKqSqEXkWJjS95p2sHejpDBGlub
         R1N+47ZW+ZfSwyPCnuNAU1jp6phaEXtJorsI6t7r77s4iQslbCCQvOnWmJd7ZCXySOJ6
         Vjd/CCS/8eZ9Rghbgg2DVUtaC5eifhxRMkMDXcCOfYLwAW/PLVnc2kq93BuqcMjbZSdb
         axLAogO1IMt4+pGpPVPWRQg965Cu4/zdd5r36Xecm4a6Q7EO8IMLu1i8lnBqUtgWDPOc
         9Xx+DknM8JtlPVRsVOogVNXAHyKQX0dGQvmyO3U7eN1pWOdVS1/MMOAfCGfJjY7VpN4F
         W87A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781181113; x=1781785913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4CyzohY6NxCIsHAPrysIwJ2ZeDEULVaTSdexi5v2m4=;
        b=jMrjbGU/K/MiY2zpDfjCinZekRAjsHLsioZc4nj7eI4VhBvHnKb1u0mEDXZ6rpWSDc
         AFAhW+U8S/DDVHpdGjmLBtrX60cuCucbfedeMIigZmiyxFnFldmIr6MZ4nxTnrDPDhNk
         Djj0Yrjtf3uuX4fjdVvrEtKWaucr1c71MLU6RrNKuPHywTKCL2i7fnDs79eHmkqVkxgc
         7cwj57+IS/kQ+HMIFG5awsEfTAzAS6H/XvUC0URVujIuLj0WoxmR81MdiiNc0TVjTVbU
         p0UEzyUbVf42N3mVisgHO8vf2ahgMH92KtQOYVcdOJc6n20hj5gecF2MxtIDBesF9yVi
         3sOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781181113; x=1781785913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w4CyzohY6NxCIsHAPrysIwJ2ZeDEULVaTSdexi5v2m4=;
        b=q9b6wbRb22SZIAdh0j2D22L3lHO0QKD+4URG1gwlNLj+BBEUujqSUCojUPZaSKAvsU
         I7eBDgpzpXSzSSLOz1gvfp1XTBfkGRaG5ME+j1qzzJt+b3/f3qlee/OP9GJouRcFsZMG
         2YQy0piNGa/qUC2jaRym519/BXRXvQViI6EZT/PHyP851rZPJqtojFOsHX5RiYQ81/vb
         Z7Z8a+2FsvsI/freFmlVb8ALDTNKZHr6hajAQp5gNmGaMt649nojHVU/8qVVJmb8faUq
         mVYqWP+ksv+E7QigEexQx/Q/2eiQYMMIuw4xCBe9uFDdjFIAu3iKpyF9yNQWD/MVQmYZ
         X/Hw==
X-Forwarded-Encrypted: i=1; AFNElJ8pdOEySPxmuphdQWjRNbLKmUNbB5xqKRsCmWCAgTjaUSuyUiEzLpzc0s4hQ50JVuC1zqRgmT05piI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC9CbIxxhXakXywxonXb/eMgGb0+9JT5LOKYlNopVplSI4S5DF
	wGpose7Z0VulVO8hfd9o1Bjt3/flwcYkOS9M0KQcrEQeKt0y/kzdOmCSN+0blhIYxvzALNvmbNj
	7D1mKhOqYVXrXHM15Dd3Oo83tjqCp7gM=
X-Gm-Gg: Acq92OGi+vHbYpNRK8WHdZTJonoInHxY63+ZVE5GviSp4OIBWTt+ankbFwfWpgWvbS0
	5TEYxcQB02+/lFvNfqj+nZ34xHXwDPvjA6Hev6FvFZAsriVU5aO4ocI+Qhpv4yAdvwIAnURWYfY
	/mRMKEa0XP+yXxHViX+dYXsTQlY4Do/vHSAUpG5QmVRvQJtPZ7hM42IczSdyJb2dHTQXxQuPJ4v
	yTYX2/ieKDGRxK/2x3T7ByAbNReRZOS1gFonTnsRCOLz6gp7pMMqTe4DbuF3jWtTqAvl7uy8UAQ
	eRjpZ6bdY0zZFLZbL78=
X-Received: by 2002:a05:7300:2205:b0:304:13f3:e461 with SMTP id
 5a478bee46e88-308047892c8mr1778310eec.3.1781181113170; Thu, 11 Jun 2026
 05:31:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606045738.21050-1-clamor95@gmail.com> <20260606045738.21050-8-clamor95@gmail.com>
 <aihl9yIqN3adKWLr@ashevche-desk.local> <CAPVz0n2+27QVeWNgPm3PH6V2Ceuym6sbMtUrh7hSHe9PcRmfMA@mail.gmail.com>
 <aimxK3asZjebYrNt@ashevche-desk.local>
In-Reply-To: <aimxK3asZjebYrNt@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 11 Jun 2026 15:31:41 +0300
X-Gm-Features: AVVi8CfaCeDkKO_UpXhT478yTj8VjHK953EzmbL2Rc52Hp0WrpWg7gTbUSSSXw4
Message-ID: <CAPVz0n0z_6fuoxBzLcN0VdUBUWZB1c0VGsAkDW3xXnPuwZj-3w@mail.gmail.com>
Subject: Re: [PATCH v4 07/14] mfd: lm3533: Switch sysfs_create_group() to device_add_group()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 10 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 21:4=
7 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Jun 10, 2026 at 05:38:38PM +0300, Svyatoslav Ryhel wrote:
> > =D0=B2=D1=82, 9 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 2=
2:14 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5=
:
> > > On Sat, Jun 06, 2026 at 07:57:31AM +0300, Svyatoslav Ryhel wrote:
> > > > Switch from sysfs_create_group() to device_add_group() including de=
vice
> > > > managed where appropriate.
> > >
> > > This should use .dev_groups member of struct device_driver.
> >
> > Specify pls, device_add_group literally uses dev_groups, I don't
> > understand what is wrong.
>
> dev_groups of the struct device_driver. It means that the data should be
> static and be available before driver probe is called.
>
> ...
>
> > > > +     ret =3D devm_device_add_group(&bd->dev, &lm3533_bl_attribute_=
group);
> > >
> > > This will make Greg KH very grumpy. (For the record, original code as=
 well
> > > but it already is in upstream. So, thanks for trying to address this,=
 just
> > > needs a bit more of work.)
> >
> > In the prev iteration YOU asked to me to adjust this. I have adjusted
> > and now you say that this is not appropriate. I will just drop this
> > commit altogether.
>
> Yes, and I still tell that this is the way to fix that issue.
>
> You can even do it yourself in a few clicks (hint: `git log --grep` is th=
e tool
> of the day): 93afe8ba9b01 ("ACPI: TAD: Use dev_groups in struct device_dr=
iver").
> This is an example of what I meant.
>

Oh, very nice, thanks!

> > > > +     if (ret < 0)
> > > > +             return dev_err_probe(&pdev->dev, ret,
> > > > +                                  "failed to create sysfs attribut=
es\n");
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
