Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E7E3B38B7
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516595; cv=pass; b=KUAGZLajpsHgLPFZdziwwaao2aFkCm5rZTOhU8RGdXqkHSoK3w4NRItll5sfk87rn3XWbWNZcRGqcuQKqPfrxApiQSn/qIQ3qKkSw/ZGuv2SgR0iFrBvTNYdr/ciKRegOhaW3AH0m8RYxtmqm1m8UIJr2XwbG7YqrQaoJaRD5xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516595; c=relaxed/simple;
	bh=jKtfd7ltufCd8Kwzt8vVP2Wk3ili/vgHCvXxUlPxLTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0u0p4OI4omsKPerKexsgWQK7x27sFN4BbJeHefNcJ0ppat0/Awxvd/V3Hrceb3vuPFJgrp8EdTThpp4sy9Dw1a23CKNb6kRIAddmV83RsX+ixEKR1S4z1N9F73g/nn1/ktKYNCcNq5JAGtoUQodk1eTVQ2MWAT5uGZLZhmCGwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiKztB8M; arc=pass smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiKztB8M"
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-5a8dc2606a0so397623e87.2
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 09:23:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778516592; cv=none;
        d=google.com; s=arc-20240605;
        b=lNeCb+HwQEP4SEmCc0isOHOiY4jkKEEDa7PhOvZ/sc3kOG+PlSGrlEljQXE1bRlx+t
         LR/S32raaT5F6W+WRc/3nKPvObdtWbeXRJ6rYP6FGdqy80Ocn+4yC1ZMAZVJG5OsVGl7
         DKbeocswpVPBSVd0v3HArrCIVoVsZuO1wpDkJPeqjYDaD78DVdOs1Zr8paMV0k0iP31f
         jKzDxfF+4buxKKJxABQ5/SeCDvLwkGO1l2UCO/lM9Kj1hRbO6y9KTf36Jbp0o+SB0bBz
         b2tfPLkBkVf7NUr8onQJWIS5bGSfJ6MXm1hr9dMDyNKmSyacAwO42c4b0kjg8pi/AxaW
         SdIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jKtfd7ltufCd8Kwzt8vVP2Wk3ili/vgHCvXxUlPxLTM=;
        fh=mzUew8fERVfK64WAkBF5OTuwxBJq/0FFlvwWBngh5Z4=;
        b=jJ2V7IkK0Uvb96drOMcJQVJovpKM+jcY8eaHDlBL++boYscUIqM14OgGVEd0RU/qq8
         voEjCn0dTBZk5jJ8ZWokPdIHESsTOlOhm30XXNd7jP4zTFDwqe8/1VK/PVHbJM1S+8/x
         f9naVtb8ySS+flN6xyzGlYUamSg4rKzkoQzsSJJDXva3ls96uQkays62pRUSHkUG71Fl
         2sivxbYbGr0zewGmmiRCSlDgiOz0gWUIduXrVt55yRxCPZ0Lfcvlf2s5cCm8SqGgppHA
         KD+iBM9CK5SugsElIzLl8kXUtHlgSbpRBmjWInXfr0s/VSbJPhgaqKSl2Bb3vtIa5whL
         /+IA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778516592; x=1779121392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKtfd7ltufCd8Kwzt8vVP2Wk3ili/vgHCvXxUlPxLTM=;
        b=RiKztB8MYN7d4+ajKnLbrzyIS3KQiMFT2cYHEiktr75ZE9WxDwWUtkxKvWplKBFkZT
         RwaQPlXmWcPYOWLiFHb7O+QSd+dM3+mWzn47cDqKBvPWNpLqP09rRd+zlIEp+yHAHgvW
         FVXaIjka5+HqspLI0qM/VgHZxHALvOB4we+eefc3D0SsRAFCTX+ElDtEtYkQJXfAn/eo
         CGkaU6B5af+aTqMfbw7vbSYruq7UyKXfC+OeyPSk5GuGxt+KH2OtPPLL9wdoxU9YGpmG
         0kInyO1FnEAoZfhUHDoaZhiFJZX68l9s3KpITYaUDgTGYKMErStmYIZT3Rjdy4bCx5o8
         t0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778516592; x=1779121392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jKtfd7ltufCd8Kwzt8vVP2Wk3ili/vgHCvXxUlPxLTM=;
        b=aoVvsvIbp7aUl3Ay+mru3OXL4jtIVTSxis7wjUyEP74Dezdm+dyVmZdznAvE5stdTo
         ZUwytSNM9f9Q/u88Lqb6VRhofqElaXFy3f2El+LNX2kWCf6gnDVUCGlN2B/DcOLfRgYt
         193RH/eWIpH3FtE4CUBDisTEg0UpxXlpXNXgTnB7vrQNM+XGeoBfw4szu/cDAlS/0Gz8
         iSXFKFzuDgTI9vHdA2xYFOTv8PYQM8HRQtg97b1CUeObSbDg89+f8snWX4l9tEDfJOxf
         zc8G2r5xuT2vTzCqhZLrDgyKAKxpN8SFjjR6sL1O1PpGJ5Aymip5lsxVc2Y5IM+Nl7AT
         XrRg==
X-Forwarded-Encrypted: i=1; AFNElJ9WDSx6Th2w2vJoiQx9eG54TONvQ5im9TASNi1GyIpqpWJlnJURr4Yb3KQ9YszauK2IStG1N8t/QFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuQ0sb8+MrBQqeseizPZpc1af1tjRVDGV8a8WHtb/LqeZ1Tiai
	CmFJGjLJUqOmtW0IqFibRU1vicIvSHXHDA7SPtOZ7KzI4w7JfX5nO0p8XeZV2xmlw7LvxBRiR7N
	ARInKpcW9frgliZR3ApWs8nU1Sxh0Zbo=
X-Gm-Gg: Acq92OEG5bfHGV6N1XanEK9zu1TI48mrUMbUeueKq2VG9FW2uxJNSnJ2wS9M5VUbdw9
	B29g9Txv4eYk4/+OdL/G1ygxzJojijPJpobaQt+pPkcXzHs48ivW/ffXgR3PoVflgf3l+pv+Hif
	srEew11/+2x8zfo7zReLYb2bYkhzIDKc0m81vSlLD2jaOekGbbTqBR+dhLyJOfqbjvOTOMBWiah
	jPHy8n/0z9TVJ9erODYKxs/Yy5UxYg5HRVCrqpn+DolqBtTSb7snN7xvG/IY/M6DTMlzhkd3VYj
	gmTw8LZNgNdH4dBzkJwiVSpaikedncH16uPUVqeTyV9FithuPr37
X-Received: by 2002:a05:6512:3b84:b0:5a4:11e:5c7e with SMTP id
 2adb3069b0e04-5a8b6c9d5c7mr2666988e87.5.1778516592291; Mon, 11 May 2026
 09:23:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509022718.82957-1-dennylin0707@gmail.com>
 <20260509022718.82957-2-dennylin0707@gmail.com> <f6e2a4de-4c1d-46ef-b383-db62091fd0f4@baylibre.com>
 <CAGEkeHfeZWi99TMvkXHhMSrUS8PshuekqjszBXaS39VsLUZ4eA@mail.gmail.com> <3493d6ef-5f02-4eb1-b81a-89597045acbb@baylibre.com>
In-Reply-To: <3493d6ef-5f02-4eb1-b81a-89597045acbb@baylibre.com>
From: Denny Lin <dennylin0707@gmail.com>
Date: Mon, 11 May 2026 09:23:00 -0700
X-Gm-Features: AVHnY4If-1z7wpsY5leg3b5K7tW-GzwRZV047ZkiArkvnziT1qHja6pu8cjzndE
Message-ID: <CAGEkeHcA+aJ_h5APbL_bG3vpyY+rSGEVn=Dk1Abe76MKDdyVpg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] dt-bindings: iio: adc: add AD7816/AD7817/AD7818 binding
To: David Lechner <dlechner@baylibre.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 7:51=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> Usually, we want to be moving the drivers out of staging when
> adding the DT bindings so that it all gets reviewed for correctness
> at the same time.
>
> Drivers in staging are usually there because they are doing things
> that are not actually acceptable for the final stable mainline
> version of a driver and need more work.
>

Thanks for the explanation.

I took a look at the driver and noticed it still uses the older
IIO sysfs-based interface rather than the iio_chan_spec + read_raw
model.

Would you recommend updating the driver first, or is it okay to
proceed with the binding separately?

Thanks,
Hungyu
