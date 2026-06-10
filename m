Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5270826B971
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102332; cv=pass; b=q0BZxkqDRZjArpmmy82Hlt/s8kDVsKJCPlmrLuSWp8nQPvE3PMk4sObugKwEP0zfZSzJ3nBqCasnazYkiYdGWy+JmpQxP2A7cYuxXImS4zNe0WZfe7Ht2rgq6f2JIrrdgekx+/icsyK50H3DdNBmL2otwf1fw3qZIkmFaxmlZjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102332; c=relaxed/simple;
	bh=TsD6fqLbjN+M4IH/+2UyPBVix65pbcDAr/qNumQhZuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWjIMQhB+Zv9VTXsbiyKkJ2YNobI3VJ/l3rbXA3YlU0rmWN5f0hwAN4Pn0xcpRJNEbL4+BBXTTOP6L4eGg/WlF12vHkAGjBaBnh4/6gyDpfbRROclTEmB3s0IkBf+TvYgRMwgadWCF8gkDinW89UQV3v+PZf480VnmLmDV7ZNXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ir2P8Lpp; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ir2P8Lpp"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-304fb780deaso6830250eec.1
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 07:38:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781102330; cv=none;
        d=google.com; s=arc-20240605;
        b=Jkcpo6sKfuHgpYgW1af+Q/Vu7oUlZigS09naQbOweVtJHhqUqHsShxhlMHDxneTwGk
         sISNrXxyFHjtsUuo7RM3pA2NSpWpdqq2+ZSXkHtXAEI/6e5XeOtFZ+WSzktxxUcOzGVS
         lYGFIV8kAK1lPFx1V0tDNYP/zYrpPp2BAggv5RIdoeW9uSe0qRGHGQ9C7G1fCn5Ogvf8
         /AVwcVvN+3Xs7ZtDsZ0ZBv4kqOIiVoLqcpSy+lZHIQ1IJgrmOcj9ls8LAyg6mXpBB5XL
         ejxo/AhJi0ljE0X1hsFK9g7+DValHgW0pJkORGlZPRMl/kGh92eet2017A4vzj383977
         d6lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xEmfQD66YljQgfpm6pWxKEM84AHfr3eAJ9XCpH6lBeM=;
        fh=rijIlGpUjyliAKsBVUiHyqeYCYJwa36YBwE2lZ/g/gw=;
        b=YgMYxpyGTBps000VKz8AXPE8rfTqs9WUCbKHcT2yVLbn6nUPc3dDIgZO4IU6qOOTfW
         oE8IqMO0AhC/uFQjyr4hhZlgiUb0mHIjN9/LyRq4rNJy/e0eiNxDZ80MGRJ6IyxAqcNt
         Aljxdjpd94hUWpUj70uvddQmf0iKR4xuZkETLd74+32m59xWMYob7Yu8wdxvBFb9P32E
         sr2MdjusQm7RSYUViWj8QZuvbd8uaRl7zGihVzjtnJjcrkKbKPlk2a+GIIolX9ST9XR7
         pvy8Wi+zb+QSwEpCzvjcBODWfCBk/LmD8O+2CGKN/qhUhb+G9ixjE4/0ZJIFDWv/S2lw
         EqWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781102330; x=1781707130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEmfQD66YljQgfpm6pWxKEM84AHfr3eAJ9XCpH6lBeM=;
        b=Ir2P8LppCaNu8VO02fs6YRWeB3T/yRaOZNBvh5K3RY9ngGcc0JwhMi6GJO1txObdo9
         ueYjNMIUYdcQQyO3oDNzqBzhK0UAIGhHOaeley5PmLvz5/EGYezU0CmnA5WdZbkd8sUs
         tW+WdEE7cwZ+cTYL+ntvXVHPZlUbV8EENMNUNfoyLEVNK2XxLflzxhcVWgT6jhBy2/ZJ
         xF8D49TGlNDIZGVKW42urV0GzjFKtOZksfQ8yZXgXq9hzHCWSuOZqNi9lPvIYBLgdU0/
         pY9qIbDWl5qpGKRKZrb5KqWSUlxnJrAPcf3j14+DnwQPkXvZbQ/7smhYQZuELJ+t/dO0
         PfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781102330; x=1781707130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xEmfQD66YljQgfpm6pWxKEM84AHfr3eAJ9XCpH6lBeM=;
        b=eCyOB84ZkAl8rTxPoivghGbgKuZNhEHEQ3eg98SWe6x/tCtuOgojp47i4mpZei6U7f
         rRkpvsE05rFmY1dX3ERkFaK9vkTUe9jDx076Whz8KoloOTBF5FUokSGTBUEmZeHkz8eO
         1pML5Ydx1ZmCSVDAmPlTHhwRCR338HpKs6hCMhxNpdyTYlQocs8ZQoMcpcG8TdQldCLY
         b7/kDBT/CWQRdp9LGWnp47xVNBD+U18phC7gv4gMyU+w5C5xVmSwR5IpfaK+vRzN2ZwN
         P3mFHwZ9nOpQ8wOgqy8Cnh7dkFKQx6JZuPfrNOo4BmhU5AhPFWeuQzf/37diBVlw276x
         f8Nw==
X-Forwarded-Encrypted: i=1; AFNElJ++clDc/bTCrbzNKwQWEqH1EzxVgWdtK9ARL87oL/EIdoehtOvydgch8XUNvixZtc9tL5zFI5j0vLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Z41EXly4GW6kENf739l4zY3m/UQzNAUlME3qFQzbSUjjtvxf
	a84C8YwZBhDspQd51PYjkER6nDRGwGsXsvxwfgjRdkCA3R+MKzgKswBf1ynrliiT8WECMJRBvDY
	Cl5LYMYI0MFJU7e8vIcyUE6RWtl59Sbc=
X-Gm-Gg: Acq92OHYNzRR1XyFEWHgc+jeRjA0dHMzuIx/rq3eE5RBbldz5TPE5xRn5WohFqhjs/k
	6XJ+s+e8OhguADCFIbeASiVzLSXeosV8hlNjgIWh8JbtsQfDyOMXrHmk4ihHvwph3Cpr1AjlOyv
	t+IxegqUA/7UMnxMQNfbzp2ImCJSJGCkeJGLpR0E2CQSJAwNQeDG+NR9xLD6+GpazhOPA4IkiEi
	xDrcWNkhTrQeHmH9i51Kc37DsaxulBVEuzdhEU9vtGBcl0gXSF8XczPV8/CU24M2ehUOe/7x5U3
	AEIr9HP+eaAzrN3LZMY=
X-Received: by 2002:a05:7300:cc0c:b0:304:e6f8:7cc9 with SMTP id
 5a478bee46e88-3077b1cc840mr15721596eec.20.1781102330361; Wed, 10 Jun 2026
 07:38:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606045738.21050-1-clamor95@gmail.com> <20260606045738.21050-8-clamor95@gmail.com>
 <aihl9yIqN3adKWLr@ashevche-desk.local>
In-Reply-To: <aihl9yIqN3adKWLr@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 10 Jun 2026 17:38:38 +0300
X-Gm-Features: AVVi8Cf09c5dRYmH0R9kJGLjsyEz3GTJujrRgluMHRMUhIaWopJLSUHlJiMgJFA
Message-ID: <CAPVz0n2+27QVeWNgPm3PH6V2Ceuym6sbMtUrh7hSHe9PcRmfMA@mail.gmail.com>
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

=D0=B2=D1=82, 9 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 22:14=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, Jun 06, 2026 at 07:57:31AM +0300, Svyatoslav Ryhel wrote:
> > Switch from sysfs_create_group() to device_add_group() including device
> > managed where appropriate.
>
> This should use .dev_groups member of struct device_driver.
>

Specify pls, device_add_group literally uses dev_groups, I don't
understand what is wrong.

> ...
>
> > +     ret =3D devm_device_add_group(&bd->dev, &lm3533_bl_attribute_grou=
p);
>
> This will make Greg KH very grumpy. (For the record, original code as wel=
l
> but it already is in upstream. So, thanks for trying to address this, jus=
t
> needs a bit more of work.)
>

In the prev iteration YOU asked to me to adjust this. I have adjusted
and now you say that this is not appropriate. I will just drop this
commit altogether.

> > +     if (ret < 0)
> > +             return dev_err_probe(&pdev->dev, ret,
> > +                                  "failed to create sysfs attributes\n=
");
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
