Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DE01C84BC
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130826; cv=pass; b=B7pcNWGwagA/R682UpcEXATgqRE4BpHIhx92EaES1KzeyeoDHZxDRndhKq23YfiKMr48s5HeKYGwDIB7Zh1qaf7e7b3xZQUJUVJgGkovNO3f8gc3bvkwECUV2VfF2kGIJKq8QaTkMtSLX8HFQWgcbelRoCs7+vnooS9WrGjITtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130826; c=relaxed/simple;
	bh=gRc5rg0uNhUBmKY5S3W7b9JJvEACGSzpTb7P6P2pWKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7jHjNxuopbEkyFeBT8hNook4sydma+tpjSnE98Osd/1hpESQ95wF1Qr7vNH9ochYwW7GDLQec3TfqmjNPOQ8m4RQvBolwwkYUKbEZPUO1DGABsk4AIdK0t4W/3ktJlMMWkY/BomlAsYm0EjNh/0CNDZ2GKiwzq/hMXXdqZskxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsGNIWZf; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsGNIWZf"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7e8833c99fcso82223117b3.3
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 15:33:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781130825; cv=none;
        d=google.com; s=arc-20240605;
        b=UYEl8VlHUu9ZGNMdu8DT0joPGCqOWoKzi8qxlX8U7fBzatRQNbSlYZCmuVaOvqxWVF
         yZem3cuvWLCuVtrWO6ZhREffdLhtsfzV/kePfSPdUD/Wy8v4nQc1z+5r+lPot/o19lmn
         d1odrz+FVdWzcLz+UMdzzs8ZbogMo3+tcJQcZ46RbOyOwm6p84TPDOJS/ITWq/cXH8i8
         f6jXFzvxqxbCb3K6lhl9qvr98f3pK2B7b3NBh/9oCYuk9iPVFoilC8WVP17KzlRBa22R
         VVRYhE4KjcNu6eZMePqPVgmtqxJUnx0VYW31YOhFzEDJ3uGVufnG9zA72XMbzbxfSyyr
         CPMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gRc5rg0uNhUBmKY5S3W7b9JJvEACGSzpTb7P6P2pWKg=;
        fh=JHiLAp8leSoIwEpqFskBf9TQj7XHvYG+HJNJGFA2nk0=;
        b=CaBru4gVnamXMcVBgQA30losQ4tBlQH9qbK1SyBX3f2jJvx+5fjSNzYIZYI9ZohBiM
         SnlUlkLK7bb4deQIadmVvas4OaEIxR2cAp3PzZaeKhMYEApolFpawVIBVJJcf5q0xhHa
         GFN/MBpn22Q80roAMIY9VmluIb+S7JjQ+vvRDvAJmgyRVOZrWpf0PwEqdNKJ8pBCCh69
         SeGdq/d8O9kEdYukTwWNlv4dfQSqmd9d0InJsG15r0EmczJsUkqzsMvkLCZDYNzMM9Bl
         3vNQeXv7PNNWZHo8iMd8kHDemFaNtO362NgCUgked00ssuBulkn65dw0rEeCJ3TqAi3R
         0lbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781130825; x=1781735625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRc5rg0uNhUBmKY5S3W7b9JJvEACGSzpTb7P6P2pWKg=;
        b=OsGNIWZfPPw9c29TnTjKd4rDpZUrpHV3QFEkJhxCX76keU7UkrSCQJdJe6GS1U6S5X
         6dx6KIxm0W0BHE0tEhlGmemRWWMuio2oJnEBUHXyXj81lxTqTp5+KhYMTGAgpU9bbPvr
         IkyfRmqqM+Byaj0wcXWjseBByZU715H7Bj6SdBM4+k+eTHPVBZ9JLt2PS82aeP/Mbr6k
         AzHdAIuxFUksXhF6AjSADpfPM+c5P2c4layAZyFX9oqWFP4FWGluZ0grB5zyC45W8F+J
         KkJudumd6GdcSh+b6+WRZNQzJsNr7deW9YS+HkX7J520j0JOgGeR3WdhVEctqIv4htlM
         EEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781130825; x=1781735625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gRc5rg0uNhUBmKY5S3W7b9JJvEACGSzpTb7P6P2pWKg=;
        b=oVV50x3BNxoi0kSkpHSrR0Z9r5eAq2nysYriacYxCcpdcVyrIGb/X++Adlutccvhfi
         FYuQ1eRYvoHzVPklcuMppNCZu9ErWKFb4UsgCiUtIf6Hf0hyhb5UKFjnByRosvOUUlvk
         FceHpzHSswsb454cAUKcCqZPcDKva5Rcvcie0cddUOkiI+tKJkLhCcoSpXBrdGf4glOv
         84vGKXM+CDsl6d5RGcLbPU7BB2ihDO5Fprtud9IFB1OPTP3rfQwpHMetxRl6jdY+H8Ja
         Jqes0VreBucDahW8bCilNT4jRzscIU7WK2327wG6YrJVhCsxIIBGUjosNYL25HsSwXbT
         Y9cw==
X-Forwarded-Encrypted: i=1; AFNElJ8Lh9lQ5z9aFzDTN6sWCdM8MOsUZmpXFhB8pm/7A1pXS/q1DjYRIPqPBB/YB1pD5wN8tB5ZEeLpM70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7hc9uR2Q0oPNT8XqngAqAGfQvhhhy0zyUMg6HRnRRqGp6GAyN
	oI/rHOsqBUmCvKxsUIlhfvQIGtizB3mwZJCJj55bPTL7VxaZy9ntrADRkJrwODELy0mt6Y7dyf8
	71oociNG8Cxti+i0dbf+PpNjkgcMjVP8=
X-Gm-Gg: Acq92OEgGWAEwn5DzR1bZTeXMwfGMbEkre2Z+BtFSEfZFsg4kc0kNLfHL8ubvIiYWF0
	lN9ifTCGIiEi3oigkif8h05ibuS1ZsJG8p01D4iGexlPer2ij+AAA/GiJdrRQ3yV1zN/I8NqX23
	x/IGjqlycFxHCk7uIaIpIkp/eZQ15UFWx4i8QBXUmyRypumZZqDzXqh3HNuSBXbYLaLPPtQnRwn
	mcrnfzxIhHDeJDEt9Ju52T0XOuqiv9hrYQcXFNloWx6Mn6RpcZhFHxwihcpuebHk1v8VQiQqKOX
	H+AQJPj3VH1ctPpgGtLIwlc+fQ==
X-Received: by 2002:a05:690c:c24d:b0:7bd:498d:7c96 with SMTP id
 00721157ae682-7f657866efbmr2517827b3.34.1781130824472; Wed, 10 Jun 2026
 15:33:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609160326.45123-1-m32285159@gmail.com> <20260609160326.45123-2-m32285159@gmail.com>
 <20260610-imperial-glittering-pudu-ddfdab@quoll>
In-Reply-To: <20260610-imperial-glittering-pudu-ddfdab@quoll>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 10 Jun 2026 17:33:33 -0500
X-Gm-Features: AVVi8CdlX_7XU5G3ZT3lf5TeUn5DNNt57yPU43XNb4deDpxPvIA7JLseq-81LG8
Message-ID: <CAKqfh0GTVZcRyGCaZDJZwE=W2=FKSMYGkgjmg_5eXs6ZG1z+_A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: plantower,pms7003: Add myself as maintainer
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Tomasz Duzsynski <tduszyns@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 4:08=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Tue, Jun 09, 2026 at 11:03:25AM -0500, Maxwell Doose wrote:
> > Tomasz's entry is no longer valid, as he is not active anymore. Add
> > myself as maintainer to replace his entry.
>
> Last replies are from Feb 2026, so not that far away. I fail to see the
> context behind that change.
>
> Anyway, it's like fourth patch from you doing the same. It's even more
> confusing seeing this done file by file.
>
> Maybe you just want to add yourself as co-maintainer?
>

In the context of this one, co-maintainer may make more sense, I'm not
as familiar with this driver as I am with, say, the sps30. However I
think we still don't want patches to land in Tomasz's (seemingly
abandoned) email. I would probably wait for Jonathan to chime
regarding that however.
