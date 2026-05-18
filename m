Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138B82DFF04
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 21:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779139107; cv=pass; b=JG/Mj2bUfqLJ42Ffcs9Vam3UCJ3rRq6jC5OR4bgFk0L2P3zqxDrDbLKeG43Hnk312XbtwN2Skb1SYgC/fsT48YgrNL7futE86oWJgcniTncP56Y8MmYVq/RWKpyDoIUdpScDEt3eVHEuiFfgmZ8T9+M0iNKvw8w2cR2+Glskh04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779139107; c=relaxed/simple;
	bh=4qUw43U2LYoI9+/R/PJBXjvbtL6mII2xem43FyU/rRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhVYmMiXg0tX/IMpl8L0Z7civCR5N8cBW4lPmyX7+OW3eN0bBzSJOo7EPzFoWNe61CtJsD3Gm0nwJ326AmmZMV0gf54390nZ/IJTAQ0vw3RP3M6cubckKpaMJsfEDzOgayOXwavWnabRI+YdwpHf4LsF0YnHW9rDpi40jhSoids=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n8JXKa7J; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8JXKa7J"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3939d2bd739so24532401fa.0
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 14:18:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779139104; cv=none;
        d=google.com; s=arc-20240605;
        b=gFkRONGA+8s0xiJNKeFdyY4IWOdnPXwB0z9OWCbxTrF5sSLUAVlfbgGSR2mjFvOPOs
         DwaS1JgZxe02WR6P1WTfp59b2FOh492j/uQUmp8CTuls8FBK4ytG68sRRenLurcTkLc+
         5PY7CvCMx4wc3bFHqCnNMOvc/Ji5s4IDLlSP7i8x+glQwuqHTqHoWNwmFtOw0fEE4ZDe
         umYseV6AQ2K7JZMhj8FjbBZBvyzjJBEAcm5CysH+jodnCd+hJ1elwcSWjNGVj6LumJxp
         9400kRrpkt5tcBAORFruMWmy67QDND3iln+Zp3R9oj16V8gmOf+NY7Ki6ejUV2Z4T3LS
         1vxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nPd2OppDv9ew6wMyj8LXvgg1wtgj3b6TQdSWXMfEVvQ=;
        fh=2mszjo3OdHdVrzBU/iGgyU8LJFp+9OtzCY26hhJp0WI=;
        b=QHELja2Kad3R+csWpxlBadE242G5sd8zSgK1YkIYD78Kivoxo7fri5amVCo06znA7W
         dqTp3tqsvzfxfQsjBAncvcGyhNL0V6l4/NDi8WSpVachfdoYT1H/4q9uqmL+ifisqdtq
         z0E8eWSRASRg3NnroPFoZmDxsalmgyFz9awCSytfSSugAUtDp9Hf2hFl0yeqvyr4gGBb
         H+PQBHTLRIc8sceJD6XLrOs/VPQ2OEd+7bbgTVIVQuu7Yfwy5fJqdHhmyIBaml+VR0e9
         OX7RL1dmKDwxn6WPcqMEcVu1t0UtL6Fo7n5QDPhdJU63mXpPc4QjT5u06o8duLkSXUmd
         qE8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779139104; x=1779743904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPd2OppDv9ew6wMyj8LXvgg1wtgj3b6TQdSWXMfEVvQ=;
        b=n8JXKa7JvAO+ffCYLdTVpySeZzFoZVeUtXKOg30D7UX5gmt6wIDgCeWHz0ys0O/d+K
         czO/s3bwkJDeXEYi1gQvPE72yka0bx4k6JZf5BKRgVV2zp8aaqLTlS5f6tqAJy7/+Ww9
         27HGv68coSSbnJzB897YX5fxbr2IDh+VYSUdjuNMM7QNO/Px5S/TCCHo0J75uZ/0zHwq
         FK2Wx3oSNJOGUm4wDm/hWbGGTXrC+t6PRDNwHg02ytCW6l1yiFNnt5Fw65QFs2TDchUL
         BCgtIYdknqhIk7gjH1lp0ZfKTGcG3H/VjwpYDNObJyd+HfPFw0fkA2L++lXEOymTnZ9p
         IulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779139104; x=1779743904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nPd2OppDv9ew6wMyj8LXvgg1wtgj3b6TQdSWXMfEVvQ=;
        b=ezIRhF+0KmDN5irjXFr6CpKHP23aQS9CQHwP3qNbgQ3RD6QenYpz/jAzG+J2CkiqtX
         g3fR43FLLO5a6s+HgEHEGE5Gm1c0hlBjUR1TCuK4wK/jgEvPicqxTrKcG/9Zn4xoMztO
         v48lkMCzi3oJl9kW0/6NQ3hOd46qzO4SxZNQMa/8JXrae5g/IU/loTZlrdsgnjHR9M+6
         1M1Fps6K4AmjIwkUxBZqm2NOj++6iygJQZon/gwhv7fsQ/D2UG6xwjvfE5qlzwqEqFUr
         /WH4ebwsp8pMvI3qjxghsVrmIe/dNcYeo1jvKyqHGEyY7b4u5bFWHzW0AsZt3divum2N
         RNgg==
X-Forwarded-Encrypted: i=1; AFNElJ+6sHgzQGghMAEobQJV8NEh3IEKvRW8OUg45nt0Xst0vXaytrwIJgyC/l90GczLnEwx18cey3SPYTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNIbuRRGSv57mJMiZLua+dygM5ohQVJoBpJ89wiIi22HflvWIR
	FDBFa3t/M9E80C4+OK7K3YiH72O9w8whpjGImNEgTHdtBa4hivGRk3hT1+5xS9H4IZk2Ijht8vF
	0ZMBxejMpKIGLgkckpE+qfmVggo1FTf4=
X-Gm-Gg: Acq92OEGYXifpEE/9ltY5L3b558VMaVc1hyj+08sDXaoU7yvjDULmmzU9iBHBYtvVOv
	YdQcazp6eQmh4Z9wsY+0ELwAK6D7SFLQPAXA4RY/ECVrQBAvxExF0mVtKQI68V5K4hv7/MOpeCe
	Zz1tv5ZZexSFq1doW208SipJwrGwuLL9vFOYPO6zYoezO2tXZ0KKIT09uZhcFeP2ZPxJ1mFH8Z4
	vVw9aklbXAigCc+UCKZsbBG9HjgnoeGCI5vWnwzv1mRf2xFxKbbw5yjOme0alOrpFJMqX9sjEL3
	/JXyVmje5fHHl2dbWFDvHf7bdqG0Ij9DMuHy0e8=
X-Received: by 2002:a05:651c:439c:10b0:393:9773:9d8d with SMTP id
 38308e7fff4ca-39561d33099mr38846201fa.10.1779139103939; Mon, 18 May 2026
 14:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511174342.123820-1-piyushpatle228@gmail.com>
 <20260511174342.123820-3-piyushpatle228@gmail.com> <20260512130622.1f3f4d08@jic23-huawei>
 <20260512130809.5ab5eb90@jic23-huawei>
In-Reply-To: <20260512130809.5ab5eb90@jic23-huawei>
From: Piyush Patle <piyushpatle228@gmail.com>
Date: Tue, 19 May 2026 02:47:44 +0530
X-Gm-Features: AVHnY4IkPA2euuGf4uy-HpNCACUI-JapCUTXmjsQETWfi991mkr273OkQQB_1ZE
Message-ID: <CAMB+xkaOEVbc=nO0nSODJC6cmbGiXZ9C+WA8NEY8Lhj=3c89JQ@mail.gmail.com>
Subject: Re: [PATCH v8 v8 02/11] dt-bindings: iio: adc: hx711: add VSUP supply property
To: Jonathan Cameron <jic23@kernel.org>
Cc: ak@it-klinger.de, andriy.shevchenko@linux.intel.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 5:38=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Tue, 12 May 2026 13:06:22 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > On Mon, 11 May 2026 23:13:27 +0530
> > Piyush Patle <piyushpatle228@gmail.com> wrote:
> >
> > > Document the optional VSUP supply used by the HX711 on-chip regulator=
.
> > >
> > > Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > ---
> >
> > I got curious given the driver doesn't yet turn this on and wanted
> > to just sanity check it via a datasheet.
> >
> > Why are we including this one but not dvdd-supply?  The suggested
> > wiring does connect them to the same supply but it's external to the
> > chip so in theory they might not be.  Curiously dvdd supply is allowed
> > to be 0.1 V lower than vsup-supply.
The HX711 does have a DVDD pin, but it is the output of the internal
LDO and is normally just bypassed to ground. VSUP is the rail supplied by
the board, so that was the one I documented here.
That said, dvdd-supply is already allowed for HX711 nodes by patch 04,
as only vref-supply is forbidden for HX711. So the binding does not block
a board from describing DVDD if needed.
The driver does not use DVDD for HX711 today, but explicit support can be
added later if there is a real user for it.
>
> I should have said, given there is nothing wrong with what you have here
> and the above is a possible additional change - applied to the testing
> branch of iio.git.
>
> Thanks,
>
> Jonathan
>
Thanks for applying patches 01-03.
> >
> > >  Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yam=
l b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> > > index 1ea60dff98d5..a8eaa1f18de5 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> > > @@ -33,6 +33,10 @@ properties:
> > >      description:
> > >        Analog supply voltage (AVDD).
> > >
> > > +  vsup-supply:
> > > +    description:
> > > +      Supply voltage for the on-chip regulator (VSUP).
> > > +
> > >    clock-frequency:
> > >      description:
> > >        Controls the SCK bit-bang timing. The value is used to derive =
the
> >
>
