Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1968472559
	for <linux-iio@vger.kernel.org>; Mon,  7 Sep 2026 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788794478; cv=none; b=j9YJaJfLbhxTRJLs49EDc9r0xQoQO2cw5+gSBKY8x5BfmPpnt6/P2aXXxRdMnQs6yumBV2k6+fMTNt0njGQ0ZSLrIVPj4hsxAa6BV50Gww2Bs2LTt7z2OQIKQ8cLvpafqMUwQJFXEb1tkfHjmu9r3uMh0NEBiTkuNc3OwFJWpIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788794478; c=relaxed/simple;
	bh=Je540+x0RLBrjADL4XgLC8DmzHI3N9G0dzH+bqi3T4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qt2KLvOBKv9FMCB7naTRYl2RU3jyDikhlkRLA1t/T2SwIWbB4zGWVy/x4IwEEVNnkVQKE4j4WNAwazQaNjPt4b6cDLjpS/uWkO8eBtYXCky4zThEZog4mGVHrDMegtFNcPzcZX1KUjfedCNNdyKOApgNSPMW7FIbY//oUUz93r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TW5UwvgY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TW5UwvgY"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49a97714f5dso35373195e9.0
        for <linux-iio@vger.kernel.org>; Mon, 07 Sep 2026 08:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788794475; x=1789399275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Je540+x0RLBrjADL4XgLC8DmzHI3N9G0dzH+bqi3T4k=;
        b=TW5UwvgYd+Z348/MHCluzx9vWPmvDNgx4x6AbxBsWhekm1fWz+2pAJi3B5LfRIX9t+
         9WwnWxIJpefDD8b3o+1R53IMplrjBCjlr2g3R7A79yHUbMnPusTe9z2VSfvHctolgAJK
         JcC0G4SEskUIBG/HRBwXnjpssbMtKxmXM94vT/Lg9cDLglCP4ItN5KE6GMsRMzm8pJ95
         2grcrZVMKTS0ck6kI8XaI5fHAQILxZlwbAfR/FEhzlkCCHEVT9kFB88zL0Aab2RQZS0M
         +R43XbWo15LUv8/EeQdtg013BBYKPNGv4ecYMy4kR7knTXqDOboWG4DQJy7kqAX+Ymbe
         x8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788794475; x=1789399275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Je540+x0RLBrjADL4XgLC8DmzHI3N9G0dzH+bqi3T4k=;
        b=TYiz+qxr6OKgityS4wnNmk491/5o/0dmx42l/3gVZnzC4bZkkZEY8CaB53sqr5RQ4O
         9exJ7UxtTRxoiVMFBlQnlqKS3lueKwndzbD/3l5KBxLTYTecdxRfPZuOESJ3L0UrTv8d
         l6MmfkPq5JN1Dekj8RBanwrnjegM74xKl4Ifmx7/PtptywVp6iSfnaJJvhYpMuGYCr0a
         VUTCOqiRIl7+8GO7CxRgnddVDTVG6yqN2HagxuFKNeut8QDTrnexmwQ+AbQ3dPxpwOcV
         wOG+L8o+/LW+CMm/fZLjbtBdXPsH5vRaFlZKfvrbhws9/smNe61Q1i4EvYZXx2ipmqA2
         ObEw==
X-Forwarded-Encrypted: i=1; AKwUvByXcHNBNLqkSWqNX/ijgL8yKCE0d43PyaMXC4KHbZv+F2C5BUoiUq1JYKQWwm1OpXfGfhY8fCHWi+w=@vger.kernel.org
X-Gm-Message-State: AFuF++kGA+fYibLtYZtnRWNe8K92acpBNM6obdvpc42Xg7gvWj5FLKYT
	ozDxMhgC/kuyRg7pqBN+GjTbiJTfpASQshX9b6fBNq/EcYClAauJQAb+
X-Gm-Gg: AYBFou2+7CwqavH0ADzV001nUw5peQCm9b5viykJ2Qrb+ZWq3njsItLmuYFFK0rmCez
	Xzx5GpV10bZtjOAmGOvDiRAQXznx2tYT4DCxb9dCqST48dl+MlghXwhPvxFFwecxtUIngxiTfTU
	xtYtDTIDIu1irvRgwxAyKr7o64AN5Lvlrav1swUKokRumOtBNgwPZE6XpBNVHWHh+wtY27nSrci
	C1Dt9tzOzYJtzGSFF1R0J55pdcDGDL4VPVFVPJNa3OsMyEOyNKNW0A88MI/pN1dxJoATnDRwQzN
	TbTDedNHoRoRNpL1zVeFnvs6fpgJCFzNciF55o6ifHSqz2iXWE8GrGZnY9BhS0JzTNG++fEj1XM
	niQgoOtK0MsI5TD6R73cxVWPICaKlcjmUEhPeQw0NTb+GkFDCjxX+hVNykRMyRxcm0PqcS2JpSw
	M4oJGeVULbv6VES3XGOyo4stAOy9ye13QADhMOXsqmks2Tn13CJQA1vzSxAkbqxkbBL3Pay8DJ8
	KmVFjPOtQBzu4i/vUUV0HklwDiDgghtP4iGBms3cQ==
X-Received: by 2002:a05:600c:3f08:b0:49c:fa20:cc04 with SMTP id 5b1f17b1804b1-49cfa20cd10mr195270575e9.27.1788794474776;
        Mon, 07 Sep 2026 08:21:14 -0700 (PDT)
Received: from flaviu-Aspire-E5-572G.. ([93.122.248.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7740d44sm695732295e9.15.2026.09.07.08.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:21:14 -0700 (PDT)
From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Flaviu Nistor <flaviu.nistor@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads1015: Add support for label
Date: Mon,  7 Sep 2026 18:21:10 +0300
Message-ID: <20260907152110.4934-1-flaviu.nistor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905030114.21de1faf@jic23-huawei>
References: <20260905030114.21de1faf@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 5:01 AM, Jonathan Cameron wrote:=0D
>On Thu, 3 Sep 2026 22:03:55 +0300=0D
>Andy Shevchenko <andriy.shevchenko@intel.com> wrote:=0D
>=0D
>> On Thu, Sep 03, 2026 at 06:16:27PM +0300, Flaviu Nistor wrote:=0D
>> > On Thu, Sep 3, 2026 at 9:18 AM, Andy Shevchenko wrote: =3D20=0D
>>=3D20=0D
>> ...=0D
>>=3D20=0D
>> > Since the iio core exposes in sysfs the in_volatagex_label=0D
>> > for all channels, there are 3 situations: =3D20=0D
>>=3D20=0D
>> > 3. The channel is not defined in the dts (in_voltagex_label is still v=
i=3D=0D
sible=0D
>> > in the sysfs), and reading the label will cause "(null)\n" to be print=
e=3D=0D
>d in=0D
>> > the console (as indicated also by Sashiko boot), since the default "" =
v=3D=0D
>alue=0D
>> > is not assigned during device_for_each_child_node_scoped(). I think th=
i=3D=0D
>s is=0D
>> > not an issue since is just the way sysfs_emit() handles an NULL string=
.=3D=0D
> =3D20=0D
>>=3D20=0D
>> Is this current state of affairs?=0D
>>=3D20=0D
>> If so, the patch must not change that =3DE2=3D80=3D94 it's an ABI now an=
d (null=3D=0D
>) is valid=0D
>> response from the user space point of view.=0D
>>=3D20=0D
>> > What would you prefer? Any further suggestions? =3D20=0D
>>=3D20=0D
>Unfortunately we never defined what should happen this way explicitly.=0D
>In practice assumption is that this is a corner case we probably won't=0D
>see. People don't tend to want to label just one random pin, they tend=0D
>to label the lot. =3D20=0D
>=0D
>So go with whatever is most common in other drivers,=0D
>=0D
=0D
Hello, I took some time and went through all of the drivers that use read_l=
abel()=0D
to get the most common solution. Most of the drivers only use datasheet_nam=
e and only=0D
a few actually get the label (if present) from the device tree during probe=
.=0D
I now have the best solution (from my point of view), which covers all (3) =
cases. If=0D
the label string is present in the device tree it will be use and printed i=
n the console=0D
in user space. If label not present or channel is not defined at all in the=
 dts, the=0D
datasheet_name will be used similar to most drivers. I will send a v3.=0D
=0D
PS: many thanks for everybody for pushing for a better solution.=0D
=0D
Best regards,=0D
Flaviu=0D
=0D
>Jonathan=
