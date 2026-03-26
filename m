Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982843F7A95
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527895; cv=none; b=H8ANuGaBqZtK08BOkhq27yFSWpzInupxo4G0YOz0fx4d3dInQQ7VE+Zh2Ymf/i9tOGZS3Vm+BkvksxIFs5Z3yi0q+Vxmj9noHMa9BBWgGSLg/XEqXDLWuwBkstuiYW9Sg51vs5mLkXoXLPuOhXuVheHefILXW2y6gQzsh/t5SLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527895; c=relaxed/simple;
	bh=mRH8dsJYsEf6aldFwfdTs6JkiAnPmrdYZd1nLYrfFck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oBm/Av7/BgbKwHM2kwtBRxkXovUyCmn68lYYmqwmFzWMEfV97dtgXehc4bBPKN+LwZTBPHDj1kn+IIV2sse//XN3pr51WbUqHClebxUjgczHrCFZ6vvN5977zGMbFkRYk8B3Khg/nkRs/G4+fd/hPbnYJt77QBOQyAqE5CziC3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79ac5de41d8so8756817b3.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 05:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774527893; x=1775132693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mRH8dsJYsEf6aldFwfdTs6JkiAnPmrdYZd1nLYrfFck=;
        b=TbaTCQ4AVuio7C+MFP0HxjbIb1QzESrlSOcIE19pg8Q+br4+851Cf4oPiFn7Xf9Dg+
         uTBG7H1q5D8JpoaQNuG6pfiMgvCnE5/Zuap1BoqiW034w2cu8SKKUYrVns8pUzZtO2Lm
         oJd03V1yc9ouv9vBXo19wBjLbTGNoCzPOkYK23+/ZnmmZ2fs2ycOZ08SBxSmLYWik4HN
         MlYf2krf2Y4oPqZunJ6l6dUMlJzpvbBGK2n0z4RrcJBVOt6zI56QL6I8IILgzAbusncO
         RgjMW1oJtlcJripMe8qWbwOVSc2EFt4Iand7hLlMTFnYFhGOEIFwLhaDWKVcPIsqreoy
         ghxQ==
X-Gm-Message-State: AOJu0YyYz/4rLrQIBIKlxdk7E2Vk38p8UOQBBNMUb0wUglkYtr02VrOx
	7zRCDlt0GUFc7BJDh6l9uTveoI5e8YJNftqzzRWWqi+bsytLhwAbTvEaW0/7JnCN
X-Gm-Gg: ATEYQzwnHNs4Sq+x4A6DQbnnnmyR9rZhDnY8GdX8mZh/VED+m8rOEaPdaGpiU/Ko1N8
	5YROs+ppuFPGJLsFKgHLCypi4s4YfCkLvt2V9XMBJaRLhG2eCluAwxPMi66K44RsSIGNksEmdt9
	TnBLyrWQIUwJQRJZiRcxWv2PWFqRAC7pb/+kh8gicepH7unynu3JfH2qTrrjZeR1dMYYnNR316L
	cOLeu7ADPIt5VQCRTigQDxGQD2zgBb9h3UpamWdI2R2ih84nOIRtQOt/nJ15d7VG8a1Yuy91GwS
	5WHqhc/EbVEiS71FebvwdGOM+Nha9aXIS8qnOK2UVitVAXNUfrb7yOfelFo5FNWWqIBr9qxpm1H
	MSihtJVTXZtEGgU1NPDv2EJVw8hMof9NP+WrDYJ8S5beeIL9oqnWEnjSwnc87Tw/MPUDvh2sQwq
	kI2wYwiwKB/vdtYZx8ZPW/AU0nGVh6x0yQTCj4NY9YScub12nzT7IRtIx1qJUInMyGI7DJkxAGZ
	b4y+NgfnOtrSG7t8Nvm28x6l8Ts34DI9dl5xH3gEQ==
X-Received: by 2002:a05:690c:6283:b0:79a:b824:ccbb with SMTP id 00721157ae682-79acf6b3d88mr72736997b3.42.1774527893361;
        Thu, 26 Mar 2026 05:24:53 -0700 (PDT)
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com. [74.125.224.44])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79b1e3f0877sm12065627b3.34.2026.03.26.05.24.52
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 05:24:52 -0700 (PDT)
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64d5a7926cfso944314d50.2
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 05:24:52 -0700 (PDT)
X-Received: by 2002:a05:690e:1c0c:b0:64f:c830:1e47 with SMTP id
 956f58d0204a3-64fc830804fmr1809469d50.21.1774527892188; Thu, 26 Mar 2026
 05:24:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325202005.29822-1-email@sirat.me> <20260326082447.5e447606@jic23-huawei>
In-Reply-To: <20260326082447.5e447606@jic23-huawei>
From: Sirat <email@sirat.me>
Date: Thu, 26 Mar 2026 18:24:41 +0600
X-Gmail-Original-Message-ID: <CANn+LW+zqf-VwAw8Ci+ZkTO95ktASyUBjg=O8NAGjMc-g39H7g@mail.gmail.com>
X-Gm-Features: AQROBzAgQAUJ_PyzObb5sGIYSy3eHoXce_8tfyN_aOmeiG4bEBi1gQYt7vl5eCo
Message-ID: <CANn+LW+zqf-VwAw8Ci+ZkTO95ktASyUBjg=O8NAGjMc-g39H7g@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] iio: proximity: add driver for ST VL53L1X ToF sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 2:25=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Thu, 26 Mar 2026 02:19:40 +0600
> Siratul Islam <email@sirat.me> wrote:
>
...
> Applied to the testing branch of iio.git.
>
> Thanks,
>
> J

Thanks for applying the patch. Thanks to you and all the reviewers.
The code it ended up becoming is much superior to what I initially
had.

Best regards
Sirat
