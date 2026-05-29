Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B6E3A2549
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053433; cv=pass; b=XmFKMxhUzjw6s5Hx7D0IoddTQ9/hAp1W94b5CKIWSGhEH3eCx7ZtKg+CQWaCg/jFO3GcPnIw7ZSLSogGmuf+r/nhWEqGkTI59qzTqf+U+lk9/zSK/C5URs9NcrZZsuK0JooKW+KNIemJbramZaZ269xR8+o4oxdKsjCXzZSpLvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053433; c=relaxed/simple;
	bh=L3mfJ8b8ZEM+xhFAaS2hUBo/4NjpVXYO+a9psiGQoGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbavyIu5JmhcH29UJMW0ZNyDQGzjjnkcSWO1niGRI6irwcEm3i0Oml/+PmYkdZfynPO84ufFdARe4Z30Xz8B0628jw+0HcBMp0Mb3+RnEdY5vNwzJPyb8HQ7BEw8PjlCZXW5+DfvQFtpNlQTwu3uUVDga1WrGdmb66Lvc4P1SXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTj3gXwy; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTj3gXwy"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-304545f5206so10569585eec.0
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 04:17:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780053432; cv=none;
        d=google.com; s=arc-20240605;
        b=gAhjyfC6d6rCAdj/+gXh1pJyaHFvMH2FyATVm/YHTTPGSdHkEP8zg9pRIXtwV60dlP
         ZiGOYDD7NpOzLGIlWvxxAG+SJ266aa8t357wuMplriJNL2/5TUSYtSPmfX2JljhM16jC
         qT1TzVU4wwCtMO70jZmO6j3PDrVGPquztVC60YN3i9Bb3ea+ls4Lq7su8WSWR//ZMVKB
         DDr8/AyVEdq2v8eYuHvzBNY4OVQaeW5rvUSMLDkyKvTWMR6Y19TJUnfMvPWGkfOwhWdg
         /2JOmAw0H94BNT0OrqL67iEdrpP6aP/zijHi8fMD+eI6Q4hSKADj67mz4oYz6bBoh5/6
         1GyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L3mfJ8b8ZEM+xhFAaS2hUBo/4NjpVXYO+a9psiGQoGo=;
        fh=GNMKpZtkIJWInA5JWxa4WytT3noDEtn5qCNQ/mKontM=;
        b=HbEifyaVQZu1WLe1CdbXDl9mkfHyEkugRPsc62LfWfFIv1JeKL5jib34wnsrU/5wwB
         ynZllzgK/azor1i1NGPi1mbpAj9Z8ZFpak7bKA6O7yNZAre4/maVl6aO3zxxgxZmqjR0
         2e3S9F+TY6p/giZK1Gy7sCV51Xu25WbkI1bdpEywQg4Z955TESRxJV7LpSARvAMQkzTs
         HWPNB53LIG/3j/a/5rJslbOFV6mfST1Y2HBMuX0E7WNuo81A4wGI4bKWlM83ruRwfujK
         GqLR61TfyCJvI05g3DY6sY/2IrBKYEEprUFeKUI7G3fBVo08itFhQZifCWxvLIHU0zl7
         BI7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780053432; x=1780658232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3mfJ8b8ZEM+xhFAaS2hUBo/4NjpVXYO+a9psiGQoGo=;
        b=PTj3gXwyVBSTT/HcISlafISe3FMEQr96CaFFu7eOrHtXClvmFwtyfUXLrFPNq1Szs6
         4T15J8oeFmFgejfH0lV54qCPetLHJQco/9DSz2wKZeY3zWQLp7j7LRP67beQVIPGJceu
         rG8UMKA9CCPlFr0DB9YF55wJ5Nx/+YlPajyUV0WSHWT1qWWgAKUooDL9Slj53w1On9wT
         VLffTQKVJ89xrmmM2OYjqsPw1oTC8IEJ3zZqey9ZMHlc5g0zBM2LePCuR5PhGP7UCFST
         GnBjdQKM4Pmo+Lb7UzoiwsoxZ2KFkdlhkdxA573e8QmV6ZuKevBQg9BMJNbKYRy9QFf/
         QrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780053432; x=1780658232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L3mfJ8b8ZEM+xhFAaS2hUBo/4NjpVXYO+a9psiGQoGo=;
        b=r1jTGVJ8bhPXtf+zUG7Vcbc5Hi9GZ0JSdjDEwEw5sGsMZCqlBRBMAiGowltaPN6JxF
         edqziOTUhhZXTB+WBdptGwe9eZWambCCaU4jeAIaN7joAeayErr3VC2m1yvYylcyQdUV
         h8Po3xmx5beE20sauFeT8I+usX0xw+m7JRahqH0rnnbxEEsKx/hyuIMts1Vy60mKhR/H
         xtwXPFHM2V9qKCgU38yrbScWIBVVSHS7RCsoOiPvY3m6xlL+lno9FNQ8i1Gi/GQVvwSV
         wmEcF+ItCeKLltN21run6aPacKJybIdld1rszEBDi776w00XFpGlKG5+9HvO15sAK/+R
         DKbQ==
X-Forwarded-Encrypted: i=1; AFNElJ9jdgrmj/rE8PBi8WmUU22QlDGoI8JzAgoUoAmreiFwlUnKhjIqNv0VPbzXHAI+czAesPvCdrfYTKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvmdgk17YTpK6/VzgeogF3WTm/a+mIhVHe3eIgCvbvtUGM3JW1
	6P6IUu3HjO1gDPd6Gesp09wpFCZKdBfhWC6UbhUd2r77DP9ttbuz4lrVJTbu2VJF69XiUl6N1kX
	Ys+HPOr4YbmnoVARmlUZGlp0TjYX4olc=
X-Gm-Gg: Acq92OGBwWkJVWIu59MpMWPJQ3zitR5ru11BN+/8ptkObHQHBNNRGkYHunDV0cBk6lY
	X76f0fBD6F4RGNnx8LtCDY83sEmqDhix1ujciWcN3DqWp2xJVLlrilF8EUTfZVOXItzkdncvAxK
	SII+TsU7bPLHHvlQbmEWiW97KeztHacJsP98/XDLhbqN8wSsws3MZmtce4bopS8vkepiD7pjVhL
	xr82e+i3CX7+wkbSDsIrD171+3KiNYXwS2v6OyaYavrxG36Y6o8QTJTSQrIWqtBgqqK0t+Glo/P
	4kwwC2YTXZYIh+kvKAg=
X-Received: by 2002:a05:7300:ac81:b0:2ea:c085:44b1 with SMTP id
 5a478bee46e88-304eb17ec82mr985940eec.19.1780053431705; Fri, 29 May 2026
 04:17:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528135123.103745-1-clamor95@gmail.com> <20260528135123.103745-6-clamor95@gmail.com>
 <ahl0La8OQHXAlV3m@aspen.lan>
In-Reply-To: <ahl0La8OQHXAlV3m@aspen.lan>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 29 May 2026 14:17:00 +0300
X-Gm-Features: AVHnY4LHdqQWkZI96KeyzyHPIcreHN1kHpCMC5cCziI3ntwRYA4WURCN1WE3agw
Message-ID: <CAPVz0n0kpYBACOo=YyNk31KGwBEoyrf+dii8V6QY4iRCGd2PNQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] video: backlight: lm3533_bl: Set initial mapping
 mode from DT
To: Daniel Thompson <daniel@riscstar.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 29 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 14:1=
0 Daniel Thompson <daniel@riscstar.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, May 28, 2026 at 04:51:22PM +0300, Svyatoslav Ryhel wrote:
> > Add support to obtain the initial mapping mode from DT instead of leavi=
ng
> > it unconfigured. Additionally, update the linear sysfs code, which uses=
 a
> > similar coding pattern.
>
> Words like "additionally" in a patch description can be a sign the patch
> should actually be two patches. In this case the patch would be a lot
> easier to read if you cleaned up the linear sysfs code (patch N) and then
> added the new DT logic (patch N+1).
>

I looked into this in reverse. My goal was to add DT logic I don't
case how sysfs works. My code matched with what sysfs does I just
included sysfs change as well. I might better drop sysfs changes
entirely since with such pace this patchset will inflate from 6 to 15
and beyond.

>
> Daniel.
