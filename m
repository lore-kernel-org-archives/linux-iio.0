Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FE33AB291
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161849; cv=pass; b=ExcDf8ZS6D5iMqrMaPnjc/FJA2QeuMUaompj8GMJpGS1afWlVIfo/jRnfzZvoxFbAHQ5truZ92p/kpMkBjwM+2sXD7QYklZ1Cz74OJ+mf+L8tCRaoo/PanMVK2qzs3vMSlcE/kGa4SaQ9nWtimAzXAmw2QULRbOWcZx2+cy+Z4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161849; c=relaxed/simple;
	bh=UkBSBLxIZCuuB74htmYnx5hF1++Wk1amY553OBJB/1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eMVUuMlT5tUzGspSV/nbtj6FKM1C95Q9fBd0jVyeh+TbQCX7OIgyOnSazbqJgu+hnnyV0oiSVG8oqpY02GpZ0uhVRbNY0UOBrNqGBkkPjwo6nN+iUaJSfHKDNGX5jEXs1Kxw+du0bJj9LG1/njPWVZVcC3ruCA/rlrxIadyj5JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhPyY83D; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhPyY83D"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ef372c58aso898455f8f.0
        for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 10:24:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780161844; cv=none;
        d=google.com; s=arc-20240605;
        b=Z5UdnZIGtBxxvzyqljl4HLYgGS4DsHoFoAItfd1adTDBOl6h57i6raGPKwfU5ww2VS
         QhUsLPGODPtdJRAVqopcI9bjYfREbLUPLYEAgq7LbWcP/eaAqTl50H4DzZwsYyR7zlIG
         qqfg0eHhknc//FwkuoBrYGeWrLO8rmcEfnqgj/b6elZlXuMTAdzNMkqCzzUky1WtUMWL
         I+CPYY14SEFb+n1vulNUdQZDxWLPUdbL8jrnPgisyuijxkHR7FBWVUUMG/hcf/TKgNQa
         zbk5YfPfhW5ucXS7a90PiThEfDFRhCorHqvjfaksX6yOeRACHsTf8f2Gz3fVHoPHQBfe
         edpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AQlzPqtSzjfFVqBmEZsclhV7SR7e0gsG8goezRczdv8=;
        fh=NR2SGnG65Qn6nHF6gxMZg3OBbR3khbKHNdBz9SzNMt8=;
        b=Gfy+LuVMzCcUQEpSBO2/nNwhsKGSsNZGQkOygRtJMA+zUKzJp3IICGYuCzGXZPOk6A
         DFFqJ/awEPZCip4QHYqrNI4yW+oITbEh7A0kff6MalVs+tpICse/DFJ9cD/Xi/hLpnoh
         MRvWH9sCEKSP5in8z0M2XCnCJDlCTZB+wYZR4tszdL98ohTlcnS5aLjLWoSsRCDz8Ssw
         TCBKNuT+xjMMa4EmJy2+6EA8Wd4FE/ng1zKkA7e5uqS9lZ0gLAy3Xkzn4yvseiO+68yy
         46lM3X/0wseoOD2fgcpB7+4a5Bpg/l1ChemTVBbn4UQERb/yK+cPGD5E+eLvpOnXBWBQ
         /JNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780161844; x=1780766644; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AQlzPqtSzjfFVqBmEZsclhV7SR7e0gsG8goezRczdv8=;
        b=mhPyY83DGCwhOqJd43QnHEk0xaBYXPNaN66oZVS0F2zBsJkwdzpr6ibWpjoOnp+CN2
         Ta7sIVqN44tSysTX8mO9w/MdKtjPAa6wk2oy3724RSb6jAG7vHdVNBuzCdj+iALLC+3B
         Y4Gd+tTgQ+ovwT1/WbIHM8zi8GMnCk4S4lyIHKy751iBn32RSDC0t6JUy/bPY8wjXvj9
         gQpGRbvMZ3uinxBx9ZkkFAMoBSV79qT5YIzRaWRHXuFzhnMcw4VGS83wTD0KgR1niUfl
         BF2uOMIGyPFVjzuIzEDYMu5UpwgcnIDbweomL+hV6jMoZ0WU1nJ62C7eeHf0Yax5M31q
         fC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780161844; x=1780766644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQlzPqtSzjfFVqBmEZsclhV7SR7e0gsG8goezRczdv8=;
        b=XUgNHTL6NF++N+p2x6cIsV6xfY5ah1lwkPR6KMSBtrsqUvfULPgP0SV1G68Xj8wxX1
         HSno0yI4dq5CC6E+ocb8Vh44z2ZRWXT3dokIlBcTjcDOR74i/4+5p8afoE8kceNqzYJz
         aXN4WqGEwnRKB3TM6n+XCy00IyeWDSumAqhYvAsprryuuNvSAIu8f6Jgao3Ffz5X0ghB
         KKoiYiPwEp03KojsRplb+XPX5KX4usqpNREBuCBWjv5oqSTVCFxpzNb5YIKXonNrKBB1
         /Vz29/zU4O/bAcAYBXhRYClAC8HhreQOblpoyMnorcFWqmnmyFmzdyZV+2hvU57g3+EM
         9L3Q==
X-Gm-Message-State: AOJu0YyqKek8GqLtE6HBzEcAPFg06Cb7Yrrjv01dXQt3hG0GcnQV61oz
	7wKOAkNp3UJy/aWY8bwEDIgvhBy+FGb/1yHsHK42kUZ+xiuaFsV3IAGvgMW2KfAHMK6tjpiR1te
	fNDcQEuO1m2NhmLgQNJH0AJalH6JKY/g=
X-Gm-Gg: Acq92OG85NC6TJNVe6UwQdKVFDt9nDwFR6fsnIzLSOuhq6yhkRVPbDhuIBYIUZGmKk6
	XkqEr8C3fCv6Do4qsIVilhVC2TzFeLFlRFPIsGqxJnbYy81jOlI399IK/E1NVY842hKKIBW6hU6
	AFGLky1f8MDtcGdmkXNGk9ICgr8/LbPFfozyCzu5toso5AsPqe+Amg6yRAGRKMC4UvQ2C8ReAm5
	HAKI8w/UIc2Ffm+C8UfOhGVJAAFSyQGtJb0tWCNE8uwe9QxMemjG/xR+/lb14cfNK6xa+RjTuak
	7kB/ilsE23H1HihLLPBzKGWxtazQTYWG7lIUohkbP65Yj8Fv821464/0LgmY5rjpVbuW1u6yCpr
	n1xiOLrB/r1B5Jzb+SKhFIrD7ZtXcNPxVnPh49epOyxoTlswY6L2SFlR/k4EF7xGmFAw1Ex/Pw2
	kzzTpJu+ovH+AucyhzTaCtg2VFYgzXj53rRwGh4hfvr4lPLEZcSg==
X-Received: by 2002:a05:6000:e88:b0:45e:7c19:a328 with SMTP id
 ffacd0b85a97d-45ef6b71568mr6258240f8f.28.1780161844477; Sat, 30 May 2026
 10:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530-veml3328-v3-0-dd562eaee8d9@gmail.com> <20260530-veml3328-v3-2-dd562eaee8d9@gmail.com>
In-Reply-To: <20260530-veml3328-v3-2-dd562eaee8d9@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 30 May 2026 19:23:53 +0200
X-Gm-Features: AVHnY4J9riritd-tavTskEndG6BWKdCZhIsEHM46Emg64TDdMke5aGxbGUNB_uY
Message-ID: <CALoEA-x5h==eL_YmbZ-WV-N=ZokPRF2pC7+p2Z87KOxDAFzu4Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: light: veml3328: add support for new device
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 May 2026 at 19:07, Joshua Crofts <joshua.crofts1@gmail.com> wrote:
>
> Add support for the Vishay VEML3328 RGB/IR light sensor communicating
> via I2C (SMBus compatible).
>
> Also add a new entry for said driver into Kconfig and Makefile.
>
> Assisted-by: Gemini:3.1-Pro
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---

Sashiko had a few remarks, two are bogus IMO, but it does mention
that the device isn't put to sleep after probing...

https://sashiko.dev/#/patchset/20260530-veml3328-v3-0-dd562eaee8d9%40gmail.com

-- 
Kind regards

CJD
