Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69343E1236
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 16:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773248048; cv=none; b=rkkPY/dEu9AH5BYcXTxFRWQ5j88Oiq1og2zd0bit/3QImuCyevf7z8sTYkEwYdKkFHgI/VDgQyQiA/nkj3qG/xoR3MaKxI69mnn8jhD7GzvxvXZSX/FKQvutDBSYusy2y+lkJYQ+nf1ucHMsHm7i7Asg4u5Jo01j7dHre38KfO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773248048; c=relaxed/simple;
	bh=Z9OZZB3CYTeVUj4B/NjeZZJLS8yiWmY8Bzo9StWySzU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=plRpB3dVp1p7toK77WfF07IzegtH3whTYxxFDn6rJn/Vp8x8pcwGGN5OM5FhGqxwuksPA8sD18/AbmKqeknIYNJ0XQJ3FNMAWD5hUge3va5Xo0uyF2acLIAJUbw5zlTqIZQh59LQlzo0Se6P0+0qxmJ5y2jAz2gnxdlwxOyEQyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jz0hG8wV; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz0hG8wV"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b943a880577so148366b.3
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 09:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773248045; x=1773852845; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4OLoZWNfLX2Hv2p8BwoMWD6UD6t/Qu6fX1zjeJKXrT8=;
        b=Jz0hG8wVy8JSzI9ok0Uo0uZpWOu0D5g3LFvwtTTAtR8zxuULBgdtxeABNvWd+36Qhf
         gkBCzhFErLvc2io+0ACD5llrWTPsebWUL/molKJo5ajtJhKaM54GtcKP3XRKVYuWG6DQ
         yh2qlLH1uV/Lu0g5XztWrkkBpPXENESTcixtWXizlXcz3WlJupsLOLk91GdRuY//dBOj
         HtcA7mDXD8CgJpGwx/IptaspMLkRGANInDgN9rWJM0aHr22Bcc7GumYKakOBmIiycXut
         KsY86RGPfVEl3NL14i+tV9JxIkjmVGrAa2czxS68w2xvxKsgbIauCJuR1dDkQpPMiZFK
         d2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773248045; x=1773852845;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4OLoZWNfLX2Hv2p8BwoMWD6UD6t/Qu6fX1zjeJKXrT8=;
        b=JLzHw5mgOVCodiFvzNcmT4qPKVI/ggltyAM1nAIdDpWgRPD0mZOLm42isH8hMNFm8t
         Lg1jiIKGvzRzECQBftK6BDVpdgEWQPSOqFZdsdqi6359FBbkRmGsD15W9whWlTH9y+ja
         MaLUQBUMWV5OUZjE6vAn0jD2+95cB4m9266nfOBB//Zu4QRF9V8R+fYrt2xsl/Vq7uvr
         iokBTeiIF4/4sAP3f2j5h3yarFDnHxMuqlgCrUppn/yBkICCoLdebYVKukkgFGDRX4N4
         NWF93G5RSpmfa9bKOB20Z6VgAyH09xoQbRZMdRHrABjdBT445wDHgI7oaNLyuuRo3jfY
         gjAw==
X-Forwarded-Encrypted: i=1; AJvYcCXuE0HgdLti1O1EI1sof6AHXew3Gx+FaTli6Q8gpY9M/Ke0FkWaILqsd+k2+YcA2t4H2IMLJV8VhJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEXTidJnB9kqKhoEttct9ZNxn3Jm7JAaR7bYDLYi9gqV23ot3n
	RejAG0/iOjEsKhawrKmJy1EYyJb0QOBIo6AGbhzlCGxqj1f/7JuoZcdH
X-Gm-Gg: ATEYQzwQ0H3QAOOBm1ELUPxBwdg29fYIupms5CpIJ9BomtUEY23rSTI1f78+hsalNmS
	veadkCajevn6ebR0ztADyhYPlsbGphGFmJ9kflJi4nMWI5EZoFwuucIp20NIW6uScxPFUemtYfT
	XNSLPGZri1YyZoqBnJG4hxpnMnS3jP+La8gTrvxR1LsTGms5taJ/pn4ucPaB5J8zAdxT33jRBQb
	PbXLrR/AV8EalM/ANUCaLCW1u6Lsbj/r9O9j3NAgEhoVnoeQ84FaUfXJfZG1rREcl61IqKzixc1
	10gFnO2/fpzP9vGIpHSWmKq1nlzRIUT7EN5IETI0u0MDsKEL5CLfggh+X8W0gWhcov0yKkmzmg6
	W05+uQjKCVnxivb5+8GDtFnSq/geeI2izsLLJYzml6F/VcQt1qd6emmeVxkmIZ2Gd1Of3p9hEky
	Lvi9G2DAjkVBdHEuKRVPHYLQ==
X-Received: by 2002:a17:907:f815:b0:b94:3836:1672 with SMTP id a640c23a62f3a-b972e2c23acmr195615166b.37.1773248044571;
        Wed, 11 Mar 2026 09:54:04 -0700 (PDT)
Received: from [10.5.0.2] ([185.128.9.22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66350890006sm39973a12.20.2026.03.11.09.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 09:54:04 -0700 (PDT)
Message-ID: <3a967f38a43933f12c98a9dfe4f1e85fa592b41b.camel@gmail.com>
Subject: Re: [PATCH RFC 6/8] iio: frequency: ad9910: add RAM mode support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, David Lechner
	 <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, Rodrigo
 Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen	 <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Date: Wed, 11 Mar 2026 16:54:48 +0000
In-Reply-To: <frn4iotwpzef7ca5yosmwllxrottjlu2rpgpbdogrydsujebf3@lwamhpkzxn65>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
	 <20260220-ad9910-iio-driver-v1-6-3b264aa48a10@analog.com>
	 <20260301133153.7f2f8501@jic23-huawei>
	 <20260307140735.5ec2e608@jic23-huawei>
	 <bxcybwaz3am7nrrfcjuvkbbe7yp4vwcxwwh4dafaj5dsy622s7@m4vdam6tyaht>
	 <b1187027-3ddd-43bc-a773-8b5d794e04fc@baylibre.com>
	 <frn4iotwpzef7ca5yosmwllxrottjlu2rpgpbdogrydsujebf3@lwamhpkzxn65>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-11 at 13:11 +0000, Rodrigo Alencar wrote:
> On 26/03/10 07:11PM, David Lechner wrote:
> > On 3/10/26 12:40 PM, Rodrigo Alencar wrote:
> > > On 26/03/07 02:07PM, Jonathan Cameron wrote:
> > > > On Sun, 1 Mar 2026 13:31:53 +0000
> > > > Jonathan Cameron <jic23@kernel.org> wrote:
> > > >=20
> > > > > On Fri, 20 Feb 2026 16:46:10 +0000
> > > > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@=
kernel.org> wrote:
> > > > >=20
> > > > > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > > > >=20
> > > > > > Add RAM channel with support for profile-based control. This in=
cludes:
> > > > > > - RAM data loading via binary sysfs attribute (ram_data);=C2=A0=
=20
> > > > >=20
> > > > > I'm not sure that's a long term viable path.=C2=A0 We either need
> > > > > to figure out how to do it as firmware file load, or via an outpu=
t buffer.
> > > > >=20
> > > > > Firmware load would probably be too static and I'm not sure quite
> > > > > how we map these to IIO output buffers.
> > > >=20
> > > > We would have to carry it for ever which is very much not ideal.
> > > > The firmware approach has the same issue, but can be thought of
> > > > as defaults at boot time forever.=C2=A0 If no defaults then we use =
whatever
> > > > we come up with as the long term solution.
> > >=20
> > > I was thinking about the firmware approach:
> > > - Normally a driver would request the firmware during probe and the
> > > =C2=A0 filename would be pre-defined.
> > > - Less statically, It could have an attribute that once written, it w=
ould
> > > =C2=A0 request the RAM contents (e.g. under /lib/firmware/ad9910_ram.=
bin).
> > > =C2=A0 It could be the enable attribute itself (but that would not be=
 effective
> > > =C2=A0 when the binary would not change), or a separate one (e.g. des=
tination),
> > > =C2=A0 or a new one (e.g. load_en)
> >=20
> > Have you looked at firmware_upload_register()? It looks like it provide=
s
> > something along these lines.
>=20
> Thanks! this is in fact perfect!
> It might be ugly, but for the sake of debugging I managed to get libiio t=
o
> interface with this by exposing it in the debugfs.
>=20
> 	debugfs_create_symlink("ram_loading",
> 			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_get_debugfs_dentry(indio_dev)=
,
> 			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "/sys/class/firmware/ad9910-ram/l=
oading");
> 	debugfs_create_symlink("ram_data",
> 			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_get_debugfs_dentry(indio_dev)=
,
> 			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "/sys/class/firmware/ad9910-ram/d=
ata");

Or for the sake of future proving, maybe let's make the sysfs a bit more ge=
neric. At least the path,

/sys/class/firmware/dev_name(iio_dev)/*

I guess userspace tools could work with the above to match the fw blob with=
 the right device. Also,
hardcoding the name as it seems you have done will be a problem if we have =
multiple devices, no?

Not sure about the above though :)

- Nuno S=C3=A1


