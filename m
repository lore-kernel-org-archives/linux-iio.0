Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A75033D514
	for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771583299; cv=pass; b=uC16MPB5Pu76KoNeI8HRONO4+WySvKqi+a5ef8a4nRo/otH9ANtH04lBp6yHkJ2aw2LPUX7u0PD4v8gqTl+NcXmO5ueyxZKunKhL18z6HqsQJOyVPbKMKH7u3SduHekFfLtLobzEVejlOm5AHteuYWam9zs+/z9KPpaHW8klthM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771583299; c=relaxed/simple;
	bh=EplM+7sFhsvuKsPfPpiL/OxUlsGV0yqnBDxUuFZMRvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hWjzjnz+PjIdW4eUc/Q9VFbp6sjXYRyx9SP+ONxf9Cx3fcIGVAADFhKrtA/zbeMAvlMBXPJsGB1dEj5vHwgEnFEks4BzhJnehzhTTRrlHdO/tKTs7ckxOHAunTuPHYm7qqZ2scMoVdNCUJv/FiiEjy0Ue1gJH7y8Xnv8JRXv37Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDUeggKU; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDUeggKU"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so326253666b.2
        for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 02:28:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771583296; cv=none;
        d=google.com; s=arc-20240605;
        b=g8ZMIgJmkzxJ3u2SLggbOODXzaZQyFHny+bL2LPuRmrOgcchizitNYQ+tx3WbCZMQH
         bBQ1fl4VThhlOdafnzd8iOAJpIQSjCKR//wKa4oc4T9/QFgi2OnUTZEZE65wTot+ew4T
         reHbcgco3MxeSIqdwWC8dY2Ekt8sdQ9GYXSfaejzvuuSZeHWGrUmeljIJBa09yNQb30Z
         PHiDGqILfw6SlLoRxeqAFXKqFzY2xF3FAd2Oe0Xo1WPUwfDGExy/tz0TTSEIQt9bcKDF
         KnEI1gI+CxlAW5enyOsNy0Ge2SdKBjgixTrVm7t/SLbJWYc1KlW9x+YtJ78Egbl1LhFG
         IjgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ro3+0onc8I4LEKSnZ3IBiigAIMu+U6c5mpjDOE/R+Gw=;
        fh=QnxIArxo2S+CnKBgFyTULZfxQszRu+TPP1CzrYM+PQs=;
        b=A6ESMhP5XQ1BN+VM11TJCUEnsZc8tJnirtgQpRqMk+8wRAbCiUJ70VbPwwAx1GAnQc
         t5pJ0Mar29OMIBDNFovbxlMls9ViVOHuOqEgo+hSxp831CgfqOa4iiTFRXxzmVR6rvtX
         /MOKikT6O2gODwHZHLUsqFj4ZY0N33W9U6g2RgM6dm/V5tF26KU60anmJF6tSdwzM0Uc
         RTwL25ToNjAbiCIoUQWzulDjTSw7Xcii1bo0fE2u3JIV+cwejGh9EGqw935aPH8Ww3ha
         IfIbMQ85ABlHosAnW4JmffuoNXyEb6rhfztd7fVhu7phdHH4tykDvPfAqA5rDp/0JZnw
         Dtmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771583296; x=1772188096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ro3+0onc8I4LEKSnZ3IBiigAIMu+U6c5mpjDOE/R+Gw=;
        b=kDUeggKUqAza2/gPU75AeV9ux1C57rP/qwW/NyGw59YprB3nsmDXy49AAiM/sfoLzq
         dV9CWnoMJazwaxjHJiacrlTeJf8fUhjSJ5QZAW8V7MTdw+Q1ZVShnRrA7M7HfrPG3c5x
         alzBStQylxeAbSS6whLpquxZCYBiX2nYNB8nk2bWpFIox7CUFYwAld6/SDPHNG8OtreK
         mRvhU2rgimEZp41fidRmndnwnOczpFDTMO0K6HcFWto1ZZCcIrbXljhHOl9gIn1lYL2X
         Opw9Shgu7jj9cMuwRn/ylV09hK4reS3Ogji5V7GIdf823JpHs4sBIyVCV7uFVuVcGeVC
         KezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771583296; x=1772188096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ro3+0onc8I4LEKSnZ3IBiigAIMu+U6c5mpjDOE/R+Gw=;
        b=IQCiZHO3WmXGAxVaMArz1h5uNtrKSMLrSr6sWKK2ujoUAqZ+o/KhopfIP3S7E/Pit7
         B5f7dp7R2BZ0LxxXUwUp3YVN2PsCJMUiTxOWQ6rjtQgmf7GQpFyVLTOh74Ln//By/Mz2
         bkcpXRWchqSmBKQ7OoEclYYzLEmLC9EHyCl2ON4U9kyMpIncSXY6/y1077+G+2scZoVk
         J9tL/Uz1TzE8CuFESM0u+Aiqi7tAULQCvFzXTqgvaP0Rmt2mnN7qG4X5oDB8HWHAjniJ
         AZvkFi51ePAz3Vw/CaRDQ+8WhPgO0Kb3gFEA+7UyoUxIFLxAc3v3xU14GVGHO92/ETl8
         4jtA==
X-Forwarded-Encrypted: i=1; AJvYcCUDZclebnxQHUH1Qxy31iXLMvh8eeeFf9Dyd24A7JOUBNepdMtGKUuj7br664Rub7zGDzuVk0E2mD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYG2r3QqDDzyOxXgak9wsl3YnK9PeWBSkOGxX0xJ6XACbtqQ9B
	iEIr02kdXF9W8Fhp3CKUR1TpS06InHFzPY7bMKP2YubvVHguW4JFCuxeg9H1TRNBcTIx5iih+AH
	i3wvEq+Sa0If3FTuZm7ZGy0PRpnrF7S4=
X-Gm-Gg: AZuq6aKbQKH47faxpZZWCLVPVLoPq1cVUD7pW6XaS9RNlkT1/knKo9VzIYHkhMkG1Lb
	dhxeIkhW7tUtjmA/iq/06Cm9AHTT1VpKo7Yqs/FjzUguG5v5o63YbarDa9FsYBtjfNeEogM4k/t
	KRwTUdY7XyI7J6qU23jaWcSSALdfSHjtXd1CvZx3tA4K8PpW5tWgfv/ZpXCu+pqlX4LldOOV6v+
	YzYBC4uzrdZ/E+otSW4Odd/k1Il1RIUIKchohX91ADQoGsxHpRgByDt3cc5BQyQXHfv27aXqloG
	TyaNImfizuYAxORIetLAvfzN5GiprRE4ByKRT2UyH2m05ifpe790jatRmADRsvoz8VApWG/cLhH
	1gvYIDO0=
X-Received: by 2002:a17:907:869e:b0:b87:6b9c:6386 with SMTP id
 a640c23a62f3a-b903dcca0d9mr568706266b.56.1771583296172; Fri, 20 Feb 2026
 02:28:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216081412.1118599-1-andriy.shevchenko@linux.intel.com> <20260220101844.17f3bc63@jic23-huawei>
In-Reply-To: <20260220101844.17f3bc63@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 20 Feb 2026 12:27:40 +0200
X-Gm-Features: AaiRm53FtVxdi0QiNxGZR1xvaKedwisHlmnL84hGzQY_NRmx-_vJkuD-09g0qs8
Message-ID: <CAHp75VdQufe2ANMm=FWvnGAfpe4Y-U_oocs-ax+tY39=z81g4A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] iio: core: Simplify IIO core managed APIs
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 12:18=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> On Mon, 16 Feb 2026 09:14:12 +0100
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> This had me briefly confused as I failed to notice it was static
> (no idea why I gave such a simple internal function kernel-doc!)
>
> However that brings the obvious follow up question.  Given your
> simplification does having a helper make sense given only a single caller=
?
>
> Let's just squash it and have the two calls inline + some resulting docs
> updates to get rid of the references to this function.

Do you want to have this change inside the proposed patch? Or in a
separate (pre/post) one?

--=20
With Best Regards,
Andy Shevchenko
