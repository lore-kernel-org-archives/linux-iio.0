Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4AF379C2F
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778668504; cv=none; b=k/ZTEGOmI308sHoI86hyJsE8OhyTvJL9FFPsTA1UFDwoxr/6bVfXD+YZfD9MDduBvzRGuMf4Hb1MY/V4VhQFITORl97XNf37LouZkEmFbsBe5/7GZke/4JCgj/3pzqCZNlVVikVbElh272A8bRVTPuguaCzNZzx9fjYFmGoG1Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778668504; c=relaxed/simple;
	bh=SQdfdarwGPx0jA+A4DoG/8WBcRVB8LB66qr65IayI+E=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tR9wAaOy2UxM+2/M2owZXnH4qqD/IiZg2+dvn8Xs6qh5LQ4Q+IGUlyQm9J1zSb8zNXR9yeFKYzAd18nmv+oE7pCtw3zKY4zP5ZJOVIv5466nmn6LDiNYzKJZKxQtHySh7ae5LCRCHQUxfpKwpJ705PfbfMWgkmLvY88Ymjts2Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+PB6msj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+PB6msj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778668503; x=1810204503;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SQdfdarwGPx0jA+A4DoG/8WBcRVB8LB66qr65IayI+E=;
  b=T+PB6msjIjPFdEQlnAalqpyZKMfdUITIpT0cLbpkNjsTUAxld+RDGyS3
   daH4pbZ/ZTkqzyxy6/ONxyZ5IQSWKyncnUtjHwbjsAXcjPWsylyhJ5sKQ
   LD2ue2sTfmejU+HXzy00hOmhWLnjGshxrpBO//apfv7rn23DghcbC3ivF
   LGSdR2AZH9MO70chwPl1uC+T54XDz/zEaY09O+vm3kLTOp9yuq4Fr83Cv
   LfYZ9PkZTl8DOHws6FNVAv+8A2KqUJ3EWaw04xb08WGv+PXBnQHXEqKzY
   6ivlFYAxUI7LhRCxxW2sSkrf9iZoZp/jwe9LTY/hlajkfPJhRnnMIvo2T
   Q==;
X-CSE-ConnectionGUID: sGg6Go5TQ+6a7dyfDBgj8w==
X-CSE-MsgGUID: pTCNUc0PRRyLrSfwCWUPyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="90692582"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="90692582"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 03:35:02 -0700
X-CSE-ConnectionGUID: PdyNgQkOR8KmcUEPsskTKg==
X-CSE-MsgGUID: MHXAGpbLROmLChc3a6DWIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="261546327"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.110])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 03:35:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 13 May 2026 13:34:57 +0300 (EEST)
To: Joao Paulo Menezes Linaris <jplinaris@usp.br>
cc: wbg@kernel.org, Guilherme Dias <guilhermeabreu200105@usp.br>, 
    linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] counter: intel-qep: Replace manual mutex logic with
 lock guards
In-Reply-To: <20260512173058.14858-1-jplinaris@usp.br>
Message-ID: <2d880cda-1baf-3b12-f79f-44b7eae74e77@linux.intel.com>
References: <20260512173058.14858-1-jplinaris@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-159391685-1778668497=:12534"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-159391685-1778668497=:12534
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 12 May 2026, Joao Paulo Menezes Linaris wrote:

> Use guard() for handling mutex lock instead of locking and unlocking
> mutex explicitly. This improves readability by eliminating the need for
> gotos and by clearly indicating mutex will be locked only when
> execution is in guard scope.
>=20
> Signed-off-by: Joao Paulo Menezes Linaris <jplinaris@usp.br>
> Co-developed-by: Guilherme Dias <guilhermeabreu200105@usp.br>
> Signed-off-by: Guilherme Dias <guilhermeabreu200105@usp.br>

Thanks.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
> v2 -> v3:
>  - add blank line between guard(mutex)() and other code
>=20
>  drivers/counter/intel-qep.c | 50 +++++++++++++------------------------
>  1 file changed, 18 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
> index c49c17805..9c6536f75 100644
> --- a/drivers/counter/intel-qep.c
> +++ b/drivers/counter/intel-qep.c
> @@ -188,25 +188,21 @@ static int intel_qep_ceiling_write(struct counter_d=
evice *counter,
>  =09=09=09=09   struct counter_count *count, u64 max)
>  {
>  =09struct intel_qep *qep =3D counter_priv(counter);
> -=09int ret =3D 0;
> =20
>  =09/* Intel QEP ceiling configuration only supports 32-bit values */
>  =09if (max !=3D (u32)max)
>  =09=09return -ERANGE;
> =20
> -=09mutex_lock(&qep->lock);
> -=09if (qep->enabled) {
> -=09=09ret =3D -EBUSY;
> -=09=09goto out;
> -=09}
> +=09guard(mutex)(&qep->lock);
> +
> +=09if (qep->enabled)
> +=09=09return -EBUSY;
> =20
>  =09pm_runtime_get_sync(qep->dev);
>  =09intel_qep_writel(qep, INTEL_QEPMAX, max);
>  =09pm_runtime_put(qep->dev);
> =20
> -out:
> -=09mutex_unlock(&qep->lock);
> -=09return ret;
> +=09return 0;
>  }
> =20
>  static int intel_qep_enable_read(struct counter_device *counter,
> @@ -226,10 +222,11 @@ static int intel_qep_enable_write(struct counter_de=
vice *counter,
>  =09u32 reg;
>  =09bool changed;
> =20
> -=09mutex_lock(&qep->lock);
> +=09guard(mutex)(&qep->lock);
> +
>  =09changed =3D val ^ qep->enabled;
>  =09if (!changed)
> -=09=09goto out;
> +=09=09return 0;
> =20
>  =09pm_runtime_get_sync(qep->dev);
>  =09reg =3D intel_qep_readl(qep, INTEL_QEPCON);
> @@ -246,8 +243,6 @@ static int intel_qep_enable_write(struct counter_devi=
ce *counter,
>  =09pm_runtime_put(qep->dev);
>  =09qep->enabled =3D val;
> =20
> -out:
> -=09mutex_unlock(&qep->lock);
>  =09return 0;
>  }
> =20
> @@ -279,7 +274,6 @@ static int intel_qep_spike_filter_ns_write(struct cou=
nter_device *counter,
>  =09struct intel_qep *qep =3D counter_priv(counter);
>  =09u32 reg;
>  =09bool enable;
> -=09int ret =3D 0;
> =20
>  =09/*
>  =09 * Spike filter length is (MAX_COUNT + 2) clock periods.
> @@ -300,11 +294,10 @@ static int intel_qep_spike_filter_ns_write(struct c=
ounter_device *counter,
>  =09if (length > INTEL_QEPFLT_MAX_COUNT(length))
>  =09=09return -ERANGE;
> =20
> -=09mutex_lock(&qep->lock);
> -=09if (qep->enabled) {
> -=09=09ret =3D -EBUSY;
> -=09=09goto out;
> -=09}
> +=09guard(mutex)(&qep->lock);
> +
> +=09if (qep->enabled)
> +=09=09return -EBUSY;
> =20
>  =09pm_runtime_get_sync(qep->dev);
>  =09reg =3D intel_qep_readl(qep, INTEL_QEPCON);
> @@ -316,9 +309,7 @@ static int intel_qep_spike_filter_ns_write(struct cou=
nter_device *counter,
>  =09intel_qep_writel(qep, INTEL_QEPCON, reg);
>  =09pm_runtime_put(qep->dev);
> =20
> -out:
> -=09mutex_unlock(&qep->lock);
> -=09return ret;
> +=09return 0;
>  }
> =20
>  static int intel_qep_preset_enable_read(struct counter_device *counter,
> @@ -342,13 +333,11 @@ static int intel_qep_preset_enable_write(struct cou=
nter_device *counter,
>  {
>  =09struct intel_qep *qep =3D counter_priv(counter);
>  =09u32 reg;
> -=09int ret =3D 0;
> =20
> -=09mutex_lock(&qep->lock);
> -=09if (qep->enabled) {
> -=09=09ret =3D -EBUSY;
> -=09=09goto out;
> -=09}
> +=09guard(mutex)(&qep->lock);
> +
> +=09if (qep->enabled)
> +=09=09return -EBUSY;
> =20
>  =09pm_runtime_get_sync(qep->dev);
>  =09reg =3D intel_qep_readl(qep, INTEL_QEPCON);
> @@ -360,10 +349,7 @@ static int intel_qep_preset_enable_write(struct coun=
ter_device *counter,
>  =09intel_qep_writel(qep, INTEL_QEPCON, reg);
>  =09pm_runtime_put(qep->dev);
> =20
> -out:
> -=09mutex_unlock(&qep->lock);
> -
> -=09return ret;
> +=09return 0;
>  }
> =20
>  static struct counter_comp intel_qep_count_ext[] =3D {
>=20

--8323328-159391685-1778668497=:12534--
