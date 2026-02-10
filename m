Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0707830CD80
	for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770741333; cv=pass; b=k5Ur/zVBgdYfOax5xplORsPOlqLXJli1PpR53im56HqJkUTb/iDXNw6exWlst+R81hWKtD7eE80pYBIdqD4KeUP/hv79xAMXI5WBqt8KeqgU/dqiVE0Fw3hSnaYgp/oaoerz7v6/YvqsciVp0MIBrn45tgdOlAgXv02D6PXbr8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770741333; c=relaxed/simple;
	bh=nftrP5MGKrTCUa/drFb7KU6KxLAMWtnD4mrPPUEZ3mY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQ7XopCNbk31qOBqUT9GpqTvI7ej5tbcIqLzdHR4EvrrKmMhtpwVejymJTYmxCcLWgIDMGxmUD5UyQp7QgndSbIbALieG8nOHDMs+GTxEgPOYioJLlnsqz26wANvnK+i1+cH8odE7aCU+gO5wnAsysBcudxvv51T4YU/w2h2DLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j97Ix8aU; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j97Ix8aU"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-895498f3819so7135596d6.3
        for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 08:35:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770741331; cv=none;
        d=google.com; s=arc-20240605;
        b=QJOaCir4iLfuc1EPpvcAzzoe93kXOOpgbB09ADDR9CaKoIAmQ0pmd9qYk2ziRKZ9Wh
         cnV1m89/3h8U2dzDARP1JMCXQ10ZlDtP2kSoUSUfVoC0UUGszJ4+3pxt8tZOJskfIXrR
         QynvbLz4ig4V2C8K7UWv2mnnpYZm486kxDdh1TwS9iNwke3V2yr5FSrClUAyLAwnd2BR
         8N35/lh6sPvbNpNmpkTG7IcHdmDwjZIYAZHBHBVSe5xh2h9QH4swWgEYGi2GYqB49xy1
         vnjb349xPgxUxEl1JfuaSXmx6EzES1cl+b5lC2QYD8pvIA+OZPGb4g9zoqOOT/MCDTOf
         mkyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nftrP5MGKrTCUa/drFb7KU6KxLAMWtnD4mrPPUEZ3mY=;
        fh=fqEBZhsl138CPQQ0a4ImrFVujhcK+pVlsXjqDQoME5U=;
        b=Poz1hajCZZj7a/Tgdfu1i2NQ6B0dgGHkljQn6YovVDt5hswKu1I1l10518qhLcUSKK
         CtU/EjsK524LnHhA9O5zjFsal5NtNhix2djYak3PL8BFQYirzAhJsI5PM3eLQfq2KXN5
         S6nB9EcOObGfN3bDD+6/LyfiFXR+mNwwoLXai8Ko+NAbPQ94zB1gq+QWjUxpCJCwmiBj
         7OQOJeZDWqOVJsJkfZ3DOp4rrc99l1viOPfSledXjM8MkVH7INTG4cAk7v8is1Xz3BcB
         96hjroLp9aDyyWLxGvQmuF2YvON+ns2HIFVMqXZ+QmegvZQzGQaMenp2VPGrelG/Aqs6
         WGvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770741331; x=1771346131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nftrP5MGKrTCUa/drFb7KU6KxLAMWtnD4mrPPUEZ3mY=;
        b=j97Ix8aUs2J6Pw0QoxRuAKkQF3Gh3jvANXVn2QAtUXrmD3KfhPYhBuhjgIZeU5+ZG2
         Nwol8eqD7E6LWZgdcsyU9+79q7unnbU29rMoEaCeHRV/yTNjQqSWYYWbZZOzdg5ciqUC
         Uo/+CGLIZ5mdA3Q/4iUcwtLs/zIVr++hXiaiiP+mwQoVBAcWA9zzFJQKvA7NAE6Co85k
         Qz9ZlRO/iVy5Rxi4iGHptEQ5egPhdliJ4lT4CiCOqfHvBMt7SlVHZJ3vzmBLN8LK3RlA
         zncLg9YOmXSVNLHwJGVFz+gIfkgjBteRUckZYz9weJeCizsgAXAtMZG4LLEV5dDrYNRl
         jTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770741331; x=1771346131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nftrP5MGKrTCUa/drFb7KU6KxLAMWtnD4mrPPUEZ3mY=;
        b=ENSZJAw3BLzCAqZ1OZAm/lGkQ62HOBoPIOqSt1F4NSA1TEHoVJ6NhMAh3jEvdWREOH
         WXyWPic0Nzoj0DprdjfhVEyRpwamkVYU3mnI8LGT1fR8E8tH2QnVAm3N8XiPXKBQVxTF
         pXUuvMFu5JKbBc7Ty6Qx/AF8J3ZIAlHKe41GvA36Ug5Zk4RRw2AFU1zBjl6Dx1BpOBAb
         ESxn9LHzXdVs8hz812XZ4Jb8XXh+H8q4Zv49ywpPcGhFbpn8Sl8lNNyosCI2ghnr/WwV
         2RJbejQl8RSv/bMgOLfzZxMqvURvLbmVa8pPEF0YTst3C9dgJZ0nnke/yfGUozzNktOi
         rPIA==
X-Forwarded-Encrypted: i=1; AJvYcCXerHLG/wuJ1bS5cDZC+TRJq3haJ/06ZJZoME9xf4y9mhAr0aUuPrVBngpPxFayOy2+muVhBOJ9OYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxspVM1yv7LqVK1dq+Jw0BjEZ3ARwhhp9nXPzaxt3PFsW72ohXv
	AySlA0qsI+AurFVhkDZDJfmOOBef4NR4WrDHx6MsPrtG8IhEhcMx9XlYaeJ/mK02FmHAopdPHTH
	EgbzCfZ04Gx6vCg6mMw9XZ8zLLoVqUWA=
X-Gm-Gg: AZuq6aIp9DZwTSfjeK/zUZvU6GYy2GSi6RnXKswidqE9xlHP9j6fqyF29GovjjxOQG1
	FQfiGG8qX4uVpEHDMnJuW/1fyIi0PSoUZTINWEY58/nMTOtAZdTJMK/EvIs//LfesSEJzaNPdE0
	vw3SvC+wihsl/KBjjgosLxwDbeAWwgIXySnjrf9/KiSe/a694mzryk/BTiU2Tly47Rwoy9rm8nz
	8xIKz6A0WvQZZUwNnijzW89nA6fk//ZmZz3OekZvi828IvXo90NjJV0So2eXwwZ08fK/XuMmsXY
	hL5z9aatXd+PcraFjKY6a2vVbveez2KD8+UX8HxROt/ac2dS0RBp8NfHP6rdomJVSuSkcandSW5
	RGMVELmA=
X-Received: by 2002:a05:6214:8007:b0:897:12e:8e8b with SMTP id
 6a1803df08f44-8970fef6e20mr24182106d6.7.1770741330712; Tue, 10 Feb 2026
 08:35:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209-upstream-20260219-v1-0-2b4d74e309d1@gmail.com>
 <20260209-upstream-20260219-v1-1-2b4d74e309d1@gmail.com> <aYmeoZIlY2HCueKO@smile.fi.intel.com>
In-Reply-To: <aYmeoZIlY2HCueKO@smile.fi.intel.com>
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Wed, 11 Feb 2026 00:35:19 +0800
X-Gm-Features: AZwV_Qg-un_nbS5q6ROT2Wy2doK4l_-Fl8D9_tVQI_OtCsAM9_DWT7M35VSqDmw
Message-ID: <CA+NOmzKZy=8WhsN6w3B195pp10JunZA7ZVjRmwD21Q1CeOBYvw@mail.gmail.com>
Subject: Re: [PATCH 1/5] iio: proximity: hx9023s: fix out-of-bounds access
 when copying firmware
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 4:45=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Feb 09, 2026 at 11:37:02AM +0800, Yasin Lee wrote:
> > Initialize fw_size before copying firmware data into the flexible
> > array member to match the __counted_by() annotation. This fixes a
> > potential out-of-bounds access that could lead to a kernel crash.
>
> Fixes tag?
>

This is a proactive fix for an original implementation issue I found
as maintainer.

> --
> With Best Regards,
> Andy Shevchenko
>
>
