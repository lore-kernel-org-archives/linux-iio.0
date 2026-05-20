Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEF73C661A
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779277354; cv=pass; b=mfOkWt8KZs6ZuOQkVv2HB29KgmFvRxtkEEO1HKsECndJqDhiFKAZK3VEwQS2NXOQF/K0iXmvxd940QVHKYUVlDfeB4uLRMODV1sSEe6ZLKyPPTHp8h7JjaBmkj1xpxmgP/Ja8T2L1tX4XLD6yGoOhuLHK5smzHYuKU3Rez0Ay3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779277354; c=relaxed/simple;
	bh=Pn58G6B6srU9x/l70tU0AeYbvxSf8sqlQAHRn4ijBj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5SeK1oB5Y59dkwIKxKLdWJtwdquhGplH5LsQ8NDnVNXFHkWnvENSx8LnzBh0MeeBAUkt5dDDxaTU89P+4yWEhELgzgzvkQdimFn2vqwXeCMX4Tqrl2/ZZ0HQ5XMVr12/ekEWX00CQXI8Sd+zJMhlv7hnhLb3i2e+IB0eKTUGIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnFeymiz; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnFeymiz"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-441209fb77eso2951469f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 04:42:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779277351; cv=none;
        d=google.com; s=arc-20240605;
        b=MlnsCy7eUSq4Zj9yiIxbZkWWq/xWT4VcFQHaDe/tgLXkayYucRFhMGVz8l4+GmDfmu
         J5UgMmDfDgz/C1xPCX2tXCWaH9omBzpuXALCKs06c6mlAcWvlONJJtIo+yelS0++vxCk
         r/h0GCgohkS49hctZFNySKb/rdTEhBGtk8xx1iU8QhZ11f1cuwK5/A3uy5IXeJukEm2f
         WdzS3vG08xqTooRSUkHTcGiJ7wun4KQ9T2f6eaVEIRizaQEO+ykVW883iOSejP7dT5RQ
         9IeW4P2cMETOwl1pvlQJYUHhf2ri7OXczcr+du4IVxmtCCqS/bBLp0UIm7ZRMqnOIf+X
         QvuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tvby5vcIc0d7JYF/tLQ0qqSxaYmfxcE7JARtxN849bI=;
        fh=JeuVm5B2fLFzUSEsZRjoiJ5rB8C6oE6MeHCxmNSjOzY=;
        b=hznBcr19odisMWKMyr6aChMq69EL5LvyOOzZJERAelx8HQFoeMt+sHd+4ZoXfBTAIt
         9AYjqb/YkBFR4OzrnT1romo/IPVj+vWgC5HaLLsEpEt3YfqXnofseHHEmcUAi8fcrxdl
         WsZ9qIXrEQPWL0n5/xxR2F4ygR4uzL2MqHILtCt1N/kJh7b+ubVsSt2c1kJi5yw+0R+W
         qgTr2pFghHKnV2fxl20LH9bKzDVK3jomXl+8Sw/dDyvNr1FZyaZ3jM00wBKrS0vUDfzO
         Paz/mN5ICrUpEBp8nkJjEv1jSnTarMcNwRKMEbM2mVV+nOiMYpnlddTxlBEg41WqmQva
         //gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779277351; x=1779882151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvby5vcIc0d7JYF/tLQ0qqSxaYmfxcE7JARtxN849bI=;
        b=hnFeymiztYYt2iaucl2i0wWCeXuyV0oHjRhTYaAILMRo2fhm35E8JkBiVt4dI0z90N
         iupyhP6LL6r57gaiomay+aPwlO2H7cRXmAON1o7tqYfgD5BN/JDurOpcyrw0Mi+hwD7c
         LrlWzb8CzQV64UPvc2/CJudJsrdmkQEEbUzpwbeL4RspLpIvAKdD0uIoc978pzgj0y7a
         t36fDNweOB9stlrxrHddHcxUDfRCbOHA4fJYyx75TrlXPXHDPRzFP89URJ4QnIgliJmI
         ZpgS/HzGUt2MZFr3yF0HlpYBqZYP2siTCfxmJsJvYy7vOhMrnQHU8vI/RsLIP9CCFpCK
         w8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779277351; x=1779882151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tvby5vcIc0d7JYF/tLQ0qqSxaYmfxcE7JARtxN849bI=;
        b=KcZe45Cu5kjZVHZjohklU9OuXSyO/mso4TkXOumAqWuleg0ijJSyoAVHkMOtonlsOI
         zha3i3NA8kDuh5P28c/rPNPXCuaUeCyqT/hPn8VfdpEXjNQHL5jIvQC8QlEWeQeB1MsO
         Qn2+W0r2KoeYVN7gt0Yb7RIIaSVlstWzUPsadeAk9IBwUyr0vo1v3GZKhcwCEjwwQ/n1
         7bbhIdbMRI4s9N/nyfHiNRBBszHgpiXOO9GrYQL7IisVv4b71ScEqGyT+WGeEETFOWFd
         p4Jk1gibCv/zmXvej+WWtbxYJfJjG8Wo/Iqh72qMVEEfBc00YWrfBUuS0+SibSoAdjiG
         VQ5g==
X-Forwarded-Encrypted: i=1; AFNElJ+Pm2J0X3SyYYm27ZDaEf8QW2Et9MfdBfeQTJGx/aclwh/ib/3JL5z6BmQI4JDpO0G1oT3sXBA3ACU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr0qhGWLkSERRgV7FL1a4diWhKDQ99h8886ysu14PfpgH6j8bd
	6zIixQv/87NDttyu59Iri0+caRGzZqyPWqdk2JnHTaek3mxx56hD6qI+GBroCxXJLeO1P7ZbBxq
	ZdviW1zXE2Ez99r0HUp+aIHn7dUapYpo=
X-Gm-Gg: Acq92OHHWGzwQahzhiUGWyqZoIGV6PvmcXhOeylSsADx5ZZT9hoSFiQMXKrXSoM075B
	KEbT/FahpZB8R6iMbOqMP6kKK/66kuJMmsZLUt7s7j0e6SIlP9NNPZJuYPgRHSQcIOC6hi7yy6c
	0cE3cSiavKeY74Pfy4SkAzEgoa/V8rNxN/uqTxGB5HKluNOOn7CiKl+8jYJCtrCAaVAhfrTjsgV
	lyUiUHwqsMjGr+32yosIi4KYvJx9vIw5+a7oZoraK2y7Fo06D7NrDijchozap6/AS2q/Z5t4zzy
	d8PdPm6L7kyjdXpZQxFTFnWRey27yIOmohKMBB7vKrtD9rNRrs8f3Z4j8LxUBS5okDXBrasLSkF
	GaVaeiUibvyf+/dHQMPIWjyUY+up9TSOW+5nNF6NijSJVIl1+9RdcVFZ/xp+hBteK2aORTJGHJw
	dFqZK8T/Anl6au+HNt
X-Received: by 2002:a05:6000:2283:b0:45e:6a3e:1ddb with SMTP id
 ffacd0b85a97d-45e6a3e1e0bmr28194289f8f.1.1779277350543; Wed, 20 May 2026
 04:42:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520111813.3934-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20260520111813.3934-1-ilpo.jarvinen@linux.intel.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 20 May 2026 13:42:18 +0200
X-Gm-Features: AVHnY4KEGOKhvk3Hb1Ln7prlR14Nvmy4Se09kZ-X-cWXAhtqIKADV8xHe-Uux_w
Message-ID: <CALoEA-wrYjbkhM7EiS+f-JjXShpRJw+gqy2zzymq9Ue5t-XN5A@mail.gmail.com>
Subject: Re: [PATCH 1/1] counter: intel-qep: Use devm_mutex_init()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: William Breathitt Gray <wbg@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Raymond Tan <raymond.tan@intel.com>, "Felipe Balbi (Intel)" <balbi@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 20 May 2026 at 13:25, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> intel_qep_probe() calls mutex_init() but lacks the pairing
> mutex_destroy() calls. Convert to devm_mutex_init() which handles
> cleanup automatically.
>
> Fixes: b711f687a1c1 ("counter: Add support for Intel Quadrature Encoder P=
eripheral")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/counter/intel-qep.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
> index c49c178056f4..816586893517 100644
> --- a/drivers/counter/intel-qep.c
> +++ b/drivers/counter/intel-qep.c
> @@ -414,7 +414,9 @@ static int intel_qep_probe(struct pci_dev *pci, const=
 struct pci_device_id *id)
>
>         qep->dev =3D dev;
>         qep->regs =3D regs;
> -       mutex_init(&qep->lock);
> +       ret =3D devm_mutex_init(dev, &qep->lock);
> +       if (ret)
> +               return ret;

Unless you're compiling with CONFIG_DEBUG_MUTEXES, mutex_destroy() is a
nop, so a solo mutex_init() call is okay. Nevertheless the devm_
counterpart makes
debugging easier.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

--=20
Kind regards

CJD
