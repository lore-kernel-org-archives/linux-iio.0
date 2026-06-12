Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529E236F917
	for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781273792; cv=none; b=WoDccA1FOD3RxEdRmD7IQeNXtEuao+5AjMre9rGvBkOj39LnEkwA4PaUaFMo7m74wTneky4cQgddiVI7URdAbrzTj72pmEhEmEozRaFxm0Os1QYoG2pQCAm7jEWOnF6ppKVcIaNf2OWj3ZfSdlo8eVHauaB8UW9Zbu6My1n4f3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781273792; c=relaxed/simple;
	bh=3fGK3MuEMlOcBmW9XxMN5UOMxwFay0WRS+u/9IMQ16U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SrEjd33mq/9Yv3QQckg7/rs1mOJEcaxewnx+9tABZA4z0WKVtChErmC/bM1reTJlHKT4g3m0RjIWfVKU3uUQ3oQbynjHJ5pNrwpsnhkyqRUm4ViyAYB1slDGPzdAxnH7wFwEm+Yp2Zrq9ofcjzDfE2av4Kq51FDJolRhqo6XVgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRxEDs3d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRxEDs3d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19881F00AC4
	for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 14:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781273789;
	bh=zzHvGw4t1ALo5R4403eulHWBiG5vQMAyxhw+Kh/g0Tc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aRxEDs3dz9wpawy0H/gTDRSGiCyhK9eK7C3WEC8II0uj8zWpVKrp5ErvkPYRMm4Fe
	 NLKP7Lq9Cnn6MQ5LtaWQlK3+f4OdfMN59jA0VjXGaUADOGPVAuyV7foIZONzIRkt9N
	 /V4pnI+n6WB4rtQ31JzvcYcZAk2CAa2TmNWjyoWa9CIxkGUuE0BPj0C46u+swBNlcX
	 mXMqd1BX4Zys6e190ggRL20sbgZsifEgObhtes1YaYOK4Hf3vsCyqFzmDjWtH84A87
	 C2SJJrM7LW8fG+TeHDlQR7vKNhpzGwTBQhy8hhTLx3XgKB8Lxb+lENDU2BHV5s3ZIf
	 +geBNGicEa4ig==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e6d2f297f4so647230a34.2
        for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 07:16:29 -0700 (PDT)
X-Gm-Message-State: AOJu0YzZ4d3HB7GmW3zSooDvpV+J4+0xyLvFhAIcixa1hbMHl0GrPYMy
	CWbzGD0pHeSt9mleYQfBC6lO+mtPXxAaxqd3CDPGcwsVRTMoIR9Jdv1wCU7Lz2G33JOQqXwtEOy
	PeCXfJi600a1Q/z0RtZG7HtUXlvs3di8=
X-Received: by 2002:a05:6830:6d49:b0:7e6:e385:4c1e with SMTP id
 46e09a7af769-7e7846f019cmr1818964a34.4.1781273789209; Fri, 12 Jun 2026
 07:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611154105.3727-1-shofiqtest@gmail.com> <20260611154105.3727-4-shofiqtest@gmail.com>
In-Reply-To: <20260611154105.3727-4-shofiqtest@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 12 Jun 2026 16:16:15 +0200
X-Gmail-Original-Message-ID: <CAD++jLngjw7WrrAmKW-VTkQzjM_TfK3hg46qbcs6=DW7bgt3qg@mail.gmail.com>
X-Gm-Features: AVVi8CckmRBftUowDa4_GiG5wg5tFvbvCbslw1rfEAbTZ_KMxVac5yjOhpwxxDA
Message-ID: <CAD++jLngjw7WrrAmKW-VTkQzjM_TfK3hg46qbcs6=DW7bgt3qg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: accel: convert lis302 binding to
 YAML schema (v2)
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shofiqul,

thanks for your patch! And thanks for working with the ST MEMS sensors!

On Thu, Jun 11, 2026 at 5:41=E2=80=AFPM Md Shofiqul Islam <shofiqtest@gmail=
.com> wrote:

> Replace the plain text lis302.txt with a YAML schema for the
> LIS302DL/LIS3LV02D accelerometer family.
(...)
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>

Please use my new email address:
Linus Walleij <linusw@kernel.org>

I don't mind being listed as maintainer, ideally I think someone at ST
should pick this up but I have good relationship with them so this
is fine unless someone signs up for the job.

Yours,
Linus Walleij
