Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFD5299A8F
	for <linux-iio@vger.kernel.org>; Sun,  8 Feb 2026 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770542585; cv=none; b=DmPJ2X1TG35r4m9VsudwNGkoAX5rmKr0FKIjvDINBGAbFT2llD2d79RTv7bdcVq7+IhwnhieeZYPfKiMuGheHrxFcYAn0hMn3wG5OrvlGKA1FrJPr8xo4G1j+XfrqM5t0nd9fHZMVLe1orUwajL8A7WMzYqHL697V2UkSJkb2Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770542585; c=relaxed/simple;
	bh=TE3PJHu2TEnqBSRz5l+14VoSIvMd0CJS7C2vhNBxg7I=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mroHkdky/01ddKVyQMf99X3osDgqCheE/Y6Wq+GXFWPaZS6JKoh53tiu1mvBPVp9k3Q+o5aKRSyQJfOCuWMx9UC8puOBRyGodGtXXRK4VY4EEhvyiKVDJrEARQ4IBlZzBO64kbNSVcKu9a2vkXriub3QnPsOi6pN0iDjU6yiV30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TY6AZ+At; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TY6AZ+At"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4362197d174so2019282f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 08 Feb 2026 01:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770542584; x=1771147384; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLptmtdkgDA/2Ft5zoqrhICOvhLVuzkpsfVXfo41zIc=;
        b=TY6AZ+Atnccs5VqPxAyNXZAz6EOUYqS6MZ15LR1fqIaYRjAJ7LQ6P1MNk+Z+gf26sW
         kpRoFvIR+PTHwL0IqmxXRNV3jqJ2FkWmXTtqZ0x837OagTK+7ZwND5EG4iEUiVTPkwUb
         KfEbZPm1JjOsPmYekGP5x1HUgQutcpunT+eQwZSQx580RnzV+19l7pWab8bbEAhyE2uy
         kpcWjTvAmwMRR9wKRUhxzX3fiw3s66m9s57YISOLiKa1BEeG0+0i7uUSy1A1yizcrQp/
         FQ0tmeQjQB1fI0ICDQtn4YyLWUC7JS/EQjURZqBmnljKPTTg51s74k/r25tnUUBZw3S3
         W+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770542584; x=1771147384;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eLptmtdkgDA/2Ft5zoqrhICOvhLVuzkpsfVXfo41zIc=;
        b=dp1ST7ulS2zkuj1xOk2QW8s7MYqT4UlMBMoiKhxZfGAA8b+Tm9UxQ5J7wVYrvMiss6
         Hj5S++15m4WB+ujZx+Pv5wqD6B+St2i7C8vVtkGN2y115Jbl2UcnsK0AjgI2bWY5zlU0
         hkOiTBJ46Zm8JqE26VUEsjGv9AgO/S6Enaim6DGyRnVG/CxDp7mNfcekJvzmcJPUtyau
         NLu3H2pURDlvlKA/4wa5jCu6DBTnlmrZGkSP51XX1cp1FrFhxoV7r6DPbPldCrv1enRX
         IJSESSXwFr/yRL8Q1+Ivgl/l8ZwT6JnouuU32ZAE/sxcBT/p1I9FsRnOP/5ubQ12Zovo
         tZ4A==
X-Forwarded-Encrypted: i=1; AJvYcCWwk/vZG/coa5KvDlJkcMot3dJ21ivH7vejiDROYgHR0N255tQE8FHpFLQeY9Vss6g9yhaH+kRKP80=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvVL241SmdeXM6Sz4R4wFnNsRM8T+zZypWf/QPXLon0nNX74hZ
	SNQNbrcKYavDmY+SKFYqDt3xHZU8/Ck4QysGRPyBy3J0LK/fopyEkS7N
X-Gm-Gg: AZuq6aKLNIFsB9tLffaHpREPHZXBFVrV5b9HhsA8Z57mzGvUIxiWz1iVgo8DgF4Ejzq
	dM7sotqF0wIN0DECIQ+JeoFDXb5Z2gnw4QqS7IT+6pTZnrcwgzqirElFH3aVH1SSRZL+3aX+V0m
	YzpmhOtwIF4drF6AB07sZ4q5ulZrJ6wk/k3dP5cxwk8McoSY3hwsdeUiVuBlISOhHqC9EyHFuvV
	8DNyIT/AM/FIRs6GKDOdMcV/eNIE4L1zV1NHro4pP/iLB5e9hlo6AwST7yaGxhk3KyRL0+AYj/h
	VxEeXbGkmZdZnXAknujIVas7qF2+W+AqQ2MNdYi1YafFB7U962RKlmXLDJC6Wq8FHCcN4hQMJ2w
	hNmbdVEDeaTeUBjUWrhKhOiLdeZ/PEJVwXRASLPhKf1Rl+ZSqBwhEpY57JqjKqREtQcaNJSuWfL
	/xyJySTM95re0DT3Er/WdG8xxQN2pacs70Aaq0x03H8MluRvtjfihLubiJGiM=
X-Received: by 2002:adf:f5d0:0:b0:436:3475:473e with SMTP id ffacd0b85a97d-43634754869mr4193507f8f.51.1770542583506;
        Sun, 08 Feb 2026 01:23:03 -0800 (PST)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362972fc26sm16557044f8f.22.2026.02.08.01.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 01:23:03 -0800 (PST)
Message-ID: <c731b6fba72286707821ea6e7722835ba45f089c.camel@gmail.com>
Subject: Re: [PATCH v2 2/4] iio: backend: add devm_iio_backend_get_by_index()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron	 <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring	 <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, Mark
 Brown	 <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Date: Sun, 08 Feb 2026 09:24:07 +0000
In-Reply-To: <550323d752213f177b7673bdd42e667f1d2228cb.1770393792.git.antoniu.miclaus@analog.com>
References: <cover.1770393792.git.antoniu.miclaus@analog.com>
	 <550323d752213f177b7673bdd42e667f1d2228cb.1770393792.git.antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-02-06 at 18:07 +0200, Antoniu Miclaus wrote:
> Add a new function to get an IIO backend by its index in the
> io-backends device tree property. This is useful for multi-channel
> devices that have multiple backends, where looking up by index is
> more straightforward than using named backends.
>=20
> The new function directly uses the index to find the backend reference
> in the io-backends property, avoiding the need for io-backend-names.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> =C2=A0drivers/iio/industrialio-backend.c | 51 +++++++++++++++++++++++++++=
+++
> =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 2 ++
> =C2=A02 files changed, 53 insertions(+)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-
> backend.c
> index 447b694d6d5f..3b692d48481e 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -1008,6 +1008,57 @@ struct iio_backend *devm_iio_backend_get(struct de=
vice *dev,
> const char *name)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get, "IIO_BACKEND");
> =C2=A0
> +static struct iio_backend *
> +__devm_iio_backend_fwnode_get_by_index(struct device *dev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct fwnode_handle *fwnode,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int index)
> +{
> +	struct fwnode_handle *fwnode_back;
> +	struct iio_backend *back;
> +	int ret;
> +
> +	fwnode_back =3D fwnode_find_reference(fwnode, "io-backends", index);
> +	if (IS_ERR(fwnode_back))
> +		return dev_err_cast_probe(dev, fwnode_back,
> +					=C2=A0 "Cannot get Firmware reference\n");
> +
> +	guard(mutex)(&iio_back_lock);
> +	list_for_each_entry(back, &iio_back_list, entry) {
> +		if (!device_match_fwnode(back->dev, fwnode_back))
> +			continue;
> +
> +		fwnode_handle_put(fwnode_back);
> +		ret =3D __devm_iio_backend_get(dev, back);
> +		if (ret)
> +			return ERR_PTR(ret);
> +
> +		back->idx =3D index;
> +
> +		return back;
> +	}
> +
> +	fwnode_handle_put(fwnode_back);
> +	return ERR_PTR(-EPROBE_DEFER);
> +}

I believe we don't necessarily need this. Why can't we use io-backend-names=
? I get
that in here we just want something matching the number of channels we have=
 so giving
names is probably does not add much added value. But still, I would prefer =
t have
more simplicity in the API and it should be fairly easy for the frontend to=
 use the
names argument.

_ Nuno S=C3=A1

