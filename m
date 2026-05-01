Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B6E413244
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 18:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777659976; cv=pass; b=UEANfIcCznSV4zRbIYheiWzO5qrFFwCRn3LdCtwLSv0HALbetRQ1OvTzyHYPuQ6opZkIRz574xAKHuE491gUUvRGRdQDENs4pnhspUI/4QqXoauaGwkzdUXN4LiM/CvmHxxwxY1U0SEltWOCF8Qd2LuvuBj7pJ9y8Cgd8BdvxAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777659976; c=relaxed/simple;
	bh=pV+suN9W1A6yZfc4Ibsbi1Vqls27R+qZ5YNULCTDH3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bcESXtCcpPMg9IQIuB4NJObBba5zb/jid2p9c3k7VqZ7fDlbh2Bzt/JzErJ/Nvw0p2W+tL0lG5wgEF7miK81N57F+oFTyAlvQfXIZI5w5eH4B+sY487ro49UaR4TCJ40HAnovrPeDte5N3mrAGQoo6EQzcNFX3OgdzP5QiuzUqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pef8mdG/; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pef8mdG/"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ba92146cc86so380376766b.1
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 11:26:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777659972; cv=none;
        d=google.com; s=arc-20240605;
        b=Jk+NF1TWbSzblyw9JGAhWTyEHWrcx//cdB+yn9ZdOHc6nD9uLr2QwCCcG0jAovBLND
         CoZ4e2MyrW6iyo9WNFZqFEFQnme21re3sDDVawtX/XmD8zBB7movAIBnxZD5yNluA1x1
         lCg/mt0Kg/bZPiKznFJy5gw1qePOPodU11F9UHhAWW4qi/Z+synqZee2iUCvEv+5IIl1
         X4KVW5JJaO2cnvcUNEqM1ecmtyPPRPsX+jeSuBhW60cmCHpf3s1l62RLIqyrW54EHGwO
         xn+Pbsf526A5Mcr/s+WtGUbvHDSqv9oNCpPs2QgNCLKsdRxSelaCq65H56WaBC6K5XdR
         6O7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mjEo9TVAU6E8H22fl8jtqKDStep6BqgLc7IS8Y+Q4Uc=;
        fh=Hm4jHSNEeC5EayGHyan0ooF4Kvn7lp1iwTjny8W8ZEM=;
        b=et7JCUSkI7M+Z/SgJPGMSW5Z7Dvq2sDDav5xp0AdAd1dOr++3/l3s6G73fQKEk0C5/
         3C1h7iXamt8CUFjvuwTKS98xK88N+7m4YGkkpYeL9IiWxhAxs+mKD5ir7HWyIpP5pNbG
         l38dShJxM0tlesmb3xl8leBOv5o5pOS4t4BccvtXpZF0j/mVBzg2OZqFxuDGGRdvz8I5
         6gfhuLJCztVXBJxdgWBvgL72uW6ljgF+S8mZXJbfpKTW7lL/OQ5xcW81t+ZD6UM5pSTc
         LdB4R1HQk5VjK/6rDYImv9i93z3izDD3wvi3jDmKuL75HwMCR882si45JH39W2NedZz5
         0nkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777659972; x=1778264772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjEo9TVAU6E8H22fl8jtqKDStep6BqgLc7IS8Y+Q4Uc=;
        b=pef8mdG/fSsLQeWZJ1ZqD7HSUqFOkNFzMfntyjPWlz0C+0uJtLAoxlLvZ4pwDPOL10
         WHN03FNGpDUR7oDFcrcqdYTnEu/IAvO1nn9iXSwjAwrTl43gm+81xC4RfOMRmeuM2Fke
         QT8NzAfQbuAQ6GEBitxCEU4abFD7C9bqH6rJMI22IBnwR/4c6qD7BD0S2Hs8W0+VRlgR
         cUkKqIw4ODhFNdn5g5FBsWUwm3qVbiwmsn+D1QPAjlwnhoxGYoMS6iYH3NOUaAlp4Hg0
         rH0xOYC9iNeLV0Kty8mvx/8i+cUjbRXveB/3b6BCEkaMRloVUGXPHQVTlE6fIyjGZk/C
         4cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777659972; x=1778264772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mjEo9TVAU6E8H22fl8jtqKDStep6BqgLc7IS8Y+Q4Uc=;
        b=N7ngV9eCLzlRkuYmYtEOpyQTnUdwX2FKWnfhzXVB9ZbZ/jYjJE8dt2ovvIQCi/v88F
         u7CKfvTwNnDBRcaizk7UNRgYXdtJAT2AXZz4jNqna2aC+PYjF4cn+jTAoHn4b9eeV8FP
         tyRZPiWQCMdNyRaGq2eOBiEv3K/YYNtxQtVGQUVOXMRViJGxn1cfLduuC3xbKoAif8y2
         odtZoQbIFINq3ImkR+Ln4/z6+qyZzeAxpnyW3IyJefYKGN8ZD4h9k/NVTr6Xbu2Mhh1r
         liqJ+wnOiEi4bWRbLCBSj7nDslDryiRNVuOf/qpLB2VkfFnAAkiMeHr4cw8YL/se3UEe
         bPFg==
X-Forwarded-Encrypted: i=1; AFNElJ9vq7TveKZNWRktsHPe8IEN92I1xqpgJBwiIswCo9wPbZlTnNo7iEMwvxygj9aNNcIfomQ5L1pIm2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/mvQ5g/JKznWQJmNQ3A717ThvxMVJeNae6QvhBNlquoqR15Sf
	EdGpxVZj4gB1gvWweIzSjXdObgXNdtd9TcCfcemOBI8ed0GuIF77rDq8SRrtOVNfH/Whgpntu24
	Tld9Ialz0D6+hm1HCSzJj0yjqa26z55k=
X-Gm-Gg: AeBDievvyChWgZMLKMPmqZnGAU8hDVAaoVvm8x5c0JG9aJ+c30suAzWGLo5JA9Cb9ff
	FxCOlKmPltagrRjZatqhehq3ckxczWfZEx1TWfIIPP7rqq3m/RnaXI+YXvE1JrZqrfQLEfIZ8pA
	GvWBfAaj7+rptak/l5/EsLiJHfK9nW3BUdIVnyfXFLE+yotRpFA8ugjWWKPhq+k3oEPfXA9vQa+
	lmoGJp007pDhuofWcfEuRZow+X+UkZTUtczOr+f5fTZORkNgAbpiTeg566HPwjU9cNZ0xYkT4GY
	3trNtdUwWS+Al0PQzhJz3IE3o9sCZu2jsTdW1L54ZPmq3E8tZJvAyy/uEmKMsYxuoL25IgGBEBU
	RLU0wDK2qN+OkwuWdbg==
X-Received: by 2002:a17:907:934b:b0:ba9:aeaa:fd18 with SMTP id
 a640c23a62f3a-bbffb951c50mr8523766b.28.1777659971938; Fri, 01 May 2026
 11:26:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429175918.2541914-1-sanjayembedded@gmail.com>
 <20260429175918.2541914-5-sanjayembedded@gmail.com> <afJdJIQS1vwOcaGT@ashevche-desk.local>
 <12C22ED3-20F9-401C-ACC9-D666393B292A@gmail.com>
In-Reply-To: <12C22ED3-20F9-401C-ACC9-D666393B292A@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 May 2026 21:25:35 +0300
X-Gm-Features: AVHnY4JiQImi-kzKeeq0M395Ntrx9wDGlULAMAnx041KdEXGJGgDR69IdiMeRVo
Message-ID: <CAHp75VdzPr+SLCPT85zw6aK8pSueBHr-OFpJ1Vmsow61e8=p4w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] iio: humidity: drop hid_sensor_remove_trigger()
 using devm API
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, jikos@kernel.org, jic23@kernel.org, 
	srinivas.pandruvada@linux.intel.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com, 
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 10:21=E2=80=AFPM Sanjay Chitroda
<sanjayembeddedse@gmail.com> wrote:
> On 30 April 2026 1:03:56=E2=80=AFam IST, Andy Shevchenko <andriy.shevchen=
ko@intel.com> wrote:
> >On Wed, Apr 29, 2026 at 11:29:18PM +0530, Sanjay Chitroda wrote:
> >
> >> Use devm_hid_sensor_setup_trigger() to automatically release resource

resources

> >> during fail, unbind or removal of driver using devres framework.

failure

> >>
> >> This simplify the setup, remove goto, avoid manual resource cleanup in

simplifies
removes
and avoids

OR

"This is done in a way to simplify..."

> >> teardown path.

...

> >> +    ret =3D devm_hid_sensor_setup_trigger(&indio_dev->dev, indio_dev,=
 name,
> >> +                                        &humid_st->common_attributes)=
;
> >
> >I believe the first parameter is utterly wrong here.
> >Or other way around, same issue but in the previous patch.
> >
> Thank you Andy for the review comment.
>
> It looks in same humidity probe of hid sensor with devm API two device po=
inter are used &pdev->dev and &indio_dev->dev; ideally all devm should have=
 same parent device for devres resource framework and over here preferable =
and consistent device should be &pdev->dev;
>
> I would first update existing devm_* API to have consistent device and on=
 top of that will use same device in devm conversation.
>
> While for gyro change device is consistent as &pdev->dev across all devm =
API.

The idea is that you have to go deeply understanding the object
lifetimes for the cases of different device instances along with
userspace communication channels (all possible ABIs the driver uses).
With only that the proper parameter may be chosen or even confirmed
that device managed resources must not be used. Yeah, this is one of
the downsides of devm_*() APIs.

--=20
With Best Regards,
Andy Shevchenko
